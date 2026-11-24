% Day 057 · Recursion — Factorial, sum of digits and power
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

fprintf('5! = %d\n', fact(5));
fprintf('Sum of digits of 98765 = %d\n', digit_sum(98765));
fprintf('2^10 by fast recursion = %d\n', fast_pow(2, 10));

function f = fact(n)
    if n <= 1
        f = 1;
    else
        f = n * fact(n - 1);
    end
end

function s = digit_sum(n)
    if n < 10
        s = n;
    else
        s = mod(n, 10) + digit_sum(floor(n / 10));
    end
end

function p = fast_pow(x, n)       % x^n with about log2(n) multiplications
    if n == 0
        p = 1;
    elseif mod(n, 2) == 0
        h = fast_pow(x, n / 2);
        p = h * h;
    else
        p = x * fast_pow(x, n - 1);
    end
end
