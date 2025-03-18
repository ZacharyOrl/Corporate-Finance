* PS1 Corporate Finance 
* Zachary Orlando


/*
* To save space, focus immediately only on the variables I will actually use for the analysis.  
* Import the Annual Fundamental CCM/CRSP Merged data in a csv

* Select relevant variables
keep gvkey linktype linkdt linkenddt fyear datadate lpermno sic invt act lct at ppent dltt pstkl sale oibdp csho ajex intan dlc txditc re cshpri pi prcc_f tic dvt dvp

save "C:/Users/zacha/Documents/2025 Spring/Corporate Finance/ccm.dta", replace

clear all 

* Then do the same for the Monthly CRSP Data

* Import it as a CSV
keep permno date prc altprc shrout comnam ticker
save "C:/Users/zacha/Documents/2025 Spring/Corporate Finance/crsp.dta", replace 

clear all
*/

********************************************************************************
* Clean CCM/CRSP Annual Firm Dataset for merge 
use "C:/Users/zacha/Documents/2025 Spring/Corporate Finance/ccm.dta",clear

rename lpermno permno

* Drop missing data for book assets
drop if missing(at)

order gvkey fyear 
sort gvkey fyear 

* Recognize datadate as a date variable
gen datevar = date(datadate, "YMD")
format datevar %td
drop datadate
rename datevar datadate

* Generate month variable
gen month = month(datadate)

* Ensure there is only one ob per year
ds gvkey fyear tic ajex , not
collapse(last) `r(varlist)', by(gvkey fyear tic ajex)

* Declare time series
destring gvkey, replace 
tsset gvkey fyear

********************************************************************************
* Generate variables needed for the analysis***********************************
********************************************************************************

* Gen LRZ Variables documented at the end of the paper. 

* total debt = short-term debt + long-term debt 
gen totdt = dlc+dltt

* book leverage = total debt/book assets 
gen bklev = totdt/at

* firm size = log(book assets)
gen size = log(at) 

* profitability = operating income defore depreciation /book assets
gen prof = oibdp/at 

* cash flow volatility = standard deviation of historical operating income, requiring at least 3 years of data
replace oibdp = oibdp/1000 // can't match LRZ without normalizing historical operating income
* Within firm generate a count
bysort gvkey: gen count = _n 

* Generate the standard deviation of historical operating income 
* LRZ Is unclear how they actually did this! Try two measures: 
* 1: 
* SD will vary by firm-year using a 60-year rolling window
rangestat (sd) oibdp if count >= 2, by(gvkey) interval(fyear -60 0)
rename oibdp_sd cfvol


* market equity = stock price  * shares outstanding
gen mkteq = prcc_f*cshpri

* market leverage = total debt/(total debt + market equity)
gen mktlev = totdt/(totdt+mkteq) 

* market-to-book = (market equity + total debt + preferred stock liquidating value  – deferred taxes and investment tax credits )/book assets
gen mktbk = (mkteq+totdt+pstkl-txditc)/at

* collateral = inventory  + net PPE/book assets
gen coll = invt + ppent/at

* z-score = 3.3 * pre-tax income  + sales + 1.4 * retained earnings  + 1.2 * (current assets – current liabilities/book assets
gen zscore = 3.3*pi+sale+1.4*re+1.2*((act-lct)/at)

* tangibility = net PPE/book assets
gen tan = ppent/at

* net debt issuance = the change in total debt from year t−1 to year t divided by the end of year t−1 total assets
sort gvkey fyear
gen dint = d.totdt/l.at

* net equity issuance = the split-adjusted change in shares outstanding times the split-adjusted average stock pricedivided by the end of year t−1 total assets
gen eint = ((csho-l.csho*(l.ajex/ajex)) * (prcc_f+l.prcc_f*(ajex/l.ajex)))/l.at

* log sales
gen log_sale = log(sale) 

* require market and book leverage to be within (0,1)
foreach var in mktlev bklev{
	replace `var'=. if `var'>1 | `var' < 0
	drop if missing(`var')
}

* dividend payer (in each year)
gen dv_payer=0 if !missing(dvt)
replace dv_payer=1 if (dvt>0 & !missing(dvt))

