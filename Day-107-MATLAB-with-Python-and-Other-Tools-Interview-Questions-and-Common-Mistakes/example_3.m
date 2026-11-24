% Day 107 · MATLAB with Python and Other Tools, Interview Questions and Common Mistakes — Common mistakes and their fixes, side by side
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

x = 0:0.5:2;
% Mistake 1: * instead of .*
try
    y = x * x;
catch ME
    fprintf('x * x fails: %s\n', ME.message);
end
y = x .* x;  fprintf('x .* x = %s\n', mat2str(y));
% Mistake 2: degrees in sin
fprintf('sin(30) = %.4f (radians!), sind(30) = %.4f\n', sin(30), sind(30));
% Mistake 3: the "between" trap
v = 10;
fprintf('3 < v < 7 gives %d (wrong), v > 3 & v < 7 gives %d (right)\n', 3 < v < 7, v > 3 & v < 7);
% Mistake 4: text comparison with ==
try
    if 'yes' == 'no', end
catch ME
    fprintf('''yes'' == ''no'' fails: %s\n', ME.message);
end
fprintf('strcmp(''yes'', ''no'') = %d\n', strcmp('yes', 'no'));
% Mistake 5: index zero
try
    x(0)
catch ME
    fprintf('x(0) fails: %s\n', ME.message);
end
