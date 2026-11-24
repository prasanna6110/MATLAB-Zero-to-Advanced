# Day 049 · Error Handling: try/catch, error, warning and assert

_Programming in MATLAB_

## Raising errors and warnings
| Command | Does |
|---------|------|
| `error('message')` | stops the program and shows the message in red |
| `error('Id:part', 'Value %d is invalid', x)` | with an identifier and formatting |
| `warning('message')` | prints a warning, the program continues |
| `assert(cond, 'message')` | raises an error if `cond` is false (good for checks and tests) |

## Catching errors
```matlab
try
    risky commands
catch ME              % ME is an MException object
    disp(ME.message)  % also ME.identifier, ME.stack
    ... recover, or rethrow(ME)
end
```
- If an error occurs inside `try`, MATLAB jumps to `catch` instead of stopping.
- Use it for things that can fail outside your control: reading files, user input, network access.
- Do not hide every error: catch only what you can handle, and re-throw the rest.

## Input validation
`validateattributes(x, {'numeric'}, {'positive', 'scalar'})` and, in MATLAB R2019b+, the `arguments` block in functions (Day 51) check inputs and give clear messages. `isnumeric`, `ischar`, `isscalar`, `isfinite` help with manual checks.

## Examples

### Example 1: error and warning  ([`example_1.m`](example_1.m))

```matlab
R = 0;
V = 12;
if R <= 0
    warning('R must be positive, using 1 ohm instead');
    R = 1;
end
fprintf('I = %.2f A\n', V / R);
try
    n = -3;
    if n < 0
        error('Demo:negative', 'n must not be negative (got %d)', n);
    end
catch ME
    fprintf('Caught [%s]: %s\n', ME.identifier, ME.message);
end
```

### Example 2: try/catch around risky operations  ([`example_2.m`](example_2.m))

```matlab
files = {'missing_file.csv', 'also_missing.txt'};
for k = 1:numel(files)
    try
        data = load(files{k});
        fprintf('%s loaded\n', files{k});
    catch ME
        fprintf('Could not load %s: using default data\n', files{k});
        data = zeros(3);
    end
end
values = {'12.5', 'abc', '7'};
for k = 1:numel(values)
    x = str2double(values{k});
    if isnan(x)
        fprintf('"%s" is not a number\n', values{k});
    else
        fprintf('"%s" -> %g\n', values{k}, x);
    end
end
```

### Example 3: assert and validateattributes for checks  ([`example_3.m`](example_3.m))

```matlab
function_ok = true;
try
    x = [1 2 3];
    assert(numel(x) == 3, 'x must have 3 elements');
    assert(all(x > 0), 'x must be positive');
    validateattributes(x, {'numeric'}, {'vector', 'positive'});
    disp('All checks passed')
    y = -5;
    validateattributes(y, {'numeric'}, {'positive'});
catch ME
    function_ok = false;
    disp(ME.message)
end
fprintf('Checks passed completely: %d\n', function_ok);
```

## Practice

1. Write code that divides two numbers and raises an error with a clear message when the divisor is zero.
2. Wrap a `load` of a file that may not exist in `try/catch` and print a friendly message.
3. Use `assert` to check that a matrix is square before inverting it.
4. What is the difference between `error` and `warning`?

---

[⬅ Day 048](../Day-048-Preallocation-Vectorisation-and-Timing-Code/README.md) · [🏠 Home](../README.md) · [Day 050 ➡](../Day-050-Creating-a-Function-File-and-Its-Structure/README.md)
