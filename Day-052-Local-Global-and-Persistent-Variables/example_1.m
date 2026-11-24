% Day 052 · Local, Global and Persistent Variables — Local variables and pass-by-value
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

x = 2;
y = change_input(x);
fprintf('x is still %d, y = %d\n', x, y);
fprintf('Is temp_inside visible here? %d\n', exist('temp_inside', 'var'));
