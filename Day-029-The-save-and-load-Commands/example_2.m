% Day 029 · The save and load Commands — Saving numbers as a text file
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

M = [1 2.5 3; 4 5.5 6];
save('matrix.txt', 'M', '-ascii');
type matrix.txt                       % show the file content
A = load('matrix.txt')                % back into a variable
delete('matrix.txt');
