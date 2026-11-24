% Day 079 · Mesh and Surface Plots: meshgrid, mesh and surf — The voltage around two point charges
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

k = 8.99e9; q1 = 2e-9; q2 = -1e-9;
[X, Y] = meshgrid(linspace(-2, 2, 81));
r1 = sqrt((X + 0.6).^2 + Y.^2) + 0.05;          % +0.05 avoids division by zero
r2 = sqrt((X - 0.6).^2 + Y.^2) + 0.05;
V = k*q1./r1 + k*q2./r2;
V = max(min(V, 200), -100);                     % clip the peaks for a readable plot
surfc(X, Y, V)
xlabel('x (m)'); ylabel('y (m)'); zlabel('V (volt)'); title('Potential of two charges')
colorbar
