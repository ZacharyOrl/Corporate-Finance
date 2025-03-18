function [residual, T_order, T] = static_resid(y, x, params, T_order, T)
if nargin < 5
    T_order = -1;
    T = NaN(3, 1);
end
[T_order, T] = endogenous_sdf_friction.sparse.static_resid_tt(y, x, params, T_order, T);
residual = NaN(6, 1);
    residual(1) = (y(2)) - (1+params(4)*(y(3)-params(3)*y(1))/y(1));
    residual(2) = (y(2)) - (y(5)*T(2)/(2*y(1))-params(4)/2*((y(3)-params(3)*y(1))/y(1))^2+y(2)*(1-params(3)));
    residual(3) = (y(3)) - (y(1)+y(1)*(params(3)-1));
    residual(4) = (y(6)) - (y(4)*T(3)-y(3));
    residual(5) = (y(4)) - (y(4)*params(5)+1-params(5)+x(1));
    residual(6) = (y(5)) - (1/(1+params(2)));
end
