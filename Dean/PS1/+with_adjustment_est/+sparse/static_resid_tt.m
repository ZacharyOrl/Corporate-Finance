function [T_order, T] = static_resid_tt(y, x, params, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 5
    T = [T; NaN(5 - size(T, 1), 1)];
end
T(1) = y(1)^(params(1)-1);
T(2) = params(1)*y(4)*T(1)+y(2)*(1-params(3))-(y(3)-params(3)*y(1))*params(6)*params(3)*1/y(1);
T(3) = y(1)^2;
T(4) = (y(3)-params(3)*y(1))^2;
T(5) = y(1)^params(1);
end
