% Day 049 · Error Handling: try/catch, error, warning and assert — assert and validateattributes for checks
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

function_ok = true;
try
    x = [1 2 3];
    assert(numel(x) == 3, 'x must have 3 elements');
    assert(all(x > 0), 'x must be positive');
    validateattributes(x, {'numeric'}, {'vector', 'positive'});
    disp('All checks passed')
    y = -5;
    validateattributes(y, {'numeric'}, {'positive'});
catch ME
    function_ok = false;
    disp(ME.message)
end
fprintf('Checks passed completely: %d\n', function_ok);
