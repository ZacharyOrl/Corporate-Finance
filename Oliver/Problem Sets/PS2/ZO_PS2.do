************************************************************************
* PS2
* Author: Zachary Orlando
************************************************************************
cd "C:\Users\zacha\Documents\2025 Spring\Corporate Finance\Problem Sets\PS2"

/*
* Import Compustat Annual data from 1980
import delimited "Compustat_firm_panel_raw.csv",clear

keep if (indfmt == "INDL" & datafmt == "STD" & popsrc == "D" & consol == "C")
keep if (at>0)
keep if (sic < 6000 | sic > 6999)
keep if (sic < 4900 | sic > 4999)
keep if (!missing(gvkey)  & !missing(fyear))
keep if (fic == "USA")
keep if (prcc_f != . & csho != .)
keep if fyear>= 1980
save "Compustat_filtered.dta",replace
*/


* Import CPI for All urban consumers (index: 2004 = 100)
/*
import delimited "CPIAUCSL.csv", clear

gen date = date(fyear,"MDY")
drop fyear

gen year = year(date)
gen fyear = year 

drop year date
save "cpi.dta",replace
*/

* Import total q measure from Peters and Taylor (2017) taken from WRDS
/*
import delimited "total_q.csv", clear

save "total_q.dta",replace
*/
************************************************************************
use "Compustat_filtered.dta",clear

sort gvkey fyear
tsset gvkey fyear

* Construct variables
bysort gvkey(fyear): gen l_ppegt = ppegt[_n-1]
bysort gvkey(fyear): gen l_at = at[_n-1]

gen inv = capx/l_ppegt // Unclear whether to follow the question or Erickson and whited which uses total assets for the denominator. 

gen avg_q = (at + prcc_f*csho - ceq - txdb )/at 

gen cash_flow = (ibc + dpc )/l_at 

gen book_leverage = (dlc + dltt)/at // Short term + Long Term debt : Total Assets

* Create financing constraint index following Hadlock and Pierce***************
sort gvkey fyear
merge m:1 fyear using cpi

drop if _merge != 3 
drop _merge 
* Deflate the key_variables to 2004 levels
gen ppegt_real = ppegt/(cpi/100)
gen at_real = at/(cpi/100)

gen size = ln(at_real)

* Create the size squared variabe
gen size2 = size^2

* Create firm age 
bysort gvkey(fyear): gen n = _n // record the observation
gen first_year = fyear if n == 1
bysort gvkey(fyear): egen temp = max(first_year)
gen age = fyear - temp 

drop temp first_year

* Create financing constraint index: 
gen fci = -0.737*size + 0.043*size2 - 0.04*age
* Create q_tot variable following Peters and Taylor ***************
sort gvkey fyear
merge 1:1 gvkey fyear using total_q

drop if _merge != 3 
drop _merge 

* Winsorize 
local vars inv avg_q cash_flow  book_leverage fci q_tot

foreach v of local vars{
	
	gen `v'_w = `v'
	winsor2 `v'_w, replace cuts(1 99)
}

gen avg_q_w_2 = avg_q_w^2 // Quadratic term for Q 
************************************************************************
* Regressions

* Q1 ********************************************************************

local fe "gvkey"
local first_run = 1  // Flag to track first iteration
sort gvkey fyear
foreach f in "" gvkey {  
    if "`f'" == "" {  
        local tex_fe "No"  
    }  
    else {  
        local tex_fe "Yes"  
    }  
	
	* First model
    reghdfe inv_w L.avg_q_w, absorb(`f')  

    local filename "ps2_q1.tex"  

    if `first_run' {
        outreg2 using "`filename'", tex st(coef se) dec(3) label addtext(Firm FE, `tex_fe') replace  
        local first_run = 0  // Set flag to 0 after first run
    }  
    else {
        outreg2 using "`filename'", tex st(coef se) dec(3) label addtext(Firm FE, `tex_fe') append  
    }
	
	* Second model with cash flows
	reghdfe inv_w L.avg_q_w cash_flow_w, absorb(`f')  

    outreg2 using "`filename'", tex st(coef se) dec(3) label addtext(Firm FE, `tex_fe') append 
}

* Q2 ********************************************************************
* Use lagged cash flows instead of contemporaneous cash flows.
foreach f in "" gvkey {  
    if "`f'" == "" {  
        local tex_fe "No"  
    }  
    else {  
        local tex_fe "Yes"  
    }  
	
	* Second model with lagged cash flows
	reghdfe inv_w L.avg_q_w L.cash_flow_w, absorb(`f')  

    local filename "ps2_q1.tex"  

    outreg2 using "`filename'", tex st(coef se) dec(3) label addtext(Firm FE, `tex_fe') append 
}

