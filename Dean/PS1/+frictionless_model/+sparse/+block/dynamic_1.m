function [y, T] = dynamic_1(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(8)=1;
  y(10)=params(4)*y(4)+1-params(4)+x(1);
end
