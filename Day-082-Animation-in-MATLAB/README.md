# Day 082 · Animation in MATLAB

_Three-Dimensional Plots_

## Simple animation
Redraw the plot in a loop and call `drawnow` (or `pause(dt)`) so the screen updates:
```matlab
h = plot(x, y);
for k = 1:N
    set(h, 'YData', new_y);    % update the existing line: fast and smooth
    drawnow
end
```
Updating the data of an existing graphics object is much faster than calling `plot` again every time.

## Useful tools
| Tool | Use |
|------|-----|
| `pause(0.05)` | wait between frames (and allow the screen to update) |
| `drawnow limitrate` | update at most ~20 times per second (faster loops) |
| `animatedline` + `addpoints` | draw a growing line (MATLAB) |
| `comet(x, y)`, `comet3` | quick built-in animations of a path |
| `F = getframe(gcf)` | capture a frame |
| `VideoWriter('out.mp4', 'MPEG-4')` + `writeVideo` | save a video (MATLAB) |
| `imwrite` with `'gif'` | build an animated GIF frame by frame |
| `movie(F)` | play captured frames |

## Examples

### Example 1: A travelling wave by updating YData  ([`example_1.m`](example_1.m))

```matlab
x = linspace(0, 4*pi, 300);
h = plot(x, sin(x), 'LineWidth', 2);
ylim([-1.2 1.2]); grid on
xlabel('x'); title('A travelling wave')
for k = 1:60
    set(h, 'YData', sin(x - 0.2*k));
    drawnow
end
fprintf('Animated %d frames\n', k);
```

### Example 2: A pendulum animation from an ODE solution  ([`example_2.m`](example_2.m))

```matlab
L = 1; g = 9.81;
[t, S] = ode45(@(t, s) [s(2); -g/L*sin(s(1))], linspace(0, 4, 80), [deg2rad(70); 0]);
figure
rod = plot([0 L*sin(S(1, 1))], [0 -L*cos(S(1, 1))], 'k-', 'LineWidth', 2); hold on
bob = plot(L*sin(S(1, 1)), -L*cos(S(1, 1)), 'ro', 'MarkerSize', 14, 'MarkerFaceColor', 'r');
hold off; axis equal; axis([-1.2 1.2 -1.2 0.2]); grid on
for k = 1:numel(t)
    xk = L*sin(S(k, 1)); yk = -L*cos(S(k, 1));
    set(rod, 'XData', [0 xk], 'YData', [0 yk]);
    set(bob, 'XData', xk, 'YData', yk);
    title(sprintf('t = %.2f s', t(k)));
    drawnow
end
fprintf('Swing amplitude stays %.1f deg (no friction)\n', rad2deg(max(S(:, 1))));
```

### Example 3: Saving an animation as a GIF and a video  ([`example_3.m`](example_3.m))

```matlab
% MATLAB-ONLY: getframe/VideoWriter need a graphics display
x = linspace(0, 2*pi, 100);
h = plot(x, sin(x)); ylim([-1 1])
v = VideoWriter('wave.mp4', 'MPEG-4');
open(v)
for k = 1:30
    set(h, 'YData', sin(x + k/5));
    frame = getframe(gcf);
    writeVideo(v, frame);
    [im, map] = rgb2ind(frame2im(frame), 256);
    if k == 1
        imwrite(im, map, 'wave.gif', 'gif', 'LoopCount', Inf, 'DelayTime', 0.05);
    else
        imwrite(im, map, 'wave.gif', 'gif', 'WriteMode', 'append', 'DelayTime', 0.05);
    end
end
close(v)
delete('wave.mp4'); delete('wave.gif');
```

## Practice

1. Animate a point moving around a circle using `set(h, 'XData', ..., 'YData', ...)`.
2. Use `comet` to animate the path of a projectile.
3. Animate the charging of a capacitor: a bar whose height follows `1 - e^{-t}`.
4. (MATLAB) Save one of your animations as an MP4 video.

---

[⬅ Day 081](../Day-081-The-view-Command-Colormaps-Shading-and-Lighting/README.md) · [🏠 Home](../README.md) · [Day 083 ➡](../Day-083-Symbolic-Objects-and-Symbolic-Expressions/README.md)
