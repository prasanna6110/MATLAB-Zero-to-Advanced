% Day 058 · Cell Arrays — A list of names of different lengths
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

cities = {'Kurukshetra', 'Satna', 'Delhi', 'Thiruvananthapuram'};
for k = 1:numel(cities)
    fprintf('%-20s %2d letters\n', cities{k}, length(cities{k}));
end
sorted = sort(cities)
ismember('Delhi', cities)
lengths = cellfun(@numel, cities);
[~, longest] = max(lengths);
fprintf('Longest name: %s\n', cities{longest});
strjoin(cities, ' -> ')
