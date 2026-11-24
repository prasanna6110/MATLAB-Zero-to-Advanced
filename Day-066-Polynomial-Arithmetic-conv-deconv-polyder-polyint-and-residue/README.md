# Day 066 · Polynomial Arithmetic: conv, deconv, polyder, polyint and residue

_Polynomials, Curve Fitting and Interpolation_

## Operations
| Operation | How |
|-----------|-----|
| add / subtract | add the vectors after **padding the shorter one with leading zeros** to the same length |
| multiply | `c = conv(a, b)` |
| divide | `[q, r] = deconv(a, b)` → `a = conv(b, q) + r` |
| derivative | `polyder(p)` |
| derivative of a product | `polyder(a, b)` |
| derivative of a quotient | `[n, d] = polyder(a, b)` → n/d |
| integral | `polyint(p)` or `polyint(p, C)` with constant C |
| partial fractions | `[r, p, k] = residue(b, a)` for b(s)/a(s) |

## Partial fractions with `residue`
For a rational function `b(s)/a(s)`:

b(s)/a(s) = r₁/(s - p₁) + r₂/(s - p₂) + … + k(s)

`residue` is used in **inverse Laplace transforms** in circuits and control: each term r/(s - p) becomes r·e^(pt).

## Examples

### Example 1: Adding, multiplying and dividing polynomials  ([`example_1.m`](example_1.m))

```matlab
a = [3 15 0 -10 -3 15 -40];
b = [3 0 -2 -6];
b_padded = [zeros(1, numel(a) - numel(b)) b];
sum_ab = a + b_padded
prod_ab = conv(a, b)
[q, r] = deconv(a, b)
check = conv(b, q) + r - a      % should be all zeros
```

### Example 2: Derivatives and integrals  ([`example_2.m`](example_2.m))

```matlab
f = [3 -2 4];                   % 3x^2 - 2x + 4
g = [1 5];                      % x + 5
df = polyder(f)                 % 6x - 2
d_fg = polyder(f, g)            % derivative of f*g
[n, d] = polyder(f, g)          % derivative of f/g = n/d
F = polyint(f)                  % x^3 - x^2 + 4x (+0)
area = polyval(F, 2) - polyval(F, 0)     % integral from 0 to 2
% Turning points of f(x) = x^3 - 6x^2 + 9x + 1
p = [1 -6 9 1];
crit = roots(polyder(p))'
values = polyval(p, crit)
```

### Example 3: Partial fractions with residue  ([`example_3.m`](example_3.m))

```matlab
% F(s) = (2s + 3) / (s^2 + 3s + 2)  =  ?/(s+2) + ?/(s+1)
b = [2 3];
a = [1 3 2];
[r, p, k] = residue(b, a)
for m = 1:numel(r)
    fprintf('%+g / (s %+g)\n', r(m), -p(m));
end
% So f(t) = r1*exp(p1*t) + r2*exp(p2*t)
t = 0:0.5:2;
f_t = r(1)*exp(p(1)*t) + r(2)*exp(p(2)*t);
disp([t; f_t])
```

## Practice

1. Multiply `(x² + 2x - 3)` by `(x - 4)` and divide the result by `(x + 3)`.
2. Find the maximum of `-x³ + 3x² + 9x` on [0, 6] using `polyder` and `roots`.
3. Integrate `4x³ - 3x² + 1` from 1 to 3 with `polyint`.
4. Use `residue` on `(s + 5)/(s² + 5s + 6)`.

---

[⬅ Day 065](../Day-065-Polynomials-polyval-roots-and-poly/README.md) · [🏠 Home](../README.md) · [Day 067 ➡](../Day-067-Curve-Fitting-with-Polynomials-polyfit/README.md)
