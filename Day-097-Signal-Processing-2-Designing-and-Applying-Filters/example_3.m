% Day 097 · Signal Processing 2: Designing and Applying Filters — Frequency responses of different designs
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Needs: Signal Processing Toolbox
fs = 1000; fc = 100;
[b1, a1] = butter(2, fc/(fs/2));
[b2, a2] = butter(8, fc/(fs/2));
b3 = fir1(40, fc/(fs/2));
[H1, f] = freqz(b1, a1, 512, fs);
H2 = freqz(b2, a2, 512, fs);
H3 = freqz(b3, 1, 512, fs);
plot(f, 20*log10(abs([H1 H2 H3]))); grid on
ylim([-80 5]); xlabel('f (Hz)'); ylabel('|H| (dB)')
legend('Butterworth n = 2', 'Butterworth n = 8', 'FIR n = 40', 'Location', 'southwest')
[~, k] = min(abs(f - 200));
fprintf('Attenuation at 200 Hz: n=2 %.1f dB, n=8 %.1f dB, FIR %.1f dB\n', 20*log10(abs([H1(k) H2(k) H3(k)])));
