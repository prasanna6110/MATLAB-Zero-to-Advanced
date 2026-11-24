% Day 058 · Cell Arrays — Creating and indexing a cell array
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

student = {'Ravi Kumar', 21, [78 85 90]};
name = student{1}
marks = student{3}
second_mark = student{3}(2)
c = student(1)                    % a 1x1 cell, not the text
class(c), class(student{1})
student{4} = 'EE Department';     % add a new cell
size(student)
celldisp(student)
