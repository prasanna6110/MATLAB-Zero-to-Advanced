# Day 040 · Multiple Plots on a Page, Multiple Figures and Saving Figures

_Two-Dimensional Plots_

## Several axes in one figure: `subplot`
`subplot(m, n, p)` divides the figure into an **m×n grid** and makes the **p-th** cell current (numbered across the rows). `subplot(2, 2, [3 4])` spans cells 3 and 4.

Modern MATLAB (R2019b+) also has `tiledlayout(m, n)` + `nexttile`, with shared titles (`title(t, '...')`) and tight spacing. `sgtitle('...')` adds one title above all subplots (R2018b+).

## Several figure windows
- `figure` opens a new, empty window; `figure(3)` makes window 3 current (or creates it).
- `close(2)` closes window 2; `close all` closes all; `clf` clears the current figure.
- `figure('Name', 'Results', 'Position', [100 100 800 400])` sets the title and size.

## Saving a figure
| Command | Saves |
|---------|-------|
| `saveas(gcf, 'fig.png')` | PNG / JPG / PDF / FIG by extension |
| `print('-dpng', '-r300', 'fig.png')` | high resolution |
| `exportgraphics(gca, 'fig.pdf')` | tight, publication quality (R2020a+) |
| `savefig('fig.fig')` | a MATLAB `.fig` you can reopen with `openfig` |

## Plotting with the PLOTS toolstrip
Select variables in the **Workspace**, then open the **PLOTS** tab: MATLAB shows the plot types that fit and writes the command for you in the Command Window.

## Examples

### Example 1: A 2x2 dashboard of one signal  ([`example_1.m`](example_1.m))

```matlab
t = linspace(0, 1, 1000);
x = sin(2*pi*5*t) + 0.4*sin(2*pi*40*t);
subplot(2, 2, 1); plot(t, x); title('Signal'); xlabel('t (s)')
subplot(2, 2, 2); hist(x, 30); title('Histogram of values')
subplot(2, 2, 3); plot(t(1:200), x(1:200), '.-'); title('Zoom: first 0.2 s')
subplot(2, 2, 4); plot(t, cumsum(x)/1000); title('Running integral')
```

### Example 2: Spanning cells and multiple figure windows  ([`example_2.m`](example_2.m))

```matlab
x = linspace(0, 10, 300);
figure(1)
subplot(2, 2, 1); plot(x, sin(x)); title('sin')
subplot(2, 2, 2); plot(x, cos(x)); title('cos')
subplot(2, 2, [3 4]); plot(x, sin(x).*cos(x)); title('sin \cdot cos spans the bottom row')
figure(2)
plot(x, exp(-x/3)); title('A second window')
fprintf('Open figure windows: %d\n', numel(get(0, 'Children')));
close all
```

### Example 3: tiledlayout, sgtitle and exportgraphics  ([`example_3.m`](example_3.m))

```matlab
% MATLAB-ONLY: tiledlayout (R2019b), exportgraphics (R2020a)
t = linspace(0, 2, 500);
tl = tiledlayout(2, 1, 'TileSpacing', 'compact');
title(tl, 'Step responses')
nexttile; plot(t, 1 - exp(-3*t)); title('First order')
nexttile; plot(t, 1 - exp(-2*t).*cos(8*t)); title('Second order, underdamped')
exportgraphics(gcf, 'steps.png', 'Resolution', 200);
delete('steps.png');
```

## Practice

1. Make a 3×1 subplot of the three phase voltages.
2. Create two figure windows with different plots and close only the first.
3. Save a figure as PNG and as a `.fig` file. Reopen the `.fig`.
4. Select two vectors in the Workspace and try three plot types from the PLOTS tab.

---

[⬅ Day 039](../Day-039-Polar-Plots/README.md) · [🏠 Home](../README.md) · [Day 041 ➡](../Day-041-Relational-and-Logical-Operators/README.md)
