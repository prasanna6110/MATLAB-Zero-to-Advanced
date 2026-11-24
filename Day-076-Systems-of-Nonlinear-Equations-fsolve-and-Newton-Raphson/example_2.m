% Day 076 · Systems of Nonlinear Equations: fsolve and Newton-Raphson — Newton-Raphson written by hand
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

F = @(v) [v(1)^2 + v(2)^2 - 4;  exp(v(1)) + v(2) - 1];
J = @(v) [2*v(1)    2*v(2);
          exp(v(1)) 1     ];
v = [1; -1];
for k = 1:20
    dv = -J(v) \ F(v);
    v = v + dv;
    fprintf('iter %d: x = %.10f, y = %.10f, |step| = %.2e\n', k, v, norm(dv));
    if norm(dv) < 1e-12, break; end
end
