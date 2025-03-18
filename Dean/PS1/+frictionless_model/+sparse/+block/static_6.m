function [y, T] = static_6(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(6)=y(4)*y(1)^params(1)-y(3);
end
