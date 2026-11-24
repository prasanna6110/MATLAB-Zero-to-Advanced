# Day 002 · Working in the Command Window and Arithmetic with Scalars

_Getting Started_

## Working in the Command Window
- Type a command after `>>` and press **Enter** to run it.
- **Semicolon `;`** at the end: the command runs but the output is **not shown**.
- Several commands on one line: separate them with **commas** (output shown) or **semicolons** (hidden).
- **↑ / ↓ arrow keys** recall previous commands. Type a few letters then ↑ to search history.
- A long command can continue on the next line with **three dots `...`** (ellipsis).
- **`%`** starts a comment. MATLAB ignores everything after it on that line.
- **`clc`** clears the Command Window (the variables stay in memory).
- **Ctrl+C** stops a running command.

## Arithmetic operators
| Operation | Symbol | Example | Result |
|-----------|--------|---------|--------|
| Addition | `+` | `5 + 3` | 8 |
| Subtraction | `-` | `5 - 3` | 2 |
| Multiplication | `*` | `5 * 3` | 15 |
| Right division | `/` | `6 / 3` | 2 |
| Left division | `\` | `3 \ 6` | 2 (6 divided by 3) |
| Power | `^` | `5 ^ 3` | 125 |

## Order of precedence
1. Parentheses `()`, innermost first
2. Power `^`
3. Multiplication and division `* / \`
4. Addition and subtraction `+ -`

Operators with the same precedence run **left to right**. When in doubt, add parentheses.

> **Common mistake:** `8 + 4/2` is 10, not 6. And `-2^2` is **-4**, because power is done before the minus sign. Write `(-2)^2` to get 4.

## Examples

### Example 1: Operator precedence step by step  ([`example_1.m`](example_1.m))

```matlab
a = 8 + 4 / 2          % 10  (division first)
b = (8 + 4) / 2        % 6
c = 2 ^ 3 * 2          % 16  (power first)
d = 2 ^ (3 * 2)        % 64
e = -2 ^ 2             % -4  (power before the minus)
f = (-2) ^ 2           % 4
g = 27 ^ (1/3) + 32 ^ 0.2   % cube root of 27 + fifth root of 32 = 3 + 2
h = 10 \ 50            % left division: 50 / 10 = 5
```

### Example 2: Commas, semicolons, ellipsis and comments  ([`example_2.m`](example_2.m))

```matlab
x = 5, y = 10; z = x + y      % x and z are printed, y is not
total = 1 + 2 + 3 + 4 + ...
        5 + 6 + 7             % '...' continues a long line
% This whole line is a comment
speed = 72;   % km/h  <- an inline comment
speed_ms = speed * 1000 / 3600
```

### Example 3: Engineering calculations  ([`example_3.m`](example_3.m))

```matlab
% 1) Equivalent of three resistors in parallel
R1 = 10; R2 = 20; R3 = 40;
Req = 1 / (1/R1 + 1/R2 + 1/R3)
% 2) Compound interest: amount after n years
P = 50000; r = 0.07; n = 5;
A = P * (1 + r)^n
% 3) Kinetic energy of a 1200 kg car at 25 m/s
m = 1200; v = 25;
KE = 0.5 * m * v^2
```

## Practice

1. Predict, then check: `5 + 3*2^2`, `(5 + 3)*2^2`, `2^-1`, `100/10/2`.
2. Calculate `(sqrt(16) + 3^3) / (2*5 - 4)` by hand and in MATLAB.
3. Three capacitors 10 µF, 22 µF and 47 µF are in series. Find the equivalent capacitance.
4. Write one long sum over two lines using `...`.

---

[⬅ Day 001](../Day-001-What-is-MATLAB-Installation-and-the-MATLAB-Desktop/README.md) · [🏠 Home](../README.md) · [Day 003 ➡](../Day-003-Display-Formats-and-Elementary-Math-Built-in-Functions/README.md)
