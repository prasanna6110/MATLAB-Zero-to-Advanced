# Day 081 · The view Command, Colormaps, Shading and Lighting

_Three-Dimensional Plots_

## `view`
`view(az, el)` sets the viewing direction:
- **azimuth** `az`: the angle in the x-y plane, measured from the negative y-axis, counter-clockwise (degrees)
- **elevation** `el`: the angle above the x-y plane

| Command | View |
|---------|------|
| `view(3)` | the default 3-D view (az = -37.5, el = 30) |
| `view(2)` or `view(0, 90)` | from the top (x-y plane) |
| `view(0, 0)` | the x-z plane |
| `view(90, 0)` | the y-z plane |
| `[az, el] = view` | read the current view |

## Colour and appearance
| Command | Effect |
|---------|--------|
| `colormap(name)` | `parula` (default), `jet`, `hot`, `cool`, `gray`, `turbo`, `hsv`, `bone`, `copper`, `winter`, `summer` … |
| `colorbar` | the colour scale |
| `caxis([a b])` / `clim([a b])` | the z range of the colours |
| `shading flat / faceted / interp` | edge and face style of `surf` |
| `light`, `lighting gouraud`, `material shiny` | lighting effects |
| `camlight left` | a light relative to the camera |
| `alpha(0.5)` | transparency |
| `axis vis3d`, `daspect([1 1 1])` | keep the proportions while rotating |

## Examples

### Example 1: The same surface from four views  ([`example_1.m`](example_1.m))

```matlab
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
```

### Example 2: Colormaps and shading  ([`example_2.m`](example_2.m))

```matlab
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
```

### Example 3: Lighting a surface and rotating with a loop  ([`example_3.m`](example_3.m))

```matlab
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
```

## Practice

1. Plot `peaks` and show it from the top, front and side in three subplots.
2. Try 4 different colormaps on the same surface and choose the clearest one.
3. Add a light and `lighting gouraud` to a `surf` plot.
4. What do `view(2)` plots of a surface look like compared to `contourf`?

---

[⬅ Day 080](../Day-080-Contour-Plots-and-Special-3-D-Graphics/README.md) · [🏠 Home](../README.md) · [Day 082 ➡](../Day-082-Animation-in-MATLAB/README.md)
