# Day 016 · String Arrays and Converting Between Numbers and Text

_Creating Arrays_

## String arrays (`"double quotes"`, MATLAB R2017a+)
Modern MATLAB also has a **string** type. A string is one object holding a whole piece of text, so a **string array** can hold texts of different lengths without padding.

| | char array `'abc'` | string `"abc"` |
|--|--------------------|----------------|
| `length` | number of characters | 1 (one string) |
| Joining | `['a' 'b']` | `"a" + "b"` |
| Comparison | `strcmp(a, b)` | `a == b` works |
| A list of texts | char matrix (padded) or cell array | `["red" "yellow"]` |

Useful string functions (they also accept char arrays): `strlength`, `contains`, `startsWith`, `endsWith`, `replace`, `split`, `join`, `extractBetween`, `extractAfter`, `extractBefore`, `upper`, `lower`, `strip`, `pad`, `reverse`, `compose`, `string(x)`, `str2double`.

> **GNU Octave note:** Octave does not have string arrays. Double quotes create a **char array** there. All string examples today are marked MATLAB-ONLY.

## Converting between numbers and text
| From → To | Function |
|-----------|----------|
| number → text | `num2str(x)`, `num2str(x, prec)`, `sprintf('%.2f', x)`, `mat2str(A)`, `string(x)` |
| text → number | `str2double(s)` (safe, returns NaN if invalid), `str2num(s)` (evaluates expressions) |
| integer → binary/hex text | `dec2bin`, `dec2hex`; back with `bin2dec`, `hex2dec` |
| character ↔ code | `double('A')`, `char(65)` |

## Examples

### Example 1: String arrays  ([`example_1.m`](example_1.m))

```matlab
% MATLAB-ONLY: string arrays need MATLAB R2017a or newer
s = "Power System";
strlength(s)
words = split(s)                  % ["Power"; "System"]
fruits = ["apple" "kiwi" "watermelon"];
strlength(fruits)                 % 5 4 10, no padding needed
greeting = "Hello " + "NIT"       % + joins strings
contains(fruits, "w")
upper(fruits(end))
fruits == "kiwi"                  % == works for strings
```

### Example 2: Number to text and back (works everywhere)  ([`example_2.m`](example_2.m))

```matlab
x = 1234.5678;
a = num2str(x)                    % default 4 decimals for big numbers
b = num2str(x, 8)                 % 8 significant digits
c = sprintf('%.1f', x)
d = mat2str([1.5 2; 3 4])         % a matrix as text you can paste back
v = str2double('42.75') * 2
bad = str2double('abc')           % NaN, not an error
e = str2num('[1 2 3] * 2')        % evaluates an expression
dec2bin(13)
bin2dec('1101')
dec2hex(255)
```

### Example 3: Parsing a line from a sensor log  ([`example_3.m`](example_3.m))

```matlab
log_line = 'T=27.4C,H=63%,P=1008hPa';
fields = strsplit(log_line, ',');
values = zeros(1, numel(fields));
for k = 1:numel(fields)
    txt = fields{k};
    digits_only = txt(ismember(txt, '0123456789.'));   % keep digits and the point
    values(k) = str2double(digits_only);
end
fprintf('Temperature %.1f C, humidity %.0f %%, pressure %.0f hPa\n', values);
```

## Practice

1. (MATLAB) Make a string array of 5 city names and find the ones that contain the letter "a".
2. Convert the number 255 to binary, octal (`dec2base(255, 8)`) and hexadecimal.
3. What is the difference between `str2num('2+3')` and `str2double('2+3')`?
4. Extract the number from `'Current: 12.75 A'` and multiply it by 230.

---

[⬅ Day 015](../Day-015-Text-in-MATLAB-Character-Arrays/README.md) · [🏠 Home](../README.md) · [Day 017 ➡](../Day-017-Addition-Subtraction-and-Operations-with-Scalars/README.md)
