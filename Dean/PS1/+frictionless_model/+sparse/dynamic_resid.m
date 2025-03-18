function [residual, T_order, T] = dynamic_resid(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(2, 1);
end
[T_order, T] = frictionless_model.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
residual = NaN(6, 1);
    residual(1) = (y(8)) - (1);
    residual(2) = (1) - (y(17)*(params(1)*y(16)*T(1)+1-params(3)));
    residual(3) = (y(7)) - (y(9)+(1-params(3))*y(1));
    residual(4) = (y(12)) - (y(10)*T(2)-y(9));
    residual(5) = (y(10)) - (params(4)*y(4)+1-params(4)+x(1));
    residual(6) = (y(11)) - (1/(1+params(2))*(y(12)/y(6))^(-params(6)));
end
