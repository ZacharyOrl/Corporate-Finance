function [g1, T_order, T] = dynamic_g1(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T_order, T)
if nargin < 9
    T_order = -1;
    T = NaN(16, 1);
end
[T_order, T] = with_adjustment_est.sparse.dynamic_g1_tt(y, x, params, steady_state, T_order, T);
g1_v = NaN(25, 1);
g1_v(1)=(-((y(1)*params(6)*(-params(3))-params(6)*(y(10)-params(3)*y(1)))/(y(1)*y(1))));
g1_v(2)=(-(params(3)-1));
g1_v(3)=(-(y(11)*T(10)-(2*y(1)*params(6)*(-params(3))*2*(y(10)-params(3)*y(1))-2*T(8))/(2*y(1)*2*y(1))));
g1_v(4)=(-params(4));
g1_v(5)=(-(T(9)*T(15)*T(16)));
g1_v(6)=(-(y(19)*T(13)-(T(6)*T(14)+T(5)*(-params(3))*2*(y(17)-params(3)*y(8)))));
g1_v(7)=(-1);
g1_v(8)=1;
g1_v(9)=1;
g1_v(10)=(-1);
g1_v(11)=(-(params(6)/y(1)));
g1_v(12)=1;
g1_v(13)=(-((-1)-params(6)*2*(y(10)-params(3)*y(1))/(2*y(1))));
g1_v(14)=(-T(7));
g1_v(15)=1;
g1_v(16)=1;
g1_v(17)=1;
g1_v(18)=(-(T(9)*T(16)*1/y(6)));
g1_v(19)=1;
g1_v(20)=(-(y(19)*(1-params(3))));
g1_v(21)=(-(y(19)*(-T(2))-T(5)*2*(y(17)-params(3)*y(8))));
g1_v(22)=(-(y(19)*params(1)*T(1)));
g1_v(23)=(-T(3));
g1_v(24)=(-1);
g1_v(25)=(-1);
if ~isoctave && matlab_ver_less_than('9.8')
    sparse_rowval = double(sparse_rowval);
    sparse_colval = double(sparse_colval);
end
g1 = sparse(sparse_rowval, sparse_colval, g1_v, 7, 23);
end