* Need the SIC 36 industry classification
* median of market and book leverage
destring sic, replace
gen int industry = .
replace industry = 1 if sic >= 100 & sic <= 999
replace industry = 2 if sic >= 1000 & sic <= 1299
replace industry = 3 if sic >= 1300 & sic <= 1399
replace industry = 4 if sic >= 1400 & sic <= 1499
replace industry = 5 if sic >= 1500 & sic <= 1799
replace industry = 6 if sic >= 2000 & sic <= 2099
replace industry = 7 if sic >= 2100 & sic <= 2199
replace industry = 8 if sic >= 2200 & sic <= 2299
replace industry = 9 if sic >= 2300 & sic <= 2399
replace industry = 10 if sic >= 2400 & sic <= 2499
replace industry = 11 if sic >= 2500 & sic <= 2599
replace industry = 12 if sic >= 2600 & sic <= 2661
replace industry = 13 if sic >= 2700 & sic <= 2799
replace industry = 14 if sic >= 2800 & sic <= 2899
replace industry = 15 if sic >= 2900 & sic <= 2999
replace industry = 16 if sic >= 3000 & sic <= 3099
replace industry = 17 if sic >= 3100 & sic <= 3199
replace industry = 18 if sic >= 3200 & sic <= 3299
replace industry = 19 if sic >= 3300 & sic <= 3399
replace industry = 20 if sic >= 3400 & sic <= 3499
replace industry = 21 if sic >= 3500 & sic <= 3599
replace industry = 22 if sic >= 3600 & sic <= 3699
replace industry = 23 if sic >= 3700 & sic <= 3799
replace industry = 24 if sic >= 3800 & sic <= 3879
replace industry = 25 if sic >= 3900 & sic <= 3999
replace industry = 26 if sic >= 4000 & sic <= 4799
replace industry = 27 if sic >= 4800 & sic <= 4829
replace industry = 28 if sic >= 4830 & sic <= 4899
replace industry = 29 if sic >= 4900 & sic <= 4949
replace industry = 30 if sic >= 4950 & sic <= 4959
replace industry = 31 if sic >= 4960 & sic <= 4969
replace industry = 32 if sic >= 4970 & sic <= 4979
replace industry = 33 if sic >= 5000 & sic <= 5199
replace industry = 34 if sic >= 5200 & sic <= 5999
replace industry = 35 if sic >= 6000 & sic <= 6999
replace industry = 36 if sic >= 7000 & sic <= 8999
replace industry = 37 if sic >= 9000 & sic <= 9999
replace industry = 38 if industry == .

* Create median industry book and market leverage variables for each firm in each year/industry
foreach var in bklev mktlev{
	bys fyear industry: egen med_ind_`var' = pctile(`var'), p(50)
}

* scale intangibles by 1000 to fit with LRZ
replace intan=intan/1000

* Define survivors as having 20 years of book leverage data 

bysort gvkey: gen within_samp = inrange(fyear,1965,2003)

* Count the number of obs within the LRZ sample for each firm
bysort gvkey within_samp: gen survivor_count = _N if within_samp == 1
bysort gvkey: egen any_survivor = max(survivor_count)

bysort gvkey: gen survivor = (any_survivor >= 20)

* Drop all years not in the LRZ sample. 
keep if inrange(fyear,1965,2003)

* Consider only non-financial firms
drop if industry == 35 

drop count
save "C:/Users/zacha/Documents/2025 Spring/Corporate Finance/LRZ.dta",replace

********************************************************************************
*Q1 Replicate Table 1 of LRZ
********************************************************************************
macro drop _all 
use "C:/Users/zacha/Documents/2025 Spring/Corporate Finance/LRZ.dta", clear

* drop the bottom and top 1% except for dividend payers (which is only 1 or 0)
foreach var in totdt bklev size prof cfvol mkteq mktlev mktbk coll zscore tan dint eint log_sale med_ind_bklev med_ind_mktlev intan {
	winsor2 `var', cut(1 99) trim suffix(_t)
}

* Save each of the outputs
foreach var in bklev_t mktlev_t log_sale_t mktbk_t prof_t tan_t cfvol_t med_ind_bklev_t dv_payer intan_t {
	summ `var', d
	
	local Mean_All_Firms_`var' `r(mean)'
	local Med_All_Firms_`var' `r(p50)'
	local Sd_All_Firms_`var' `r(sd)'

	summ `var' if survivor==1, d
	
	local Mean_Survivors_`var' `r(mean)'
	local Med_Survivors_`var' `r(p50)'
	local Sd_Survivors_`var' `r(sd)'
}

* Get observation count
count
local N_All_Firms `r(N)'
count if survivor==1
local N_Survivors `r(N)'

