% Day 012 · Adding Elements, Deleting Elements and Reshaping Arrays — Deleting rows, columns and elements
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

v = 10:10:80;
v(3) = []                     % delete one element
v([1 end]) = []               % delete first and last
A = magic(5);
A(2, :) = [];                 % delete row 2
A(:, [1 3]) = []              % delete columns 1 and 3
try
    A(1, 1) = [];             % cannot leave a hole
catch err
    disp(err.message)
end
