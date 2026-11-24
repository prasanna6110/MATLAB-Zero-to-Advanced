% Day 063 · Regular Expressions and Advanced Text Processing — Validating input formats
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

emails = {'ravi@nitkkr.ac.in', 'wrong@', 'neha.k@gmail.com', '@x.com'};
pat = '^[\w.]+@\w+(\.\w+)+$';
for k = 1:numel(emails)
    ok = ~isempty(regexp(emails{k}, pat, 'once'));
    fprintf('%-20s %s\n', emails{k}, ternary(ok, 'valid', 'INVALID'));
end
phones = {'9876543210', '98765-43210', '12345'};
for k = 1:numel(phones)
    digits_only = regexprep(phones{k}, '\D', '');
    fprintf('%-12s -> %s (%d digits)\n', phones{k}, digits_only, length(digits_only));
end

function out = ternary(cond, a, b)
    if cond, out = a; else, out = b; end
end
