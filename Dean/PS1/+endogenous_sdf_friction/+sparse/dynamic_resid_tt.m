function [T_order, T] = dynamic_resid_tt(y, x, params, steady_state, T_order, T)
if T_order >= 0
    return
end
T_order = 0;
if size(T, 1) < 4
    T = [T; NaN(4 - size(T, 1), 1)];
end
T(1) = y(7)^(params(1)-1);
T(2) = params(1)*y(16)*T(1)-params(4)*params(3)*(y(15)-y(7));
T(3) = y(1)^params(1);
T(4) = params(4)*(y(7)-y(1))^2;
end
