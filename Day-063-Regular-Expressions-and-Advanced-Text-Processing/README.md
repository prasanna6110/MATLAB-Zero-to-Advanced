# Day 063 · Regular Expressions and Advanced Text Processing

_Data Types_

## Regular expressions
A **regular expression (regex)** is a pattern for searching text.

| Pattern | Matches |
|---------|---------|
| `\d` / `\D` | a digit / a non-digit |
| `\w` / `\W` | a letter, digit or `_` / anything else |
| `\s` | a white-space character |
| `.` | any character |
| `[aeiou]`, `[A-Z]`, `[^0-9]` | a set, a range, NOT in the set |
| `*` `+` `?` | 0 or more, 1 or more, 0 or 1 |
| `{n}`, `{n,m}` | exactly n, between n and m |
| `^`, `$` | start, end of the text |
| `( )` | a group (a token you can extract) |
| `\|` | or |

## MATLAB regex functions
| Function | Does |
|----------|------|
| `regexp(str, pat, 'match')` | all matching pieces (cell array) |
| `regexp(str, pat, 'tokens')` | the groups `( )` of every match |
| `regexp(str, pat, 'names')` | named groups `(?<name>...)` as a structure |
| `regexp(str, pat, 'split')` | split the text at the matches |
| `regexp(str, pat, 'once', ...)` | only the first match |
| `regexpi` | ignore case |
| `regexprep(str, pat, rep)` | replace (use `$1` for group 1) |

Other helpful text functions: `strsplit`, `strjoin`, `strtok`, `textscan`, `sprintf`, `lower`/`upper`, `fliplr`, `isstrprop(s, 'digit')`.

## Examples

### Example 1: Extracting numbers and words  ([`example_1.m`](example_1.m))

```matlab
txt = 'Bus 7: V = 0.982 pu, angle -3.45 deg, load 120.5 MW';
nums = regexp(txt, '-?\d+\.?\d*', 'match')
values = str2double(nums)
words = regexp(txt, '[A-Za-z]+', 'match')
parts = regexp(txt, ',\s*', 'split')
first_number = regexp(txt, '\d+', 'match', 'once')
```

### Example 2: Validating input formats  ([`example_2.m`](example_2.m))

```matlab
emails = {'ravi@nitkkr.ac.in', 'wrong@', 'neha.k@gmail.com', '@x.com'};
pat = '^[\w.]+@\w+(\.\w+)+$';
for k = 1:numel(emails)
    ok = ~isempty(regexp(emails{k}, pat, 'once'));
    fprintf('%-20s %s\n', emails{k}, ternary(ok, 'valid', 'INVALID'));
end
phones = {'9876543210', '98765-43210', '12345'};
for k = 1:numel(phones)
    digits_only = regexprep(phones{k}, '\D', '');
    fprintf('%-12s -> %s (%d digits)\n', phones{k}, digits_only, length(digits_only));
end

function out = ternary(cond, a, b)
    if cond, out = a; else, out = b; end
end
```

### Example 3: Tokens, named groups and replacement  ([`example_3.m`](example_3.m))

```matlab
log_text = sprintf('2026-11-24 10:05 TRIP CB12\n2026-11-24 10:07 CLOSE CB12\n2026-11-24 11:40 TRIP CB03');
tok = regexp(log_text, '(\d{2}:\d{2}) (TRIP|CLOSE) (CB\d+)', 'tokens');
for k = 1:numel(tok)
    fprintf('At %s breaker %s: %s\n', tok{k}{1}, tok{k}{3}, tok{k}{2});
end
s = regexp('V=231.4', '(?<name>\w+)=(?<value>[\d.]+)', 'names')
swapped = regexprep('Kumar, Ravi', '(\w+), (\w+)', '$2 $1')
% MATLAB can also run code in the replacement: regexprep(s, '(^|\s)(\w)', '$1${upper($2)}')
```

## Practice

1. Extract all the 6-digit PIN codes from a text.
2. Check whether a password has at least 8 characters, one digit and one capital letter.
3. Replace multiple spaces in a text with a single space using `regexprep`.
4. From `'R1=10k, R2=4.7k, R3=220'`, extract each resistor name and value.

---

[⬅ Day 062](../Day-062-Date-and-Time/README.md) · [🏠 Home](../README.md) · [Day 064 ➡](../Day-064-Set-Operations-and-Key-Value-Maps/README.md)
