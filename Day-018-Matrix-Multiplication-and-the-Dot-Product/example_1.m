% Day 018 · Matrix Multiplication and the Dot Product — Matrix multiplication rules
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

A = [1 2 3; 4 5 6];         % 2x3
B = [1 0; 0 1; 1 1];         % 3x2
C = A * B                    % 2x2
D = B * A                    % 3x3, a different result
try
    A * A                    % 2x3 * 2x3 is not allowed
catch err
    disp(err.message)
end
M = magic(3);
M^2                          % same as M*M
