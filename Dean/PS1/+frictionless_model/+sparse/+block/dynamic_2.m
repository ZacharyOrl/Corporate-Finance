function [y, T, residual, g1] = dynamic_2(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(4, 1);
  residual(1)=(y(7))-(y(9)+(1-params(3))*y(1));
  residual(2)=(y(12))-(y(10)*y(1)^params(1)-y(9));
  T(1)=params(1)*y(16)*y(7)^(params(1)-1)+1-params(3);
  residual(3)=(1)-(y(17)*T(1));
  residual(4)=(y(11))-(1/(1+params(2))*(y(12)/y(6))^(-params(6)));
  T(2)=getPowerDeriv(y(12)/y(6),(-params(6)),1);
if nargout > 3
    g1_v = NaN(11, 1);
g1_v(1)=(-(1/(1+params(2))*(-y(12))/(y(6)*y(6))*T(2)));
g1_v(2)=(-(1-params(3)));
g1_v(3)=(-(y(10)*getPowerDeriv(y(1),params(1),1)));
g1_v(4)=(-1);
g1_v(5)=1;
g1_v(6)=1;
g1_v(7)=(-(1/(1+params(2))*T(2)*1/y(6)));
g1_v(8)=1;
g1_v(9)=(-(y(17)*params(1)*y(16)*getPowerDeriv(y(7),params(1)-1,1)));
g1_v(10)=1;
g1_v(11)=(-T(1));
    if ~isoctave && matlab_ver_less_than('9.8')
        sparse_rowval = double(sparse_rowval);
        sparse_colval = double(sparse_colval);
    end
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 4, 12);
end
end
