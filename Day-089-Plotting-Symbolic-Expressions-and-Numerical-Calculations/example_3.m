% Day 089 · Plotting Symbolic Expressions and Numerical Calculations — Fast numeric evaluation with matlabFunction
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Needs: Symbolic Math Toolbox
syms t w zeta positive
step_resp = 1 - exp(-zeta*w*t)*(cos(w*sqrt(1 - zeta^2)*t) + zeta/sqrt(1 - zeta^2)*sin(w*sqrt(1 - zeta^2)*t));
g = matlabFunction(step_resp, 'Vars', [t w zeta]);   % fixes the order of the inputs
tt = linspace(0, 3, 300);
hold on
for z = [0.2 0.5 0.8]
    plot(tt, g(tt, 5, z), 'DisplayName', sprintf('\\zeta = %.1f', z));
end
hold off; grid on; legend show
xlabel('t (s)'); title('Second-order step responses (\omega_n = 5 rad/s)')
peak = max(g(tt, 5, 0.2));
fprintf('Overshoot for zeta = 0.2: %.1f %% (theory %.1f %%)\n', 100*(peak - 1), 100*exp(-0.2*pi/sqrt(1 - 0.04)));
