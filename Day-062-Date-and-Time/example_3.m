% Day 062 · Date and Time — datetime and duration objects
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% MATLAB-ONLY: datetime and duration (R2014b+)
t = datetime(2026, 11, 24, 9, 30, 0)
t.Format = 'dd-MMM-yyyy HH:mm';
exam = t + days(10) + hours(2)
left = exam - t                         % a duration
day(exam, 'name')
readings = datetime(2026, 11, 24, 0:6:23, 0, 0)'
diff(readings)
isweekend(datetime(2026, 11, 29))
