function [g1, T_order, T] = static_g1(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T_order, T)
if nargin < 8
    T_order = -1;
    T = NaN(2, 1);
end
[T_order, T] = frictionless_model.sparse.static_g1_tt(y, x, params, T_order, T);
g1_v = NaN(12, 1);
g1_v(1)=(-(y(5)*params(1)*y(4)*getPowerDeriv(y(1),params(1)-1,1)));
g1_v(2)=1-(1-params(3));
g1_v(3)=(-(y(4)*getPowerDeriv(y(1),params(1),1)));
g1_v(4)=1;
g1_v(5)=(-1);
g1_v(6)=1;
g1_v(7)=(-(y(5)*params(1)*T(1)));
g1_v(8)=(-T(2));
g1_v(9)=1-params(4);
g1_v(10)=(-(params(1)*y(4)*T(1)+1-params(3)));
g1_v(11)=1;
g1_v(12)=1;
if ~isoctave && matlab_ver_less_than('9.8')
    sparse_rowval = double(sparse_rowval);
    sparse_colval = double(sparse_colval);
end
g1 = sparse(sparse_rowval, sparse_colval, g1_v, 6, 6);
end
