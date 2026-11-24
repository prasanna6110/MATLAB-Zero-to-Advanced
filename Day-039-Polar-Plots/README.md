# Day 039 · Polar Plots

_Two-Dimensional Plots_

## `polarplot` and `polar`
For curves given as **r(θ)**:
```matlab
polarplot(theta, r)           % MATLAB R2016a+
polar(theta, r)               % the classic command (also in Octave)
```
- θ is in **radians**.
- Line specifiers work: `polarplot(theta, r, 'r--')`.
- To convert to x, y yourself: `[x, y] = pol2cart(theta, r)`, then `plot(x, y)`.

## Uses
- antenna radiation patterns
- microphone and loudspeaker patterns
- rose curves, spirals, cardioids
- phasor diagrams (`compass(z)` draws complex numbers as arrows)

## Examples

### Example 1: Rose curves and spirals  ([`example_1.m`](example_1.m))

```matlab
theta = linspace(0, 2*pi, 400);
subplot(1, 2, 1)
polar(theta, abs(cos(3*theta)))
title('r = |cos 3\theta|')
subplot(1, 2, 2)
th = linspace(0, 6*pi, 600);
polar(th, th)
title('Spiral r = \theta')
```

### Example 2: An antenna-like radiation pattern  ([`example_2.m`](example_2.m))

```matlab
theta = linspace(0, 2*pi, 720);
pattern = abs(cos(theta) .* sin(4*theta)) + 0.05;   % a made-up multi-lobe pattern
polar(theta, pattern, 'r')
title('Radiation pattern')
[~, k] = max(pattern);
fprintf('Main lobe at %.1f degrees\n', rad2deg(theta(k)));
```

### Example 3: A phasor diagram with compass  ([`example_3.m`](example_3.m))

```matlab
V = 230;
I = 10 * exp(-1j*deg2rad(36.87));         % lagging current, pf 0.8
VR = 8 * 10 * exp(-1j*deg2rad(36.87));    % drop across an 8 ohm resistor
compass([V/23, I, VR/23])                 % scaled so all are visible
title('Phasors (scaled): V, I, V_R')
fprintf('Power factor = %.2f lagging\n', cos(angle(V) - angle(I)));
```

## Practice

1. Plot the cardioid `r = 1 + cos θ`.
2. Plot `r = sin(2θ)²` and count its petals.
3. Convert the polar curve `r = 2` to x, y with `pol2cart` and plot it with `axis equal`.
4. Draw the three phase voltages of a balanced system with `compass`.

---

[⬅ Day 038](../Day-038-Histograms/README.md) · [🏠 Home](../README.md) · [Day 040 ➡](../Day-040-Multiple-Plots-on-a-Page-Multiple-Figures-and-Saving-Figures/README.md)
