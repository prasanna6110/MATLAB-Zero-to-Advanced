# Day 028 · Building Text with sprintf, num2str and Formatted Tables

_Scripts and Data_

## `sprintf`
`sprintf` works exactly like `fprintf` but **returns the text** instead of printing it. Use it to build labels, file names, titles and messages:
```matlab
label = sprintf('Load = %.1f kW', P);
fname = sprintf('data_%03d.csv', k);   % data_001.csv, data_002.csv ...
```

## Other ways to turn numbers into text
| Function | Example | Result |
|----------|---------|--------|
| `num2str(x)` | `num2str(pi)` | `'3.1416'` |
| `num2str(x, n)` | `num2str(pi, 8)` | `'3.1415927'` |
| `num2str(x, fmt)` | `num2str(pi, '%10.5f')` | `'   3.14159'` |
| `int2str(x)` | `int2str(2.7)` | `'3'` |
| `mat2str(A)` | `mat2str([1 2;3 4])` | `'[1 2;3 4]'` |
| `disp(A)` | | prints a matrix neatly |
| `newline` | | the new-line character |

## Printing a formatted table
1. Put the columns of the table side by side in a matrix.
2. Print the header with `fprintf`.
3. Print the data with one `fprintf` using the **transposed** matrix, so that MATLAB reads it row by row.

## Examples

### Example 1: sprintf for labels and file names  ([`example_1.m`](example_1.m))

```matlab
P = 12.3456;
label = sprintf('Load = %.1f kW', P)
for k = [1 7 23]
    fname = sprintf('report_%03d.txt', k);
    disp(fname)
end
msg = sprintf('%s scored %d marks', 'Neha', 87);
disp(upper(msg))
```

### Example 2: A neat table of a loan repayment  ([`example_2.m`](example_2.m))

```matlab
P = 500000;  annual = 9;  n = 6;                 % 6-month loan
r = annual / 12 / 100;
emi = P * r * (1 + r)^n / ((1 + r)^n - 1);
balance = P;
fprintf('EMI = Rs %.2f\n\n', emi);
fprintf('%5s %12s %12s %14s\n', 'Month', 'Interest', 'Principal', 'Balance');
for m = 1:n
    interest = balance * r;
    principal = emi - interest;
    balance = balance - principal;
    fprintf('%5d %12.2f %12.2f %14.2f\n', m, interest, principal, abs(balance));
end
```

### Example 3: A vectorised table with one fprintf  ([`example_3.m`](example_3.m))

```matlab
f = [50 100 500 1000 5000];
L = 10e-3;  C = 10e-6;
XL = 2*pi*f*L;
XC = 1 ./ (2*pi*f*C);
tbl = [f; XL; XC];
fprintf('%8s %10s %10s\n', 'f (Hz)', 'XL (ohm)', 'XC (ohm)');
fprintf('%8d %10.3f %10.3f\n', tbl);       % tbl is 3xN, read column by column
```

## Practice

1. Use `sprintf` to create file names `image_01.png` … `image_10.png` in a loop.
2. Print the multiplication table of 7 as `7 x 1 = 7` … with aligned columns.
3. Build a title text that contains the mean and std of a data vector with 2 decimals.
4. Print a table of temperature in °C (0 to 100, step 10) and °F.

---

[⬅ Day 027](../Day-027-Output-Commands-disp-and-fprintf/README.md) · [🏠 Home](../README.md) · [Day 029 ➡](../Day-029-The-save-and-load-Commands/README.md)
