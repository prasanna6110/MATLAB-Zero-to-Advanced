% Day 094 · Physical Modelling with Simscape and Simulink-Supported Hardware — The expected current of that circuit, from the equations
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% A 24 V source switched onto series R-L-C at t = 0 (capacitor initially empty)
R = 10; L = 0.1; C = 100e-6; V = 24;
alpha = R/(2*L); w0 = 1/sqrt(L*C); wd = sqrt(w0^2 - alpha^2);
t = linspace(0, 0.1, 2000);
i = V/(wd*L) * exp(-alpha*t) .* sin(wd*t);        % underdamped closed-form solution
plot(t*1000, i, 'LineWidth', 1.5); grid on
xlabel('t (ms)'); ylabel('i (A)'); title('Current the Simscape Scope should show')
[ipk, k] = max(i);
fprintf('alpha = %.1f 1/s, w0 = %.1f rad/s, wd = %.1f rad/s\n', alpha, w0, wd);
fprintf('Peak current %.3f A at %.2f ms\n', ipk, t(k)*1000);
