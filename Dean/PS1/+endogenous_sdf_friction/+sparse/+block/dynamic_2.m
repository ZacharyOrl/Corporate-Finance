function [y, T, residual, g1] = dynamic_2(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
residual=NaN(5, 1);
  residual(1)=(y(9))-(y(7)+y(1)*(params(3)-1));
  T(1)=params(4)*(y(7)-y(1))^2;
  residual(2)=(y(12))-(y(10)*y(1)^params(1)-y(9)-T(1)/(2*y(1)));
  T(2)=params(1)*y(16)*y(7)^(params(1)-1)-params(4)*params(3)*(y(15)-y(7));
  residual(3)=(y(8))-(y(17)*T(2)/(2*y(7))-params(4)/2*((y(15)-params(3)*y(7))/y(7))^2+y(14)*(1-params(3)));
  residual(4)=(y(8))-(1+params(4)*(y(9)-params(3)*y(1))/y(1));
  residual(5)=(y(11))-(1/(1+params(2))*(y(12)/y(6))^(-params(7)));
  T(3)=getPowerDeriv(y(12)/y(6),(-params(7)),1);
if nargout > 3
    g1_v = NaN(18, 1);
g1_v(1)=(-(params(3)-1));
g1_v(2)=(-(y(10)*getPowerDeriv(y(1),params(1),1)-(2*y(1)*params(4)*(-(2*(y(7)-y(1))))-2*T(1))/(2*y(1)*2*y(1))));
g1_v(3)=(-((y(1)*params(4)*(-params(3))-params(4)*(y(9)-params(3)*y(1)))/(y(1)*y(1))));
g1_v(4)=(-(1/(1+params(2))*(-y(12))/(y(6)*y(6))*T(3)));
g1_v(5)=(-1);
g1_v(6)=params(4)*2*(y(7)-y(1))/(2*y(1));
g1_v(7)=(-(y(17)*(2*y(7)*(params(4)*params(3)+params(1)*y(16)*getPowerDeriv(y(7),params(1)-1,1))-2*T(2))/(2*y(7)*2*y(7))-params(4)/2*(y(7)*(-params(3))-(y(15)-params(3)*y(7)))/(y(7)*y(7))*2*(y(15)-params(3)*y(7))/y(7)));
g1_v(8)=1;
g1_v(9)=(-(1/(1+params(2))*T(3)*1/y(6)));
g1_v(10)=1;
g1_v(11)=1;
g1_v(12)=1;
g1_v(13)=1;
g1_v(14)=(-(params(4)/y(1)));
g1_v(15)=1;
g1_v(16)=(-(1-params(3)));
g1_v(17)=(-(y(17)*(-(params(4)*params(3)))/(2*y(7))-params(4)/2*2*(y(15)-params(3)*y(7))/y(7)*1/y(7)));
g1_v(18)=(-(T(2)/(2*y(7))));
    if ~isoctave && matlab_ver_less_than('9.8')
        sparse_rowval = double(sparse_rowval);
        sparse_colval = double(sparse_colval);
    end
    g1 = sparse(sparse_rowval, sparse_colval, g1_v, 5, 15);
end
end
