% Day 073 · Numerical Integration: integral, trapz and cumtrapz — integral of functions, including infinite limits
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

q1 = integral(@(x) 0.8*x.*exp(-0.2*x), 0, 8)
q2 = integral(@(x) exp(-x.^2), -Inf, Inf)       % sqrt(pi)
sqrt(pi)
q3 = integral(@(x) 1 ./ (1 + x.^2), 0, 1)       % pi/4
% RMS value of a 325 V peak sine over one period
T = 0.02;
Vrms = sqrt(integral(@(t) (325*sin(2*pi*50*t)).^2, 0, T) / T);
fprintf('Vrms = %.2f V (325/sqrt(2) = %.2f)\n', Vrms, 325/sqrt(2));
