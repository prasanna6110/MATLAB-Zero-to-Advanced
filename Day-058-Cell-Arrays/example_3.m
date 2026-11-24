% Day 058 · Cell Arrays — Mixed data, cell2mat and num2cell
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

data = {'Transformer', 250, 'kVA'; 'Motor', 15, 'kW'; 'Cable', 120, 'm'};
for r = 1:size(data, 1)
    fprintf('%-12s %6g %s\n', data{r, :});        % data{r,:} gives 3 contents
end
ratings = cell2mat(data(:, 2))'                    % numbers out of the cells
C = num2cell([1 2 3])                              % each number in its own cell
nested = {1, {'a', {'deep'}}};
nested{2}{2}{1}                                    % cells inside cells
