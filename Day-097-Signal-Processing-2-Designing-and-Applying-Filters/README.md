# Day 097 · Signal Processing 2: Designing and Applying Filters

_Advanced MATLAB and Toolboxes_

## Filtering
A **filter** keeps some frequencies and removes others.
| Type | Keeps |
|------|-------|
| low-pass | frequencies below the cut-off (removes noise) |
| high-pass | above the cut-off (removes drift/DC) |
| band-pass | a band (e.g. one channel) |
| band-stop / notch | everything except a band (e.g. 50 Hz hum) |

## Applying a filter
```matlab
y = filter(b, a, x)        % core MATLAB: difference equation with coefficients b, a
y = filtfilt(b, a, x)      % forwards and backwards: no phase delay (Signal Processing Toolbox)
```
A **moving average** of n points is the FIR filter `b = ones(1, n)/n, a = 1`.

## Designing filters (Signal Processing Toolbox; also Octave's `signal` package)
| Function | Designs |
|----------|---------|
| `[b, a] = butter(n, Wn)` | Butterworth IIR (flat pass band). `Wn` = cut-off / (fs/2) |
| `butter(n, Wn, 'high')`, `butter(n, [W1 W2], 'stop')` | high-pass, band-stop |
| `cheby1`, `cheby2`, `ellip` | sharper IIR filters with ripple |
| `b = fir1(n, Wn)` | linear-phase FIR |
| `designfilt(...)`, **Filter Designer** app (`filterDesigner`) | interactive design (MATLAB) |
| `freqz(b, a, nfft, fs)` | the frequency response |
| `lowpass(x, fpass, fs)`, `highpass`, `bandstop` | one-line filtering (MATLAB R2018a+) |

The **order** n sets how sharp the transition is; higher order = sharper but more delay and risk of numerical trouble.

## Examples

### Example 1: A moving-average filter with core filter  ([`example_1.m`](example_1.m))

```matlab
rng(2);
t = 0:0.001:1;
clean = sin(2*pi*3*t);
x = clean + 0.4*randn(size(t));
for n = [5 25 75]
    y = filter(ones(1, n)/n, 1, x);
    err = sqrt(mean((y(200:end) - clean(200 - floor(n/2):end - floor(n/2))).^2));
    fprintf('Moving average of %2d points: RMS error %.3f (after removing the delay)\n', n, err);
end
y = filter(ones(1, 25)/25, 1, x);
plot(t, x, 'Color', [0.75 0.75 0.75]); hold on
plot(t, y, 'b', t, clean, 'k--', 'LineWidth', 1.3); hold off
legend('noisy', '25-point average (delayed)', 'clean'); xlabel('t (s)')
```

### Example 2: Butterworth low-pass and a 50 Hz notch  ([`example_2.m`](example_2.m))

```matlab
% Needs: Signal Processing Toolbox
fs = 1000; t = 0:1/fs:2;
rng(3);
ecg_like = sin(2*pi*1.2*t).^15;                   % a spiky slow signal
x = ecg_like + 0.3*sin(2*pi*50*t) + 0.1*randn(size(t));
[b, a] = butter(4, 30/(fs/2));                    % 4th-order low-pass at 30 Hz
y = filtfilt(b, a, x);
[bn, an] = butter(2, [48 52]/(fs/2), 'stop');     % band-stop around 50 Hz
y2 = filtfilt(bn, an, x);
subplot(3, 1, 1); plot(t, x); title('Signal + 50 Hz hum + noise')
subplot(3, 1, 2); plot(t, y); title('Low-pass 30 Hz')
subplot(3, 1, 3); plot(t, y2); title('Notch 48-52 Hz'); xlabel('t (s)')
fprintf('RMS error: raw %.3f, low-pass %.3f, notch %.3f\n', ...
    sqrt(mean((x - ecg_like).^2)), sqrt(mean((y - ecg_like).^2)), sqrt(mean((y2 - ecg_like).^2)));
```

### Example 3: Frequency responses of different designs  ([`example_3.m`](example_3.m))

```matlab
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
```

## Practice

1. Smooth a noisy temperature record with moving averages of 3 and 11 points.
2. Remove a slow drift from a signal with a high-pass Butterworth filter.
3. Plot the frequency response of a 4th-order Butterworth band-pass filter for 40–60 Hz.
4. Why does `filtfilt` not delay the signal while `filter` does?

---

[⬅ Day 096](../Day-096-Signal-Processing-1-Sampling-FFT-and-the-Frequency-Spectrum/README.md) · [🏠 Home](../README.md) · [Day 098 ➡](../Day-098-Control-Systems-1-Transfer-Functions-Poles-and-Step-Response/README.md)