* Q3 ********************************************************************
* Add a quadratic term for Q to the first regression
foreach f in "" gvkey {  
    if "`f'" == "" {  
        local tex_fe "No"  
    }  
    else {  
        local tex_fe "Yes"  
    }  
	
	* First model with quadratic term
    reghdfe inv_w L.avg_q_w L.avg_q_w_2, absorb(`f')  

    local filename "ps2_q1.tex"  

    outreg2 using "`filename'", tex st(coef se) dec(3) label addtext(Firm FE, `tex_fe') append  
}

* Q4 ********************************************************************
* Repeat Q1 with robust SEs

foreach f in "" gvkey {  
    if "`f'" == "" {  
        local tex_fe "No"  
    }  
    else {  
        local tex_fe "Yes"  
    }  
	
	* First model
    reghdfe inv_w L.avg_q_w, vce(robust) absorb(`f')  

    local filename "ps2_q4.tex"  

    outreg2 using "`filename'", tex st(coef se) dec(3) label addtext(Firm FE, `tex_fe') append  
	
	*Second model with cash flows
	reghdfe inv_w L.avg_q_w cash_flow_w, vce(robust) absorb(`f')  

    local filename "ps2_q4.tex"  

    outreg2 using "`filename'", tex st(coef se) dec(3) label addtext(Firm FE, `tex_fe') append 
}


* Q5 ********************************************************************
* Test if the slopes are equal 

*No FE
reghdfe inv_w L.avg_q_w cash_flow_w, vce(robust) absorb()  
test _b[L.avg_q_w] = _b[cash_flow_w]

*FE
reghdfe inv_w L.avg_q_w cash_flow_w, vce(robust) absorb(gvkey)  
test _b[L.avg_q_w] = _b[cash_flow_w]

* Q6*********************************************************************

* Create quintiles by fyear
sort fyear
by fyear: egen lev_quintile = xtile(book_leverage_w), nquantiles(5)

sort gvkey fyear
reghdfe inv_w L.avg_q_w cash_flow_w if lev_quint == 1, absorb(gvkey) cluster(gvkey)
outreg2 using "ps2_q6.tex" , tex st(coef se) dec(3) label addtext(Firm FE, No, Cluster, Firm) replace


local fe "gvkey"
foreach q in 2 3 4 5 {
    * Select data for the current quintile
    qui su lev_quintile if lev_quintile == `q', meanonly
    local n = r(N)
    if `n' > 0 {  
        display "Running model for quintile `q'"

        * Run regression with firm fixed effects for the current quintile
        reghdfe inv_w L.avg_q_w cash_flow_w if lev_quintile == `q', absorb(`fe')  
		
        * Output results to LaTeX file
		
		local filename "ps2_q6.tex"
        outreg2 using "`filename'", tex st(coef se) dec(3) label addtext(Firm FE, Yes) append 
    }
}

* Q7*********************************************************************
xtile fci_quintile = fci_w, nquantiles(5) //Put into quintiles unconditionally.

foreach q in 1 2 3 4 5 {
    reghdfe inv_w L.avg_q_w cash_flow_w if fci_quintile == `q', absorb(gvkey) cluster(gvkey)
	
    outreg2 using "ps2_q6.tex", tex st(coef se) dec(3) label addtext(Firm FE, Yes, Cluster, Firm) append
}

* Q8*********************************************************************
bysort gvkey(fyear): gen l_avg_q_w = L.avg_q_w

* Eqn 1
xtewreg inv_w l_avg_q_w, maxdeg(5)
outreg2 using "ps2_q8.tex", tex st(coef se) dec(3) replace

* Eqn 2
xtewreg inv_w l_avg_q_w cash_flow_w, maxdeg(5) mis(1) cent(set)
outreg2 using "ps2_q8.tex", tex st(coef se) dec(3) append

* Q9********************************************************************
local fe "gvkey"
local first_run = 1  // Flag to track first iteration
sort gvkey fyear
foreach f in "" gvkey {  
    if "`f'" == "" {  
        local tex_fe "No"  
    }  
    else {  
        local tex_fe "Yes"  
    }  
	
	* First model
    reghdfe inv_w L.q_tot_w, absorb(`f')  

    local filename "ps2_q9.tex"  

    if `first_run' {
        outreg2 using "`filename'", tex st(coef se) dec(3) label addtext(Firm FE, `tex_fe') replace  
        local first_run = 0  // Set flag to 0 after first run
    }  
    else {
        outreg2 using "`filename'", tex st(coef se) dec(3) label addtext(Firm FE, `tex_fe') append  
    }
	

}