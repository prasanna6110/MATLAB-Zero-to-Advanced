% Day 064 · Set Operations and Key-Value Maps — Sets of students and courses
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

ml = {'Asha', 'Ravi', 'Meena', 'Kabir'};
ps = {'Ravi', 'Isha', 'Meena', 'Arjun'};
both = intersect(ml, ps)
either = union(ml, ps)
only_ml = setdiff(ml, ps)
just_one = setxor(ml, ps)
[tf, loc] = ismember({'Isha', 'Neha'}, ps)
[u, ~, idx] = unique([3 1 3 2 1 3]);
counts = accumarray(idx(:), 1)'          % how many times each unique value appears
disp([u; counts])
