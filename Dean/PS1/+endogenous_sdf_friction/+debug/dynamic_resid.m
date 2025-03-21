function [lhs, rhs] = dynamic_resid(y, x, params, steady_state)
T = NaN(4, 1);
lhs = NaN(6, 1);
rhs = NaN(6, 1);
T(1) = y(7)^(params(1)-1);
T(2) = params(1)*y(16)*T(1)-params(4)*params(3)*(y(15)-y(7));
T(3) = y(1)^params(1);
T(4) = params(4)*(y(7)-y(1))^2;
lhs(1) = y(8);
rhs(1) = 1+params(4)*(y(9)-params(3)*y(1))/y(1);
lhs(2) = y(8);
rhs(2) = y(17)*T(2)/(2*y(7))-params(4)/2*((y(15)-params(3)*y(7))/y(7))^2+y(14)*(1-params(3));
lhs(3) = y(9);
rhs(3) = y(7)+y(1)*(params(3)-1);
lhs(4) = y(12);
rhs(4) = y(10)*T(3)-y(9)-T(4)/(2*y(1));
lhs(5) = y(10);
rhs(5) = params(5)*y(4)+1-params(5)+x(1);
lhs(6) = y(11);
rhs(6) = 1/(1+params(2))*(y(12)/y(6))^(-params(7));
end
