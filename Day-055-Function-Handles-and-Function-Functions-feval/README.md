# Day 055 · Function Handles and Function Functions (feval)

_User-Defined Functions_

## Function handles
A **function handle** is a variable that **refers to a function**. Create one with `@`:
```matlab
h = @sin;               % a handle to a built-in or file function
g = @(x) x.^2 + 1;      % an anonymous function is also a handle
h(pi/2)                 % call it like the function
```
Related functions: `func2str(h)`, `str2func('cos')`, `functions(h)`, `isa(h, 'function_handle')`.

## Function functions
A **function function** takes **another function as an input**. Many MATLAB tools work this way:

| Function | Uses the passed function to |
|----------|-----------------------------|
| `fplot(f, [a b])` | plot it |
| `fzero(f, x0)` | find where it is zero |
| `fminbnd(f, a, b)` | find its minimum |
| `integral(f, a, b)` | integrate it |
| `ode45(f, tspan, y0)` | solve an ODE |
| `arrayfun(f, v)` | apply it to every element |
| `cellfun(f, C)` | apply it to every cell |

## Writing your own function function
Accept the handle as an input and call it inside:
```matlab
function r = my_tool(fun, a, b)
    r = fun(b) - fun(a);
end
```
Older code passes the **name as text** and calls `feval('name', x)`. Handles are preferred: faster and less error-prone.

## Examples

### Example 1: Handles to built-in and anonymous functions  ([`example_1.m`](example_1.m))

```matlab
h = @cos;
h(0)
fns = {@sin, @cos, @(x) x.^2, @sqrt};       % a cell array of functions
x = 0.5;
for k = 1:numel(fns)
    fprintf('%-12s(%.1f) = %.4f\n', func2str(fns{k}), x, fns{k}(x));
end
f = str2func('exp');
f(1)
feval(@log10, 1000)
feval('max', [3 9 2])                      % the old way, by name
```

### Example 2: Writing your own function function  ([`example_2.m`](example_2.m))

```matlab
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
```

### Example 3: arrayfun and cellfun  ([`example_3.m`](example_3.m))

```matlab
words = {'resistor', 'IC', 'capacitor', 'diode'};
lengths = cellfun(@length, words)
upper_words = cellfun(@upper, words, 'UniformOutput', false)
long_ones = words(cellfun(@(w) length(w) > 5, words))
n = 1:6;
fact = arrayfun(@factorial, n)
digits_sum = arrayfun(@(k) sum(num2str(k) - '0'), [123 4567 99])
```

## Practice

1. Create a cell array of 4 function handles and plot each one in its own subplot with `fplot`.
2. Write `function plot_and_root(f, a, b)` that plots `f` on `[a b]` and marks its root.
3. Use `cellfun` to count the words longer than 4 letters in a cell array.
4. Convert the text `'@(x) x.^2 + 1'` into a function with `str2func` and evaluate it at 3.

---

[⬅ Day 054](../Day-054-Anonymous-Functions/README.md) · [🏠 Home](../README.md) · [Day 056 ➡](../Day-056-Subfunctions-and-Nested-Functions/README.md)
