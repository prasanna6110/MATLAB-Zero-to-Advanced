# Day 004 · Variables: Assignment, Naming Rules and Predefined Variables

_Getting Started_

## The assignment operator `=`
`variable_name = expression` calculates the right side and stores it in the variable. It is **not** "equals" in the maths sense: `x = x + 1` means "take x, add 1, store it back in x".

Rules:
- The variable on the left must be **one name**. `x + 2 = 10` is an error.
- Every variable on the right must already have a value.
- Re-assigning a variable **overwrites** its old value.

## Naming rules
- Must **start with a letter**. Can contain letters, digits and underscores: `load_kW`, `R2`, `vMax`.
- **No spaces**, no hyphens, no special characters (`$ # - .`).
- **Case sensitive**: `Volt`, `volt` and `VOLT` are three different variables.
- Up to 63 characters (`namelengthmax`).
- Do **not** use keywords: `if for while end function return break switch case otherwise else elseif try catch global persistent continue parfor spmd classdef`. List them with `iskeyword`.
- **Avoid** names of built-in functions such as `sum`, `max`, `sin`, `i`, `j`, `pi`, `length`. If you write `sum = 5`, the `sum()` function stops working until you `clear sum`.

## Predefined variables
| Name | Value |
|------|-------|
| `ans` | result of the last expression not stored in a variable |
| `pi` | π = 3.14159… |
| `eps` | 2.2204e-16, the gap between 1 and the next double (floating-point accuracy) |
| `Inf` / `inf` | infinity, e.g. `1/0` |
| `NaN` | Not-a-Number, e.g. `0/0` |
| `i`, `j` | the imaginary unit √-1 (use `1i` to be safe) |
| `realmax`, `realmin`, `intmax`, `intmin` | largest / smallest numbers |

## Examples

### Example 1: Assignment is not an equation  ([`example_1.m`](example_1.m))

```matlab
x = 10
x = x + 5          % take the old x (10), add 5, store back -> 15
x = x * 2          % 30
count = 0;
count = count + 1;
count = count + 1;
disp(count)        % 2
% Several values from one formula
a = 12; b = 5;
c = sqrt(a^2 + b^2)
```

### Example 2: Valid names, case sensitivity and keywords  ([`example_2.m`](example_2.m))

```matlab
Volt = 230; volt = 110;
disp([Volt volt])            % two different variables
motor_speed_rpm = 1440;
R2 = 4.7e3;
iskeyword('for')             % 1 = true, 'for' is reserved
isvarname('2ndValue')        % 0 = false, cannot start with a digit
isvarname('value_2')         % 1 = true
% Shadowing a function by mistake:
sum = 10;                    % now 'sum' is a variable...
clear sum                    % ...clear it so sum() works again
sum([1 2 3])
```

### Example 3: Predefined variables, Inf, NaN and complex numbers  ([`example_3.m`](example_3.m))

```matlab
pi
eps
1 / 0                        % Inf
-5 / 0                       % -Inf
0 / 0                        % NaN
Inf - Inf                    % NaN
z = 3 + 4i                   % complex number
abs(z)                       % magnitude 5
angle(z)                     % phase in radians
sqrt(-16)                    % 0 + 4i
realmax
```

## Practice

1. Which of these are valid variable names: `2x`, `x2`, `my-var`, `my_var`, `_temp`, `Temp`, `end`?
2. Set `a = 3`, then run `a = a^2 + a` three times. Predict each value first.
3. What do `NaN == NaN` and `isnan(NaN)` return? Why?
4. Create the complex impedance `Z = 30 + 40j` and find its magnitude and angle in degrees (`rad2deg`).

---

[⬅ Day 003](../Day-003-Display-Formats-and-Elementary-Math-Built-in-Functions/README.md) · [🏠 Home](../README.md) · [Day 005 ➡](../Day-005-Managing-Variables-who-whos-clear-clc-and-the-Workspace/README.md)
