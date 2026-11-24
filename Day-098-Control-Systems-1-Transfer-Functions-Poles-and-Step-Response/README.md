# Day 098 · Control Systems 1: Transfer Functions, Poles and Step Response

_Advanced MATLAB and Toolboxes_

## Linear system models (Control System Toolbox)
| Command | Creates |
|---------|---------|
| `G = tf(num, den)` | a transfer function, e.g. `tf(10, [1 3 10])` = 10/(s² + 3s + 10) |
| `s = tf('s'); G = 10/(s^2 + 3*s + 10)` | the same, written naturally |
| `zpk(z, p, k)` | zeros, poles, gain form |
| `ss(A, B, C, D)` | state-space |
| `G1*G2`, `G1 + G2`, `feedback(G, H)` | series, parallel, closed loop (negative feedback) |
| `c2d(G, Ts)` | discrete-time version |

## Analysis
| Command | Gives |
|---------|-------|
| `pole(G)`, `zero(G)`, `pzmap(G)` | poles and zeros |
| `dcgain(G)` | the steady-state gain |
| `step(G)`, `impulse(G)`, `lsim(G, u, t)` | time responses |
| `stepinfo(G)` | rise time, settling time, overshoot (MATLAB) |
| `damp(G)` | natural frequency and damping of each pole |

## Stability
A continuous system is **stable** when **all poles have negative real parts** (left half of the s-plane).

## Standard second-order system
G(s) = ωn² / (s² + 2ζωn s + ωn²)
- ζ < 1 underdamped (overshoot = e^(-ζπ/√(1-ζ²)) · 100 %), ζ = 1 critical, ζ > 1 overdamped
- settling time (2%) ≈ 4/(ζωn)

## Examples

### Example 1: Transfer functions, poles and the step response  ([`example_1.m`](example_1.m))

```matlab
% Needs: Control System Toolbox
s = tf('s');
G = 25 / (s^2 + 4*s + 25)
p = pole(G)
wn = abs(p(1)); zeta = -real(p(1))/wn;
fprintf('wn = %.2f rad/s, zeta = %.2f, DC gain = %.2f\n', wn, zeta, dcgain(G));
[y, t] = step(G, 4);
plot(t, y, 'LineWidth', 1.5); grid on; xlabel('t (s)'); title('Step response')
os = (max(y) - 1)*100;
ts = t(find(abs(y - 1) > 0.02, 1, 'last'));
fprintf('Overshoot %.1f %% (formula %.1f %%), settling time %.2f s (4/(zeta wn) = %.2f s)\n', ...
    os, 100*exp(-zeta*pi/sqrt(1 - zeta^2)), ts, 4/(zeta*wn));
```

### Example 2: Combining blocks: series, feedback and stability  ([`example_2.m`](example_2.m))

```matlab
% Needs: Control System Toolbox
s = tf('s');
plant = 1 / (s*(s + 2)*(s + 5));
for K = [10 40 65 100]                      % theory (Routh): stable only for K < 70
    T = feedback(K*plant, 1);
    p = pole(T);
    if all(real(p) < 0), state = 'stable'; else, state = 'UNSTABLE'; end
    fprintf('K = %3d: poles %s -> %s\n', K, mat2str(p.', 3), state);
end
T = feedback(40*plant, 1);
[y, t] = step(T, 10);
plot(t, y); grid on; title('Closed loop with K = 40')
```

### Example 3: stepinfo and lsim (MATLAB)  ([`example_3.m`](example_3.m))

```matlab
% MATLAB-ONLY: stepinfo is not in GNU Octave's control package
s = tf('s');
G = 25 / (s^2 + 4*s + 25);
info = stepinfo(G)
t = 0:0.01:6;
u = double(t >= 1) - double(t >= 3);       % a pulse input
lsim(G, u, t); grid on
damp(G)
```

## Practice

1. Create `G(s) = 5/(s² + 2s + 5)` and find its poles, ωn and ζ.
2. Plot the step responses of `ωn²/(s² + 2ζωn s + ωn²)` for ζ = 0.1, 0.5, 1, 2.
3. Find the range of K for which `K/(s(s+1)(s+3))` with unity feedback is stable.
4. Convert G to state-space with `ss(G)` and back with `tf`.

---

[⬅ Day 097](../Day-097-Signal-Processing-2-Designing-and-Applying-Filters/README.md) · [🏠 Home](../README.md) · [Day 099 ➡](../Day-099-Control-Systems-2-Bode-Root-Locus-Margins-and-PID-Design/README.md)
