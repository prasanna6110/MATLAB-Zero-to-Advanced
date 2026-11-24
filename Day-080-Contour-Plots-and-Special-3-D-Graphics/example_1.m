% Day 080 · Contour Plots and Special 3-D Graphics — Contour, filled contour and labels
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

[X, Y] = meshgrid(linspace(-3, 3, 100));
Z = 3*(1 - X).^2 .* exp(-X.^2 - (Y + 1).^2) - 10*(X/5 - X.^3 - Y.^5) .* exp(-X.^2 - Y.^2);
subplot(1, 2, 1)
[C, h] = contour(X, Y, Z, 12);
clabel(C, h); title('contour + labels'); axis equal
subplot(1, 2, 2)
contourf(X, Y, Z, 20); colorbar; title('contourf'); axis equal
[zmax, k] = max(Z(:));
fprintf('Highest point %.2f at (%.2f, %.2f)\n', zmax, X(k), Y(k));
