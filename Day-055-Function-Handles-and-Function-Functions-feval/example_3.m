% Day 055 · Function Handles and Function Functions (feval) — arrayfun and cellfun
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

words = {'resistor', 'IC', 'capacitor', 'diode'};
lengths = cellfun(@length, words)
upper_words = cellfun(@upper, words, 'UniformOutput', false)
long_ones = words(cellfun(@(w) length(w) > 5, words))
n = 1:6;
fact = arrayfun(@factorial, n)
digits_sum = arrayfun(@(k) sum(num2str(k) - '0'), [123 4567 99])
