% Day 011 · Using the Colon in Addressing Arrays and the end Keyword — Reversing, every second element, and A(:)
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

v = 10:10:100;
reversed = v(end:-1:1)
odd_positions = v(1:2:end)
B = magic(3)
as_column = B(:)'              % column by column, shown as a row
B(:, [1 3]) = B(:, [3 1])      % swap columns 1 and 3
