# Day 053 · Scripts vs Functions, and Local Functions in Scripts

_User-Defined Functions_

## Comparison
| | Script | Function |
|--|--------|----------|
| First line | any command | `function ... = name(...)` |
| Inputs / outputs | none (uses the workspace) | arguments in `()` and `[]` |
| Workspace | the **base** workspace, shared | its **own**, private |
| Variables after it runs | stay in the workspace | disappear (only outputs return) |
| Typical use | a sequence of steps, an experiment, a report | a reusable calculation |
| Run with | its name, or Run | its name **with inputs** |

## Local functions inside a script (MATLAB R2016b+)
A script can end with one or more **local functions** that only that script can use:
```matlab
x = 3;
fprintf('%g\n', triple(x));

function y = triple(x)      % local functions go at the END of the script
    y = 3 * x;
end                          % each must end with 'end'
```
This keeps small helpers in the same file. (GNU Octave instead wants the functions **before** they are used, with `1;` on the first line; this course's test runner handles that automatically.)

## Many functions in one function file
A function file can also contain extra functions after the main one: these are **subfunctions** (Day 56), visible only inside that file.

## Function precedence
When you type a name, MATLAB looks for: a variable → a nested/local function → a private function → a class method → a file in the current folder → files on the path. `which name -all` lists every match.

## Examples

### Example 1: A script with local functions  ([`example_1.m`](example_1.m))

```matlab
temps_c = [-10 0 25 37 100];
temps_f = c_to_f(temps_c);
for k = 1:numel(temps_c)
    fprintf('%6.1f C = %6.1f F  (%s)\n', temps_c(k), temps_f(k), describe(temps_c(k)));
end

function f = c_to_f(c)
    f = c * 9/5 + 32;
end

function txt = describe(c)
    if c <= 0
        txt = 'freezing';
    elseif c < 30
        txt = 'pleasant';
    elseif c < 45
        txt = 'hot';
    else
        txt = 'boiling region';
    end
end
```

### Example 2: The same task as a script and as a function  ([`example_2.m`](example_2.m))

```matlab
% Script style: works on whatever is in the workspace
R = [10 20 30];
R_series = sum(R);
R_parallel = 1 / sum(1 ./ R);
fprintf('Script:   series %.2f, parallel %.3f\n', R_series, R_parallel);
% Function style: inputs in, outputs out
[s, p] = resistor_combo([10 20 30]);
fprintf('Function: series %.2f, parallel %.3f\n', s, p);
[s2, p2] = resistor_combo([4.7 4.7]);
fprintf('Function: series %.2f, parallel %.3f\n', s2, p2);

function [Rs, Rp] = resistor_combo(R)
    Rs = sum(R);
    Rp = 1 / sum(1 ./ R);
end
```

### Example 3: Which file runs? which and exist  ([`example_3.m`](example_3.m))

```matlab
which sin
which mean
fprintf('exist sin: %d (5 = built-in, 2 = file)\n', exist('sin'));
fprintf('exist mean: %d\n', exist('mean'));
mean = 7;                        % a variable now hides the function
fprintf('exist mean after "mean = 7": %d (1 = variable)\n', exist('mean'));
clear mean
fprintf('mean([2 4 6]) works again: %g\n', mean([2 4 6]));
```

## Practice

1. Convert one of your earlier scripts into a function with clear inputs and outputs.
2. Write a script that ends with two local functions and calls both.
3. Explain what happens to variables created in a script vs a function after they run.
4. Use `which -all max` to see how many `max` files exist on your path.

---

[⬅ Day 052](../Day-052-Local-Global-and-Persistent-Variables/README.md) · [🏠 Home](../README.md) · [Day 054 ➡](../Day-054-Anonymous-Functions/README.md)
