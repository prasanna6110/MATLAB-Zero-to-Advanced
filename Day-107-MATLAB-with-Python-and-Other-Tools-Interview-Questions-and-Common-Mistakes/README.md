# Day 107 · MATLAB with Python and Other Tools, Interview Questions and Common Mistakes

_Advanced MATLAB and Toolboxes_

## MATLAB and other languages
- **Call Python from MATLAB**: `pyenv` shows the Python in use; then `py.math.sqrt(16)`, `py.list({1, 2})`, `py.numpy.array(...)`, or `pyrun("x = 3**2", "x")` (R2021b+).
- **Call MATLAB from Python**: the **MATLAB Engine API for Python** (`import matlab.engine; eng = matlab.engine.start_matlab()`).
- **C/C++/Fortran**: MEX files (`mex file.c`), and `loadlibrary` for DLLs.
- **Java and .NET** objects can be used directly.
- **MATLAB Compiler**: standalone apps; **MATLAB Coder**: C code from MATLAB functions.
- **GNU Octave**: free and mostly compatible; no Simulink, App Designer, tables or string arrays.
- **Python (NumPy/SciPy/Matplotlib)**: similar ideas, but 0-based indexing, `*` is element-wise for NumPy arrays and `@` is matrix multiplication.

## Frequently asked interview / viva questions
1. *Difference between a script and a function?* (workspace, inputs/outputs, Day 53)
2. *`*` vs `.*`, `/` vs `./`, `'` vs `.'`?* (matrix vs element-wise, conjugate transpose)
3. *How do you solve Ax = b, and why `\` instead of `inv`?* (speed, accuracy)
4. *Cell array vs structure vs table?* (any content by index / named fields / column data)
5. *What is vectorisation and preallocation?*
6. *How do you find the roots of a nonlinear equation / an ODE solution?* (`fzero`, `fsolve`, `ode45`, stiff → `ode15s`)
7. *What is a function handle and an anonymous function?*
8. *`==` with floating point numbers?* (use a tolerance)
9. *Difference between `&` and `&&`?* (element-wise vs short-circuit scalar)
10. *How do you make a 3-D surface plot?* (`meshgrid` + `surf`)
11. *What is Simulink and when do you use a stiff solver?*
12. *Value class vs handle class?*

## The 15 most common beginner mistakes
| Mistake | Fix |
|---------|-----|
| `x*y` for vectors | `x.*y` |
| `sin(30)` meaning degrees | `sind(30)` |
| index 0 or 1.5 | indices start at 1 and are integers |
| `if name == 'yes'` | `strcmp(name, 'yes')` |
| `3 < x < 7` | `x > 3 & x < 7` |
| comparing floats with `==` | `abs(a - b) < tol` |
| naming a variable `sum`, `max`, `i` | choose another name, `clear sum` |
| file not in the Current Folder | `cd` there or `addpath` |
| script name = a function/variable name or starts with a digit | rename the file |
| growing arrays in loops | preallocate |
| forgetting `end` | one `end` per `if/for/while/switch/function` |
| no `\n` in `fprintf` | add `\n` |
| `[1 2 3] + [1 2]` | make the sizes match |
| `input` without `'s'` for text | `input('Name: ', 's')` |
| `clear` inside functions / overwriting results | remove it; use different names |

## Examples

### Example 1: Calling Python from MATLAB  ([`example_1.m`](example_1.m))

```matlab
% MATLAB-ONLY: needs a supported Python installation (check with pyenv)
pe = pyenv;
fprintf('Using Python %s\n', pe.Version);
py.math.sqrt(16)
words = py.str('power system analysis').split();
n = int64(py.len(words))
x = pyrun("import statistics as s; m = s.mean([4, 8, 15, 16, 23, 42])", "m")
```

### Example 2: Quick self-test of the most important rules  ([`example_2.m`](example_2.m))

```matlab
a = [1 2 3]; b = [4 5 6];
checks = {
    'a.*b is element-wise',            isequal(a.*b, [4 10 18])
    'a*b'' is the dot product',        a*b' == 32
    'indexing starts at 1',            a(1) == 1
    'end gives the last element',      a(end) == 3
    'sind uses degrees',               abs(sind(30) - 0.5) < 1e-12
    'float compare needs a tolerance', (0.1 + 0.2 ~= 0.3) && abs(0.1 + 0.2 - 0.3) < 1e-12
    'strcmp compares text',            strcmp('yes', 'yes') && ~strcmp('yes', 'Yes')
    'A\b solves Ax = b',               norm([2 1; 1 3]\[3; 5] - [0.8; 1.4]) < 1e-12
    };
for k = 1:size(checks, 1)
    fprintf('[%s] %s\n', ternary(checks{k, 2}, 'OK', '!!'), checks{k, 1});
end

function out = ternary(c, a, b)
    if c, out = a; else, out = b; end
end
```

### Example 3: Common mistakes and their fixes, side by side  ([`example_3.m`](example_3.m))

```matlab
x = 0:0.5:2;
% Mistake 1: * instead of .*
try
    y = x * x;
catch ME
    fprintf('x * x fails: %s\n', ME.message);
end
y = x .* x;  fprintf('x .* x = %s\n', mat2str(y));
% Mistake 2: degrees in sin
fprintf('sin(30) = %.4f (radians!), sind(30) = %.4f\n', sin(30), sind(30));
% Mistake 3: the "between" trap
v = 10;
fprintf('3 < v < 7 gives %d (wrong), v > 3 & v < 7 gives %d (right)\n', 3 < v < 7, v > 3 & v < 7);
% Mistake 4: text comparison with ==
try
    if 'yes' == 'no', end
catch ME
    fprintf('''yes'' == ''no'' fails: %s\n', ME.message);
end
fprintf('strcmp(''yes'', ''no'') = %d\n', strcmp('yes', 'no'));
% Mistake 5: index zero
try
    x(0)
catch ME
    fprintf('x(0) fails: %s\n', ME.message);
end
```

## Practice

1. Answer the 12 interview questions in your own words, with a one-line code example each.
2. Write a MATLAB function and call it from Python with the MATLAB Engine (or the reverse with `py.`).
3. Take one of your earlier programs and check it against the 15 common mistakes.
4. Rewrite a short MATLAB program in Python/NumPy and note three differences.

---

[⬅ Day 106](../Day-106-Performance-Parallel-Computing-and-Good-Coding-Practice/README.md) · [🏠 Home](../README.md) · [Day 108 ➡](../Day-108-Project-1-Scientific-Calculator-with-a-Menu/README.md)
