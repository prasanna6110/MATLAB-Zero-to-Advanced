% Day 060 · Tables — Creating, filtering and sorting a table
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% MATLAB-ONLY: the table type is not available in GNU Octave
Name = {'Asha'; 'Ravi'; 'Meena'; 'Kabir'; 'Isha'};
Dept = {'EE'; 'ME'; 'EE'; 'CS'; 'CS'};
Marks = [88; 64; 93; 71; 85];
T = table(Name, Dept, Marks)
T.Grade = repmat('B', height(T), 1);
T.Grade(T.Marks >= 85) = 'A';
top = sortrows(T, 'Marks', 'descend');
head(top, 3)
ee = T(strcmp(T.Dept, 'EE'), :)
mean(T.Marks)
