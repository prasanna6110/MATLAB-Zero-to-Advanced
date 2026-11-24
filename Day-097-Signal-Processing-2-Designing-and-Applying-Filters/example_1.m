% Day 097 · Signal Processing 2: Designing and Applying Filters — A moving-average filter with core filter
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

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
