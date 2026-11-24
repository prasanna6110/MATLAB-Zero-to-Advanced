# Day 079 · Mesh and Surface Plots: meshgrid, mesh and surf

_Three-Dimensional Plots_

## Step 1: a grid in the x-y plane
`[X, Y] = meshgrid(x, y)` turns two vectors into two matrices with the x and y coordinates of **every grid point**.
```matlab
x = -2:0.1:2;  y = -1:0.1:3;
[X, Y] = meshgrid(x, y);      % size: numel(y) x numel(x)
```
## Step 2: z at every grid point
Use **element-wise** operators: `Z = X.*exp(-X.^2 - Y.^2)`.

## Step 3: plot
| Function | Draws |
|----------|-------|
| `mesh(X, Y, Z)` | a wire-frame (coloured lines) |
| `surf(X, Y, Z)` | a surface with coloured faces |
| `surfc`, `meshc` | with contour lines under it |
| `meshz` | with a "curtain" around the edges |
| `surfl` | with lighting |
| `waterfall` | mesh lines in one direction only |

The colour follows z (the `colormap`). Add `colorbar` to show the scale, and `shading interp` for a smooth look (Day 81).

`[X, Y] = ndgrid(...)` is similar but with the first two dimensions swapped; `meshgrid` is the usual choice for plotting.

## Examples

### Example 1: meshgrid, mesh and surf  ([`example_1.m`](example_1.m))

```matlab
x = -3:0.25:3;
y = -3:0.25:3;
[X, Y] = meshgrid(x, y);
Z = 1.8.^(-1.5*sqrt(X.^2 + Y.^2)) .* cos(0.5*Y) .* sin(X);
subplot(1, 2, 1); mesh(X, Y, Z); title('mesh'); xlabel('x'); ylabel('y')
subplot(1, 2, 2); surf(X, Y, Z); title('surf'); xlabel('x'); ylabel('y')
colorbar
size(X)
```

### Example 2: What meshgrid really makes  ([`example_2.m`](example_2.m))

```matlab
[X, Y] = meshgrid(1:4, 10:10:30)
Z = X + Y                         % the value at every combination
% The same with implicit expansion (no meshgrid needed for calculation):
Z2 = (1:4) + (10:10:30)'
```

### Example 3: The voltage around two point charges  ([`example_3.m`](example_3.m))

```matlab
k = 8.99e9; q1 = 2e-9; q2 = -1e-9;
[X, Y] = meshgrid(linspace(-2, 2, 81));
r1 = sqrt((X + 0.6).^2 + Y.^2) + 0.05;          % +0.05 avoids division by zero
r2 = sqrt((X - 0.6).^2 + Y.^2) + 0.05;
V = k*q1./r1 + k*q2./r2;
V = max(min(V, 200), -100);                     % clip the peaks for a readable plot
surfc(X, Y, V)
xlabel('x (m)'); ylabel('y (m)'); zlabel('V (volt)'); title('Potential of two charges')
colorbar
```

## Practice

1. Plot `z = sin(√(x² + y²))/√(x² + y²)` (the "sombrero") with `surf`.
2. Plot `z = x² - y²` (a saddle) with `mesh` and then `meshz`.
3. What sizes are X and Y from `meshgrid(1:5, 1:3)`?
4. Plot the temperature `T = 100 e^{-(x²+y²)/2}` over a plate with `surfc`.

---

[⬅ Day 078](../Day-078-Three-Dimensional-Line-Plots-plot3/README.md) · [🏠 Home](../README.md) · [Day 080 ➡](../Day-080-Contour-Plots-and-Special-3-D-Graphics/README.md)
