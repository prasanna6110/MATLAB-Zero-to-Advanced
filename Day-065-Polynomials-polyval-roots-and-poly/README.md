# Day 065 · Polynomials: polyval, roots and poly

_Polynomials, Curve Fitting and Interpolation_

## How MATLAB stores a polynomial
A polynomial is a **row vector of its coefficients, from the highest power down to the constant**:

f(x) = 5x³ + 6x² - 7x + 3  →  `p = [5 6 -7 3]`

Missing powers need a **0**: x⁴ - 2x + 1 → `[1 0 0 -2 1]`.

## Main functions
| Function | Does |
|----------|------|
| `polyval(p, x)` | the value of p at x (x can be a vector or matrix) |
| `roots(p)` | all roots (real and complex) as a column |
| `poly(r)` | the polynomial (leading coefficient 1) whose roots are r |
| `poly(A)` | the characteristic polynomial of a square matrix |
| `polyval(p, A)` vs `polyvalm(p, A)` | element-wise vs matrix polynomial |

A polynomial of degree n has exactly n roots (counting complex and repeated ones). `roots` returns them in no particular order.

## Examples

### Example 1: Evaluating and plotting a polynomial  ([`example_1.m`](example_1.m))

```matlab
p = [1 -12.1 40.59 -17.015 -71.95 35.88];   % degree 5
polyval(p, 9)
x = linspace(-1.5, 6.7, 300);
y = polyval(p, x);
plot(x, y, 'LineWidth', 1.5); grid on
xlabel('x'); ylabel('p(x)'); title('A fifth-degree polynomial')
r = roots(p)
hold on
plot(real(r(abs(imag(r)) < 1e-9)), 0*r(abs(imag(r)) < 1e-9), 'ro', 'MarkerFaceColor', 'r')
hold off
```

### Example 2: roots and poly are opposites  ([`example_2.m`](example_2.m))

```matlab
p = [1 -6 11 -6];          % (x-1)(x-2)(x-3)
r = roots(p)'
back = poly(r)             % recovers p
q = poly([-2 0.5 4])       % build from roots
polyval(q, [-2 0.5 4])     % all zero
roots([1 0 4])             % x^2 + 4: complex roots +/- 2i
```

### Example 3: The characteristic polynomial of a matrix  ([`example_3.m`](example_3.m))

```matlab
A = [2 1 0; 1 3 1; 0 1 4];
cp = poly(A)               % det(lambda*I - A)
lambda = roots(cp)'
eig(A)'                    % the same numbers
% Natural frequencies of a 2-mass spring system (k/m = 100)
K = [200 -100; -100 100];
w = sqrt(roots(poly(K)))'  % rad/s
```

## Practice

1. Write `x⁴ - 3x² + 2` as a MATLAB vector and find its roots.
2. Evaluate `p(x) = 2x³ - x + 7` at x = -2, 0, 2.5 using one `polyval` call.
3. Find the polynomial whose roots are 1, -1, 3 and check it.
4. Plot a polynomial and mark its real roots on the graph.

---

[⬅ Day 064](../Day-064-Set-Operations-and-Key-Value-Maps/README.md) · [🏠 Home](../README.md) · [Day 066 ➡](../Day-066-Polynomial-Arithmetic-conv-deconv-polyder-polyint-and-residue/README.md)
