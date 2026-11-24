% Day 055 · Function Handles and Function Functions (feval) — Writing your own function function
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

f = @(x) x.^3 - 2*x - 5;
fprintf('Average value of f on [0, 3]: %.4f\n', avg_value(f, 0, 3));
fprintf('Average value of sin on [0, pi]: %.4f (2/pi = %.4f)\n', avg_value(@sin, 0, pi), 2/pi);
r = bisect(f, 2, 3, 1e-8);
fprintf('Root of f by bisection: %.8f (fzero: %.8f)\n', r, fzero(f, 2));

function m = avg_value(fun, a, b)
    x = linspace(a, b, 10001);
    m = trapz(x, fun(x)) / (b - a);
end

function c = bisect(fun, a, b, tol)
    if fun(a) * fun(b) > 0
        error('The function must change sign between a and b');
    end
    while (b - a) / 2 > tol
        c = (a + b) / 2;
        if fun(a) * fun(c) <= 0
            b = c;
        else
            a = c;
        end
    end
    c = (a + b) / 2;
end
