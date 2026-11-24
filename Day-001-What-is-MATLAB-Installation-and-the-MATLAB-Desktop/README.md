# Day 001 · What is MATLAB? Installation and the MATLAB Desktop

_Getting Started_

## What is MATLAB?
**MATLAB = MATrix LABoratory.** It is a programming language *and* an environment for numerical computing. Its basic data type is the **matrix (array)**: even a single number like `5` is stored as a 1×1 matrix.

Engineers and scientists use it for:
- calculations and engineering maths (matrices, equations, calculus)
- data analysis, statistics and curve fitting
- plotting and visualisation (2-D and 3-D)
- simulation and modelling (differential equations, **Simulink**)
- signal processing, control systems, power systems, image processing, machine learning

## How to get MATLAB
| Option | Cost | Notes |
|--------|------|-------|
| **Campus-Wide licence** | free for students | most institutes (NITs, IITs) provide one. Log in with your college e-mail at mathworks.com |
| **MATLAB Online** | free with a licence | runs in the browser at matlab.mathworks.com; nothing to install |
| **MATLAB Student / Home** | paid | personal licence |
| **GNU Octave** | free and open source | a highly compatible alternative. Almost every example in this course also runs in Octave |

### Installation steps (desktop)
1. Create a MathWorks account with your college e-mail.
2. Download the installer and sign in.
3. Pick the products: **MATLAB**, **Simulink**, and (recommended for this course) **Symbolic Math**, **Signal Processing**, **Control System**, **Statistics and Machine Learning**, **Optimization** toolboxes.
4. Check the system requirements: a 64-bit OS (Windows 10/11, macOS, Linux), at least 8 GB RAM recommended, and about 4–30 GB of disk depending on the toolboxes.

## The MATLAB Desktop
| Window | What it does |
|--------|--------------|
| **Command Window** | type a command after the `>>` prompt and press Enter |
| **Workspace** | lists every variable in memory with its size and value |
| **Current Folder** | files in the folder MATLAB is working in |
| **Editor** | write, save and run script and function files (`.m`) |
| **Command History** | previously typed commands (press ↑ in the Command Window) |
| **Figure Window** | opens automatically for plots |
| **Help Browser** | documentation (`doc`) |

The **Toolstrip** at the top has tabs: **HOME** (new script, open, import data, preferences), **PLOTS**, **APPS**, and **EDITOR** (when a file is open).

## How to use this course
Every day has notes, 2–3 runnable examples (`example_1.m` …) and practice questions. Open the example in the Editor and press **Run**, or type its name (`example_1`) in the Command Window when that folder is the Current Folder. Type the code yourself before running it: that is how the syntax sticks.

## Examples

### Example 1: Your very first commands  ([`example_1.m`](example_1.m))

```matlab
% Type these in the Command Window one by one (or run this file)
disp('Hello, MATLAB!')      % disp shows text or a value
2 + 3                       % with no variable, the result goes into 'ans'
ans * 10                    % ans can be used in the next calculation
version                     % which version you are running
```

### Example 2: MATLAB as a smart calculator  ([`example_2.m`](example_2.m))

```matlab
% Power in a resistor: P = V^2 / R
V = 230;          % volts
R = 50;           % ohms
P = V^2 / R       % no semicolon -> MATLAB prints the result
I = V / R;        % semicolon -> the result is calculated but NOT printed
disp(I)
% Area and circumference of a circle
r = 3.5;
area = pi * r^2
circumference = 2 * pi * r
```

### Example 3: Everything is a matrix  ([`example_3.m`](example_3.m))

```matlab
a = 7;
size(a)            % 1 1 -> a single number is a 1x1 matrix
v = [1 2 3 4];
size(v)            % 1 4 -> a row vector
M = [1 2; 3 4; 5 6];
size(M)            % 3 2 -> 3 rows, 2 columns
class(a)           % 'double' -> the default number type
```

## Practice

1. Find out whether your college has a MATLAB Campus-Wide licence and activate it (or install GNU Octave).
2. Open MATLAB and identify the Command Window, Workspace, Current Folder and Editor.
3. Calculate the energy in kWh used by a 1.5 kW heater running for 3.5 hours.
4. What is the size of `[10 20 30; 40 50 60]`? Check with `size`.

---

[🏠 Home](../README.md) · [Day 002 ➡](../Day-002-Working-in-the-Command-Window-and-Arithmetic-with-Scalars/README.md)
