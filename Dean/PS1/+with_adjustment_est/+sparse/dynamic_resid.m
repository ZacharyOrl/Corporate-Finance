function [residual, T_order, T] = dynamic_resid(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(9, 1);
end
[T_order, T] = with_adjustment_est.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
residual = NaN(7, 1);
    residual(1) = (y(9)) - (1+params(6)*(y(10)-params(3)*y(1))/y(1));
    residual(2) = (y(9)) - (y(19)*T(3)-T(5)*T(6));
    residual(3) = (y(10)) - (y(8)+y(1)*(params(3)-1));
    residual(4) = (y(13)) - (y(11)*T(7)-y(10)-T(8)/(2*y(1)));
    residual(5) = (y(11)) - (params(4)*y(4)+1-params(4)+x(1));
    residual(6) = (y(12)) - (T(9)*(y(13)/y(6))^(-params(5)));
    residual(7) = (y(14)) - (y(9)+x(2));
end
