% Day 097 · Signal Processing 2: Designing and Applying Filters — Butterworth low-pass and a 50 Hz notch
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

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
