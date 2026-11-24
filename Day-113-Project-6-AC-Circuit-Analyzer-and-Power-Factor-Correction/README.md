# Day 113 · Project 6: AC Circuit Analyzer and Power Factor Correction

_Projects_

## Goal
Analyse a single-phase installation with several loads (motors, lights, heaters) using **phasors**: total current, real/reactive/apparent power and power factor. Then size the **capacitor** that corrects the power factor to a target, and show the savings in current and in the kVA demand charge.

## Formulas
- Load k with P and pf (lagging): Q = P·tan(acos pf).
- Total: P = ΣP, Q = ΣQ, S = √(P² + Q²), pf = P/S, I = S/V.
- Capacitor for target pf₂: Qc = P (tan φ₁ - tan φ₂), C = Qc / (2π f V²).
- Line losses ∝ I², so reducing I reduces losses.

## Concepts used
Complex numbers, vectorised power calculations, `fzero` (alternative sizing check), `compass` phasor diagram, bar charts.

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear; close all;
V = 230; f = 50;
loads = struct('name', {'Induction motor', 'Pump motor', 'Fluorescent lights', 'Heater', 'Welding set'}, ...
               'P_kW', {7.5, 3.7, 1.2, 4.0, 5.0}, 'pf', {0.78, 0.80, 0.85, 1.00, 0.60});
P = [loads.P_kW];  pf = [loads.pf];
Q = P .* tan(acos(pf));
S = sqrt(P.^2 + Q.^2);
fprintf('%-20s %7s %7s %8s %8s %8s\n', 'Load', 'P kW', 'pf', 'Q kVAR', 'S kVA', 'I (A)');
for k = 1:numel(loads)
    fprintf('%-20s %7.2f %7.2f %8.2f %8.2f %8.2f\n', loads(k).name, P(k), pf(k), Q(k), S(k), S(k)*1000/V);
end
Pt = sum(P); Qt = sum(Q); St = hypot(Pt, Qt); pft = Pt/St; It = St*1000/V;
fprintf('%-20s %7.2f %7.2f %8.2f %8.2f %8.2f\n\n', 'TOTAL', Pt, pft, Qt, St, It);
% ---- power factor correction ----
targets = [0.90 0.95 0.98 1.00];
R_line = 0.15;                                  % ohm, feeder resistance
demand_rate = 350;                              % Rs per kVA per month
fprintf('%8s %10s %10s %8s %10s %12s\n', 'Target', 'Qc kVAR', 'C (uF)', 'I (A)', 'Loss (W)', 'Saving Rs/m');
loss0 = It^2 * R_line;
for pf2 = targets
    Qc = Pt * (tan(acos(pft)) - tan(acos(pf2)));
    C = Qc*1000 / (2*pi*f*V^2);
    S2 = Pt / pf2;  I2 = S2*1000/V;
    loss = I2^2 * R_line;
    saving = (St - S2) * demand_rate;
    fprintf('%8.2f %10.2f %10.1f %8.1f %10.0f %12.0f\n', pf2, Qc, C*1e6, I2, loss, saving);
end
fprintf('(Line loss before correction: %.0f W)\n', loss0);
% ---- check with complex numbers ----
pf2 = 0.95;
Qc = Pt * (tan(acos(pft)) - tan(acos(pf2)));
C = Qc*1000 / (2*pi*f*V^2);
Iload = conj((Pt + 1j*Qt)*1000 / V);            % I = conj(S/V)
Icap = V * 1j*2*pi*f*C;
Inew = Iload + Icap;
fprintf('\nPhasor check: |I| %.1f A -> %.1f A, pf %.3f -> %.3f\n', abs(Iload), abs(Inew), cos(angle(Iload)), cos(angle(Inew)));
subplot(1, 2, 1); compass([Iload Icap Inew]); title('I_{load}, I_{cap}, I_{new}')
subplot(1, 2, 2); bar([P; Q]', 'grouped'); legend('P (kW)', 'Q (kVAR)'); title('Loads'); xlabel('load number')
```

## Extend this project

- Add a time schedule for each load and compute the daily kWh and kVARh.
- Choose capacitor banks from standard sizes (2.5, 5, 7.5, 10 kVAR) and switch them in steps.
- Check for over-correction (leading pf) at light load.
- Extend to a three-phase installation.

---

[⬅ Day 112](../Day-112-Project-5-DC-Circuit-Solver-using-Nodal-Analysis/README.md) · [🏠 Home](../README.md) · [Day 114 ➡](../Day-114-Project-7-RLC-Transient-Analyzer/README.md)
