% Day 061 · Numeric Types, Logical Type and Type Conversion — single vs double precision
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

x = single(1) / 3
y = 1 / 3
fprintf('single: %.20f\ndouble: %.20f\n', x, y);
eps('single'), eps('double')
A = rand(1000);
B = single(A);
s1 = whos('A'); s2 = whos('B');
fprintf('double uses %d bytes, single uses %d bytes\n', s1.bytes, s2.bytes);
