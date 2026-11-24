% Day 096 · Signal Processing 1: Sampling, FFT and the Frequency Spectrum — Aliasing: sampling too slowly
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

f_sig = 90;                                   % a 90 Hz sine
t_fine = linspace(0, 0.1, 2000);
fs_low = 100;                                 % below 2*90 = 180 Hz
t_s = 0:1/fs_low:0.1;
plot(t_fine, sin(2*pi*f_sig*t_fine), 'Color', [0.7 0.7 0.7]); hold on
plot(t_s, sin(2*pi*f_sig*t_s), 'ro-', 'MarkerFaceColor', 'r'); hold off
title('90 Hz sampled at 100 Hz looks like 10 Hz'); xlabel('t (s)')
f_alias = abs(f_sig - round(f_sig/fs_low)*fs_low);
fprintf('Apparent (alias) frequency: %g Hz\n', f_alias);
