% Day 064 · Set Operations and Key-Value Maps — A dictionary of resistor colour codes
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

colours = {'black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet', 'grey', 'white'};
code = containers.Map(colours, num2cell(0:9));
band = {'yellow', 'violet', 'red'};                    % 47 x 10^2 = 4.7 kohm
R = (10*code(band{1}) + code(band{2})) * 10^code(band{3});
fprintf('%s-%s-%s = %g ohm\n', band{:}, R);
fprintf('Map has %d keys. Is "gold" a key? %d\n', code.Count, isKey(code, 'gold'));
