# Day 017 · Addition, Subtraction and Operations with Scalars

_Mathematics with Arrays_

## Adding and subtracting arrays
`A + B` and `A - B` work **element by element**. Both arrays must have the **same size** (or be compatible, see below).

## Arrays and scalars
A scalar is applied to **every element**:
- `A + 5`, `A - 2`, `3 * A`, `A / 4` all work element by element.

## Implicit expansion (MATLAB R2016b+)
If one array has size 1 in a dimension, MATLAB **expands** it to match the other:
- a 3×3 matrix minus a 1×3 row vector subtracts the row from **every row**
- a 3×1 column plus a 1×4 row gives a 3×4 matrix (an "outer sum")

This is handy for things like removing the mean of every column: `X - mean(X)`. (Older MATLAB needed `bsxfun` for this.)

> If the sizes are not compatible, e.g. 1×3 + 1×4, you get *"Arrays have incompatible sizes for this operation"*.

## Examples

### Example 1: Element-by-element addition and subtraction  ([`example_1.m`](example_1.m))

```matlab
A = [1 2 3; 4 5 6];
B = [10 20 30; 40 50 60];
S = A + B
D = B - A
v = [3 6 9] - [1 1 1]
A + 100                    % a scalar is added to every element
2 * A - 1
```

### Example 2: Implicit expansion  ([`example_2.m`](example_2.m))

```matlab
X = [1 2 3; 4 5 6; 7 8 9];
row = [10 20 30];
X + row                    % row added to every row
col = [100; 200; 300];
X + col                    % column added to every column
outer = (1:3)' + (1:4)     % 3x4 table of sums
X - mean(X)                % each column now has mean 0
```

### Example 3: Daily energy readings  ([`example_3.m`](example_3.m))

```matlab
% Meter readings (kWh) at the start of 5 days for 3 houses (rows)
start = [1200 1250 1305 1361 1410
          800  842  880  925  970
         2200 2290 2375 2460 2550];
daily_use = diff(start, 1, 2)          % differences along columns -> daily use
extra_vs_house1 = daily_use - daily_use(1, :)
total_per_house = sum(daily_use, 2)'
```

## Practice

1. Add 5 to every element of `magic(3)` and subtract the identity matrix.
2. Create a 5×5 multiplication-table-style **sum** table using implicit expansion.
3. Subtract the minimum of each column of a matrix from that column (`A - min(A)`).
4. What error do you get for `[1 2 3] + [1 2]`? Why?

---

[⬅ Day 016](../Day-016-String-Arrays-and-Converting-Between-Numbers-and-Text/README.md) · [🏠 Home](../README.md) · [Day 018 ➡](../Day-018-Matrix-Multiplication-and-the-Dot-Product/README.md)
