% Day 036 · Plots with Logarithmic Axes and Error Bars — Linear vs semilog vs loglog
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

x = linspace(0.1, 60, 1000);
y = 2.^(-0.2*x + 10);
subplot(2, 2, 1); plot(x, y);     title('plot (linear)'); grid on
subplot(2, 2, 2); semilogy(x, y); title('semilogy: exponential -> straight'); grid on
subplot(2, 2, 3); semilogx(x, y); title('semilogx'); grid on
subplot(2, 2, 4); loglog(x, y);   title('loglog'); grid on
