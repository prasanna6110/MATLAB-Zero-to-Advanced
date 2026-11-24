% Day 072 · Finding a Minimum or a Maximum: fminbnd and fminsearch — Minimum and maximum of a function
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

f = @(x) x.^3 - 12*x.^2 + 40.25*x - 36.5;
fplot(f, [0 10]); grid on; hold on
[xmin, fmin] = fminbnd(f, 3, 8);
[xmax, negfmax] = fminbnd(@(x) -f(x), 0, 4);
plot(xmin, fmin, 'gv', xmax, -negfmax, 'r^', 'MarkerSize', 10, 'MarkerFaceColor', 'auto'); hold off
fprintf('Local minimum %.4f at x = %.4f\n', fmin, xmin);
fprintf('Local maximum %.4f at x = %.4f\n', -negfmax, xmax);
[x2, f2] = fminbnd(f, 0, 10)          % still the LOCAL minimum near 5.6...
fprintf('but f(0) = %.1f is lower: always check the end points too!\n', f(0));
