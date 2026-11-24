# Day 062 · Date and Time

_Data Types_

## The `datetime` type (MATLAB R2014b+)
```matlab
t = datetime('now')
t = datetime(2026, 11, 24, 9, 30, 0)
t = datetime('24-Nov-2026 09:30', 'InputFormat', 'dd-MMM-yyyy HH:mm')
```
- Parts: `year(t)`, `month(t)`, `day(t)`, `hour(t)`, `weekday(t)`, `day(t, 'name')`
- Arithmetic: `t + days(3)`, `t - hours(5)`, `t2 - t1` gives a **duration**; `between(t1, t2)` gives a calendar duration.
- Sequences: `t0:hours(1):t1`
- Format: `t.Format = 'dd/MM/yyyy HH:mm'`, `datestr`/`string(t)` for text
- `duration`: `minutes(90)`, `seconds(d)`; `calendarDuration`: `calmonths(2)`

## Classic date functions (also in Octave)
| Function | Gives |
|----------|-------|
| `now` | the current date and time as a **serial date number** (days since year 0) |
| `clock` | `[year month day hour minute seconds]` |
| `datenum(y, m, d, h, mi, s)` | a serial date number |
| `datestr(n, format)` | text, e.g. `datestr(now, 'dd-mmm-yyyy HH:MM')` |
| `datevec(n)` | back to `[y m d h mi s]` |
| `weekday(n)` | 1 = Sunday … 7 = Saturday |
| `calendar(y, m)` | the month as a matrix |
| `eomday(y, m)` | days in that month |
| `tic`/`toc`, `cputime`, `pause(s)` | timing and waiting |

Differences of serial numbers are in **days**, so multiply by 24 for hours.

## Examples

### Example 1: Classic date numbers (MATLAB and Octave)  ([`example_1.m`](example_1.m))

```matlab
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
```

### Example 2: Age calculator and time differences  ([`example_2.m`](example_2.m))

```matlab
birth = datenum(1998, 1, 13, 4, 55, 0);
today_n = datenum(2026, 11, 24, 12, 0, 0);
age_days = today_n - birth;
fprintf('Age: %.0f days = %.2f years\n', age_days, age_days / 365.25);
shift_start = datenum(2026, 11, 24, 22, 0, 0);
shift_end   = datenum(2026, 11, 25, 6, 30, 0);
fprintf('Night shift length: %.2f hours\n', (shift_end - shift_start) * 24);
stamps = datenum(2026, 11, 24, 0, 0:15:60, 0);
disp(datestr(stamps, 'HH:MM'))
```

### Example 3: datetime and duration objects  ([`example_3.m`](example_3.m))

```matlab
% MATLAB-ONLY: datetime and duration (R2014b+)
t = datetime(2026, 11, 24, 9, 30, 0)
t.Format = 'dd-MMM-yyyy HH:mm';
exam = t + days(10) + hours(2)
left = exam - t                         % a duration
day(exam, 'name')
readings = datetime(2026, 11, 24, 0:6:23, 0, 0)'
diff(readings)
isweekend(datetime(2026, 11, 29))
```

## Practice

1. How many days are left until your next birthday? Use `datenum`.
2. Print the calendar of the current month with `calendar`.
3. Create time stamps every 30 minutes for one day and print them as `HH:MM`.
4. (MATLAB) Use `datetime` to find the day of the week of 1 January 2030.

---

[⬅ Day 061](../Day-061-Numeric-Types-Logical-Type-and-Type-Conversion/README.md) · [🏠 Home](../README.md) · [Day 063 ➡](../Day-063-Regular-Expressions-and-Advanced-Text-Processing/README.md)
