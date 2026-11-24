# Day 109 · Project 2: Student Result Management System

_Projects_

## Goal
Store students and their marks, compute totals, percentages, grades and ranks, find subject toppers and failures, print a formatted mark sheet, save it to a CSV file and plot the class statistics.

## Concepts used
Structure arrays, `sort`, logical indexing, functions, `fprintf` tables, `fopen`/`fprintf` to CSV, `bar` and `hist` plots.

## How it works
1. The class data is a structure array (`students(k).name`, `.roll`, `.marks`).
2. `grade_of` turns a percentage into a grade.
3. Ranks come from `sort(..., 'descend')`.
4. The report is printed and written to `results.csv` (deleted at the end of the demo; remove the `delete` line to keep it).

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear; close all;
subjects = {'Maths', 'Physics', 'Circuits', 'Programming', 'English'};
names = {'Aarav', 'Diya', 'Kabir', 'Meera', 'Rohan', 'Sneha', 'Vikram', 'Zoya'};
rng(7);
marks = min(100, max(18, round(65 + 15*randn(numel(names), numel(subjects)))));
marks(3, 2) = 31;                                  % make sure someone fails a subject
for k = 1:numel(names)
    students(k) = struct('roll', 2600 + k, 'name', names{k}, 'marks', marks(k, :)); %#ok<SAGROW>
end
pass_mark = 40;
for k = 1:numel(students)
    s = students(k);
    students(k).total = sum(s.marks);
    students(k).percent = 100 * students(k).total / (100 * numel(subjects));
    students(k).passed = all(s.marks >= pass_mark);
    students(k).grade = grade_of(students(k).percent, students(k).passed);
end
[~, order] = sort([students.total], 'descend');
rank = zeros(1, numel(students)); rank(order) = 1:numel(students);
% ---- mark sheet ----
fprintf('%-5s %-7s', 'Roll', 'Name'); fprintf('%6.5s', subjects{:}); fprintf('%7s %7s %6s %5s\n', 'Total', '%', 'Grade', 'Rank');
fprintf('%s\n', repmat('-', 1, 76));
for k = order
    s = students(k);
    fprintf('%-5d %-7s', s.roll, s.name); fprintf('%6d', s.marks);
    fprintf('%7d %7.2f %6s %5d\n', s.total, s.percent, s.grade, rank(k));
end
% ---- statistics ----
fprintf('\nClass average: %.2f %%\n', mean([students.percent]));
for j = 1:numel(subjects)
    [top, who] = max(marks(:, j));
    fails = names(marks(:, j) < pass_mark);
    fail_txt = 'none'; if ~isempty(fails), fail_txt = strjoin(fails, ', '); end
    fprintf('%-12s avg %5.1f | topper %-6s (%d) | failed: %s\n', subjects{j}, mean(marks(:, j)), names{who}, top, fail_txt);
end
% ---- save as CSV ----
fid = fopen('results.csv', 'w');
fprintf(fid, 'Roll,Name,%s,Total,Percent,Grade,Rank\n', strjoin(subjects, ','));
for k = order
    s = students(k);
    fprintf(fid, '%d,%s,%s,%d,%.2f,%s,%d\n', s.roll, s.name, strjoin(arrayfun(@num2str, s.marks, 'UniformOutput', false), ','), s.total, s.percent, s.grade, rank(k));
end
fclose(fid);
fprintf('\nSaved results.csv (%d lines)\n', numel(strsplit(strtrim(fileread('results.csv')), sprintf('\n'))));
delete('results.csv');                        % remove this line to keep the file
% ---- plots ----
subplot(1, 2, 1); bar(mean(marks)); set(gca, 'XTickLabel', subjects); title('Subject averages'); ylim([0 100])
subplot(1, 2, 2); hist([students.percent], 5); title('Distribution of percentages'); xlabel('%')

function g = grade_of(p, passed)
    if ~passed,   g = 'F';
    elseif p >= 85, g = 'A+';
    elseif p >= 75, g = 'A';
    elseif p >= 65, g = 'B';
    elseif p >= 55, g = 'C';
    else,           g = 'D';
    end
end
```

## Extend this project

- Read the marks from a CSV file instead of generating them.
- Add attendance and withhold the result of students below 75% attendance.
- Make a separate mark sheet text file for each student.
- Add a search by roll number.

---

[⬅ Day 108](../Day-108-Project-1-Scientific-Calculator-with-a-Menu/README.md) · [🏠 Home](../README.md) · [Day 110 ➡](../Day-110-Project-3-Smart-Unit-Converter/README.md)
