% Day 078 · Three-Dimensional Line Plots: plot3 — A charged particle in a magnetic field
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

q = 1.6e-19; m = 9.11e-31; B = [0; 0; 1e-3];     % an electron in 1 mT along z
f = @(t, s) [s(4:6); q/m * cross(s(4:6), B)];
s0 = [0; 0; 0; 1e5; 0; 2e4];                      % start at the origin with velocity
[t, S] = ode45(f, [0 2e-7], s0, odeset('RelTol', 1e-8));
plot3(S(:, 1), S(:, 2), S(:, 3), 'm'); grid on
xlabel('x (m)'); ylabel('y (m)'); zlabel('z (m)'); title('Helical path')
r_theory = m * 1e5 / (abs(q) * 1e-3);
fprintf('Radius of the helix: %.3f mm (theory %.3f mm)\n', (max(S(:, 2)) - min(S(:, 2)))/2*1000, r_theory*1000);
