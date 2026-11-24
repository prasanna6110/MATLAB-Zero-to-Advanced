% Day 044 · for Loops — Looping over items and over matrix columns
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

names = {'Feeder-1', 'Feeder-2', 'Feeder-3'};
loads = [3.2 5.8 4.1];                      % MW
for k = 1:numel(names)
    status = 'OK';
    if loads(k) > 5, status = 'OVERLOADED'; end
    fprintf('%s: %.1f MW  %s\n', names{k}, loads(k), status);
end
M = [1 2 3; 4 5 6];
for col = M                                 % col takes each column
    fprintf('column sum = %d\n', sum(col));
end
