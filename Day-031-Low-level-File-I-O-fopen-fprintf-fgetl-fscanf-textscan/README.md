# Day 031 · Low-level File I/O: fopen, fprintf, fgetl, fscanf, textscan

_Scripts and Data_

## Opening and closing
```matlab
fid = fopen('file.txt', 'w');   % 'r' read, 'w' write (overwrite), 'a' append, 'r+' read and write
if fid == -1, error('Could not open the file'); end
...
fclose(fid);                    % always close
```

## Writing
`fprintf(fid, format, values)`: the same as screen `fprintf`, with the file id first. (`fid = 1` is the screen.)

## Reading
| Function | Reads |
|----------|-------|
| `fgetl(fid)` | one line **without** the new-line character (returns -1 at the end) |
| `fgets(fid)` | one line **with** the new-line character |
| `fscanf(fid, '%f')` | all numbers matching the format into a column |
| `fscanf(fid, '%f %f', [2 Inf])` | into a 2-row matrix |
| `textscan(fid, '%s %f %d', 'Delimiter', ',')` | columns of different types into a **cell array** |
| `fileread('f.txt')` | the whole file as one text |
| `feof(fid)` | true at the end of the file |

A common pattern reads a file line by line:
```matlab
fid = fopen('log.txt');
line = fgetl(fid);
while ischar(line)
    % ... use line ...
    line = fgetl(fid);
end
fclose(fid);
```

## Examples

### Example 1: Writing and appending a text log  ([`example_1.m`](example_1.m))

```matlab
fid = fopen('events.log', 'w');
fprintf(fid, '%s\n', 'Breaker CB1 closed', 'Load increased to 80%');
fclose(fid);
fid = fopen('events.log', 'a');                % append mode
fprintf(fid, 'Fault cleared in %d ms\n', 85);
fclose(fid);
txt = fileread('events.log');
disp(txt)
delete('events.log');
```

### Example 2: Reading line by line with fgetl  ([`example_2.m`](example_2.m))

```matlab
fid = fopen('stations.txt', 'w');
fprintf(fid, 'Panipat 230\nKurukshetra 228\nAmbala 233\nKarnal 226\n');
fclose(fid);
fid = fopen('stations.txt', 'r');
line = fgetl(fid);
count = 0;
while ischar(line)
    parts = strsplit(line, ' ');
    v = str2double(parts{2});
    flag = '';
    if v < 228, flag = '  <- low'; end
    fprintf('%-12s %d V%s\n', parts{1}, v, flag);
    count = count + 1;
    line = fgetl(fid);
end
fclose(fid);
fprintf('%d lines read\n', count);
delete('stations.txt');
```

### Example 3: fscanf and textscan  ([`example_3.m`](example_3.m))

```matlab
fid = fopen('xy.txt', 'w');
fprintf(fid, '%.1f %.2f\n', [0:0.5:2; (0:0.5:2).^2]);
fclose(fid);
fid = fopen('xy.txt');
XY = fscanf(fid, '%f %f', [2 Inf]);           % 2 rows, as many columns as needed
fclose(fid);
disp(XY')
fid = fopen('parts.csv', 'w');
fprintf(fid, 'R101,10,0.25\nC205,47,0.10\nL330,3,1.50\n');
fclose(fid);
fid = fopen('parts.csv');
C = textscan(fid, '%s %f %f', 'Delimiter', ',');
fclose(fid);
codes = C{1}; qty = C{2}; cost = C{3};
for k = 1:numel(codes)
    fprintf('%s: %g pcs x Rs %.2f = Rs %.2f\n', codes{k}, qty(k), cost(k), qty(k)*cost(k));
end
delete('xy.txt'); delete('parts.csv');
```

## Practice

1. Write the numbers 1 to 20 to a file, one per line, then read them back with `fscanf`.
2. Read a text file and count how many lines contain the word "error" (`strfind` or `contains`).
3. Use `textscan` to read a file of `name,age,city` lines.
4. Why should every `fopen` have a matching `fclose`?

---

[⬅ Day 030](../Day-030-Importing-and-Exporting-Data-CSV-Text-and-Excel-Files/README.md) · [🏠 Home](../README.md) · [Day 032 ➡](../Day-032-The-plot-Command-and-Line-Specifiers/README.md)
