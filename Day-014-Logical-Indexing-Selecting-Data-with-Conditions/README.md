# Day 014 · Logical Indexing: Selecting Data with Conditions

_Creating Arrays_

## Logical arrays
A comparison like `v > 5` returns a **logical array** of 1s (true) and 0s (false), the same size as `v`.

## Logical indexing
Put a logical array inside the brackets to pick **only the elements where it is true**:
```matlab
v(v > 5)           % the elements greater than 5
v(v < 0) = 0       % replace negatives with 0
A(A == 0) = NaN    % works on matrices too
```
It is usually **faster and shorter than a loop + if**.

Combine conditions with `&` (and), `|` (or), `~` (not), e.g. `v(v >= 10 & v <= 20)`. (The full list of relational and logical operators is on Day 41.)

## Useful helpers
- `nnz(cond)` or `sum(cond)`: how many are true
- `find(cond)`: the indices where it is true
- `any(cond)`, `all(cond)`
- `isnan(v)`, `isinf(v)`: find missing or infinite values; `v(~isnan(v))` keeps the valid ones

## Examples

### Example 1: Selecting with conditions  ([`example_1.m`](example_1.m))

```matlab
v = [12 -3 45 7 -8 20 0 33];
mask = v > 10                  % logical array
big = v(mask)                  % 12 45 20 33
negatives = v(v < 0)
count_positive = nnz(v > 0)
v(v < 0) = 0                   % clip the negatives to zero
```

### Example 2: Cleaning measured data  ([`example_2.m`](example_2.m))

```matlab
readings = [229 231 NaN 228 999 230 -1 232 NaN 227];
valid = readings(~isnan(readings) & readings > 0 & readings < 300);
fprintf('Valid readings: %s\n', mat2str(valid));
fprintf('Mean voltage  : %.2f V\n', mean(valid));
fprintf('Bad samples   : %d\n', numel(readings) - numel(valid));
% Replace the bad ones with the mean instead of removing them
fixed = readings;
bad = isnan(fixed) | fixed <= 0 | fixed >= 300;
fixed(bad) = round(mean(valid));
disp(fixed)
```

### Example 3: Logical indexing on a matrix  ([`example_3.m`](example_3.m))

```matlab
marks = [45 78 92; 33 65 58; 88 41 70];   % 3 students x 3 subjects
passed = marks >= 40
fail_count_per_subject = sum(~passed)
marks(marks < 40) = 40                    % grace marks up to 40
% Rows (students) who scored more than 60 in every subject
good_students = find(all(marks > 60, 2))'
```

## Practice

1. From `1:50`, select the numbers divisible by both 3 and 5 (use `mod`).
2. Replace every value above 100 in a vector with 100.
3. Count the NaN values in `[1 NaN 3 NaN NaN 6]` and compute the mean of the rest.
4. For a 5×4 matrix of random integers 1–100, list the row numbers whose sum is above 200.

---

[⬅ Day 013](../Day-013-Built-in-Functions-for-Handling-Arrays/README.md) · [🏠 Home](../README.md) · [Day 015 ➡](../Day-015-Text-in-MATLAB-Character-Arrays/README.md)
