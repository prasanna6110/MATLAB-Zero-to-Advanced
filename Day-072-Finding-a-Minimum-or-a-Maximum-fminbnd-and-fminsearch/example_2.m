% Day 072 · Finding a Minimum or a Maximum: fminbnd and fminsearch — Maximum power transfer
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

Vs = 12; Rs = 8;                       % source voltage and internal resistance
P = @(RL) Vs^2 * RL ./ (Rs + RL).^2;
[RL_best, negP] = fminbnd(@(RL) -P(RL), 0.1, 50);
fprintf('Maximum power %.3f W when RL = %.3f ohm (theory: RL = Rs = %d)\n', -negP, RL_best, Rs);
fplot(P, [0 50]); xlabel('R_L (\Omega)'); ylabel('P (W)'); grid on
% A box from a 30 cm x 20 cm sheet: cut squares of side x, maximise the volume
V = @(x) x .* (30 - 2*x) .* (20 - 2*x);
[xb, negV] = fminbnd(@(x) -V(x), 0, 10);
fprintf('Best cut %.3f cm gives volume %.1f cm^3\n', xb, -negV);
