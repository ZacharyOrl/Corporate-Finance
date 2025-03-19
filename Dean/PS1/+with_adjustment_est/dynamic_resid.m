function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
% function residual = dynamic_resid(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = with_adjustment_est.dynamic_resid_tt(T, y, x, params, steady_state, it_);
end
residual = zeros(7, 1);
    residual(1) = (y(5)) - (1+params(6)*(y(6)-params(3)*y(1))/y(1));
    residual(2) = (y(5)) - (y(14)*T(3)-T(5)*T(6));
    residual(3) = (y(6)) - (y(4)+y(1)*(params(3)-1));
    residual(4) = (y(9)) - (y(7)*T(7)-y(6)-T(8)/(2*y(1)));
    residual(5) = (y(7)) - (params(4)*y(2)+1-params(4)+x(it_, 1));
    residual(6) = (y(8)) - (T(9)*(y(9)/y(3))^(-params(5)));
    residual(7) = (y(10)) - (y(5)+x(it_, 2));

end
