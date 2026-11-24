# Day 096 · Signal Processing 1: Sampling, FFT and the Frequency Spectrum

_Advanced MATLAB and Toolboxes_

## Sampling
A computer stores a signal as **samples** taken every **Ts** seconds, at the **sampling frequency** fs = 1/Ts.
- **Nyquist theorem:** fs must be **more than twice** the highest frequency in the signal. Otherwise high frequencies appear as false low ones (**aliasing**).
- With N samples, the **frequency resolution** is fs/N Hz.

## The FFT
`X = fft(x)` computes the Discrete Fourier Transform: which **frequencies** the signal contains and how strong they are.
```matlab
N  = length(x);
X  = fft(x);
P2 = abs(X/N);                 % two-sided amplitude
P1 = P2(1:floor(N/2)+1);       % keep the positive frequencies
P1(2:end-1) = 2*P1(2:end-1);   % fold the negative half in
f  = fs*(0:floor(N/2))/N;      % the frequency axis
plot(f, P1)
```
Then each peak's height is the **amplitude** of that sine wave.

Related: `ifft` (back to time), `fftshift` (centre the zero frequency), `abs`/`angle` (magnitude/phase), `periodogram`/`pwelch` (power spectra), `spectrogram` (frequency content over time), and for power quality the **THD** (total harmonic distortion).

## Windowing
If the signal does not contain a whole number of periods, the peaks "leak" into neighbouring frequencies. Multiplying by a window (`hann(N)`, `hamming(N)`) reduces this leakage.

## Examples

### Example 1: The spectrum of a signal with two frequencies and noise  ([`example_1.m`](example_1.m))

```matlab
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
```

### Example 2: Aliasing: sampling too slowly  ([`example_2.m`](example_2.m))

```matlab
f_sig = 90;                                   % a 90 Hz sine
t_fine = linspace(0, 0.1, 2000);
fs_low = 100;                                 % below 2*90 = 180 Hz
t_s = 0:1/fs_low:0.1;
plot(t_fine, sin(2*pi*f_sig*t_fine), 'Color', [0.7 0.7 0.7]); hold on
plot(t_s, sin(2*pi*f_sig*t_s), 'ro-', 'MarkerFaceColor', 'r'); hold off
title('90 Hz sampled at 100 Hz looks like 10 Hz'); xlabel('t (s)')
f_alias = abs(f_sig - round(f_sig/fs_low)*fs_low);
fprintf('Apparent (alias) frequency: %g Hz\n', f_alias);
```

### Example 3: Harmonics and THD of a distorted current  ([`example_3.m`](example_3.m))

```matlab
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
```

## Practice

1. Find the frequencies in `x = 3sin(2π·15t) + sin(2π·40t)` sampled at 200 Hz for 2 s.
2. Show aliasing of a 70 Hz sine sampled at 80 Hz. What frequency appears?
3. Add a 3rd harmonic of 20% to a 50 Hz sine and compute its THD.
4. Compare the spectrum of a 50.5-cycle signal with and without a `hann` window.

---

[⬅ Day 095](../Day-095-Simulink-Examples-Feedback-Control-with-a-PID-Controller/README.md) · [🏠 Home](../README.md) · [Day 097 ➡](../Day-097-Signal-Processing-2-Designing-and-Applying-Filters/README.md)
