# Day 078 · Three-Dimensional Line Plots: plot3

_Three-Dimensional Plots_

## `plot3(x, y, z)`
Draws a curve through the points (x(k), y(k), z(k)). It is like `plot` with a third vector:
```matlab
plot3(x, y, z, 'line specifiers', 'PropertyName', value)
```
- `x`, `y`, `z` must have the same length.
- Line specifiers and properties are the same as for `plot`.
- `zlabel('...')` labels the third axis; `grid on`, `axis equal`, `axis([xmin xmax ymin ymax zmin zmax])` work as in 2-D.
- Rotate the view with the mouse (**Rotate 3D** button) or with `view` (Day 81).

Uses: trajectories (a projectile with wind, a drone path, a charged particle in a magnetic field), parametric curves (helix), and 3-D data paths.

## Examples

### Example 1: A helix and a conical spiral  ([`example_1.m`](example_1.m))

```matlab
t = linspace(0, 6*pi, 500);
subplot(1, 2, 1)
plot3(cos(t), sin(t), t/(2*pi), 'LineWidth', 1.5)
grid on; xlabel('x'); ylabel('y'); zlabel('turns'); title('Helix')
subplot(1, 2, 2)
r = t / max(t);
plot3(r.*cos(3*t), r.*sin(3*t), r, 'r')
grid on; title('Conical spiral')
```

### Example 2: A projectile with a cross wind  ([`example_2.m`](example_2.m))

```matlab
v0 = 30; elev = 45; g = 9.81; wind = 2.0;        % m/s^2 sideways acceleration
t = linspace(0, 2*v0*sind(elev)/g, 200);
x = v0*cosd(elev)*t;
y = 0.5*wind*t.^2;
z = v0*sind(elev)*t - 0.5*g*t.^2;
plot3(x, y, z, 'b', 'LineWidth', 2); hold on
plot3(x, zeros(size(x)), z, 'k--')                % the path without wind
hold off; grid on
xlabel('Downrange (m)'); ylabel('Drift (m)'); zlabel('Height (m)')
legend('with wind', 'no wind')
fprintf('Range %.1f m, sideways drift %.1f m\n', x(end), y(end));
```

### Example 3: A charged particle in a magnetic field  ([`example_3.m`](example_3.m))

```matlab
q = 1.6e-19; m = 9.11e-31; B = [0; 0; 1e-3];     % an electron in 1 mT along z
f = @(t, s) [s(4:6); q/m * cross(s(4:6), B)];
s0 = [0; 0; 0; 1e5; 0; 2e4];                      % start at the origin with velocity
[t, S] = ode45(f, [0 2e-7], s0, odeset('RelTol', 1e-8));
plot3(S(:, 1), S(:, 2), S(:, 3), 'm'); grid on
xlabel('x (m)'); ylabel('y (m)'); zlabel('z (m)'); title('Helical path')
r_theory = m * 1e5 / (abs(q) * 1e-3);
fprintf('Radius of the helix: %.3f mm (theory %.3f mm)\n', (max(S(:, 2)) - min(S(:, 2)))/2*1000, r_theory*1000);
```

## Practice

1. Plot the 3-D curve `x = t cos t, y = t sin t, z = t` for 0 ≤ t ≤ 10π.
2. Plot two helices of opposite direction in one figure with a legend.
3. Simulate and plot a ball thrown with a sideways velocity.
4. Rotate your plot with the mouse and note the azimuth and elevation shown.

---

[⬅ Day 077](../Day-077-Numerical-Differentiation-and-Finite-Differences/README.md) · [🏠 Home](../README.md) · [Day 079 ➡](../Day-079-Mesh-and-Surface-Plots-meshgrid-mesh-and-surf/README.md)
