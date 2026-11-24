% Day 096 · Signal Processing 1: Sampling, FFT and the Frequency Spectrum — The spectrum of a signal with two frequencies and noise
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

fs = 1000;                       % Hz
t = 0:1/fs:1 - 1/fs;             % 1 second, N = 1000
rng(1);
x = 0.7*sin(2*pi*50*t) + 1.0*sin(2*pi*120*t) + 0.5*randn(size(t));
N = length(x);
X = fft(x);
P2 = abs(X/N);
P1 = P2(1:N/2 + 1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:N/2)/N;
subplot(2, 1, 1); plot(t(1:200), x(1:200)); title('Noisy signal (first 0.2 s)'); xlabel('t (s)')
subplot(2, 1, 2); plot(f, P1); title('Amplitude spectrum'); xlabel('f (Hz)'); grid on
[~, idx] = sort(P1, 'descend');
fprintf('Strongest frequencies: %g Hz (amp %.2f) and %g Hz (amp %.2f)\n', f(idx(1)), P1(idx(1)), f(idx(2)), P1(idx(2)));
