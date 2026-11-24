% Day 081 · The view Command, Colormaps, Shading and Lighting — Colormaps and shading
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

[X, Y] = meshgrid(linspace(-2, 2, 60));
Z = sin(X.^2 + Y.^2) ./ (X.^2 + Y.^2 + 0.5);
maps = {'jet', 'hot', 'gray', 'cool'};
for k = 1:4
    ax = subplot(2, 2, k);
    surf(X, Y, Z)
    colormap(ax, maps{k})
    if k <= 2, shading interp; else, shading flat; end
    title(maps{k})
end
