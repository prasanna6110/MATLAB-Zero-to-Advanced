% Day 020 · Element-by-Element Operations — The dot makes the difference
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

a = [1 2 3];
b = [4 5 6];
a .* b
a ./ b
a .^ 2
2 .^ a                      % 2^1, 2^2, 2^3
try
    a * b                   % matrix multiply of two 1x3 -> error
catch err
    disp(err.message)
end
A = [1 2; 3 4];
A * A                       % matrix product
A .* A                      % squares of the elements: a different result
