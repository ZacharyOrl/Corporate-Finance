function [g1, T_order, T] = dynamic_g1(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T_order, T)
if nargin < 9
    T_order = -1;
    T = NaN(5, 1);
end
[T_order, T] = endogenous_sdf_friction.sparse.dynamic_g1_tt(y, x, params, steady_state, T_order, T);
g1_v = NaN(23, 1);
g1_v(1)=(-((y(1)*params(4)*(-params(3))-params(4)*(y(9)-params(3)*y(1)))/(y(1)*y(1))));
g1_v(2)=(-(params(3)-1));
g1_v(3)=(-(y(10)*getPowerDeriv(y(1),params(1),1)-(2*y(1)*params(4)*(-(2*(y(7)-y(1))))-2*T(4))/(2*y(1)*2*y(1))));
g1_v(4)=(-params(5));
g1_v(5)=(-(1/(1+params(2))*(-y(12))/(y(6)*y(6))*T(5)));
g1_v(6)=(-(y(17)*(2*y(7)*(params(4)*params(3)+params(1)*y(16)*getPowerDeriv(y(7),params(1)-1,1))-2*T(2))/(2*y(7)*2*y(7))-params(4)/2*(y(7)*(-params(3))-(y(15)-params(3)*y(7)))/(y(7)*y(7))*2*(y(15)-params(3)*y(7))/y(7)));
g1_v(7)=(-1);
g1_v(8)=params(4)*2*(y(7)-y(1))/(2*y(1));
g1_v(9)=1;
g1_v(10)=1;
g1_v(11)=(-(params(4)/y(1)));
g1_v(12)=1;
g1_v(13)=1;
g1_v(14)=(-T(3));
g1_v(15)=1;
g1_v(16)=1;
g1_v(17)=1;
g1_v(18)=(-(1/(1+params(2))*T(5)*1/y(6)));
g1_v(19)=(-(1-params(3)));
g1_v(20)=(-(y(17)*(-(params(4)*params(3)))/(2*y(7))-params(4)/2*2*(y(15)-params(3)*y(7))/y(7)*1/y(7)));
g1_v(21)=(-(y(17)*params(1)*T(1)/(2*y(7))));
g1_v(22)=(-(T(2)/(2*y(7))));
g1_v(23)=(-1);
if ~isoctave && matlab_ver_less_than('9.8')
    sparse_rowval = double(sparse_rowval);
    sparse_colval = double(sparse_colval);
end
g1 = sparse(sparse_rowval, sparse_colval, g1_v, 6, 19);
end
