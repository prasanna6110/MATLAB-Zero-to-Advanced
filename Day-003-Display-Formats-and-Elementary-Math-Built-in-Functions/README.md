# Day 003 · Display Formats and Elementary Math Built-in Functions

_Getting Started_

## Display formats: the `format` command
`format` changes **only how numbers are displayed**, never how they are stored (MATLAB always stores about 16 significant digits).

| Command | Shows | `pi` displays as |
|---------|-------|------------------|
| `format short` (default) | 4 decimals | 3.1416 |
| `format long` | 15 decimals | 3.141592653589793 |
| `format short e` | 4 decimals + exponent | 3.1416e+00 |
| `format long e` | 15 decimals + exponent | 3.141592653589793e+00 |
| `format short g` / `long g` | best of fixed or exponent | 3.1416 |
| `format bank` | 2 decimals (money) | 3.14 |
| `format compact` / `loose` | removes / adds blank lines | |
| `format rat` | a ratio of small integers | 355/113 |

## Elementary math functions
Call a function as `name(argument)`.

| Function | Meaning | Example |
|----------|---------|---------|
| `sqrt(x)` | square root | `sqrt(81)` → 9 |
| `nthroot(x,n)` | real n-th root | `nthroot(-27,3)` → -3 |
| `exp(x)` | eˣ | `exp(1)` → 2.7183 |
| `abs(x)` | absolute value | `abs(-7)` → 7 |
| `log(x)` | natural log (ln) | `log(exp(2))` → 2 |
| `log10(x)` / `log2(x)` | base-10 / base-2 log | `log10(1000)` → 3 |
| `factorial(n)` | n! | `factorial(5)` → 120 |
| `sin cos tan cot sec csc` | trig, angle in **radians** | `sin(pi/6)` → 0.5 |
| `sind cosd tand` | trig, angle in **degrees** | `sind(30)` → 0.5 |
| `asin acos atan atan2` | inverse trig (radians) | `atan2(1,1)` → 0.7854 |
| `asind acosd atand` | inverse trig (degrees) | `acosd(0.5)` → 60 |
| `sinh cosh tanh` | hyperbolic | |
| `round(x)` | nearest integer | `round(2.5)` → 3 |
| `fix(x)` | round toward zero | `fix(-2.7)` → -2 |
| `floor(x)` / `ceil(x)` | toward -∞ / +∞ | `floor(-2.3)` → -3 |
| `rem(x,y)` / `mod(x,y)` | remainder (sign of x / sign of y) | `rem(-7,3)` → -1, `mod(-7,3)` → 2 |
| `sign(x)` | -1, 0 or 1 | `sign(-4)` → -1 |
| `gcd`, `lcm`, `isprime`, `primes` | number theory | `gcd(12,18)` → 6 |
| `round(x, n)` | round to n decimal places (MATLAB R2014b+) | `round(pi,2)` → 3.14 |

> **Common mistake:** `sin(30)` uses **30 radians**. For degrees use `sind(30)` or `sin(30*pi/180)`.

## Examples

### Example 1: The same number in different formats  ([`example_1.m`](example_1.m))

```matlab
format short
x = 1/3
format long
x
format short e
big = 6.02214076e23
format bank
salary = 45210.567
format rat
pi
format short          % always switch back to the default
```

### Example 2: Elementary functions  ([`example_2.m`](example_2.m))

```matlab
sqrt(144)
nthroot(-125, 3)
exp(2)
log(100)              % natural log
log10(100)
factorial(6)
abs(-3 + 4)
round(-2.5), fix(-2.5), floor(-2.5), ceil(-2.5)
rem(17, 5), mod(-17, 5)
round(2.71828 * 1000) / 1000   % 2.718 (newer MATLAB: round(2.71828, 3))
```

### Example 3: Trigonometry in radians and degrees  ([`example_3.m`](example_3.m))

```matlab
angle_deg = 60;
s1 = sin(angle_deg * pi / 180)   % convert to radians yourself
s2 = sind(angle_deg)             % or use the degree version
theta = atan2d(3, 4)             % angle of the point (4,3) in degrees
% Power factor angle from P and Q
P = 800; Q = 600;
phi = atand(Q / P)               % degrees
pf = cosd(phi)                   % power factor = 0.8
```

## Practice

1. Show `exp(1)` in `format long`, `format short e` and `format bank`.
2. Find the hypotenuse of a right triangle with sides 5 and 12 using `sqrt` (also try `hypot(5,12)`).
3. Compare `rem(-10,4)` and `mod(-10,4)`. Explain the difference.
4. A ladder 6 m long makes 70° with the ground. How high does it reach? (Use `sind`.)

---

[⬅ Day 002](../Day-002-Working-in-the-Command-Window-and-Arithmetic-with-Scalars/README.md) · [🏠 Home](../README.md) · [Day 004 ➡](../Day-004-Variables-Assignment-Naming-Rules-and-Predefined-Variables/README.md)
