% Day 107 · MATLAB with Python and Other Tools, Interview Questions and Common Mistakes — Quick self-test of the most important rules
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

a = [1 2 3]; b = [4 5 6];
checks = {
    'a.*b is element-wise',            isequal(a.*b, [4 10 18])
    'a*b'' is the dot product',        a*b' == 32
    'indexing starts at 1',            a(1) == 1
    'end gives the last element',      a(end) == 3
    'sind uses degrees',               abs(sind(30) - 0.5) < 1e-12
    'float compare needs a tolerance', (0.1 + 0.2 ~= 0.3) && abs(0.1 + 0.2 - 0.3) < 1e-12
    'strcmp compares text',            strcmp('yes', 'yes') && ~strcmp('yes', 'Yes')
    'A\b solves Ax = b',               norm([2 1; 1 3]\[3; 5] - [0.8; 1.4]) < 1e-12
    };
for k = 1:size(checks, 1)
    fprintf('[%s] %s\n', ternary(checks{k, 2}, 'OK', '!!'), checks{k, 1});
end

function out = ternary(c, a, b)
    if c, out = a; else, out = b; end
end
