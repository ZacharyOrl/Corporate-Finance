function g2 = dynamic_g2(T, y, x, params, steady_state, it_, T_flag)
% function g2 = dynamic_g2(T, y, x, params, steady_state, it_, T_flag)
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
%   g2
%

if T_flag
    T = with_adjustment_est.dynamic_g2_tt(T, y, x, params, steady_state, it_);
end
g2_i = zeros(27,1);
g2_j = zeros(27,1);
g2_v = zeros(27,1);

g2_i(1)=1;
g2_i(2)=1;
g2_i(3)=1;
g2_i(4)=2;
g2_i(5)=2;
g2_i(6)=2;
g2_i(7)=2;
g2_i(8)=2;
g2_i(9)=2;
g2_i(10)=2;
g2_i(11)=2;
g2_i(12)=2;
g2_i(13)=2;
g2_i(14)=2;
g2_i(15)=2;
g2_i(16)=2;
g2_i(17)=2;
g2_i(18)=4;
g2_i(19)=4;
g2_i(20)=4;
g2_i(21)=4;
g2_i(22)=4;
g2_i(23)=4;
g2_i(24)=6;
g2_i(25)=6;
g2_i(26)=6;
g2_i(27)=6;
g2_j(1)=1;
g2_j(2)=6;
g2_j(3)=81;
g2_j(4)=52;
g2_j(5)=60;
g2_j(6)=180;
g2_j(7)=61;
g2_j(8)=196;
g2_j(9)=62;
g2_j(10)=212;
g2_j(11)=174;
g2_j(12)=219;
g2_j(13)=188;
g2_j(14)=190;
g2_j(15)=220;
g2_j(16)=206;
g2_j(17)=221;
g2_j(18)=1;
g2_j(19)=6;
g2_j(20)=81;
g2_j(21)=7;
g2_j(22)=97;
g2_j(23)=86;
g2_j(24)=35;
g2_j(25)=41;
g2_j(26)=131;
g2_j(27)=137;
g2_v(1)=(-((-((y(1)*params(6)*(-params(3))-params(6)*(y(6)-params(3)*y(1)))*(y(1)+y(1))))/(y(1)*y(1)*y(1)*y(1))));
g2_v(2)=(-((-params(6))/(y(1)*y(1))));
g2_v(3)=g2_v(2);
g2_v(4)=(-(y(14)*(params(1)*y(13)*getPowerDeriv(y(4),params(1)-1,2)-((-params(3))*T(12)+(-params(3))*T(12)+(y(12)-params(3)*y(4))*params(6)*params(3)*(y(4)+y(4))/(y(4)*y(4)*y(4)*y(4))))-(T(17)+T(6)*2*params(6)*(T(4)*T(4)*(-2)-(-(2*y(4)))*(T(4)*2*y(4)+T(4)*2*y(4)))/(T(4)*T(4)*T(4)*T(4))+T(17)+T(5)*(-params(3))*2*(-params(3)))));
g2_v(5)=(-(y(14)*(-T(12))-(T(14)*2*(y(12)-params(3)*y(4))+T(5)*2*(-params(3)))));
g2_v(6)=g2_v(5);
g2_v(7)=(-(y(14)*params(1)*T(11)));
g2_v(8)=g2_v(7);
g2_v(9)=(-T(13));
g2_v(10)=g2_v(9);
g2_v(11)=(-(1-params(3)));
g2_v(12)=g2_v(11);
g2_v(13)=2*T(5);
g2_v(14)=T(2);
g2_v(15)=g2_v(14);
g2_v(16)=(-(params(1)*T(1)));
g2_v(17)=g2_v(16);
g2_v(18)=(-(y(7)*getPowerDeriv(y(1),params(1),2)-(2*y(1)*2*y(1)*2*y(1)*params(6)*(-params(3))*2*(-params(3))-(2*y(1)*params(6)*(-params(3))*2*(y(6)-params(3)*y(1))-2*T(8))*(2*2*y(1)+2*2*y(1)))/(2*y(1)*2*y(1)*2*y(1)*2*y(1))));
g2_v(19)=(2*y(1)*params(6)*2*(-params(3))-2*params(6)*2*(y(6)-params(3)*y(1)))/(2*y(1)*2*y(1));
g2_v(20)=g2_v(19);
g2_v(21)=(-T(10));
g2_v(22)=g2_v(21);
g2_v(23)=2*params(6)/(2*y(1));
g2_v(24)=(-(T(9)*(T(16)*(-((-y(9))*(y(3)+y(3))))/(y(3)*y(3)*y(3)*y(3))+T(15)*T(15)*T(18))));
g2_v(25)=(-(T(9)*(T(16)*(-1)/(y(3)*y(3))+T(15)*1/y(3)*T(18))));
g2_v(26)=g2_v(25);
g2_v(27)=(-(T(9)*1/y(3)*1/y(3)*T(18)));
g2 = sparse(g2_i,g2_j,g2_v,7,256);
end
