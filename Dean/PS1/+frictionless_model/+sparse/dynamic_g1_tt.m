function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = frictionless_model.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 3
    T = [T; NaN(3 - size(T, 1), 1)];
end
T(3) = getPowerDeriv(y(12)/y(6),(-params(6)),1);
end
