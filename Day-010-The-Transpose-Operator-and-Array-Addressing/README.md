# Day 010 · The Transpose Operator and Array Addressing

_Creating Arrays_

## Transpose
The **transpose** `'` turns rows into columns and columns into rows. Row vector ↔ column vector; an m×n matrix becomes n×m.

- `A'` is the **complex conjugate transpose** (it also negates the imaginary parts).
- `A.'` is the plain transpose (no conjugate). For real numbers both are the same.

## Addressing a vector
Elements are numbered from **1** (not 0).
| Expression | Meaning |
|------------|---------|
| `v(3)` | the 3rd element |
| `v(end)` | the last element |
| `v(end-1)` | the second-to-last |
| `v([1 3 5])` | elements 1, 3 and 5 |
| `v(4) = 10` | change element 4 |

## Addressing a matrix
`A(r, c)` is the element in row `r`, column `c`.
- `A(2,3) = 0` changes one element.
- Elements can be used in expressions: `A(1,1) + A(2,2)`.
- **Linear indexing**: `A(k)` counts **down the columns** (column-major order). In a 3×3 matrix, `A(4)` is `A(1,2)`.
- `sub2ind` / `ind2sub` convert between (row, column) and linear index.

## Examples

### Example 1: Transposing vectors and matrices  ([`example_1.m`](example_1.m))

```matlab
row = [3 6 9]
col = row'                     % now a column
A = [1 2 3; 4 5 6]
At = A'                        % 3x2
z = [1+2i 3-4i];
z'                             % conjugate transpose: signs of the imaginary parts flip
z.'                            % plain transpose
```

### Example 2: Picking elements out of a vector  ([`example_2.m`](example_2.m))

```matlab
marks = [67 82 91 45 73 88];
first = marks(1)
last = marks(end)
third_and_fifth = marks([3 5])
marks(4) = 50;                 % correct a wrong entry
marks
average_of_first_three = (marks(1) + marks(2) + marks(3)) / 3
```

### Example 3: Matrix elements and linear indexing  ([`example_3.m`](example_3.m))

```matlab
A = [10 20 30; 40 50 60; 70 80 90]
A(2, 3)                        % row 2, column 3 -> 60
A(3, 1) = -1                   % change one element
A(4)                           % linear index: counts down columns -> 20
k = sub2ind(size(A), 2, 3)     % (2,3) is linear index 8
[r, c] = ind2sub(size(A), 8)   % and back again
```

## Practice

1. For `v = 5:5:50`, display the 4th element, the last element, and elements 2, 4 and 6.
2. In `A = magic(4)`, change the element in row 3, column 2 to 100.
3. What is `A(7)` for a 3×3 matrix `A`? Which row and column is it?
4. Explain the difference between `'` and `.'` with a complex vector.

---

[⬅ Day 009](../Day-009-Creating-Matrices-zeros-ones-eye-rand-magic-and-Concatenation/README.md) · [🏠 Home](../README.md) · [Day 011 ➡](../Day-011-Using-the-Colon-in-Addressing-Arrays-and-the-end-Keyword/README.md)
