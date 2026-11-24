# Day 029 · The save and load Commands

_Scripts and Data_

## `save`
| Command | Saves |
|---------|-------|
| `save myfile` | **all** workspace variables to `myfile.mat` (binary MAT-file) |
| `save myfile a b` | only `a` and `b` |
| `save('myfile.mat', 'a', 'b')` | function form, useful when the name is in a variable |
| `save myfile a -append` | adds or replaces `a` in an existing file |
| `save data.txt A -ascii` | the numbers of A as plain text (only numeric arrays, no names) |

## `load`
| Command | Does |
|---------|------|
| `load myfile` | loads all variables back with their names |
| `load myfile a` | loads only `a` |
| `S = load('myfile.mat')` | loads into a **structure**: `S.a`, `S.b` (no surprise variables) |
| `A = load('data.txt')` | reads a text file of numbers into the variable A |

## Other file helpers
- `whos -file myfile.mat` shows what a MAT-file contains.
- `exist('myfile.mat', 'file')` checks that a file exists (returns 2).
- `delete myfile.mat` deletes a file. `movefile`, `copyfile`, `mkdir`, `rmdir`, `fullfile` handle files and folders.

MAT-files keep the exact values, sizes and types, so they are the best way to save work between sessions.

## Examples

### Example 1: Saving and loading a MAT-file  ([`example_1.m`](example_1.m))

```matlab
clear
V = 230; I = [1.2 3.4 5.6]; site = 'Substation-A';
save('session1.mat');                 % everything
save('only_I.mat', 'I');              % one variable
clear
whos
load('session1.mat');
fprintf('Loaded V = %d and site = %s\n', V, site);
S = load('only_I.mat')                % into a structure
delete('session1.mat'); delete('only_I.mat');   % tidy up
```

### Example 2: Saving numbers as a text file  ([`example_2.m`](example_2.m))

```matlab
M = [1 2.5 3; 4 5.5 6];
save('matrix.txt', 'M', '-ascii');
type matrix.txt                       % show the file content
A = load('matrix.txt')                % back into a variable
delete('matrix.txt');
```

### Example 3: Appending to a MAT-file and checking files  ([`example_3.m`](example_3.m))

```matlab
results = struct('run', 1, 'error', 0.031);
save('experiment.mat', 'results');
notes = 'second run used a finer mesh';
save('experiment.mat', 'notes', '-append');
if exist('experiment.mat', 'file') == 2
    info = whos('-file', 'experiment.mat');
    fprintf('The file holds: %s\n', strjoin({info.name}, ', '));
end
folder = tempdir;
full_name = fullfile(folder, 'backup.mat');
copyfile('experiment.mat', full_name);
fprintf('Backup written to %s\n', full_name);
delete(full_name); delete('experiment.mat');
```

## Practice

1. Create three variables, save two of them to a MAT-file, clear everything and load only one back.
2. Save a 5×5 magic square as ASCII text, open the file in a text editor, then load it back.
3. What is the advantage of `S = load('file.mat')` over plain `load file.mat`?
4. Write a script that saves its results to a file whose name includes the date (`datestr(now, 'yyyymmdd')`).

---

[⬅ Day 028](../Day-028-Building-Text-with-sprintf-num2str-and-Formatted-Tables/README.md) · [🏠 Home](../README.md) · [Day 030 ➡](../Day-030-Importing-and-Exporting-Data-CSV-Text-and-Excel-Files/README.md)
