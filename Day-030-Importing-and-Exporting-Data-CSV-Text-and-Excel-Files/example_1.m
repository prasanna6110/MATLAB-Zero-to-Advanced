% Day 030 · Importing and Exporting Data: CSV, Text and Excel Files — CSV files with the classic functions (MATLAB and Octave)
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

hours = (1:6)';
load_kW = [42 38 35 50 63 71]';
csvwrite('load.csv', [hours load_kW]);
type load.csv
data = csvread('load.csv');
fprintf('Peak load %d kW at hour %d\n', max(data(:, 2)), data(data(:, 2) == max(data(:, 2)), 1));
dlmwrite('load_tab.txt', data, 'delimiter', '\t', 'precision', '%.1f');
type load_tab.txt
again = dlmread('load_tab.txt', '\t');
isequal(again, data)
delete('load.csv'); delete('load_tab.txt');
