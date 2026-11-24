# Day 057 · Recursion

_User-Defined Functions_

## A function that calls itself
A **recursive** function solves a problem by calling **itself** on a **smaller** version of the problem. It needs:
1. a **base case** that is answered directly (stops the recursion)
2. a **recursive case** that reduces the problem towards the base case

```matlab
function f = fact(n)
    if n <= 1
        f = 1;               % base case
    else
        f = n * fact(n - 1); % recursive case
    end
end
```

## Things to know
- MATLAB limits the depth (`get(0, 'RecursionLimit')`, default 500). Too deep → an error.
- Naive recursion can be **very slow** when it repeats work (Fibonacci). Store results (memoisation) or use a loop.
- Recursion is natural for tree-like problems: folders inside folders, divide-and-conquer sorting, fractals, Tower of Hanoi, determinants by cofactor expansion.

## Examples

### Example 1: Factorial, sum of digits and power  ([`example_1.m`](example_1.m))

```matlab
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
```

### Example 2: Fibonacci: naive vs memoised  ([`example_2.m`](example_2.m))

```matlab
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
```

### Example 3: Tower of Hanoi and recursive merge sort  ([`example_3.m`](example_3.m))

```matlab
hanoi(3, 'A', 'C', 'B');
v = [38 27 43 3 9 82 10];
fprintf('Sorted: %s\n', mat2str(merge_sort(v)));

function hanoi(n, from, to, via)
    if n == 0, return; end
    hanoi(n - 1, from, via, to);
    fprintf('Move disc %d from %s to %s\n', n, from, to);
    hanoi(n - 1, via, to, from);
end

function s = merge_sort(v)
    if numel(v) <= 1
        s = v;
        return
    end
    mid = floor(numel(v) / 2);
    a = merge_sort(v(1:mid));
    b = merge_sort(v(mid+1:end));
    s = zeros(1, numel(v)); i = 1; j = 1;
    for k = 1:numel(v)
        if j > numel(b) || (i <= numel(a) && a(i) <= b(j))
            s(k) = a(i); i = i + 1;
        else
            s(k) = b(j); j = j + 1;
        end
    end
end
```

## Practice

1. Write a recursive function for the greatest common divisor (gcd(a, b) = gcd(b, mod(a, b))).
2. Write a recursive function that reverses a text.
3. Count the moves of Tower of Hanoi for n = 1..10 and compare with 2ⁿ - 1.
4. Write a recursive binary search on a sorted vector.

---

[⬅ Day 056](../Day-056-Subfunctions-and-Nested-Functions/README.md) · [🏠 Home](../README.md) · [Day 058 ➡](../Day-058-Cell-Arrays/README.md)
