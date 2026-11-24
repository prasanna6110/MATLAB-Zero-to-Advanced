# Day 030 · Importing and Exporting Data: CSV, Text and Excel Files

_Scripts and Data_

## Modern functions (MATLAB R2019a+)
| Task | Function |
|------|----------|
| Write a numeric matrix to CSV / Excel | `writematrix(A, 'data.csv')`, `writematrix(A, 'data.xlsx')` |
| Read a numeric matrix | `A = readmatrix('data.csv')` (also `.xlsx`, `.txt`) |
| Read a file with headers and mixed types | `T = readtable('data.csv')` → a **table** (Day 60) |
| Write a table | `writetable(T, 'out.xlsx', 'Sheet', 2)` |
| Text or cell data | `readcell`, `writecell`, `readlines`, `writelines` |

## Classic functions (work in older MATLAB and in Octave)
| Task | Function |
|------|----------|
| Write / read numbers as CSV | `csvwrite('f.csv', A)` / `csvread('f.csv', r0, c0)` (skip rows/cols) |
| Any delimiter | `dlmwrite('f.txt', A, 'delimiter', '\t')` / `dlmread('f.txt', '\t', r0, c0)` |
| Excel | `xlswrite` / `xlsread` (MATLAB, on Windows uses Excel) |
| Mixed data | `importdata('f.csv')` returns `.data` and `.textdata` |

## The Import Tool
**HOME → Import Data** opens a visual tool: pick the columns, choose the output type (table, column vectors, numeric matrix), and press **Import**. It can also **generate a script** of the import so you can repeat it.

> Always check what you read: `size`, a few rows with `A(1:5,:)`, and `any(isnan(A(:)))` for missing values.

## Examples

### Example 1: CSV files with the classic functions (MATLAB and Octave)  ([`example_1.m`](example_1.m))

```matlab
hours = (1:6)';
load_kW = [42 38 35 50 63 71]';
csvwrite('load.csv', [hours load_kW]);
type load.csv
data = csvread('load.csv');
fprintf('Peak load %d kW at hour %d\n', max(data(:, 2)), data(data(:, 2) == max(data(:, 2)), 1));
dlmwrite('load_tab.txt', data, 'delimiter', '\t', 'precision', '%.1f');
type load_tab.txt
again = dlmread('load_tab.txt', '\t');
isequal(again, data)
delete('load.csv'); delete('load_tab.txt');
```

### Example 2: Skipping a header line  ([`example_2.m`](example_2.m))

```matlab
fid = fopen('readings.csv', 'w');
fprintf(fid, 'time_s,voltage_V,current_A\n');      % a header line
fprintf(fid, '%g,%g,%g\n', [0 1 2 3; 230 229 231 228; 5.1 5.3 5.0 5.4]);
fclose(fid);
M = dlmread('readings.csv', ',', 1, 0);             % start at row 1 (0-based), skip the header
disp(M)
S = importdata('readings.csv');                     % numbers + header text
disp(S.colheaders)
P = M(:, 2) .* M(:, 3);
fprintf('Average power %.1f W\n', mean(P));
delete('readings.csv');
```

### Example 3: readmatrix, readtable and Excel (modern MATLAB)  ([`example_3.m`](example_3.m))

```matlab
% MATLAB-ONLY: readmatrix/readtable/writetable need MATLAB R2019a+
A = magic(4);
writematrix(A, 'magic.xlsx');            % an Excel file
B = readmatrix('magic.xlsx');
isequal(A, B)
names = {'Asha'; 'Ravi'; 'Meena'};
marks = [88; 72; 95];
T = table(names, marks);
writetable(T, 'marks.csv');
T2 = readtable('marks.csv')
T2(T2.marks > 80, :)                     % filter rows of a table
delete('magic.xlsx'); delete('marks.csv');
```

## Practice

1. Write a 10×3 matrix of random numbers to a CSV file and read it back.
2. Create a CSV with a header row in a text editor, then read it with `dlmread` (or `readmatrix`) skipping the header.
3. Use the Import Tool on a file and press **Generate Script**. Read the code it wrote.
4. Export a table of names and marks to Excel and open it in Excel.

---

[⬅ Day 029](../Day-029-The-save-and-load-Commands/README.md) · [🏠 Home](../README.md) · [Day 031 ➡](../Day-031-Low-level-File-I-O-fopen-fprintf-fgetl-fscanf-textscan/README.md)
