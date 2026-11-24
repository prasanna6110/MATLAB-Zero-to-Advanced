% Day 049 · Error Handling: try/catch, error, warning and assert — error and warning
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

R = 0;
V = 12;
if R <= 0
    warning('R must be positive, using 1 ohm instead');
    R = 1;
end
fprintf('I = %.2f A\n', V / R);
try
    n = -3;
    if n < 0
        error('Demo:negative', 'n must not be negative (got %d)', n);
    end
catch ME
    fprintf('Caught [%s]: %s\n', ME.identifier, ME.message);
end
