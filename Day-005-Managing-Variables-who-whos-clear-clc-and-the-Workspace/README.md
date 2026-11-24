# Day 005 · Managing Variables: who, whos, clear, clc and the Workspace

_Getting Started_

## Useful commands
| Command | What it does |
|---------|--------------|
| `clc` | clears the Command Window screen (variables are kept) |
| `clear` | removes **all** variables from memory |
| `clear x y` | removes only `x` and `y` |
| `clearvars -except a b` | removes everything except `a` and `b` |
| `who` | lists variable names |
| `whos` | lists names with size, bytes and class |
| `exist('x')` | 1 if `x` is a variable, 2 if it is a file, 5 if a built-in, 0 if none |
| `isvarname`, `class(x)`, `size(x)` | check a name, the type, the dimensions |
| `close all` | closes all figure windows |

## The Workspace window
Shows every variable with its value, size and class. **Double-click** a variable to open it in the **Variables Editor**, a spreadsheet view where you can edit values. Right-click a variable to plot it, rename it, or save it.

## A good habit
Many people start scripts with
```matlab
clc; clear; close all;
```
so every run begins with a clean screen, empty memory and no old figures. (In a *function* never use `clear`.)

## Examples

### Example 1: who and whos  ([`example_1.m`](example_1.m))

```matlab
clear                      % start with an empty workspace
voltage = 230;
current = [1.2 3.4 5.6];
name = 'Transformer-1';
M = magic(4);
who                        % just the names
whos                       % names, size, bytes, class
```

### Example 2: clear, exist and clearvars  ([`example_2.m`](example_2.m))

```matlab
a = 1; b = 2; c = 3;
exist('b')                 % 1 -> b is a variable
clear b
exist('b')                 % 0 -> gone
clearvars -except c        % remove everything except c
who
exist('sin')               % 2 or 5 -> sin is a function
```

### Example 3: A clean script template  ([`example_3.m`](example_3.m))

```matlab
clc; clear; close all;     % clean start
% ---- inputs ----
P_kW = 5.5;                % motor power
hours_per_day = 8;
days = 30;
tariff = 7.25;             % Rs per kWh
% ---- calculation ----
energy_kWh = P_kW * hours_per_day * days;
cost = energy_kWh * tariff;
% ---- output ----
fprintf('Energy used: %.1f kWh\n', energy_kWh);
fprintf('Monthly cost: Rs %.2f\n', cost);
whos energy_kWh cost
```

## Practice

1. Create five variables, then remove two of them with `clear`. Check with `who`.
2. What is the difference between `clc` and `clear`?
3. How many bytes does a 100×100 matrix of doubles use? Check with `whos` (answer: 8 bytes each).
4. Open the Variables Editor by double-clicking a matrix in the Workspace and change one value.

---

[⬅ Day 004](../Day-004-Variables-Assignment-Naming-Rules-and-Predefined-Variables/README.md) · [🏠 Home](../README.md) · [Day 006 ➡](../Day-006-Script-Files-Sections-and-the-Current-Folder/README.md)
