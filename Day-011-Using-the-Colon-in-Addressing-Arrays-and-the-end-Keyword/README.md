# Day 011 · Using the Colon in Addressing Arrays and the end Keyword

_Creating Arrays_

## The colon in addressing
The colon `:` selects a **range** of elements, or **all** of them.

| Expression | Meaning |
|------------|---------|
| `v(:)` | all elements, as a **column** |
| `v(m:n)` | elements m to n |
| `A(:, n)` | all rows of column n (a column) |
| `A(n, :)` | all columns of row n (a row) |
| `A(:, m:n)` | columns m to n |
| `A(m:n, :)` | rows m to n |
| `A(m:n, p:q)` | a sub-matrix |
| `A([1 3], [2 4])` | rows 1 and 3, columns 2 and 4 |
| `A(end, :)` | the last row |
| `A(:, end-1:end)` | the last two columns |
| `A(:)'` | all elements as one row |
| `v(end:-1:1)` | the vector reversed |

`end` inside an index means "the last index in this dimension".

## Examples

### Example 1: Rows, columns and sub-matrices  ([`example_1.m`](example_1.m))

```matlab
A = reshape(1:20, 4, 5)'       % a 5x4 matrix 1..20 row by row
row2 = A(2, :)
col3 = A(:, 3)
sub = A(2:4, 2:3)              % rows 2-4, columns 2-3
corners = A([1 end], [1 end])  % the four corners
last_row = A(end, :)
```

### Example 2: Reversing, every second element, and A(:)  ([`example_2.m`](example_2.m))

```matlab
v = 10:10:100;
reversed = v(end:-1:1)
odd_positions = v(1:2:end)
B = magic(3)
as_column = B(:)'              % column by column, shown as a row
B(:, [1 3]) = B(:, [3 1])      % swap columns 1 and 3
```

### Example 3: Selecting data from a measurement table  ([`example_3.m`](example_3.m))

```matlab
% Each row: [hour, voltage, current, power factor]
data = [ 1 231 12.1 0.92
         2 229 14.8 0.90
         3 226 18.5 0.86
         4 228 16.0 0.88
         5 232 11.2 0.93];
hours = data(:, 1)';
voltage = data(:, 2)';
pf = data(:, end)';
fprintf('Voltages : %s\n', mat2str(voltage));
fprintf('PF hours 2-4: %s\n', mat2str(pf(2:4)));
P = data(:, 2) .* data(:, 3) .* data(:, 4);  % real power in W for every hour
disp([hours' round(P)])           % hour and power side by side
```

## Practice

1. From `A = magic(6)`, extract the 3×3 block in the middle-right (rows 2–4, columns 4–6).
2. Reverse the order of the rows of a matrix (`A(end:-1:1, :)`; compare with `flipud`).
3. Pick every third element of `1:30`.
4. Replace the whole second column of a matrix with zeros in one line.

---

[⬅ Day 010](../Day-010-The-Transpose-Operator-and-Array-Addressing/README.md) · [🏠 Home](../README.md) · [Day 012 ➡](../Day-012-Adding-Elements-Deleting-Elements-and-Reshaping-Arrays/README.md)
