% Day 060 · Tables — Group statistics and timetables
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% MATLAB-ONLY: groupsummary (R2018a) and timetable (R2016b)
Dept = categorical({'EE'; 'ME'; 'EE'; 'CS'; 'CS'; 'ME'});
Marks = [88; 64; 93; 71; 85; 77];
T = table(Dept, Marks);
G = groupsummary(T, 'Dept', {'mean', 'max'}, 'Marks')
t = datetime(2026, 11, 24, 0:3:21, 0, 0)';
load_kW = [40; 35; 52; 75; 68; 80; 95; 60];
TT = timetable(t, load_kW);
daily = retime(TT, 'daily', 'max')
