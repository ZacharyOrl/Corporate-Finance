function [T_order, T] = dynamic_g2_tt(y, x, params, steady_state, T_order, T)
if T_order >= 2
    return
end
[T_order, T] = with_adjustment_est.sparse.dynamic_g1_tt(y, x, params, steady_state, T_order, T);
T_order = 2;
if size(T, 1) < 18
    T = [T; NaN(18 - size(T, 1), 1)];
end
T(17) = T(14)*(-params(3))*2*(y(17)-params(3)*y(8));
T(18) = getPowerDeriv(y(13)/y(6),(-params(5)),2);
end
