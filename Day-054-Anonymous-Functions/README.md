# Day 054 · Anonymous Functions

_User-Defined Functions_

## Syntax
```matlab
name = @(arglist) expression
```
- A one-line function created **without a file**: `sq = @(x) x.^2;` then `sq(4)` → 16.
- It can have several inputs: `hyp = @(a, b) sqrt(a.^2 + b.^2)`, or none: `now_t = @() datestr(now)`.
- Only **one expression** is allowed (no `if`, no loops, no several statements).
- Write it with **element-wise** operators so it works on vectors.
- Variables from the workspace used in the expression are **captured** when the function is created. Changing them later does **not** change the function.
- An anonymous function can call other functions, including other anonymous functions.

`name` is a **function handle** (Day 55), so you can pass it to `fplot`, `fzero`, `integral`, `ode45` and many more.

## Examples

### Example 1: One-line functions  ([`example_1.m`](example_1.m))

```matlab
sq = @(x) x.^2;
sq(5)
sq([1 2 3])
hyp = @(a, b) sqrt(a.^2 + b.^2);
hyp(3, 4)
f = @(x) exp(-x) .* sin(2*x);
x = linspace(0, 5, 6);
disp([x; f(x)])
rand_dice = @() randi(6);          % no inputs
rng(1); rand_dice()
```

### Example 2: Captured variables  ([`example_2.m`](example_2.m))

```matlab
a = 2; b = 3;
line_fn = @(x) a*x + b;
line_fn(10)                        % 23
a = 100;                           % change a afterwards...
line_fn(10)                        % ...still 23: a = 2 was captured
line_fn = @(x) a*x + b;            % re-create it to use the new a
line_fn(10)                        % 1003
```

### Example 3: Engineering formulas as anonymous functions  ([`example_3.m`](example_3.m))

```matlab
XL = @(f, L) 2*pi*f.*L;
XC = @(f, C) 1 ./ (2*pi*f.*C);
Zmag = @(R, f, L, C) sqrt(R.^2 + (XL(f, L) - XC(f, C)).^2);   % uses the other two
f = [25 50 100 200];
disp([f; Zmag(10, f, 0.1, 100e-6)])
f0 = fzero(@(f) XL(f, 0.1) - XC(f, 100e-6), 50);
fprintf('Resonance at %.2f Hz\n', f0);
```

## Practice

1. Write an anonymous function for the area of a triangle from base and height.
2. Write `g = @(x) ...` for `g(x) = x³ - 2x - 5` and plot it with `fplot`.
3. Create `f = @(x) k*x` with k = 2, then change k to 5. What does `f(1)` give? Why?
4. Write an anonymous function that converts km/h to m/s and use it on a vector.

---

[⬅ Day 053](../Day-053-Scripts-vs-Functions-and-Local-Functions-in-Scripts/README.md) · [🏠 Home](../README.md) · [Day 055 ➡](../Day-055-Function-Handles-and-Function-Functions-feval/README.md)
