% Day 128 · Project 21: Numerical Methods Toolkit: Comparing Root-Finding Methods — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear; close all;
problems = {
    'x^3 - 2x - 5',        @(x) x.^3 - 2*x - 5,      @(x) 3*x.^2 - 2,          [2 3]
    'cos(x) - x',          @(x) cos(x) - x,          @(x) -sin(x) - 1,          [0 1]
    'e^-x - 0.2x (diode-like)', @(x) exp(-x) - 0.2*x, @(x) -exp(-x) - 0.2,      [0 5]
    };
methods = {'bisection', 'false position', 'Newton', 'secant'};
tol = 1e-12;
for p = 1:size(problems, 1)
    [name, f, df, ab] = problems{p, :};
    ref = fzero(f, ab);
    fprintf('\n%s   (fzero root = %.12f)\n', name, ref);
    fprintf('%-15s %8s %20s %12s\n', 'Method', 'Iter', 'Root', 'Error');
    for m = 1:numel(methods)
        switch m
            case 1, [r, hist] = bisection(f, ab(1), ab(2), tol);
            case 2, [r, hist] = false_position(f, ab(1), ab(2), tol);
            case 3, [r, hist] = newton(f, df, mean(ab), tol);
            case 4, [r, hist] = secant(f, ab(1), ab(2), tol);
        end
        fprintf('%-15s %8d %20.12f %12.2e\n', methods{m}, numel(hist), r, abs(r - ref));
        if p == 1
            semilogy(1:numel(hist), max(abs(hist - ref), 1e-16), 'o-', 'DisplayName', methods{m}); hold on
        end
    end
end
hold off; grid on; xlabel('iteration'); ylabel('|error|'); legend show
title('Convergence on x^3 - 2x - 5 = 0')

function [c, hist] = bisection(f, a, b, tol)
    hist = [];
    while true
        c = (a + b)/2;  hist(end+1) = c; %#ok<AGROW>
        if f(a)*f(c) <= 0, b = c; else, a = c; end
        if (b - a)/2 < tol || numel(hist) > 200, break; end
    end
end

function [c, hist] = false_position(f, a, b, tol)
    hist = []; c = a;
    for k = 1:500
        c_old = c;
        c = b - f(b)*(b - a)/(f(b) - f(a));  hist(end+1) = c; %#ok<AGROW>
        if f(a)*f(c) <= 0, b = c; else, a = c; end
        if abs(c - c_old) < tol || f(c) == 0, break; end
    end
end

function [x, hist] = newton(f, df, x, tol)
    hist = [];
    for k = 1:100
        step = f(x)/df(x);
        x = x - step;  hist(end+1) = x; %#ok<AGROW>
        if abs(step) < tol, break; end
    end
end

function [x1, hist] = secant(f, x0, x1, tol)
    hist = [];
    for k = 1:100
        x2 = x1 - f(x1)*(x1 - x0)/(f(x1) - f(x0));
        x0 = x1; x1 = x2;  hist(end+1) = x1; %#ok<AGROW>
        if abs(x1 - x0) < tol || f(x1) == 0, break; end
    end
end
