# Day 015 · Text in MATLAB: Character Arrays

_Creating Arrays_

## Character arrays (`'single quotes'`)
Text in single quotes is a **character array**: a row vector of characters. Each character is stored by its numeric (Unicode) code.

```matlab
name = 'Kurukshetra';   % 1x11 char
name(1)                 % 'K'
name(end:-1:1)          % reversed
double('A')             % 65
char(72)                % 'H'
```

## Joining and multi-row text
- `['Hello ' 'World']` joins texts (horizontal concatenation).
- Rows of a char **matrix** must have the same length. `char('red', 'yellow')` pads the shorter rows with spaces.
- `strcat('a ', 'b')` joins but **removes trailing spaces** of char inputs.

## Common text functions
| Function | Example | Result |
|----------|---------|--------|
| `upper`, `lower` | `upper('ok')` | `'OK'` |
| `strtrim` | `strtrim('  hi  ')` | `'hi'` |
| `strrep(s, old, new)` | `strrep('a-b-c','-','+')` | `'a+b+c'` |
| `strfind(s, pat)` | `strfind('abcabc','bc')` | `[2 5]` |
| `strsplit(s, d)` | `strsplit('a,b,c', ',')` | `{'a','b','c'}` |
| `strjoin(c, d)` | `strjoin({'a','b'}, '-')` | `'a-b'` |
| `strcmp`, `strcmpi` | compare (exact / ignore case) | 1 or 0 |
| `strncmp` | compare the first n characters | |
| `num2str(x)`, `num2str(x, 4)` | number → text | `'3.1416'` |
| `str2num`, `str2double` | text → number | `str2double('2.5')` → 2.5 |
| `sprintf` | formatted text (Day 28) | |
| `blanks(n)`, `deblank`, `fliplr` | spaces, remove trailing blanks, reverse | |

> **Common mistake:** `if name == 'yes'` fails or misbehaves when the lengths differ. Compare text with `strcmp(name, 'yes')`.

## Examples

### Example 1: Characters are numbers underneath  ([`example_1.m`](example_1.m))

```matlab
city = 'Satna';
length(city)
city(1)
city([1 end])
codes = double(city)            % Unicode codes
shifted = char(codes + 1)       % a tiny "Caesar cipher"
reversed = fliplr(city)
upper(city)
```

### Example 2: Joining text and numbers  ([`example_2.m`](example_2.m))

```matlab
name = 'Motor-3';
speed = 1440;
msg = ['Speed of ' name ' is ' num2str(speed) ' rpm'];
disp(msg)
v = 230.456;
disp(['Voltage = ' num2str(v, 5) ' V'])      % 5 significant digits
rows = char('Monday', 'Tue', 'Wednesday')    % padded to equal length
size(rows)
```

### Example 3: Searching, replacing, splitting and comparing  ([`example_3.m`](example_3.m))

```matlab
line = 'V=230;I=12.5;PF=0.92';
parts = strsplit(line, ';')                  % a cell array of texts
for k = 1:numel(parts)
    kv = strsplit(parts{k}, '=');
    fprintf('%-3s -> %g\n', kv{1}, str2double(kv{2}));
end
strrep(line, ';', ', ')
strfind(line, '=')
strcmp('Yes', 'yes'), strcmpi('Yes', 'yes')
strtrim('   padded text   ')
```

## Practice

1. Ask for nothing, but store your full name in a variable, then print it in upper case and reversed.
2. Count how many times the letter 'a' occurs in `'banana bandana'` (`sum(s == 'a')`).
3. Split `'red,green,blue'` into three parts and join them back with `' | '`.
4. Check if a word is a palindrome using `strcmp(w, fliplr(w))`.

---

[⬅ Day 014](../Day-014-Logical-Indexing-Selecting-Data-with-Conditions/README.md) · [🏠 Home](../README.md) · [Day 016 ➡](../Day-016-String-Arrays-and-Converting-Between-Numbers-and-Text/README.md)
