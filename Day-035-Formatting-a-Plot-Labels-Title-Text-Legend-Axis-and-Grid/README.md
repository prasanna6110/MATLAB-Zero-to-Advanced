# Day 035 · Formatting a Plot: Labels, Title, Text, Legend, Axis and Grid

_Two-Dimensional Plots_

## Formatting commands
| Command | Does |
|---------|------|
| `xlabel('text')`, `ylabel('text')` | axis labels |
| `title('text')` | the title |
| `text(x, y, 'text')` | text at a point in the axes |
| `gtext('text')` | place text with the mouse (interactive) |
| `legend(...)` | the legend |
| `axis([xmin xmax ymin ymax])` | the axis limits; also `xlim([a b])`, `ylim([a b])` |
| `axis equal` / `axis square` / `axis tight` / `axis off` | aspect ratio and look |
| `grid on` / `grid off` / `grid minor` | grid lines |
| `box on` | a box around the axes |
| `xticks([..])`, `xticklabels({..})` | tick positions and labels |

## Text formatting
- Greek letters and symbols (TeX): `\alpha \beta \omega \pi \theta \Omega \mu \infty \circ`
- Subscripts and superscripts: `x_1`, `x^2`, `e^{-t/\tau}` (use `{}` for more than one character)
- Bold / italic: `\bf`, `\it`, `\rm`; font size: `'FontSize', 14`
- Colour of text: `text(..., 'Color', 'r')`; or `\color{red}` inside the text

## Plot Editor and handles
**Insert / Tools / Edit Plot** in the Figure window let you change anything with the mouse. In code, every graphics object has a **handle**: `h = plot(...)`, then `h.LineWidth = 2` (or `set(h, 'LineWidth', 2)`). `gca` is the current axes, `gcf` the current figure: `set(gca, 'FontSize', 12)`.

## Examples

### Example 1: A fully labelled plot  ([`example_1.m`](example_1.m))

```matlab
t = linspace(0, 5, 300);
tau = 1;
v = 10 * (1 - exp(-t/tau));
plot(t, v, 'b', 'LineWidth', 2)
xlabel('Time t (s)', 'FontSize', 12)
ylabel('v_C(t) (V)', 'FontSize', 12)
title('Charging: v_C = 10(1 - e^{-t/\tau}),  \tau = 1 s')
axis([0 5 0 11])
grid on
hold on
plot(tau, 10*(1 - exp(-1)), 'ro', 'MarkerFaceColor', 'r')
text(tau + 0.15, 6.0, '63.2% at t = \tau', 'Color', 'r')
hold off
```

### Example 2: Axis options and custom ticks  ([`example_2.m`](example_2.m))

```matlab
x = linspace(0, 2*pi, 200);
plot(x, sin(x), x, cos(x), '--', 'LineWidth', 1.5)
xlim([0 2*pi]); ylim([-1.2 1.2])
xticks(0:pi/2:2*pi)
xticklabels({'0', '\pi/2', '\pi', '3\pi/2', '2\pi'})
legend('sin \theta', 'cos \theta', 'Location', 'southwest')
grid on
figure
th = linspace(0, 2*pi, 100);
plot(2*cos(th), 2*sin(th))
axis equal                          % otherwise the circle looks like an ellipse
title('axis equal keeps circles round')
```

### Example 3: Changing a plot through handles  ([`example_3.m`](example_3.m))

```matlab
x = 1:10;
h = plot(x, x.^1.5, 'o-');
set(h, 'LineWidth', 2)              % in MATLAB R2014b+ you can also write h.LineWidth = 2
set(h, 'MarkerFaceColor', 'g')
ax = gca;
set(ax, 'FontSize', 11, 'XGrid', 'on', 'YGrid', 'on')
title('Changed through handles')
fprintf('The line has %d points and colour %s\n', numel(get(h, 'XData')), mat2str(get(h, 'Color'), 3));
```

## Practice

1. Plot `y = e^{-0.5x} sin(5x)` with a title containing Greek letters and a superscript.
2. Put a text label with an arrow-like note `\leftarrow max` at the highest point of a curve.
3. Set x ticks at every 30° on a plot of `sind(x)` for 0–360°.
4. Make a plot, then change its line colour and width using its handle.

---

[⬅ Day 034](../Day-034-Plotting-Multiple-Graphs-plot-with-Several-Pairs-hold-and-line/README.md) · [🏠 Home](../README.md) · [Day 036 ➡](../Day-036-Plots-with-Logarithmic-Axes-and-Error-Bars/README.md)
