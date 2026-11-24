# Day 042 · Conditional Statements: if, else and elseif

_Programming in MATLAB_

## The three forms
```matlab
if condition
    commands
end

if condition
    commands when true
else
    commands when false
end

if condition1
    commands1
elseif condition2
    commands2
else
    commands when nothing above was true
end
```
- Only the **first** true branch runs.
- `elseif` is **one word**. `else if` starts a new, nested `if` that needs its own `end`.
- When the condition is an **array**, it is true only if **all** its elements are non-zero (and it is not empty). Use `any` or `all` to be clear.
- Indent the commands inside (Ctrl+I in the Editor) so the structure is easy to see.

## Examples

### Example 1: if-else: pass or fail  ([`example_1.m`](example_1.m))

```matlab
marks = 37;
if marks >= 40
    fprintf('Pass with %d marks\n', marks);
else
    fprintf('Fail: %d more marks needed\n', 40 - marks);
end
```

### Example 2: if-elseif-else: an electricity bill with slabs  ([`example_2.m`](example_2.m))

```matlab
units = 345;
if units <= 100
    bill = units * 3.5;
elseif units <= 200
    bill = 100*3.5 + (units - 100) * 4.5;
elseif units <= 400
    bill = 100*3.5 + 100*4.5 + (units - 200) * 6.0;
else
    bill = 100*3.5 + 100*4.5 + 200*6.0 + (units - 400) * 7.5;
end
fixed = 60;
fprintf('Units %d -> energy charge Rs %.2f + fixed Rs %d = Rs %.2f\n', units, bill, fixed, bill + fixed);
```

### Example 3: Classifying the roots of a quadratic  ([`example_3.m`](example_3.m))

```matlab
coeffs = [1 -2 5; 1 -5 6; 1 4 4];     % three equations a x^2 + b x + c = 0
for k = 1:3
    a = coeffs(k, 1); b = coeffs(k, 2); c = coeffs(k, 3);
    D = b^2 - 4*a*c;
    if D > 0
        r = (-b + [1 -1]*sqrt(D)) / (2*a);
        fprintf('Real distinct roots: %g and %g\n', r);
    elseif D == 0
        fprintf('One repeated root: %g\n', -b/(2*a));
    else
        re = -b/(2*a); im = sqrt(-D)/(2*a);
        fprintf('Complex roots: %g +/- %gi\n', re, im);
    end
end
```

## Practice

1. Write a script that prints the grade (A ≥ 90, B ≥ 75, C ≥ 60, D ≥ 40, else F) for a mark.
2. Check whether a number is positive, negative or zero.
3. Given three side lengths, decide whether they form a triangle and whether it is equilateral, isosceles or scalene.
4. Classify a voltage reading as "under-voltage" (< 207 V), "normal" or "over-voltage" (> 253 V).

---

[⬅ Day 041](../Day-041-Relational-and-Logical-Operators/README.md) · [🏠 Home](../README.md) · [Day 043 ➡](../Day-043-The-switch-case-Statement/README.md)
