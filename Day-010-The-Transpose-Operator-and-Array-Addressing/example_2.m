% Day 010 · The Transpose Operator and Array Addressing — Picking elements out of a vector
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

marks = [67 82 91 45 73 88];
first = marks(1)
last = marks(end)
third_and_fifth = marks([3 5])
marks(4) = 50;                 % correct a wrong entry
marks
average_of_first_three = (marks(1) + marks(2) + marks(3)) / 3
