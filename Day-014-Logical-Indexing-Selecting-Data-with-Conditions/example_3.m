% Day 014 · Logical Indexing: Selecting Data with Conditions — Logical indexing on a matrix
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

marks = [45 78 92; 33 65 58; 88 41 70];   % 3 students x 3 subjects
passed = marks >= 40
fail_count_per_subject = sum(~passed)
marks(marks < 40) = 40                    % grace marks up to 40
% Rows (students) who scored more than 60 in every subject
good_students = find(all(marks > 60, 2))'
