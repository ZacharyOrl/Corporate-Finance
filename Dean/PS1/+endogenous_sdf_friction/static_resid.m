function residual = static_resid(T, y, x, params, T_flag)
% function residual = static_resid(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   residual
%

if T_flag
    T = endogenous_sdf_friction.static_resid_tt(T, y, x, params);
end
residual = zeros(6, 1);
    residual(1) = (y(2)) - (1+params(4)*(y(3)-params(3)*y(1))/y(1));
    residual(2) = (y(2)) - (y(5)*T(2)/(2*y(1))-params(4)/2*((y(3)-params(3)*y(1))/y(1))^2+y(2)*(1-params(3)));
    residual(3) = (y(3)) - (y(1)+y(1)*(params(3)-1));
    residual(4) = (y(6)) - (y(4)*T(3)-y(3));
    residual(5) = (y(4)) - (y(4)*params(5)+1-params(5)+x(1));
    residual(6) = (y(5)) - (1/(1+params(2)));

end