macro list
* Generate the table
clear
set obs 11

gen str30 Variable = ""
foreach var in Mean_All_Firms Med_All_Firms Sd_All_Firms Mean_Survivors Med_Survivors Sd_Survivors{
	gen `var'=.
}
replace Variable="bklev_t" if _n==1
replace Variable="mktlev_t" if _n==2
replace Variable="log_sale_t" if _n==3
replace Variable="mktbk_t" if _n==4
replace Variable="prof_t" if _n==5
replace Variable="tan_t" if _n==6
replace Variable="cfvol_t" if _n==7
replace Variable="med_ind_bklev_t" if _n==8
replace Variable="dv_payer" if _n==9
replace Variable="intan_t" if _n==10
replace Variable="Obs." if _n==11
macro list
* Fill the table
foreach stat of varlist Mean_All_Firms Med_All_Firms Sd_All_Firms Mean_Survivors Med_Survivors Sd_Survivors {
	local variables = "bklev_t mktlev_t log_sale_t mktbk_t prof_t tan_t cfvol_t med_ind_bklev_t dv_payer intan_t"
	foreach var of local variables{
		replace `stat' = ``stat'_`var'' if Variable=="`var'"
		replace `stat'= `N_All_Firms' if Variable=="Obs." & inlist("`stat'", "Mean_All_Firms", "Med_All_Firms", "Sd_All_Firms")
		replace `stat'=`N_Survivors' if Variable=="Obs." & inlist("`stat'", "Mean_Survivors", "Med_Survivors", "Sd_Survivors")
	}
}

* Give each variable the proper name 
replace Variable="Book leverage" if _n==1
replace Variable="Market leverage" if _n==2
replace Variable="Log(sales)" if _n==3
replace Variable="Market-to-book" if _n==4
replace Variable="Profitability" if _n==5
replace Variable="Tangibility" if _n==6
replace Variable="Cash flow vol." if _n==7
replace Variable="Median industry book leverage" if _n==8
replace Variable="Dividend payer" if _n==9
replace Variable="Intangible assets" if _n==10
replace Variable="Obs." if _n==11

********************************************************************************
*Q2 Replicate Table 2 (Panels A and B) of LRZ
********************************************************************************
macro drop _all 
use "C:/Users/zacha/Documents/2025 Spring/Corporate Finance/LRZ.dta", clear

* Construct initial leverage variables (market and book)
bysort gvkey (datadate): gen count = _n 

foreach v in mktlev bklev{
	gen temp = `v' if count == 1
	bysort gvkey (datadate): egen init_`v' =  max(temp)
	drop temp
}

