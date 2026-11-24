# Day 006 · Script Files, Sections and the Current Folder

_Getting Started_

## What is a script file?
A **script** is a plain text file with the extension **`.m`** that contains a list of MATLAB commands. Running the script runs the commands in order, **exactly as if you typed them** in the Command Window. Variables created by a script live in the **base workspace**, so you can see them afterwards.

### Creating, saving and running
1. **HOME → New Script** (or type `edit myfile`) opens the Editor.
2. Type the commands and save with a valid name: `power_calc.m` (same rules as variable names, no spaces, must not start with a digit, must not clash with a function name).
3. Run it by:
   - pressing **Run** (F5) in the Editor, or
   - typing its name **without `.m`** in the Command Window: `power_calc`.

### The Current Folder
MATLAB can only run a file that is in the **Current Folder** or on the **search path**. If you get *"Unrecognized function or variable"*, the file is probably not in the current folder.
- `pwd` shows the current folder; `cd folder` changes it; `ls` / `dir` lists files.
- `addpath('C:\mycode')` adds a folder to the path; `savepath` saves it; `which name` tells you which file runs.

### Sections and comments
- **`%%`** at the start of a line starts a **section**. **Run Section** (Ctrl+Enter) runs only the section the cursor is in: great for experiments.
- **`%{ ... %}`** makes a block comment.
- **Ctrl+R / Ctrl+T** comment / uncomment the selected lines. **Ctrl+I** fixes indentation.

### Live Scripts (`.mlx`)
**New → Live Script** creates a notebook-style file where the code, its output, plots and formatted text appear together. Ideal for assignments and reports. You can export it to PDF, Word or HTML.

## Examples

### Example 1: A complete script with sections  ([`example_1.m`](example_1.m))

```matlab
%% Section 1: inputs
clc; clear;
L = 0.5;          % inductance in henry
C = 20e-6;        % capacitance in farad
R = 10;           % resistance in ohm

%% Section 2: resonance of a series RLC circuit
f0 = 1 / (2 * pi * sqrt(L * C));       % resonant frequency
Q  = (1 / R) * sqrt(L / C);            % quality factor
BW = f0 / Q;                           % bandwidth

%% Section 3: results
fprintf('Resonant frequency f0 = %.2f Hz\n', f0);
fprintf('Quality factor     Q  = %.2f\n', Q);
fprintf('Bandwidth          BW = %.2f Hz\n', BW);
```

### Example 2: Block comments and the folder commands  ([`example_2.m`](example_2.m))

```matlab
%{
This is a block comment.
Everything between the two markers is ignored,
handy for a description at the top of a script.
%}
current_folder = pwd             % where am I?
files = dir('*.m');              % list the .m files here
fprintf('There are %d .m files in this folder\n', numel(files));
which sqrt                       % sqrt is a built-in function
```

### Example 3: A script that calls another script  ([`example_3.m`](example_3.m))

```matlab
% helper_constants.m is a script file in this same folder.
% Running it creates its variables in the workspace, as if typed here.
helper_constants
fprintf('Speed of light: %g m/s\n', c0);
fprintf('Charge of an electron: %g C\n', q_e);
wavelength = c0 / 50e6;          % wavelength of a 50 MHz signal
fprintf('Wavelength at 50 MHz: %.2f m\n', wavelength);
```

### The helper script used above  ([`helper_constants.m`](helper_constants.m))

```matlab
% A script that only defines constants. Other scripts can run it.
c0  = 299792458;        % speed of light, m/s
q_e = 1.602176634e-19;  % electron charge, C
mu0 = 4 * pi * 1e-7;    % permeability of free space, H/m
eps0 = 8.854e-12;       % permittivity of free space, F/m
```

## Practice

1. Write a script `ohms_law.m` that calculates current and power for V = 12 V and R = 220 Ω.
2. Split it into three sections with `%%` and run each section separately.
3. Save a script as `1test.m`. What happens when you try to run it? Why?
4. Create a Live Script with a title, one equation, some code and its output. Export it to PDF.

---

[⬅ Day 005](../Day-005-Managing-Variables-who-whos-clear-clc-and-the-Workspace/README.md) · [🏠 Home](../README.md) · [Day 007 ➡](../Day-007-Getting-Help-Reading-Errors-and-MATLAB-Applications/README.md)
