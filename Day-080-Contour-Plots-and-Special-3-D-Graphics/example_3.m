% Day 080 · Contour Plots and Special 3-D Graphics — A vector field with quiver and a heat map
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

[X, Y] = meshgrid(-2:0.25:2);
U = -Y;  V = X;                         % a rotating field
subplot(1, 2, 1)
quiver(X, Y, U, V); axis equal; title('Rotating field')
subplot(1, 2, 2)
T = 25 + 75*exp(-((X - 0.5).^2 + Y.^2));   % a hot spot on a plate
imagesc(-2:0.25:2, -2:0.25:2, T); axis xy; axis equal tight
colorbar; title('Temperature (C)')