* drop the bottom and top 0.5% except for dividend payers (which is only 1 or 0)
foreach var in totdt init_mktlev init_bklev bklev size prof cfvol  mkteq mktlev mktbk coll zscore tan dint eint log_sale med_ind_bklev med_ind_mktlev intan {
	winsor2 `var', cut(1 99) trim suffix(_t)
}

* scale variables by their standard deviation
foreach var in log_sale_t mktbk_t prof_t tan_t med_ind_bklev_t med_ind_mktlev_t cfvol_t dv_payer init_bklev_t init_mktlev_t {
	summ `var'
	scalar `var'_std = r(sd)
	gen `var'_std=`var'/`var'_std
}

* Panel A***********************************************************************
sort gvkey fyear

* Determine the sample for book leverage as the dependent
reghdfe bklev_t init_bklev_t_std L.log_sale_t L.mktbk_t L.prof_t L.tan_t L.med_ind_bklev_t L.med_ind_mktlev_t L.cfvol_t L.dv_payer, cluster(gvkey)
gen reg_sample = e(sample)

* Column 1
reghdfe bklev_t init_bklev_t_std if reg_sample == 1,cluster(gvkey)
outreg2 using T2A.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, No) replace

* Column 2
reghdfe bklev_t init_bklev_t_std  L.log_sale_t L.mktbk_t L.prof_t L.tan_t  if reg_sample == 1,cluster(gvkey) absorb(fyear)
outreg2 using T2A.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, Yes) append

* Column 3 
reghdfe bklev_t init_bklev_t_std L.log_sale_t L.mktbk_t L.prof_t L.tan_t L.med_ind_bklev_t L.med_ind_mktlev_t L.cfvol_t L.dv_payer if reg_sample == 1, cluster(gvkey) absorb(fyear)
outreg2 using T2A.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, Yes) append

drop reg_sample
* Determine the sample for market leverage as the dependent
reghdfe mktlev_t init_mktlev_t_std L.log_sale_t L.mktbk_t L.prof_t L.tan_t L.med_ind_bklev_t L.med_ind_mktlev_t L.cfvol_t L.dv_payer, cluster(gvkey)
gen reg_sample = e(sample)

* Column 1
reghdfe mktlev_t init_mktlev_t_std if reg_sample == 1,cluster(gvkey)
outreg2 using T2A.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, No) append

* Column 2
reghdfe mktlev_t init_mktlev_t_std  L.log_sale_t L.mktbk_t L.prof_t L.tan_t  if reg_sample == 1,cluster(gvkey) absorb(fyear)
outreg2 using T2A.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, Yes) append

* Column 3 
reghdfe mktlev_t init_mktlev_t_std L.log_sale_t L.mktbk_t L.prof_t L.tan_t L.med_ind_bklev_t L.med_ind_mktlev_t L.cfvol_t L.dv_payer if reg_sample == 1, cluster(gvkey) absorb(fyear)
outreg2 using T2A.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, Yes) append

shell rm T2A.txt
drop reg_sample 
********************************************************************************
* Panel B: Survivors
********************************************************************************

* Determine the sample for book leverage as the dependent
reghdfe bklev_t init_bklev_t_std L.log_sale_t L.mktbk_t L.prof_t L.tan_t L.med_ind_bklev_t L.med_ind_mktlev_t L.cfvol_t L.dv_payer if survivor == 1, cluster(gvkey)
gen reg_sample = e(sample)

* Column 1
reghdfe bklev_t init_bklev_t_std if reg_sample == 1,cluster(gvkey)
outreg2 using T2B.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, No) replace

* Column 2
reghdfe bklev_t init_bklev_t_std  L.log_sale_t L.mktbk_t L.prof_t L.tan_t  if reg_sample == 1,cluster(gvkey) absorb(fyear)
outreg2 using T2B.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, Yes) append

* Column 3 
reghdfe bklev_t init_bklev_t_std L.log_sale_t L.mktbk_t L.prof_t L.tan_t L.med_ind_bklev_t L.med_ind_mktlev_t L.cfvol_t L.dv_payer if reg_sample == 1, cluster(gvkey) absorb(fyear)
outreg2 using T2B.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, Yes) append

drop reg_sample
* Determine the sample for market leverage as the dependent
reghdfe mktlev_t init_mktlev_t_std L.log_sale_t L.mktbk_t L.prof_t L.tan_t L.med_ind_bklev_t L.med_ind_mktlev_t L.cfvol_t L.dv_payer if survivor == 1, cluster(gvkey)
gen reg_sample = e(sample)

* Column 1
reghdfe mktlev_t init_mktlev_t_std if reg_sample == 1,cluster(gvkey)
outreg2 using T2B.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, No) append

* Column 2
reghdfe mktlev_t init_mktlev_t_std  L.log_sale_t L.mktbk_t L.prof_t L.tan_t  if reg_sample == 1,cluster(gvkey) absorb(fyear)
outreg2 using T2B.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, Yes) append

* Column 3 
reghdfe mktlev_t init_mktlev_t_std L.log_sale_t L.mktbk_t L.prof_t L.tan_t L.med_ind_bklev_t L.med_ind_mktlev_t L.cfvol_t L.dv_payer if reg_sample == 1, cluster(gvkey) absorb(fyear)
outreg2 using T2B.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, Yes) append

shell rm T2B.txt

********************************************************************************
* Q3: Re-run panel A but with a firm FE instead of just initial leverage 
********************************************************************************
macro drop _all 
use "C:/Users/zacha/Documents/2025 Spring/Corporate Finance/LRZ.dta", clear

* Construct initial leverage variables (market and book)
bysort gvkey (datadate): gen count = _n 

foreach v in mktlev bklev{
	gen temp = `v' if count == 1
	bysort gvkey (datadate): egen init_`v' =  max(temp)
	drop temp
}

* drop the bottom and top 0.5% except for dividend payers (which is only 1 or 0)
foreach var in totdt init_mktlev init_bklev bklev size prof cfvol  mkteq mktlev mktbk coll zscore tan dint eint log_sale med_ind_bklev med_ind_mktlev intan {
	winsor2 `var', cut(1 99) trim suffix(_t)
}

