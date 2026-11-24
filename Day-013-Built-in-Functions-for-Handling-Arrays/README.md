# Day 013 · Built-in Functions for Handling Arrays

_Creating Arrays_

## Size and shape
| Function | Returns |
|----------|---------|
| `length(A)` | the largest dimension |
| `size(A)` | `[rows cols]`; `[m, n] = size(A)`; `size(A, 1)` rows only |
| `numel(A)` | the total number of elements |
| `ndims(A)` | the number of dimensions |
| `isempty`, `isrow`, `iscolumn`, `isvector`, `isscalar`, `ismatrix` | true / false checks |

## Finding and sorting
| Function | Returns |
|----------|---------|
| `max(v)`, `[m, k] = max(v)` | the largest value and its index |
| `min(v)`, `[m, k] = min(v)` | the smallest value and its index |
| `sort(v)`, `sort(v, 'descend')`, `[s, idx] = sort(v)` | sorted values (and the original positions) |
| `sortrows(A, col)` | sorts the rows by a column |
| `find(v)` | the indices of non-zero elements; `find(v > 5)` |
| `unique(v)` | the distinct values, sorted |
| `ismember(a, v)` | is each element of `a` in `v`? |
| `any(v)`, `all(v)` | is any / every element non-zero? |
| `cumsum`, `cumprod`, `diff` | running total / product, differences between neighbours |
| `dot(a,b)`, `cross(a,b)` | dot and cross products |
| `det(A)`, `inv(A)`, `trace(A)`, `rank(A)` | matrix functions (Day 19) |

Most functions act **column by column** on a matrix: `max(A)` gives the maximum of each column. Use `max(A, [], 2)` for each row and `max(A(:))` (or `max(A, [], 'all')`) for the whole matrix.

## Examples

### Example 1: size, length, numel  ([`example_1.m`](example_1.m))

```matlab
A = rand(3, 7);
length(A)
size(A)
[rows, cols] = size(A)
numel(A)
isvector(1:5), isscalar(7), isempty([])
```

### Example 2: max, min, sort and find  ([`example_2.m`](example_2.m))

```matlab
temps = [31 35 29 38 33 36 30];
[t_max, day_max] = max(temps)
[t_min, day_min] = min(temps)
[sorted, order] = sort(temps, 'descend')
hot_days = find(temps > 34)
fprintf('%d hot days\n', numel(hot_days));
unique([3 1 3 2 1 3])
cumsum([5 10 15])                   % running total
diff([100 104 103 110])             % day-to-day change
```

### Example 3: Column-wise vs row-wise vs whole matrix  ([`example_3.m`](example_3.m))

```matlab
M = [8 1 6; 3 5 7; 4 9 2]
max(M)                              % maximum of each column
max(M, [], 2)'                      % maximum of each row
max(M(:))                           % maximum of everything
[~, idx] = max(M(:));               % ~ ignores an output
[r, c] = ind2sub(size(M), idx)      % position of the overall maximum
sortrows([3 30; 1 10; 2 20], 1)     % sort rows by column 1
```

## Practice

1. For a vector of 10 student marks, find the topper's mark and position, and the number of students below 40.
2. Sort the rows of `[4 2; 1 9; 3 5]` by the second column in descending order.
3. Use `cumsum` to find the cumulative energy of hourly loads `[2 3 5 4 6] kWh`.
4. Find the smallest element of `magic(5)` and its row and column.

---

[⬅ Day 012](../Day-012-Adding-Elements-Deleting-Elements-and-Reshaping-Arrays/README.md) · [🏠 Home](../README.md) · [Day 014 ➡](../Day-014-Logical-Indexing-Selecting-Data-with-Conditions/README.md)
