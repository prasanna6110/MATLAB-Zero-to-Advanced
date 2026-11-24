% Day 057 · Recursion — Fibonacci: naive vs memoised
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

n = 20;
tic; a = fib_slow(n); t1 = toc;
tic; b = fib_memo(n); t2 = toc;
fprintf('fib(%d) = %d (slow %.4f s) = %d (memo %.4f s)\n', n, a, t1, b, t2);

function f = fib_slow(n)
    if n <= 2
        f = 1;
    else
        f = fib_slow(n - 1) + fib_slow(n - 2);   % repeats the same work many times
    end
end

function f = fib_memo(n)
    persistent memo
    if isempty(memo), memo = [1 1]; end
    if n <= numel(memo) && memo(n) > 0
        f = memo(n);
        return
    end
    f = fib_memo(n - 1) + fib_memo(n - 2);
    memo(n) = f;
end
