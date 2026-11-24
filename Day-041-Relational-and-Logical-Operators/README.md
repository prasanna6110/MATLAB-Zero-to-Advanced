# Day 041 · Relational and Logical Operators

_Programming in MATLAB_

## Relational operators
| Operator | Meaning |
|----------|---------|
| `<` `>` `<=` `>=` | less / greater (or equal) |
| `==` | equal to (two equal signs!) |
| `~=` | not equal to |

The result is **logical**: `1` (true) or `0` (false). With arrays, the comparison is done **element by element** and returns a logical array.

## Logical operators
| Operator | Name | True when |
|----------|------|-----------|
| `&` | AND | both are true (element-wise) |
| `\|` | OR | at least one is true (element-wise) |
| `~` | NOT | the operand is false |
| `&&` | short-circuit AND | scalars only, stops if the first is false |
| `\|\|` | short-circuit OR | scalars only, stops if the first is true |
| `xor(a, b)` | exclusive OR | exactly one is true |

Any **non-zero** number counts as true; zero counts as false.

## Order of precedence (highest first)
1. parentheses
2. exponent `^`
3. logical NOT `~`
4. multiplication, division
5. addition, subtraction
6. relational operators `< > <= >= == ~=`
7. `&`
8. `|`
9. `&&`
10. `||`

> **Common mistake:** `3 < x < 7` does **not** test "x between 3 and 7". MATLAB evaluates `(3 < x)` first (0 or 1), then compares that with 7, so the answer is always true. Write `x > 3 & x < 7`.

> Floating point: `0.1 + 0.2 == 0.3` is **false** because of rounding. Compare with a tolerance: `abs(a - b) < 1e-10`.

Useful logical functions: `any`, `all`, `find`, `isequal`, `ismember`, `isempty`, `isnan`, `logical`, `true`, `false`.

## Examples

### Example 1: Comparisons give 0 or 1  ([`example_1.m`](example_1.m))

```matlab
5 > 8
5 ~= 8
a = 5 >= 5
class(a)                           % logical
v = [3 8 1 9 4];
v > 4                              % element by element
sum(v > 4)                         % how many
y = (6 < 10) + (7 > 8) + (5*3 == 60/4)   % true + false + true = 2
```

### Example 2: AND, OR, NOT and the "between" trap  ([`example_2.m`](example_2.m))

```matlab
x = 10;
wrong = 3 < x < 7                  % (3 < 10) = 1, then 1 < 7 = 1 -> wrong!
right = x > 3 & x < 7              % 0, correct
~(x > 5)
xor(true, true)
temps = [12 18 25 31 38 42];
comfortable = temps(temps >= 18 & temps <= 30)
extreme = temps(temps < 15 | temps > 40)
```

### Example 3: Short-circuit operators and floating-point comparison  ([`example_3.m`](example_3.m))

```matlab
v = [];
if ~isempty(v) && v(1) > 0         % && stops before v(1), so no error
    disp('positive first element')
else
    disp('empty or not positive')
end
a = 0.1 + 0.2;
a == 0.3                           % 0 because of rounding
abs(a - 0.3) < 1e-12               % 1, compare with a tolerance
fprintf('%.20f\n', a);
```

## Practice

1. Evaluate by hand, then check: `~(4 > 3) | 2 == 2`, `3 + 4 > 6 & 5 ~= 5`.
2. For `v = randi(100, 1, 20)`, count the elements between 25 and 75 (inclusive).
3. Why does `if [1 0 1]` count as false?
4. Write a test that a year is a leap year: divisible by 4 and (not by 100 or by 400).

---

[⬅ Day 040](../Day-040-Multiple-Plots-on-a-Page-Multiple-Figures-and-Saving-Figures/README.md) · [🏠 Home](../README.md) · [Day 042 ➡](../Day-042-Conditional-Statements-if-else-and-elseif/README.md)
