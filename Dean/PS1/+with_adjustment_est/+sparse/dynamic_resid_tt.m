function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 9
    T = [T; NaN(9 - size(T, 1), 1)];
end
T(1) = y(8)^(params(1)-1);
T(2) = params(6)*params(3)*1/y(8);
T(3) = params(1)*y(18)*T(1)+y(16)*(1-params(3))-T(2)*(y(17)-params(3)*y(8));
T(4) = y(8)^2;
T(5) = 2*params(6)*1/T(4);
T(6) = (y(17)-params(3)*y(8))^2;
T(7) = y(1)^params(1);
T(8) = params(6)*(y(10)-params(3)*y(1))^2;
T(9) = 1/(1+params(2));
end
