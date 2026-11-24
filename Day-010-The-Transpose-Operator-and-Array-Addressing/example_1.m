% Day 010 · The Transpose Operator and Array Addressing — Transposing vectors and matrices
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

row = [3 6 9]
col = row'                     % now a column
A = [1 2 3; 4 5 6]
At = A'                        % 3x2
z = [1+2i 3-4i];
z'                             % conjugate transpose: signs of the imaginary parts flip
z.'                            % plain transpose
