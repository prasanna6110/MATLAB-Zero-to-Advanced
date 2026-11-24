% Day 062 · Date and Time — Classic date numbers (MATLAB and Octave)
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

d1 = datenum(2026, 1, 26);              % Republic Day 2026
d2 = datenum(2026, 8, 15);              % Independence Day 2026
fprintf('Days between: %d\n', d2 - d1);
datestr(d1, 'dddd, dd mmmm yyyy')
[~, name] = weekday(d2);
fprintf('15 Aug 2026 is a %s\n', name);
v = datevec(d1 + 100.25)                % 100 days and 6 hours later
fprintf('February 2028 has %d days\n', eomday(2028, 2));
c = clock;
fprintf('This script ran in the year %d\n', c(1));
