% Day 022 · Built-in Functions for Analyzing Arrays (Statistics) — Statistics of exam marks
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

marks = [56 78 91 45 67 78 88 72 59 78 95 40];
fprintf('Mean   %.2f\n', mean(marks));
fprintf('Median %.2f\n', median(marks));
fprintf('Mode   %d\n', mode(marks));
fprintf('Std    %.2f\n', std(marks));
fprintf('Range  %d (from %d to %d)\n', max(marks) - min(marks), min(marks), max(marks));
above = sum(marks > mean(marks));
fprintf('%d students are above the mean\n', above);
