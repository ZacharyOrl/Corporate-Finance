// This code solves Hayashi's investment model.
// Written by Akio Ino

var k, q, i, z, sdf, c, qob; // Even though z is exogenous shock, it is determined by z'=(1-rho) + rho z + eps, so it is determined inside the model and we should include z in this section.

varexo eps_z, measure_error;


parameters 
	theta r delta rho_z gamma phi_0;


// Start describing the model. For our purpose, 7 and 8 are redundant.
model ;  
// NOTE: In Dynare notation, k = k{t+1}, and k(-1) = k_t.

// 1. FOC with respect to I_t (equation (4) in lecture note)
q = 1 + phi_0 * (i - delta * k(-1))/k(-1);

// 2. FOC with respect to k{t+1} (equation (5))
q = sdf(+1) * (theta * z(+1) * k^(theta - 1) + q(+1) * (1 - delta) - delta * phi_0 * (1/k) * (i(+1) - delta*k)) - (2*phi_0 ) * (1/k^2) * ((i(+1) - delta * k)^2);

// 3. Law of motion for capital-output
i = k + (delta - 1) * k(-1);

// 4. Market clearing for consumption goods
c = z * k(-1)^theta - i - phi_0 * (i - delta * k(-1))^2 / (2 * k(-1)) ;

// 5. Law of motion for z
z = rho_z * z(-1) + (1 - rho_z) + eps_z;

// 6. Stochastic discount factor
sdf = (1 / (1 + r)) * (c / c(-1))^(-gamma);

// 7. Measurement error in q

qob = q + measure_error;

end;
// This section gives dynare the initial value to solve for the steady state.
initval;

    z = 1;
    q = 1;
    k = (theta / (r + delta))^(1 / (1 - theta));
    i = delta * k;
    sdf = 1 / (1 + r);
    c = k^theta - i;
    qob = 0;

end;


// Set the correlation btw eps and measurement error to be zero.
shocks;
corr eps_z, measure_error = 0;

end;

// Calibrated parameter
r     = 0.04;   // discount rate
delta = 0.15;   // depreciation rate
gamma = 2.0;
rho_z   = 0.7;    // persistency of productivity shock

// Observable variable
varobs k, qob;

// Parameters to be estimated
// I computed the standard error of kob and qob, and use it as a prior mean for sigma_z and sigma_q.
estimated_params;
stderr eps_z, inv_gamma_pdf, 0.007, 1.0;
theta, uniform_pdf, , ,0, 1;
phi_0, uniform_pdf, , ,0, 1;
stderr measure_error,inv_gamma_pdf, 0.007,1.0 ;
end;

// with mode_compute = 6, dynare will not use the hessian at the posterior mode in MCMC part.
// Hence even if the hessian is not positive definite, dynare will not stop the computation,
// although it is more inefficient and takes more time.
// mh_jscale is used to scale the var-cov matrix in MCMC part. 
// It is recommended that we choose mh_jscale so that the acceptance ratio is close to 0.234.
// See, for example, Roberts, Gelman and Gilks(‎1997)"Weak convergence and optimal scaling of random walk Metropolis algorithms".

estimation(datafile=data_ps2,mode_compute = 6, mh_jscale=1.8) k qob;

