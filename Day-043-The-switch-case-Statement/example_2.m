% Day 043 · The switch-case Statement — Numeric cases: days in a month
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

month = 2; year = 2028;
switch month
    case {1, 3, 5, 7, 8, 10, 12}
        days = 31;
    case {4, 6, 9, 11}
        days = 30;
    case 2
        if mod(year, 4) == 0 && (mod(year, 100) ~= 0 || mod(year, 400) == 0)
            days = 29;
        else
            days = 28;
        end
    otherwise
        error('Month must be 1 to 12');
end
fprintf('Month %d of %d has %d days\n', month, year, days);
