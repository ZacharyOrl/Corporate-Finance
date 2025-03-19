function [y, T] = static_2(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(5)=1/(1+params(2));
end
