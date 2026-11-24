% Day 099 · Control Systems 2: Bode, Root Locus, Margins and PID Design — Bode plot and stability margins
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Needs: Control System Toolbox
s = tf('s');
L = 50 / (s*(s + 2)*(s + 10));          % open-loop transfer function
bode(L); grid on
[Gm, Pm, Wcg, Wcp] = margin(L);
fprintf('Gain margin %.2f (%.1f dB) at %.2f rad/s\n', Gm, 20*log10(Gm), Wcg);
fprintf('Phase margin %.1f deg at %.2f rad/s\n', Pm, Wcp);
[mag, ph] = bode(L, 1);
fprintf('At 1 rad/s: |L| = %.2f, phase = %.1f deg\n', squeeze(mag), squeeze(ph));
