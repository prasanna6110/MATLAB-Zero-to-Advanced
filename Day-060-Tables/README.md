# Day 060 · Tables

_Data Types_

## The table data type (MATLAB R2013b+)
A **table** stores column-oriented data like a spreadsheet: each **variable (column)** has a name and can have its own type (numbers, text, dates, categories), and all columns have the same number of rows.

```matlab
T = table(names, ages, marks, 'VariableNames', {'Name', 'Age', 'Marks'});
T = readtable('data.csv');        % from a file
```

## Working with tables
| Task | Syntax |
|------|--------|
| a column as an array | `T.Marks` or `T{:, 'Marks'}` |
| rows / columns as a smaller table | `T(1:3, :)`, `T(:, {'Name', 'Marks'})` |
| filter rows | `T(T.Marks > 80, :)` |
| add a column | `T.Grade = ...` |
| sort | `sortrows(T, 'Marks', 'descend')` |
| summary | `summary(T)`, `head(T)`, `height(T)`, `width(T)` |
| group statistics | `groupsummary(T, 'Dept', 'mean', 'Marks')` |
| join two tables | `join`, `innerjoin`, `outerjoin` |
| missing data | `rmmissing(T)`, `fillmissing(T, 'linear')` |
| write | `writetable(T, 'out.xlsx')` |

Also see `timetable` (rows indexed by time, with `retime` and `synchronize`) and `categorical` arrays for repeated labels.

> **GNU Octave note:** Octave has no `table` type. The last example today shows a portable alternative with a structure of column vectors.

## Examples

### Example 1: Creating, filtering and sorting a table  ([`example_1.m`](example_1.m))

```matlab
% MATLAB-ONLY: the table type is not available in GNU Octave
Name = {'Asha'; 'Ravi'; 'Meena'; 'Kabir'; 'Isha'};
Dept = {'EE'; 'ME'; 'EE'; 'CS'; 'CS'};
Marks = [88; 64; 93; 71; 85];
T = table(Name, Dept, Marks)
T.Grade = repmat('B', height(T), 1);
T.Grade(T.Marks >= 85) = 'A';
top = sortrows(T, 'Marks', 'descend');
head(top, 3)
ee = T(strcmp(T.Dept, 'EE'), :)
mean(T.Marks)
```

### Example 2: Group statistics and timetables  ([`example_2.m`](example_2.m))

```matlab
% MATLAB-ONLY: groupsummary (R2018a) and timetable (R2016b)
Dept = categorical({'EE'; 'ME'; 'EE'; 'CS'; 'CS'; 'ME'});
Marks = [88; 64; 93; 71; 85; 77];
T = table(Dept, Marks);
G = groupsummary(T, 'Dept', {'mean', 'max'}, 'Marks')
t = datetime(2026, 11, 24, 0:3:21, 0, 0)';
load_kW = [40; 35; 52; 75; 68; 80; 95; 60];
TT = timetable(t, load_kW);
daily = retime(TT, 'daily', 'max')
```

### Example 3: A portable table: a structure of columns  ([`example_3.m`](example_3.m))

```matlab
% Works in MATLAB and Octave: each field is one column
T.Name = {'Asha'; 'Ravi'; 'Meena'; 'Kabir'; 'Isha'};
T.Dept = {'EE'; 'ME'; 'EE'; 'CS'; 'CS'};
T.Marks = [88; 64; 93; 71; 85];
[~, order] = sort(T.Marks, 'descend');
fprintf('%-6s %-4s %5s\n', 'Name', 'Dept', 'Marks');
for k = order'
    fprintf('%-6s %-4s %5d\n', T.Name{k}, T.Dept{k}, T.Marks(k));
end
depts = unique(T.Dept);
for d = 1:numel(depts)
    in_d = strcmp(T.Dept, depts{d});
    fprintf('%s: mean %.1f over %d students\n', depts{d}, mean(T.Marks(in_d)), nnz(in_d));
end
```

## Practice

1. (MATLAB) Create a table of 6 appliances with power and daily hours, add a column for daily energy, and sort by energy.
2. (MATLAB) Read a CSV file with `readtable` and use `summary`.
3. (MATLAB) Use `groupsummary` to find the average marks per department.
4. Repeat question 1 with the portable structure-of-columns approach.

---

[⬅ Day 059](../Day-059-Structures/README.md) · [🏠 Home](../README.md) · [Day 061 ➡](../Day-061-Numeric-Types-Logical-Type-and-Type-Conversion/README.md)
