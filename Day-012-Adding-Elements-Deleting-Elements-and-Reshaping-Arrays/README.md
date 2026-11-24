# Day 012 · Adding Elements, Deleting Elements and Reshaping Arrays

_Creating Arrays_

## Adding elements
- **Assigning past the end** grows the array. Missing elements in between are filled with **zeros**.
  - `v = [1 2]; v(5) = 9` → `1 2 0 0 9`
- **Appending**: `v = [v 7]` (row) or `v(end+1) = 7`.
- A matrix grows the same way: `A(4, 5) = 1` makes A at least 4×5 and pads with zeros.
- Add a whole row or column: `A(end+1, :) = [ ... ]`, `A = [A newCol]`.

## Deleting elements
Assign the empty matrix `[]`:
- `v(3) = []` deletes element 3
- `v([1 end]) = []` deletes the first and last elements
- `A(2, :) = []` deletes row 2
- `A(:, [1 3]) = []` deletes columns 1 and 3
- You cannot delete a single element of a matrix (that would leave a hole): `A(2,2) = []` is an error.

## Reshaping and rearranging
| Function | Does |
|----------|------|
| `reshape(A, m, n)` | the same elements, new shape m×n (column-major order, `m*n` must equal `numel(A)`) |
| `reshape(A, [], n)` | MATLAB works out the number of rows |
| `fliplr`, `flipud`, `flip` | mirror left-right / up-down |
| `rot90(A)` | rotate 90° counter-clockwise |
| `circshift(v, k)` | shift elements circularly |
| `squeeze`, `permute` | rearrange dimensions of N-D arrays |

## Examples

### Example 1: Growing vectors and matrices  ([`example_1.m`](example_1.m))

```matlab
v = [4 8];
v(5) = 20                     % elements 3 and 4 become 0
v(end+1) = 24                 % append
v = [v 28 32]                 % append several
A = eye(2);
A(3, 4) = 9                   % grows to 3x4, padded with zeros
A(end+1, :) = 1:4             % add a new row
```

### Example 2: Deleting rows, columns and elements  ([`example_2.m`](example_2.m))

```matlab
v = 10:10:80;
v(3) = []                     % delete one element
v([1 end]) = []               % delete first and last
A = magic(5);
A(2, :) = [];                 % delete row 2
A(:, [1 3]) = []              % delete columns 1 and 3
try
    A(1, 1) = [];             % cannot leave a hole
catch err
    disp(err.message)
end
```

### Example 3: reshape, flip, rotate and shift  ([`example_3.m`](example_3.m))

```matlab
x = 1:12;
R = reshape(x, 3, 4)          % filled column by column
R2 = reshape(x, [], 2)'       % let MATLAB find the rows
fliplr(R)
flipud(R)
rot90(R)
circshift(1:6, 2)             % 5 6 1 2 3 4
% Hourly data (24 values) as a 4x6 table of 4-hour blocks
hourly = round(100 + 20 * sin((1:24) / 24 * 2 * pi));
blocks = reshape(hourly, 6, 4)'
```

## Practice

1. Start with `v = []` and append the numbers 1, 4, 9, 16, 25 one at a time using `end+1`.
2. From `magic(6)` delete rows 2 and 5 and the last column.
3. Turn `1:20` into a 4×5 matrix where the first **row** is 1 2 3 4 5 (hint: reshape then transpose).
4. What happens with `reshape(1:10, 3, [])`? Why?

---

[⬅ Day 011](../Day-011-Using-the-Colon-in-Addressing-Arrays-and-the-end-Keyword/README.md) · [🏠 Home](../README.md) · [Day 013 ➡](../Day-013-Built-in-Functions-for-Handling-Arrays/README.md)
