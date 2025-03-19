function [y, T, residual, g1] = dynamic_2(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(5, 1);
  residual(1)=(y(10))-(y(8)+y(1)*(params(3)-1));
  T(1)=params(6)*(y(10)-params(3)*y(1))^2;
  residual(2)=(y(13))-(y(11)*y(1)^params(1)-y(10)-T(1)/(2*y(1)));
  T(2)=params(1)*y(18)*y(8)^(params(1)-1)+y(16)*(1-params(3))-params(6)*params(3)*1/y(8)*(y(17)-params(3)*y(8));
  T(3)=y(8)^2;
  T(4)=(y(17)-params(3)*y(8))^2;
  residual(3)=(y(9))-(y(19)*T(2)-2*params(6)*1/T(3)*T(4));
  residual(4)=(y(9))-(1+params(6)*(y(10)-params(3)*y(1))/y(1));
  residual(5)=(y(12))-(1/(1+params(2))*(y(13)/y(6))^(-params(5)));
  T(5)=getPowerDeriv(y(13)/y(6),(-params(5)),1);
if nargout > 3
    g1_v = NaN(17, 1);
g1_v(1)=(-(params(3)-1));
g1_v(2)=(-(y(11)*getPowerDeriv(y(1),params(1),1)-(2*y(1)*params(6)*(-params(3))*2*(y(10)-params(3)*y(1))-2*T(1))/(2*y(1)*2*y(1))));
g1_v(3)=(-((y(1)*params(6)*(-params(3))-params(6)*(y(10)-params(3)*y(1)))/(y(1)*y(1))));
g1_v(4)=(-(1/(1+params(2))*(-y(13))/(y(6)*y(6))*T(5)));
g1_v(5)=(-1);
g1_v(6)=(-(y(19)*(params(1)*y(18)*getPowerDeriv(y(8),params(1)-1,1)-((y(17)-params(3)*y(8))*params(6)*params(3)*(-1)/(y(8)*y(8))+params(6)*params(3)*1/y(8)*(-params(3))))-(T(4)*2*params(6)*(-(2*y(8)))/(T(3)*T(3))+2*params(6)*1/T(3)*(-params(3))*2*(y(17)-params(3)*y(8)))));
g1_v(7)=1;
g1_v(8)=(-(1/(1+params(2))*T(5)*1/y(6)));
g1_v(9)=1;
g1_v(10)=1;
g1_v(11)=1;
g1_v(12)=(-((-1)-params(6)*2*(y(10)-params(3)*y(1))/(2*y(1))));
g1_v(13)=(-(params(6)/y(1)));
g1_v(14)=1;
g1_v(15)=(-(y(19)*(1-params(3))));
g1_v(16)=(-(y(19)*(-(params(6)*params(3)*1/y(8)))-2*params(6)*1/T(3)*2*(y(17)-params(3)*y(8))));
g1_v(17)=(-T(2));
    if ~isoctave && matlab_ver_less_than('9.8')
        sparse_rowval = double(sparse_rowval);
        sparse_colval = double(sparse_colval);
    end
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 5, 15);
end
end
