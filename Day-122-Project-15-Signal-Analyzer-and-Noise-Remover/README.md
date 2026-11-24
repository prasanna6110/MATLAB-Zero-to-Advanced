# Day 122 · Project 15: Signal Analyzer and Noise Remover

_Projects_

## Goal
Build a small **signal-analysis toolkit** using only core MATLAB: generate or load a signal, compute its statistics (mean, RMS, peak, crest factor), its **spectrum** with the FFT, detect the dominant frequencies, then **remove noise and hum** in the frequency domain and with a moving-average filter, and measure the improvement with the **signal-to-noise ratio (SNR)**.

## Methods
- RMS = √(mean(x²)); crest factor = peak / RMS.
- Spectrum: one-sided amplitude from `fft`.
- Peak detection: local maxima above a threshold.
- **FFT filtering**: set the unwanted frequency bins to zero (and their mirror bins), then `ifft`.
- SNR (dB) = 10·log₁₀(signal power / noise power).

## Concepts used
Functions returning structures, FFT and IFFT, logical masks on frequency, `filter`, subplots.

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear; close all;
fs = 2000; t = 0:1/fs:2 - 1/fs;
rng(11);
clean = 1.0*sin(2*pi*5*t) + 0.5*sin(2*pi*12*t);          % the wanted low-frequency signal
hum = 0.6*sin(2*pi*50*t) + 0.2*sin(2*pi*150*t);           % mains hum and its 3rd harmonic
noise = 0.4*randn(size(t));
x = clean + hum + noise;
st = signal_stats(x);
fprintf('Mean %.3f, RMS %.3f, peak %.3f, crest factor %.2f\n', st.mean, st.rms, st.peak, st.crest);
[f, A] = spectrum(x, fs);
peaks = find_peaks(f, A, 0.1);
fprintf('Dominant frequencies: %s Hz\n', mat2str(round(peaks)));
% Filter 1: keep only 0-30 Hz using the FFT
y_fft = fft_filter(x, fs, @(fr) fr <= 30);
% Filter 2: a 40-point moving average (zeros at multiples of 50 Hz)
n = 40;
y_ma = filter(ones(1, n)/n, 1, x);
y_ma = [y_ma(n/2 + 1:end) zeros(1, n/2)];                 % remove the delay of n/2 samples
snr = @(est, ref) 10*log10(sum(ref.^2) / sum((est - ref).^2));
valid = 1:numel(t) - n;                                   % ignore the filter's start-up and end
fprintf('SNR raw %.1f dB | FFT low-pass %.1f dB | moving average %.1f dB\n', snr(x, clean), snr(y_fft, clean), snr(y_ma(valid), clean(valid)));
subplot(3, 1, 1); plot(t, x, 'Color', [0.6 0.6 0.6]); hold on; plot(t, clean, 'k'); hold off; xlim([0 1]); title('Noisy signal and the clean one')
subplot(3, 1, 2); plot(f, A); xlim([0 200]); grid on; title('Amplitude spectrum'); xlabel('Hz')
subplot(3, 1, 3); plot(t, y_fft, 'b', t, clean, 'k--'); xlim([0 1]); title('After FFT filtering'); legend('filtered', 'clean')

function s = signal_stats(x)
    s.mean = mean(x); s.rms = sqrt(mean(x.^2)); s.peak = max(abs(x)); s.crest = s.peak/s.rms;
end

function [f, A] = spectrum(x, fs)
    N = numel(x); X = fft(x);
    A = abs(X(1:floor(N/2) + 1))/N; A(2:end-1) = 2*A(2:end-1);
    f = (0:floor(N/2))*fs/N;
end

function pk = find_peaks(f, A, thr)
    k = find(A(2:end-1) > A(1:end-2) & A(2:end-1) >= A(3:end) & A(2:end-1) > thr) + 1;
    pk = f(k);
end

function y = fft_filter(x, fs, keep)
    N = numel(x); X = fft(x);
    fr = (0:N-1)*fs/N;
    fr(fr > fs/2) = fs - fr(fr > fs/2);          % mirror: the bins above fs/2 are negative frequencies
    X(~keep(fr)) = 0;
    y = real(ifft(X));
end
```

## Extend this project

- Load a real audio file with `audioread` and remove a hum from it.
- Replace the FFT filter with a Butterworth filter (`butter` + `filtfilt`) and compare the SNR.
- Add a spectrogram view (`spectrogram`) of a chirp signal.
- Detect the moment when a fault (a sudden amplitude jump) happens in a 50 Hz current signal.

---

[⬅ Day 121](../Day-121-Project-14-DC-Motor-Speed-Control-with-a-PI-Controller/README.md) · [🏠 Home](../README.md) · [Day 123 ➡](../Day-123-Project-16-Image-Analysis-Detecting-and-Counting-Objects/README.md)
