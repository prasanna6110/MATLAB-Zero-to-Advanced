% Day 076 · Systems of Nonlinear Equations: fsolve and Newton-Raphson — Solving two nonlinear equations with fsolve
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Needs: Optimization Toolbox (fsolve is built into GNU Octave)
F = @(v) [v(1)^2 + v(2)^2 - 4;
          exp(v(1)) + v(2) - 1];
[v, Fval, flag] = fsolve(F, [1; -1], optimset('Display', 'off'));
fprintf('Solution x = %.6f, y = %.6f (flag %d, residual %.1e)\n', v, flag, norm(Fval));
[v2, ~] = fsolve(F, [-2; 1], optimset('Display', 'off'));
fprintf('Another solution from another guess: x = %.6f, y = %.6f\n', v2);
th = linspace(0, 2*pi, 200);
plot(2*cos(th), 2*sin(th), 'b'); hold on
x = linspace(-2.5, 1.2, 200); plot(x, 1 - exp(x), 'r')
plot([v(1) v2(1)], [v(2) v2(2)], 'ko', 'MarkerFaceColor', 'k'); hold off
axis equal; grid on; legend('x^2 + y^2 = 4', 'y = 1 - e^x')
