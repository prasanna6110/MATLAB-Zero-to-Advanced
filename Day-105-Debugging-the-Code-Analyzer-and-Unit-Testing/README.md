# Day 105 · Debugging, the Code Analyzer and Unit Testing

_Advanced MATLAB and Toolboxes_

## The Code Analyzer
The Editor underlines suspicious code in **orange** (warnings) and **red** (errors), with a coloured square at the top right. Hover for the message; many have an automatic fix. Run `checkcode('file.m')` to get the list. Common hints: a variable that grows in a loop (preallocate), an unused variable, a missing semicolon.

## The debugger
| Action | How |
|--------|-----|
| set a breakpoint | click the line number (a red dot), or `dbstop in file at 12` |
| stop when an error happens | `dbstop if error` (very useful!) |
| conditional breakpoint | right-click the dot → *Set Condition*, e.g. `k == 50` |
| step | **Step** (F10), **Step In** (F11), **Step Out**, **Continue** (F5) |
| inspect | hover over variables, use the Workspace, type commands at the `K>>` prompt |
| quit debugging | **Quit Debugging** or `dbquit`; `dbclear all` removes breakpoints |

## Testing your code
- **`assert`** inside scripts for quick checks.
- **Script-based tests**: a script whose sections (`%%`) contain asserts; run with `runtests('testScript')`.
- **Function-based tests**: `function tests = myTests, tests = functiontests(localfunctions); end` with local test functions using `verifyEqual(testCase, actual, expected, 'AbsTol', 1e-9)`.
- **Class-based tests**: `classdef MyTest < matlab.unittest.TestCase`.

A test compares the result with a **known correct answer** (a hand calculation, a special case, an identity). When you later change the code, re-run the tests to make sure nothing broke.

## Examples

### The function file quadratic_roots.m to be tested  ([`quadratic_roots.m`](quadratic_roots.m))

```matlab
function r = quadratic_roots(a, b, c)
% QUADRATIC_ROOTS  Roots of a x^2 + b x + c = 0 (real or complex), sorted.
if a == 0
    error('quadratic_roots:notQuadratic', 'a must not be zero');
end
D = b^2 - 4*a*c;
r = sort([(-b + sqrt(D)) / (2*a), (-b - sqrt(D)) / (2*a)]);
end
```

### Example 1: A test script with assert  ([`example_1.m`](example_1.m))

```matlab
% Each check compares with an answer we know is right
tol = 1e-12;
r = quadratic_roots(1, -3, 2);
assert(max(abs(r - [1 2])) < tol, 'distinct real roots');
r = quadratic_roots(1, 2, 1);
assert(max(abs(r - [-1 -1])) < tol, 'repeated root');
r = quadratic_roots(1, 0, 4);
assert(max(abs(sort(imag(r)) - [-2 2])) < tol && all(abs(real(r)) < tol), 'complex roots');
r = quadratic_roots(2, -4, -6);
assert(max(abs(polyval([2 -4 -6], r))) < tol, 'roots satisfy the equation');
threw = false;
try
    quadratic_roots(0, 1, 1);
catch ME
    threw = strcmp(ME.identifier, 'quadratic_roots:notQuadratic');
end
assert(threw, 'a = 0 must raise an error');
disp('All 5 tests passed.')
```

### A function-based unit test file for MATLAB's test framework  ([`test_quadratic.m`](test_quadratic.m))

```matlab
function tests = test_quadratic
% TEST_QUADRATIC  Unit tests for quadratic_roots (MATLAB only).
%   Run with:  results = runtests('test_quadratic')
    tests = functiontests(localfunctions);
end

function test_real_roots(testCase)
    verifyEqual(testCase, quadratic_roots(1, -3, 2), [1 2], 'AbsTol', 1e-12);
end

function test_repeated_root(testCase)
    verifyEqual(testCase, quadratic_roots(1, 2, 1), [-1 -1], 'AbsTol', 1e-12);
end

function test_error_for_linear(testCase)
    verifyError(testCase, @() quadratic_roots(0, 1, 1), 'quadratic_roots:notQuadratic');
end
```

### Example 2: Finding a bug with checks (a debugging walk-through)  ([`example_2.m`](example_2.m))

```matlab
% A buggy average function: it should ignore NaN values.
data = [4 NaN 8 6 NaN 2];
buggy = buggy_mean(data);
fixed = fixed_mean(data);
fprintf('buggy_mean = %g, fixed_mean = %g, expected %g\n', buggy, fixed, mean(data(~isnan(data))));
% How to find it in MATLAB: put a breakpoint inside buggy_mean (click the line number),
% run, then look at 'total' and 'count' at the K>> prompt after each step (F10).

function m = buggy_mean(v)
    total = 0; count = 0;
    for k = 1:numel(v)
        if ~isnan(v(k))
            total = total + v(k);
        end
        count = count + 1;          % BUG: counts the NaN values too
    end
    m = total / count;
end

function m = fixed_mean(v)
    total = 0; count = 0;
    for k = 1:numel(v)
        if ~isnan(v(k))
            total = total + v(k);
            count = count + 1;      % only count the valid values
        end
    end
    m = total / count;
end
```

## Practice

1. Open a long script of yours and fix every Code Analyzer warning.
2. Use `dbstop if error`, then run code with an index error, and inspect the variables at the `K>>` prompt.
3. Write 4 asserts that test a function `c_to_f` at known points (-40, 0, 37, 100).
4. (MATLAB) Turn your asserts into a function-based test file and run it with `runtests`.

---

[⬅ Day 104](../Day-104-Building-GUIs-App-Designer-and-Programmatic-Apps/README.md) · [🏠 Home](../README.md) · [Day 106 ➡](../Day-106-Performance-Parallel-Computing-and-Good-Coding-Practice/README.md)
