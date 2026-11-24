% Day 020 · Element-by-Element Operations — Power dissipated in a set of resistors
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

R = [10 22 47 100 220];         % ohms
V = 12;                         % volts across each (all in parallel)
I = V ./ R                      % current in each
P = V^2 ./ R                    % power in each
P_check = I.^2 .* R             % same answer, a different formula
fprintf('Total current %.3f A, total power %.2f W\n', sum(I), sum(P));
