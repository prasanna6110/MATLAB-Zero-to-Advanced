function y = change_input(x)
% CHANGE_INPUT  Shows that inputs are copies (passed by value).
x = x * 100;          % changes only the local copy
temp_inside = 5;      % a local variable, invisible outside
y = x + temp_inside;
end

% (Course file for Day 052 · Local, Global and Persistent Variables)
