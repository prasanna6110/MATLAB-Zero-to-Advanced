# Day 099 · Control Systems 2: Bode, Root Locus, Margins and PID Design

_Advanced MATLAB and Toolboxes_

## Frequency response
- `bode(G)`: magnitude (dB) and phase against frequency.
- `[mag, phase, w] = bode(G)` returns the numbers.
- `nyquist(G)`: the Nyquist plot.
- `[Gm, Pm, Wcg, Wcp] = margin(G)`: the **gain margin** (how much the gain can rise before instability) and **phase margin** (how much extra phase lag is allowed). Typical targets: GM > 6 dB, PM 45°–60°.

## Root locus
`rlocus(G)` shows how the closed-loop poles move as the gain K goes from 0 to ∞. Where the branches cross into the right half-plane the system becomes unstable.

## PID controllers
C(s) = Kp + Ki/s + Kd·s
- `C = pid(Kp, Ki, Kd)` creates it.
- `T = feedback(C*G, 1)` closes the loop.
- `pidtune(G, 'PID')` (MATLAB) designs gains automatically; the **PID Tuner** app does it interactively.
- Classic hand tuning: **Ziegler-Nichols** (find the ultimate gain Ku where the loop oscillates and its period Pu, then Kp = 0.6Ku, Ti = Pu/2, Td = Pu/8).

## Apps
**Control System Designer** (`controlSystemDesigner(G)`): root locus, Bode and step response together, with draggable poles and zeros.

## Examples

### Example 1: Bode plot and stability margins  ([`example_1.m`](example_1.m))

```matlab
% Needs: Control System Toolbox
s = tf('s');
L = 50 / (s*(s + 2)*(s + 10));          % open-loop transfer function
bode(L); grid on
[Gm, Pm, Wcg, Wcp] = margin(L);
fprintf('Gain margin %.2f (%.1f dB) at %.2f rad/s\n', Gm, 20*log10(Gm), Wcg);
fprintf('Phase margin %.1f deg at %.2f rad/s\n', Pm, Wcp);
[mag, ph] = bode(L, 1);
fprintf('At 1 rad/s: |L| = %.2f, phase = %.1f deg\n', squeeze(mag), squeeze(ph));
```

### Example 2: Root locus and the gain at the stability limit  ([`example_2.m`](example_2.m))

```matlab
% Needs: Control System Toolbox
s = tf('s');
G = 1 / (s*(s + 2)*(s + 10));
rlocus(G); grid on; title('Root locus')
% The closed loop 1 + K G = 0 -> s^3 + 12 s^2 + 20 s + K = 0
% Routh: unstable when K > 12*20 = 240
for K = [100 239 241]
    p = roots([1 12 20 K]);
    fprintf('K = %3d: max real part of the poles = %+.4f\n', K, max(real(p)));
end
w_osc = sqrt(20);
fprintf('At K = 240 the loop oscillates at %.3f rad/s (period %.3f s)\n', w_osc, 2*pi/w_osc);
```

### Example 3: Designing a PID with Ziegler-Nichols and checking it  ([`example_3.m`](example_3.m))

```matlab
% Needs: Control System Toolbox
s = tf('s');
G = 1 / (s*(s + 2)*(s + 10));
Ku = 240; Pu = 2*pi/sqrt(20);                        % from the previous example
Kp = 0.6*Ku; Ki = Kp/(Pu/2); Kd = Kp*Pu/8;
C = pid(Kp, Ki, Kd);
T_p = feedback(0.5*Ku*G, 1);                         % P only (Kp = 0.5 Ku)
T_pid = feedback(C*G, 1);
[y1, t1] = step(T_p, 8);
[y2, t2] = step(T_pid, 8);
plot(t1, y1, t2, y2, 'LineWidth', 1.3); grid on
legend('P (0.5 Ku)', 'Ziegler-Nichols PID'); xlabel('t (s)')
fprintf('Kp = %.1f, Ki = %.1f, Kd = %.1f\n', Kp, Ki, Kd);
fprintf('Value at t = 8 s: P %.3f, PID %.3f; PID overshoot %.0f %% (Z-N gains are aggressive: fine-tune them next)\n', y1(end), y2(end), 100*(max(y2) - 1));
```

## Practice

1. Draw the Bode plot of `10/(s+1)` and read the -3 dB frequency.
2. Find the gain and phase margins of `20/(s(s+1)(s+5))`.
3. Use the root locus to find the K that gives ζ ≈ 0.5 for `1/(s(s+4))`.
4. (MATLAB) Use `pidtune` on the plant above and compare with Ziegler-Nichols.

---

[⬅ Day 098](../Day-098-Control-Systems-1-Transfer-Functions-Poles-and-Step-Response/README.md) · [🏠 Home](../README.md) · [Day 100 ➡](../Day-100-Image-Processing-Basics-Images-as-Matrices/README.md)
