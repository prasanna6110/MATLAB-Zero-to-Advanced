% Day 105 · Debugging, the Code Analyzer and Unit Testing — Finding a bug with checks (a debugging walk-through)
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% A buggy average function: it should ignore NaN values.
data = [4 NaN 8 6 NaN 2];
buggy = buggy_mean(data);
fixed = fixed_mean(data);
fprintf('buggy_mean = %g, fixed_mean = %g, expected %g\n', buggy, fixed, mean(data(~isnan(data))));
% How to find it in MATLAB: put a breakpoint inside buggy_mean (click the line number),
% run, then look at 'total' and 'count' at the K>> prompt after each step (F10).

function m = buggy_mean(v)
    total = 0; count = 0;
    for k = 1:numel(v)
        if ~isnan(v(k))
            total = total + v(k);
        end
        count = count + 1;          % BUG: counts the NaN values too
    end
    m = total / count;
end

function m = fixed_mean(v)
    total = 0; count = 0;
    for k = 1:numel(v)
        if ~isnan(v(k))
            total = total + v(k);
            count = count + 1;      % only count the valid values
        end
    end
    m = total / count;
end
