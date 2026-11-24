# Day 050 · Creating a Function File and Its Structure

_User-Defined Functions_

## Why functions?
A **function** is a program that takes **inputs**, does a calculation and returns **outputs**. Unlike a script it has its **own workspace**, so it does not disturb (or depend on) your other variables. Write a function once and reuse it everywhere, exactly like `sqrt` or `max`.

## The structure of a function file
```matlab
function [out1, out2] = function_name(in1, in2)
% FUNCTION_NAME  One-line description (the H1 line).
%   Longer help text: how to call it, what the inputs
%   and outputs mean, units, an example.
    commands that compute out1 and out2 from in1 and in2
end
```
1. **Function definition line**: the keyword `function`, the output list in `[ ]`, `=`, the name, and the input list in `( )`.
2. **H1 line**: the first comment line. `lookfor` searches it.
3. **Help text**: the comment lines after it. `help function_name` prints the H1 and help text.
4. **Function body**: the code. Every output variable **must get a value**.
5. `end` closes the function (optional in a file with one function, required for nested functions and functions in scripts).

## Saving
Save the file with **the same name as the function**: `function_name.m`. If the names differ, MATLAB uses the **file** name. It must be in the **Current Folder** or on the path.

## Examples

### The function file circle_props.m  ([`circle_props.m`](circle_props.m))

```matlab
function [area, circumference] = circle_props(r)
% CIRCLE_PROPS  Area and circumference of a circle.
%   [A, C] = CIRCLE_PROPS(R) returns the area A and the circumference C
%   of a circle of radius R. R can be a vector: then A and C are vectors.
%
%   Example:
%       [a, c] = circle_props(2)
area = pi * r.^2;              % .^ so that it also works for vectors
circumference = 2 * pi * r;
end
```

### Example 1: Calling circle_props  ([`example_1.m`](example_1.m))

```matlab
[a, c] = circle_props(3)                 % both outputs
a_only = circle_props(10)                % only the first output
[areas, circs] = circle_props([1 2 3])   % works on vectors too
help circle_props                        % shows the help text
```

### The function file kwh_cost.m  ([`kwh_cost.m`](kwh_cost.m))

```matlab
function cost = kwh_cost(power_W, hours, tariff)
% KWH_COST  Cost of running an appliance.
%   COST = KWH_COST(POWER_W, HOURS, TARIFF) gives the cost in rupees of a
%   load of POWER_W watts running for HOURS hours at TARIFF Rs/kWh.
energy_kWh = power_W .* hours / 1000;
cost = energy_kWh * tariff;
end
```

### Example 2: Using kwh_cost for several appliances  ([`example_2.m`](example_2.m))

```matlab
names = {'Fan', 'LED TV', 'Fridge', 'AC'};
watts = [75 90 150 1500];
hours = [12 5 24 6];
monthly = kwh_cost(watts, hours * 30, 7.5);
for k = 1:numel(names)
    fprintf('%-7s Rs %8.2f per month\n', names{k}, monthly(k));
end
fprintf('Total   Rs %8.2f\n', sum(monthly));
```

## Practice

1. Write `f2c.m` that converts Fahrenheit to Celsius and works for vectors.
2. Write `[s, p] = sum_prod(v)` returning the sum and the product of a vector.
3. Add proper H1 and help text to your function and test `help` and `lookfor`.
4. What happens if an output variable is never assigned inside the function?

---

[⬅ Day 049](../Day-049-Error-Handling-try-catch-error-warning-and-assert/README.md) · [🏠 Home](../README.md) · [Day 051 ➡](../Day-051-Input-and-Output-Arguments-nargin-nargout-Defaults-and-varargin/README.md)
