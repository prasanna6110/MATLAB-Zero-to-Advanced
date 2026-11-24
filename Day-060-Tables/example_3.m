% Day 060 · Tables — A portable table: a structure of columns
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

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
