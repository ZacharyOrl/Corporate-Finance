function [T_order, T] = dynamic_g1_tt(y, x, params, steady_state, T_order, T)
if T_order >= 1
    return
end
[T_order, T] = with_adjustment_est.sparse.dynamic_resid_tt(y, x, params, steady_state, T_order, T);
T_order = 1;
if size(T, 1) < 16
    T = [T; NaN(16 - size(T, 1), 1)];
end
T(10) = getPowerDeriv(y(1),params(1),1);
T(11) = getPowerDeriv(y(8),params(1)-1,1);
T(12) = params(6)*params(3)*(-1)/(y(8)*y(8));
T(13) = params(1)*y(18)*T(11)-((y(17)-params(3)*y(8))*T(12)+T(2)*(-params(3)));
T(14) = 2*params(6)*(-(2*y(8)))/(T(4)*T(4));
T(15) = (-y(13))/(y(6)*y(6));
T(16) = getPowerDeriv(y(13)/y(6),(-params(5)),1);
end
