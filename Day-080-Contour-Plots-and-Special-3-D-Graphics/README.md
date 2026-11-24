# Day 080 · Contour Plots and Special 3-D Graphics

_Three-Dimensional Plots_

## Contours
A **contour line** joins points with the same z (like height lines on a map).
| Function | Draws |
|----------|-------|
| `contour(X, Y, Z, n)` | n contour lines |
| `contour(X, Y, Z, levels)` | lines at chosen levels |
| `contourf` | filled contours |
| `contour3` | contour lines at their height in 3-D |
| `[C, h] = contour(...); clabel(C, h)` | label the lines |

## Other 3-D graphics
| Function | Draws |
|----------|-------|
| `bar3(Y)` | 3-D bars (MATLAB) |
| `stem3(x, y, z)` | 3-D stems |
| `scatter3(x, y, z, s, c)` | 3-D points with size and colour |
| `pie3(x)` | a 3-D pie |
| `[X, Y, Z] = sphere(n)` then `surf` | a sphere |
| `[X, Y, Z] = cylinder(r)` | a cylinder or shape of revolution |
| `quiver(X, Y, U, V)` / `quiver3` | arrows of a vector field |
| `streamline`, `slice`, `isosurface` | flow and volume data |
| `fill3`, `patch` | filled polygons in 3-D |
| `pcolor(X, Y, Z)`, `imagesc(Z)` | a coloured map of a matrix seen from above |

## Examples

### Example 1: Contour, filled contour and labels  ([`example_1.m`](example_1.m))

```matlab
[X, Y] = meshgrid(linspace(-3, 3, 100));
Z = 3*(1 - X).^2 .* exp(-X.^2 - (Y + 1).^2) - 10*(X/5 - X.^3 - Y.^5) .* exp(-X.^2 - Y.^2);
subplot(1, 2, 1)
[C, h] = contour(X, Y, Z, 12);
clabel(C, h); title('contour + labels'); axis equal
subplot(1, 2, 2)
contourf(X, Y, Z, 20); colorbar; title('contourf'); axis equal
[zmax, k] = max(Z(:));
fprintf('Highest point %.2f at (%.2f, %.2f)\n', zmax, X(k), Y(k));
```

### Example 2: Points, stems, sphere and cylinder  ([`example_2.m`](example_2.m))

```matlab
subplot(2, 2, 1)
rng(1); P = randn(3, 80);
scatter3(P(1, :), P(2, :), P(3, :), 20, P(3, :), 'filled'); title('scatter3')
% In MATLAB, bar3(magic(4)) draws 3-D bars (not available in GNU Octave)
subplot(2, 2, 2)
t = linspace(0, 2*pi, 20);
stem3(cos(t), sin(t), t); title('stem3')
subplot(2, 2, 3)
[Xs, Ys, Zs] = sphere(30);
surf(Xs, Ys, Zs); axis equal; title('sphere')
subplot(2, 2, 4)
[Xc, Yc, Zc] = cylinder(1 + 0.3*sin(linspace(0, 2*pi, 20)), 40);   % a vase shape
surf(Xc, Yc, Zc); title('cylinder (shape of revolution)')
```

### Example 3: A vector field with quiver and a heat map  ([`example_3.m`](example_3.m))

```matlab
[X, Y] = meshgrid(-2:0.25:2);
U = -Y;  V = X;                         % a rotating field
subplot(1, 2, 1)
quiver(X, Y, U, V); axis equal; title('Rotating field')
subplot(1, 2, 2)
T = 25 + 75*exp(-((X - 0.5).^2 + Y.^2));   % a hot spot on a plate
imagesc(-2:0.25:2, -2:0.25:2, T); axis xy; axis equal tight
colorbar; title('Temperature (C)')
```

## Practice

1. Draw 15 labelled contour lines of `z = x e^{-x² - y²}`.
2. Show monthly sales of 3 products over 6 months with `bar3`.
3. Draw a cone with `cylinder` (radius going linearly from 1 to 0).
4. Plot the field `U = x, V = y` with `quiver`. What does it look like?

---

[⬅ Day 079](../Day-079-Mesh-and-Surface-Plots-meshgrid-mesh-and-surf/README.md) · [🏠 Home](../README.md) · [Day 081 ➡](../Day-081-The-view-Command-Colormaps-Shading-and-Lighting/README.md)
