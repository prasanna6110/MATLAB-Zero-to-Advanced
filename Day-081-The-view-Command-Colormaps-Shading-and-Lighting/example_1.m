% Day 081 · The view Command, Colormaps, Shading and Lighting — The same surface from four views
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

[X, Y] = meshgrid(-3:0.15:3);
Z = peaks(X, Y);
views = [-37.5 30; 0 90; 0 0; 90 0];
names = {'default view(3)', 'top view(2)', 'x-z plane view(0,0)', 'y-z plane view(90,0)'};
for k = 1:4
    subplot(2, 2, k)
    surf(X, Y, Z); shading interp
    view(views(k, 1), views(k, 2)); title(names{k})
    xlabel('x'); ylabel('y'); zlabel('z')
end
