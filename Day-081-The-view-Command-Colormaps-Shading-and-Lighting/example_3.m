% Day 081 · The view Command, Colormaps, Shading and Lighting — Lighting a surface and rotating with a loop
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

[X, Y, Z] = sphere(60);
surf(X, Y, Z, 'FaceColor', [0.2 0.6 1], 'EdgeColor', 'none')
axis equal off
light('Position', [2 2 3])
lighting gouraud
material shiny
for az = 0:30:90
    view(az, 25)
    drawnow
end
[az, el] = view;
fprintf('Final view: azimuth %g, elevation %g\n', az, el);
