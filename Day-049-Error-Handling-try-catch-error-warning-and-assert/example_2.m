% Day 049 · Error Handling: try/catch, error, warning and assert — try/catch around risky operations
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

files = {'missing_file.csv', 'also_missing.txt'};
for k = 1:numel(files)
    try
        data = load(files{k});
        fprintf('%s loaded\n', files{k});
    catch ME
        fprintf('Could not load %s: using default data\n', files{k});
        data = zeros(3);
    end
end
values = {'12.5', 'abc', '7'};
for k = 1:numel(values)
    x = str2double(values{k});
    if isnan(x)
        fprintf('"%s" is not a number\n', values{k});
    else
        fprintf('"%s" -> %g\n', values{k}, x);
    end
end