* scale variables by their standard deviation
foreach var in log_sale_t mktbk_t prof_t tan_t med_ind_bklev_t med_ind_mktlev_t cfvol_t dv_payer init_bklev_t init_mktlev_t {
	summ `var'
	scalar `var'_std = r(sd)
	gen `var'_std=`var'/`var'_std
}

* Panel A***********************************************************************
sort gvkey fyear

* Determine the sample for book leverage as the dependent
reghdfe bklev_t L.log_sale_t L.mktbk_t L.prof_t L.tan_t L.med_ind_bklev_t L.med_ind_mktlev_t L.cfvol_t L.dv_payer, cluster(gvkey) absorb(gvkey)
gen reg_sample = e(sample)

* Column 1
reghdfe bklev_t if reg_sample == 1,cluster(gvkey) absorb(gvkey)
outreg2 using Q3.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, No) replace

* Column 2
reghdfe bklev_t   L.log_sale_t L.mktbk_t L.prof_t L.tan_t  if reg_sample == 1,cluster(gvkey) absorb(fyear gvkey)
outreg2 using Q3.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, Yes) append

* Column 3 
reghdfe bklev_t  L.log_sale_t L.mktbk_t L.prof_t L.tan_t L.med_ind_bklev_t L.med_ind_mktlev_t L.cfvol_t L.dv_payer if reg_sample == 1, cluster(gvkey) absorb(gvkey)
outreg2 using Q3.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, Yes) append

drop reg_sample
* Determine the sample for market leverage as the dependent
reghdfe mktlev_t L.log_sale_t L.mktbk_t L.prof_t L.tan_t L.med_ind_bklev_t L.med_ind_mktlev_t L.cfvol_t L.dv_payer, cluster(gvkey) absorb(gvkey)
gen reg_sample = e(sample)

* Column 1
reghdfe mktlev_t  if reg_sample == 1,cluster(gvkey) absorb(gvkey)
outreg2 using Q3.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, No) append

* Column 2
reghdfe mktlev_t  L.log_sale_t L.mktbk_t L.prof_t L.tan_t  if reg_sample == 1,cluster(gvkey) absorb(fyear gvkey)
outreg2 using Q3.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, Yes) append

* Column 3 
reghdfe mktlev_t L.log_sale_t L.mktbk_t L.prof_t L.tan_t L.med_ind_bklev_t L.med_ind_mktlev_t L.cfvol_t L.dv_payer if reg_sample == 1, cluster(gvkey) absorb(fyear gvkey)
outreg2 using Q3.tex, tex st(coef tstat) dec(3) noaster label addstat(Adj. R2, e(r2_a)) addtext(Year FE, Yes) append

shell rm Q3.txt
drop reg_sample 

********************************************************************************
* Q4
********************************************************************************
* Import CRSP and clean 
use "C:/Users/zacha/Documents/2025 Spring/Corporate Finance/crsp.dta",clear

* Recognize date as a date variable
gen datevar = date(date, "YMD")
format datevar %td
drop date
rename datevar date

* Generate date variables
gen month = month(date) // month in the year
gen mdate = mofd(date) // monthly TS (will vary across year)
format mdate %tm
gen fyear = yofd(date)
format fyear %ty

* Ensure the panel is in the correct range
keep if inrange(fyear, 1965, 2003)

* Drop if we cannot calculate market equity
order fyear prc shrout, a(date)
drop if missing(prc) | missing(shrout) 

sort permno mdate
duplicates drop permno mdate, force

* CCM has shares outstanding / 1000000
* CRSP has shares outstanding /1000
replace shrout = shrout / 1000
* Set the dataset as a time series
xtset permno mdate, monthly

* Generate market equity 
* Som negative prices, correct this error 
* sum prc,d
gen mkt_equity = abs(prc) * shrout

collapse(last) mkt_equity shrout prc,by(fyear permno)
save "C:/Users/zacha/Documents/2025 Spring/Corporate Finance/crsp_lrz.dta",replace

use  "C:/Users/zacha/Documents/2025 Spring/Corporate Finance/LRZ.dta", clear

sum mkteq,d 
duplicates drop permno fyear,force

merge 1:1 permno fyear using "C:/Users/zacha/Documents/2025 Spring/Corporate Finance/crsp_lrz.dta"
 drop if _merge != 3
 drop _merge 
 
gen diff = mkteq - mkt_equity

bysort gvkey: egen mean_diff = mean(diff)

