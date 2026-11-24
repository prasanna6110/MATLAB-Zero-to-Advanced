# Day 027 · Output Commands: disp and fprintf

_Scripts and Data_

## `disp`
`disp(x)` shows the value of a variable or a text **without the variable name**. It cannot mix text and numbers directly, so convert the number first: `disp(['I = ' num2str(I) ' A'])`.

## `fprintf`: formatted output
```matlab
fprintf('text with %format codes\n', var1, var2)
```
| Format code | Shows | Example `x = 12.3456` |
|-------------|-------|------------------------|
| `%d` / `%i` | integer | `%d` with 42 → `42` |
| `%f` | fixed point | `%.2f` → `12.35` |
| `%e` / `%E` | exponential | `%.3e` → `1.235e+01` |
| `%g` / `%G` | shorter of `%f` and `%e` | `%g` → `12.3456` |
| `%s` | text | `%s` with `'abc'` |
| `%c` | one character | |
| `%x`, `%o` | hexadecimal, octal | |
| `%%` | a percent sign | |

**Width and precision:** `%8.3f` means a field 8 characters wide with 3 decimals. `%-8s` left-aligns, `%+d` always shows the sign, `%08.2f` pads with zeros.

**Escape characters:** `\n` new line, `\t` tab, `\\` backslash, `''` a single quote inside the text.

> `fprintf` does **not** add a new line by itself. End the text with `\n`.

## Examples

### Example 1: disp vs fprintf  ([`example_1.m`](example_1.m))

```matlab
V = 230; I = 4.567;
disp(V)
disp('Supply details:')
disp(['Current = ' num2str(I) ' A'])
fprintf('Voltage = %d V\n', V);
fprintf('Current = %.2f A and power = %.1f W\n', I, V*I);
fprintf('Very small: %e, compact: %g\n', 0.000123, 0.000123);
fprintf('Efficiency is 95%%\n');
fprintf('It''s done!\n');
```

### Example 2: Width, alignment and signs  ([`example_2.m`](example_2.m))

```matlab
items = {'Resistor', 'Capacitor', 'IC 555'};
prices = [2.5 12 18.75];
fprintf('%-12s|%8s\n', 'Item', 'Price');
fprintf('%s\n', repmat('-', 1, 21));
for k = 1:3
    fprintf('%-12s|%8.2f\n', items{k}, prices(k));
end
fprintf('%+d %+d\n', 5, -5);
fprintf('[%06.2f]\n', 3.14159);
fprintf('Tab\tseparated\tvalues\n');
```

### Example 3: fprintf repeats its format for vectors and matrices  ([`example_3.m`](example_3.m))

```matlab
x = 1:5;
fprintf('%d ', x); fprintf('\n');          % the format is reused for every element
fprintf('x = %d, x^2 = %d\n', [x; x.^2]);  % takes elements column by column
T = [1 2 3; 10 20 30];
fprintf('%d %d\n', T)                      % column order: 1 10, 2 20, 3 30
fprintf('%5.1f %5.1f %5.1f\n', T');        % transpose to print row by row
```

## Practice

1. Print the value of π with 2, 5 and 10 decimal places using `fprintf`.
2. Print a table of n, n² and n³ for n = 1..10 with aligned columns.
3. Print `Marks: 85% (Grade A)` exactly, including the percent sign.
4. Explain why `fprintf('%d %d\n', [1 2; 3 4])` prints `1 3` first.

---

[⬅ Day 026](../Day-026-The-Workspace-and-Input-to-a-Script-File/README.md) · [🏠 Home](../README.md) · [Day 028 ➡](../Day-028-Building-Text-with-sprintf-num2str-and-Formatted-Tables/README.md)
