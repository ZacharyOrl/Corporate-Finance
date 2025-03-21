function g1 = static_g1(T, y, x, params, T_flag)
% function g1 = static_g1(T, y, x, params, T_flag)
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
%   g1
%

if T_flag
    T = endogenous_sdf_friction.static_g1_tt(T, y, x, params);
end
g1 = zeros(6, 6);
g1(1,1)=(-((y(1)*params(4)*(-params(3))-params(4)*(y(3)-params(3)*y(1)))/(y(1)*y(1))));
g1(1,2)=1;
g1(1,3)=(-(params(4)/y(1)));
g1(2,1)=(-(y(5)*(2*y(1)*(params(4)*params(3)+params(1)*y(4)*getPowerDeriv(y(1),params(1)-1,1))-2*T(2))/(2*y(1)*2*y(1))-params(4)/2*(y(1)*(-params(3))-(y(3)-params(3)*y(1)))/(y(1)*y(1))*2*(y(3)-params(3)*y(1))/y(1)));
g1(2,2)=1-(1-params(3));
g1(2,3)=(-(y(5)*(-(params(4)*params(3)))/(2*y(1))-params(4)/2*2*(y(3)-params(3)*y(1))/y(1)*1/y(1)));
g1(2,4)=(-(y(5)*params(1)*T(1)/(2*y(1))));
g1(2,5)=(-(T(2)/(2*y(1))));
g1(3,1)=(-params(3));
g1(3,3)=1;
g1(4,1)=(-(y(4)*getPowerDeriv(y(1),params(1),1)));
g1(4,3)=1;
g1(4,4)=(-T(3));
g1(4,6)=1;
g1(5,4)=1-params(5);
g1(6,5)=1;

end
