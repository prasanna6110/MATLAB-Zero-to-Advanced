# Day 058 · Cell Arrays

_Data Types_

## What is a cell array?
A **cell array** is an array whose elements (cells) can hold **anything**: numbers, text of different lengths, matrices, even other cell arrays. Create it with **curly braces**:
```matlab
C = {'Ravi', 21, [80 75 92]; 'Neha', 22, [88 91 79]};   % 2x3 cell array
C = cell(2, 3);                                        % 2x3 empty cells
```

## `()` vs `{}`: the most important rule
| Syntax | Gives |
|--------|-------|
| `C(2, 1)` | a **cell** (a 1×1 cell array that contains 'Neha') |
| `C{2, 1}` | the **content** ('Neha') |
| `C{1, 3}(2)` | the 2nd element of the vector stored in cell (1,3) |
| `C(:, 1)` | a cell array of the first column |
| `C{end+1} = x` | adds a cell (for a vector-shaped cell array) |
| `C(2) = []` | deletes a cell |

## Useful functions
`iscell`, `iscellstr`, `celldisp`, `cellfun`, `cell2mat` (cells of numbers → matrix), `num2cell`, `sort` (for a cell array of texts), `strjoin`, `ismember('x', C)`, `[C{:}]` (join all contents).

Cell arrays are the classic way to store a **list of texts** of different lengths.

## Examples

### Example 1: Creating and indexing a cell array  ([`example_1.m`](example_1.m))

```matlab
student = {'Ravi Kumar', 21, [78 85 90]};
name = student{1}
marks = student{3}
second_mark = student{3}(2)
c = student(1)                    % a 1x1 cell, not the text
class(c), class(student{1})
student{4} = 'EE Department';     % add a new cell
size(student)
celldisp(student)
```

### Example 2: A list of names of different lengths  ([`example_2.m`](example_2.m))

```matlab
cities = {'Kurukshetra', 'Satna', 'Delhi', 'Thiruvananthapuram'};
for k = 1:numel(cities)
    fprintf('%-20s %2d letters\n', cities{k}, length(cities{k}));
end
sorted = sort(cities)
ismember('Delhi', cities)
lengths = cellfun(@numel, cities);
[~, longest] = max(lengths);
fprintf('Longest name: %s\n', cities{longest});
strjoin(cities, ' -> ')
```

### Example 3: Mixed data, cell2mat and num2cell  ([`example_3.m`](example_3.m))

```matlab
data = {'Transformer', 250, 'kVA'; 'Motor', 15, 'kW'; 'Cable', 120, 'm'};
for r = 1:size(data, 1)
    fprintf('%-12s %6g %s\n', data{r, :});        % data{r,:} gives 3 contents
end
ratings = cell2mat(data(:, 2))'                    % numbers out of the cells
C = num2cell([1 2 3])                              % each number in its own cell
nested = {1, {'a', {'deep'}}};
nested{2}{2}{1}                                    % cells inside cells
```

## Practice

1. Store 5 student names and their marks in a 5×2 cell array and print them as a table.
2. Show the difference between `C(1)` and `C{1}` using `class`.
3. Use `cellfun` to find which texts in a cell array start with a capital letter.
4. Convert a cell array of numbers into a numeric vector.

---

[⬅ Day 057](../Day-057-Recursion/README.md) · [🏠 Home](../README.md) · [Day 059 ➡](../Day-059-Structures/README.md)
