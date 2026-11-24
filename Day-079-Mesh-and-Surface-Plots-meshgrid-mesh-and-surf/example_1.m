% Day 079 · Mesh and Surface Plots: meshgrid, mesh and surf — meshgrid, mesh and surf
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

x = -3:0.25:3;
y = -3:0.25:3;
[X, Y] = meshgrid(x, y);
Z = 1.8.^(-1.5*sqrt(X.^2 + Y.^2)) .* cos(0.5*Y) .* sin(X);
subplot(1, 2, 1); mesh(X, Y, Z); title('mesh'); xlabel('x'); ylabel('y')
subplot(1, 2, 2); surf(X, Y, Z); title('surf'); xlabel('x'); ylabel('y')
colorbar
size(X)
