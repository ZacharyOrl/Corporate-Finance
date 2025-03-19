function [g2_v, T_order, T] = dynamic_g2(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(18, 1);
end
[T_order, T] = with_adjustment_est.sparse.dynamic_g2_tt(y, x, params, steady_state, T_order, T);
g2_v = NaN(17, 1);
g2_v(1)=(-((-((y(1)*params(6)*(-params(3))-params(6)*(y(10)-params(3)*y(1)))*(y(1)+y(1))))/(y(1)*y(1)*y(1)*y(1))));
g2_v(2)=(-((-params(6))/(y(1)*y(1))));
g2_v(3)=(-(y(19)*(params(1)*y(18)*getPowerDeriv(y(8),params(1)-1,2)-((-params(3))*T(12)+(-params(3))*T(12)+(y(17)-params(3)*y(8))*params(6)*params(3)*(y(8)+y(8))/(y(8)*y(8)*y(8)*y(8))))-(T(17)+T(6)*2*params(6)*(T(4)*T(4)*(-2)-(-(2*y(8)))*(T(4)*2*y(8)+T(4)*2*y(8)))/(T(4)*T(4)*T(4)*T(4))+T(17)+T(5)*(-params(3))*2*(-params(3)))));
g2_v(4)=(-(y(19)*(-T(12))-(T(14)*2*(y(17)-params(3)*y(8))+T(5)*2*(-params(3)))));
g2_v(5)=(-(y(19)*params(1)*T(11)));
g2_v(6)=(-T(13));
g2_v(7)=(-(1-params(3)));
g2_v(8)=2*T(5);
g2_v(9)=T(2);
g2_v(10)=(-(params(1)*T(1)));
g2_v(11)=(-(y(11)*getPowerDeriv(y(1),params(1),2)-(2*y(1)*2*y(1)*2*y(1)*params(6)*(-params(3))*2*(-params(3))-(2*y(1)*params(6)*(-params(3))*2*(y(10)-params(3)*y(1))-2*T(8))*(2*2*y(1)+2*2*y(1)))/(2*y(1)*2*y(1)*2*y(1)*2*y(1))));
g2_v(12)=(2*y(1)*params(6)*2*(-params(3))-2*params(6)*2*(y(10)-params(3)*y(1)))/(2*y(1)*2*y(1));
g2_v(13)=(-T(10));
g2_v(14)=2*params(6)/(2*y(1));
g2_v(15)=(-(T(9)*(T(16)*(-((-y(13))*(y(6)+y(6))))/(y(6)*y(6)*y(6)*y(6))+T(15)*T(15)*T(18))));
g2_v(16)=(-(T(9)*(T(16)*(-1)/(y(6)*y(6))+T(15)*1/y(6)*T(18))));
g2_v(17)=(-(T(9)*1/y(6)*1/y(6)*T(18)));
end
