% Day 045 · while Loops — Square root by repeated averaging
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

a = 50;                    % find sqrt(a)
x = a;                     % first guess
iter = 0;
while abs(x^2 - a) > 1e-10 && iter < 100
    x = (x + a/x) / 2;     % average of x and a/x
    iter = iter + 1;
    fprintf('iteration %d: x = %.12f\n', iter, x);
end
fprintf('sqrt(%d) = %.10f (built-in %.10f)\n', a, x, sqrt(a));
