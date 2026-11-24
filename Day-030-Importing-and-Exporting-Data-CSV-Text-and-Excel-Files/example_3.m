% Day 030 · Importing and Exporting Data: CSV, Text and Excel Files — readmatrix, readtable and Excel (modern MATLAB)
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% MATLAB-ONLY: readmatrix/readtable/writetable need MATLAB R2019a+
A = magic(4);
writematrix(A, 'magic.xlsx');            % an Excel file
B = readmatrix('magic.xlsx');
isequal(A, B)
names = {'Asha'; 'Ravi'; 'Meena'};
marks = [88; 72; 95];
T = table(names, marks);
writetable(T, 'marks.csv');
T2 = readtable('marks.csv')
T2(T2.marks > 80, :)                     % filter rows of a table
delete('magic.xlsx'); delete('marks.csv');
