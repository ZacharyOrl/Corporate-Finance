function [residual, T_order, T] = dynamic_resid(y, x, params, steady_state, T_order, T)
if nargin < 6
    T_order = -1;
    T = NaN(4, 1);
end
[T_order, T] = endogenous_sdf_friction.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
residual = NaN(6, 1);
    residual(1) = (y(8)) - (1+params(4)*(y(9)-params(3)*y(1))/y(1));
    residual(2) = (y(8)) - (y(17)*T(2)/(2*y(7))-params(4)/2*((y(15)-params(3)*y(7))/y(7))^2+y(14)*(1-params(3)));
    residual(3) = (y(9)) - (y(7)+y(1)*(params(3)-1));
    residual(4) = (y(12)) - (y(10)*T(3)-y(9)-T(4)/(2*y(1)));
    residual(5) = (y(10)) - (params(5)*y(4)+1-params(5)+x(1));
    residual(6) = (y(11)) - (1/(1+params(2))*(y(12)/y(6))^(-params(7)));
end
