# Day 043 · The switch-case Statement

_Programming in MATLAB_

## Syntax
```matlab
switch expression
    case value1
        commands
    case {value2, value3}      % several values in a cell array
        commands
    otherwise
        commands when nothing matched
end
```
- The expression can be a **number** or a **text** (char or string).
- The first matching `case` runs, and then the switch ends (no "fall-through" as in C, no `break` needed).
- `otherwise` is optional.
- Text matching is **exact and case-sensitive**: use `lower(choice)` to ignore case.
- `switch` is clearer than a long `if-elseif` chain when you compare one value against fixed options. For ranges (`x > 5`) use `if`.

## Examples

### Example 1: A unit converter with text cases  ([`example_1.m`](example_1.m))

```matlab
value = 12;
unit = 'km';
switch lower(unit)
    case {'mm'}
        meters = value / 1000;
    case 'cm'
        meters = value / 100;
    case {'m', 'meter', 'metre'}
        meters = value;
    case 'km'
        meters = value * 1000;
    case {'in', 'inch'}
        meters = value * 0.0254;
    otherwise
        meters = NaN;
        disp('Unknown unit')
end
fprintf('%g %s = %g m\n', value, unit, meters);
```

### Example 2: Numeric cases: days in a month  ([`example_2.m`](example_2.m))

```matlab
month = 2; year = 2028;
switch month
    case {1, 3, 5, 7, 8, 10, 12}
        days = 31;
    case {4, 6, 9, 11}
        days = 30;
    case 2
        if mod(year, 4) == 0 && (mod(year, 100) ~= 0 || mod(year, 400) == 0)
            days = 29;
        else
            days = 28;
        end
    otherwise
        error('Month must be 1 to 12');
end
fprintf('Month %d of %d has %d days\n', month, year, days);
```

### Example 3: A small calculator menu  ([`example_3.m`](example_3.m))

```matlab
a = 18; b = 4;
ops = {'+', '-', '*', '/', '^', '%'};
for k = 1:numel(ops)
    op = ops{k};
    switch op
        case '+', r = a + b;
        case '-', r = a - b;
        case '*', r = a * b;
        case '/', r = a / b;
        case '^', r = a ^ b;
        otherwise
            fprintf('%s is not supported\n', op);
            continue
    end
    fprintf('%g %s %g = %g\n', a, op, b, r);
end
```

## Practice

1. Print the name of the day for a number 1–7 using `switch`.
2. Write a switch that gives the resistor colour for a digit (0 = black … 9 = white).
3. Make the unit converter also accept `'ft'` and `'mile'`.
4. When would you prefer `if-elseif` over `switch`? Give an example.

---

[⬅ Day 042](../Day-042-Conditional-Statements-if-else-and-elseif/README.md) · [🏠 Home](../README.md) · [Day 044 ➡](../Day-044-for-Loops/README.md)
