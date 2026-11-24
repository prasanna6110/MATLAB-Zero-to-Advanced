% Day 096 · Signal Processing 1: Sampling, FFT and the Frequency Spectrum — Harmonics and THD of a distorted current
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

fs = 10000; t = 0:1/fs:0.2 - 1/fs;           % 10 cycles of 50 Hz
i = 10*sin(2*pi*50*t) + 2.0*sin(2*pi*150*t) + 1.2*sin(2*pi*250*t) + 0.6*sin(2*pi*350*t);
N = numel(i);
I = abs(fft(i))/N*2;
f = (0:N-1)*fs/N;
h = 1:9;                                      % harmonic numbers
amp = zeros(size(h));
for k = h
    [~, bin] = min(abs(f - 50*k));
    amp(k) = I(bin);
end
amp(amp < 1e-6) = 0;                         % clear rounding noise of absent harmonics
THD = sqrt(sum(amp(2:end).^2)) / amp(1) * 100;
bar(h, amp); xlabel('Harmonic number'); ylabel('Amplitude (A)'); title(sprintf('THD = %.1f %%', THD))
fprintf('Harmonic amplitudes: %s\n', mat2str(amp, 3));
fprintf('Total harmonic distortion: %.2f %%\n', THD);
