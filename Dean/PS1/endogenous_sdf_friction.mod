// Add endogenous variables 

var k q i z sdf c ;

// Add exogenous shocks 
varexo eps_z ; 

// Add parameters
parameters theta r delta  phi_0 rho_z sigma_z gamma ;

theta = 0.7 ; 
r = 0.04 ; 
delta = 0.15 ; 
phi_0 = 0.01 ; 
rho_z = 0.7 ; 
sigma_z = 0.1 ; 
gamma = 2.0 ; 

model ;  
// NOTE: In Dynare notation, k = k{t+1}, and k(-1) = k_t.

// 1. FOC with respect to I_t (equation (4) in lecture note)
q = 1 + phi_0 * (i - delta * k(-1))/k(-1);

// 2. FOC with respect to k{t+1} (equation (5))
q = sdf(+1) * ((theta * z(+1) * k^(theta - 1) - delta * phi_0 * (i(+1) - k)) / (2 * k)) - (phi_0 / 2) * ((i(+1) - delta * k) / k)^2 + q(+1) * (1 - delta);


// 3. Law of motion for capital-output
i = k + (delta - 1) * k(-1);

// 4. Market clearing for consumption goods
c = z * k(-1)^theta - i - phi_0 * (k - k(-1))^2 / (2 * k(-1)) ;

// 5. Law of motion for z
z = rho_z * z(-1) + (1 - rho_z) + eps_z;

// 6. Stochastic discount factor
sdf = (1 / (1 + r)) * (c / c(-1))^(-gamma);

end;

// Dynare views predetermined variables as dated from yesterday (-1)
// Forward looking variables are denoted (+1) (or +2, +3...)


initval;
z = 1;
q = 1;
k = (theta / (r + delta))^(1 / (1 - theta));
i = delta * k;
sdf = 1 / (1 + r);
c = k^theta - i;
end;

shocks ;  
var eps_z ; stderr sigma_z; 
end ; 

steady; 

check ; // Checks that the blanchard-kahn conditions are satisfied. 
// If they aren't satisfied, the steady state doesn't have a saddle path to
// it. 

// Set the seed
set_dynare_seed(03242023);

// “stoch simul(options)” solves and simulates the model, produces the policy functions,
// and generates impulse responses functions and unconditional second moments.
stoch_simul(order=1, irf=40, periods=2000, drop=200, nodisplay);

// dynare frictionless_model.mod
