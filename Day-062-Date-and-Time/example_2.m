% Day 062 · Date and Time — Age calculator and time differences
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

birth = datenum(1998, 1, 13, 4, 55, 0);
today_n = datenum(2026, 11, 24, 12, 0, 0);
age_days = today_n - birth;
fprintf('Age: %.0f days = %.2f years\n', age_days, age_days / 365.25);
shift_start = datenum(2026, 11, 24, 22, 0, 0);
shift_end   = datenum(2026, 11, 25, 6, 30, 0);
fprintf('Night shift length: %.2f hours\n', (shift_end - shift_start) * 24);
stamps = datenum(2026, 11, 24, 0, 0:15:60, 0);
disp(datestr(stamps, 'HH:MM'))
