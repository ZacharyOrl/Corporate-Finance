function [y, T] = static_4(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(7)=y(2)+x(2);
  y(6)=y(4)*y(1)^params(1)-y(3)-params(6)*T(3)/(2*y(1));
end
