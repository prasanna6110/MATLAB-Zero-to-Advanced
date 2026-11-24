# Day 118 · Project 11: Load Flow Analysis by the Gauss-Seidel Method

_Projects_

## Goal
Solve the **power flow** of a small power system: given the network and the power injected at each bus, find every **bus voltage** (magnitude and angle), the **line flows** and the **losses**. This is the most important study in power-system planning and operation.

## Method
1. Build the **bus admittance matrix Ybus** from the line data (series impedance and line charging).
2. Bus types: **slack** (V and angle fixed), **PV** (P and |V| fixed: generators), **PQ** (P and Q fixed: loads).
3. **Gauss-Seidel** update for bus i:
   Vᵢ = (1/Yᵢᵢ) · [ (Pᵢ - jQᵢ)/conj(Vᵢ) - Σ_{k≠i} Yᵢₖ Vₖ ]
   For a PV bus, first compute Qᵢ = -Im(conj(Vᵢ) Σ Yᵢₖ Vₖ), update, then reset |Vᵢ| to its set value.
4. An **acceleration factor** (≈1.6) speeds up convergence. Stop when the largest change is below the tolerance.
5. Line flow from i to k: Sᵢₖ = Vᵢ · conj(Iᵢₖ), Iᵢₖ = (Vᵢ - Vₖ)·y + Vᵢ·(jB/2). Losses = Sᵢₖ + Sₖᵢ.

All quantities are in **per unit** on a 100 MVA base.

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear;
base = 100;                                     % MVA
% Bus data: number, type (1 slack, 2 PV, 3 PQ), |V| set, Pgen, Qgen, Pload, Qload (MW, MVAr)
bus = [1 1 1.05   0   0    0    0
       2 2 1.02  80   0   20   10
       3 3 1.00   0   0  110   50
       4 3 1.00   0   0   80   30];
% Line data: from, to, R, X, B (total line charging), all per unit
line = [1 2 0.02 0.06 0.06
        1 3 0.08 0.24 0.05
        2 3 0.06 0.18 0.04
        2 4 0.06 0.18 0.04
        3 4 0.01 0.03 0.02];
n = size(bus, 1);
Y = zeros(n);
for k = 1:size(line, 1)
    f = line(k, 1); t = line(k, 2);
    y = 1 / (line(k, 3) + 1j*line(k, 4));  b = 1j*line(k, 5)/2;
    Y(f, f) = Y(f, f) + y + b;  Y(t, t) = Y(t, t) + y + b;
    Y(f, t) = Y(f, t) - y;      Y(t, f) = Y(t, f) - y;
end
type = bus(:, 2);  Vset = bus(:, 3);
P = (bus(:, 4) - bus(:, 6)) / base;
Q = (bus(:, 5) - bus(:, 7)) / base;
V = Vset .* ones(n, 1);  V(type == 3) = 1;
alpha = 1.6; tol = 1e-8;
for iter = 1:500
    dVmax = 0;
    for i = 2:n
        if type(i) == 2
            Q(i) = -imag(conj(V(i)) * (Y(i, :) * V));
        end
        Vnew = ((P(i) - 1j*Q(i)) / conj(V(i)) - (Y(i, :) * V - Y(i, i)*V(i))) / Y(i, i);
        if type(i) == 2
            Vnew = Vset(i) * Vnew / abs(Vnew);          % keep |V| at its set value
            V(i) = Vnew;
        else
            Vacc = V(i) + alpha*(Vnew - V(i));
            dVmax = max(dVmax, abs(Vacc - V(i)));
            V(i) = Vacc;
        end
    end
    if dVmax < tol, break; end
end
S = V .* conj(Y*V) * base;                          % injected power at every bus
fprintf('Gauss-Seidel converged in %d iterations\n\n', iter);
fprintf('%4s %8s %10s %10s %10s\n', 'Bus', '|V| pu', 'Angle deg', 'P inj MW', 'Q inj MVAr');
for i = 1:n
    fprintf('%4d %8.4f %10.4f %10.2f %10.2f\n', i, abs(V(i)), rad2deg(angle(V(i))), real(S(i)), imag(S(i)));
end
fprintf('\n%8s %10s %10s %10s %10s\n', 'Line', 'P MW', 'Q MVAr', 'Loss MW', 'Loss MVAr');
total_loss = 0;
for k = 1:size(line, 1)
    f = line(k, 1); t = line(k, 2);
    y = 1 / (line(k, 3) + 1j*line(k, 4));  b = 1j*line(k, 5)/2;
    Sft = V(f) * conj((V(f) - V(t))*y + V(f)*b) * base;
    Stf = V(t) * conj((V(t) - V(f))*y + V(t)*b) * base;
    total_loss = total_loss + Sft + Stf;
    fprintf('%4d-%-3d %10.2f %10.2f %10.3f %10.3f\n', f, t, real(Sft), imag(Sft), real(Sft + Stf), imag(Sft + Stf));
end
fprintf('\nTotal losses: %.3f MW, %.3f MVAr\n', real(total_loss), imag(total_loss));
fprintf('Check: generation - load - losses = %.2e MW\n', sum(real(S)) - real(total_loss));
```

## Extend this project

- Write the Newton-Raphson load flow for the same system and compare the number of iterations.
- Add reactive power limits for the PV bus (switch it to PQ when a limit is hit).
- Increase the load at bus 4 step by step and plot |V4| against the load (a PV curve).
- Read the bus and line data from CSV files (IEEE 14-bus system).

---

[⬅ Day 117](../Day-117-Project-10-Microgrid-Energy-Management-with-PV-Battery-and-Grid/README.md) · [🏠 Home](../README.md) · [Day 119 ➡](../Day-119-Project-12-Economic-Load-Dispatch/README.md)
