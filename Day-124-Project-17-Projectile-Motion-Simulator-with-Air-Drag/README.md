# Day 124 · Project 17: Projectile Motion Simulator with Air Drag

_Projects_

## Goal
Simulate a projectile **with air resistance** (drag ∝ v²), stop the simulation exactly when it hits the ground using **ODE events**, compare with the drag-free formulas, and find the **launch angle that gives the maximum range** (it is less than 45° when there is drag).

## Model
State [x, y, vx, vy]:
- dx/dt = vx, dy/dt = vy
- dvx/dt = -(k/m)·v·vx, dvy/dt = -g - (k/m)·v·vy, with v = √(vx² + vy²), k = ½ρ C_d A

## Concepts used
`ode45` with an **Events** function, nested anonymous functions, `fminbnd` for the best angle, parameter sweeps, plots.

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear; close all;
p = struct('m', 0.145, 'Cd', 0.35, 'r', 0.037, 'rho', 1.2, 'g', 9.81);   % a cricket-ball-sized sphere
p.k = 0.5*p.rho*p.Cd*pi*p.r^2;
v0 = 40;
angles = [20 30 40 45 50 60];
fprintf('%7s %12s %12s %12s %10s\n', 'Angle', 'Range drag', 'Range ideal', 'Max height', 'Time');
for a = angles
    s = fly(v0, a, p);
    ideal = v0^2*sind(2*a)/p.g;
    fprintf('%7d %12.2f %12.2f %12.2f %10.2f\n', a, s.range, ideal, s.hmax, s.T);
    plot(s.x, s.y, 'DisplayName', sprintf('%d deg', a)); hold on
end
[a_best, negR] = fminbnd(@(a) -fly(v0, a, p).range, 10, 60);
fprintf('\nBest angle with drag: %.2f deg (range %.2f m). Without drag it would be 45 deg (%.2f m).\n', a_best, -negR, v0^2/p.g);
s = fly(v0, a_best, p);
plot(s.x, s.y, 'k', 'LineWidth', 2, 'DisplayName', 'best angle'); hold off
axis equal; grid on; xlabel('x (m)'); ylabel('y (m)'); legend show; title('Trajectories with air drag')
fprintf('Impact speed %.2f m/s (launch %.1f m/s): %.0f%% of the kinetic energy was lost to drag\n', s.vimpact, v0, 100*(1 - (s.vimpact/v0)^2));

function s = fly(v0, angle_deg, p)
    f = @(t, z) [z(3); z(4); -p.k/p.m*hypot(z(3), z(4))*z(3); -p.g - p.k/p.m*hypot(z(3), z(4))*z(4)];
    opts = odeset('Events', @hit_ground, 'RelTol', 1e-8, 'AbsTol', 1e-10);
    z0 = [0; 0; v0*cosd(angle_deg); v0*sind(angle_deg)];
    [t, Z] = ode45(f, [0 60], z0, opts);
    s.x = Z(:, 1); s.y = Z(:, 2);
    s.range = Z(end, 1); s.hmax = max(Z(:, 2)); s.T = t(end);
    s.vimpact = hypot(Z(end, 3), Z(end, 4));
end

function [value, isterminal, direction] = hit_ground(t, z)
    value = z(2) - (t < 1e-6);     % y = 0, ignoring the launch instant
    isterminal = 1;                % stop the integration
    direction = -1;                % only when y is decreasing
end
```

## Extend this project

- Add a head wind or tail wind and see how the best angle changes.
- Launch from a cliff of height h and find the best angle.
- Add the Magnus force for a spinning ball.
- Find the launch speed needed to reach a target 80 m away (use `fzero`).

---

[⬅ Day 123](../Day-123-Project-16-Image-Analysis-Detecting-and-Counting-Objects/README.md) · [🏠 Home](../README.md) · [Day 125 ➡](../Day-125-Project-18-Heat-Conduction-in-a-Plate-Finite-Differences/README.md)
