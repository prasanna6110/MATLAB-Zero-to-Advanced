% Day 027 · Output Commands: disp and fprintf — fprintf repeats its format for vectors and matrices
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

x = 1:5;
fprintf('%d ', x); fprintf('\n');          % the format is reused for every element
fprintf('x = %d, x^2 = %d\n', [x; x.^2]);  % takes elements column by column
T = [1 2 3; 10 20 30];
fprintf('%d %d\n', T)                      % column order: 1 10, 2 20, 3 30
fprintf('%5.1f %5.1f %5.1f\n', T');        % transpose to print row by row
