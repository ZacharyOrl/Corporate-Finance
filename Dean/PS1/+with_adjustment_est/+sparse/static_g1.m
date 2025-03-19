function [g1, T_order, T] = static_g1(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T_order, T)
if nargin < 8
    T_order = -1;
    T = NaN(5, 1);
end
[T_order, T] = with_adjustment_est.sparse.static_g1_tt(y, x, params, T_order, T);
g1_v = NaN(18, 1);
g1_v(1)=(-((y(1)*params(6)*(-params(3))-params(6)*(y(3)-params(3)*y(1)))/(y(1)*y(1))));
g1_v(2)=(-(y(5)*(params(1)*y(4)*getPowerDeriv(y(1),params(1)-1,1)-(params(6)*params(3)*1/y(1)*(-params(3))+(y(3)-params(3)*y(1))*params(6)*params(3)*(-1)/(y(1)*y(1))))-(T(4)*2*params(6)*(-(2*y(1)))/(T(3)*T(3))+2*params(6)*1/T(3)*(-params(3))*2*(y(3)-params(3)*y(1)))));
g1_v(3)=(-params(3));
g1_v(4)=(-(y(4)*getPowerDeriv(y(1),params(1),1)-(2*y(1)*params(6)*(-params(3))*2*(y(3)-params(3)*y(1))-2*params(6)*T(4))/(2*y(1)*2*y(1))));
g1_v(5)=1;
g1_v(6)=1-y(5)*(1-params(3));
g1_v(7)=(-1);
g1_v(8)=(-(params(6)/y(1)));
g1_v(9)=(-(y(5)*(-(params(6)*params(3)*1/y(1)))-2*params(6)*1/T(3)*2*(y(3)-params(3)*y(1))));
g1_v(10)=1;
g1_v(11)=(-((-1)-params(6)*2*(y(3)-params(3)*y(1))/(2*y(1))));
g1_v(12)=(-(y(5)*params(1)*T(1)));
g1_v(13)=(-T(5));
g1_v(14)=1-params(4);
g1_v(15)=(-T(2));
g1_v(16)=1;
g1_v(17)=1;
g1_v(18)=1;
if ~isoctave && matlab_ver_less_than('9.8')
    sparse_rowval = double(sparse_rowval);
    sparse_colval = double(sparse_colval);
end
g1 = sparse(sparse_rowval, sparse_colval, g1_v, 7, 7);
end
