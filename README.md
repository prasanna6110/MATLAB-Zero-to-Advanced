# 🧮 MATLAB: Zero to Advanced (Day-wise)

A complete **day-by-day** MATLAB course for students and engineers. You start with the **Command Window and simple arithmetic**, then learn arrays, plotting, programming, functions, polynomials and curve fitting, numerical methods, 3-D plots, **Symbolic Math** and **Simulink**, and finally move on to signal processing, control systems, image processing, machine learning, OOP and GUIs. The course ends with **30 complete projects**, many of them from electrical and power engineering.

**137 days · 361 code files · 30 projects**

Every day folder has:

- 📖 **`README.md`**: easy notes (the idea, the syntax, tables of commands, common mistakes)
- 💻 **`example_1.m`, `example_2.m`, `example_3.m`**: runnable MATLAB code with comments explaining every line
- 🏋️ **Practice**: exercises to test yourself
- ⬅ ➡ links to the previous and next day

## 🗺️ How to follow this course

1. Get MATLAB: use your college's **Campus-Wide licence**, **MATLAB Online** (in the browser), or the free **GNU Octave**.
2. Download the course:
   ```bash
   git clone https://github.com/prasanna6110/MATLAB-Zero-to-Advanced.git
   ```
   (or click **Code → Download ZIP** on GitHub).
3. Start at **[Day 001](Day-001-What-is-MATLAB-Installation-and-the-MATLAB-Desktop/README.md)** and go in order.
4. Every day: **read** the notes → set that day's folder as MATLAB's **Current Folder** → open `example_1.m` and press **Run** → **change the numbers** and watch what happens → **do** the practice questions.
5. Toolboxes: a few days use the Symbolic Math, Signal Processing, Control System, Statistics and Machine Learning, or Optimization toolboxes, plus Simulink. Those examples say so in a `% Needs:` comment at the top. Most campus licences include all of them.

### ✅ Tested code
Every example was run automatically in **GNU Octave** (with the `symbolic`, `signal`, `control`, `statistics` and `optim` packages). A few examples use features that only exist in MATLAB (tables, string arrays, `datetime`, Simulink, App Designer, some toolbox functions). They are marked with `% MATLAB-ONLY` on their first line.

## 🎯 Phases

| Phase | What you learn |
|-------|----------------|
| **Getting Started** | Installation, the desktop, Command Window, arithmetic, display formats, math functions, variables, scripts, help and errors |
| **Creating Arrays** | Vectors, matrices, transpose, indexing with the colon and `end`, adding and deleting elements, array functions, logical indexing, text |
| **Mathematics with Arrays** | Matrix vs element-wise operations, solving linear equations, built-in analysis functions, random numbers, linear algebra |
| **Scripts and Data** | Workspace, `input`, `disp`, `fprintf`, `save`/`load`, reading and writing CSV, Excel and text files |
| **2-D Plots** | `plot`, `fplot`, multiple graphs, formatting, log axes, error bars, bar/stem/stairs/pie, histograms, polar plots, subplots |
| **Programming** | Relational and logical operators, `if`, `switch`, `for`, `while`, nesting, `break`/`continue`, vectorisation, error handling |
| **Functions** | Function files, inputs/outputs, local/global/persistent variables, anonymous functions, function handles, subfunctions, nested functions, recursion |
| **Data Types** | Cell arrays, structures, tables, numeric types, date and time, text processing, maps |
| **Polynomials, Curve Fitting and Interpolation** | `polyval`, `roots`, `conv`, `polyder`, `polyfit`, fitting other functions, `interp1`, splines |
| **Numerical Analysis** | `fzero`, `fminbnd`, `fminsearch`, `integral`, `trapz`, `ode45`, systems of ODEs, `fsolve`, numerical derivatives |
| **3-D Plots** | `plot3`, `meshgrid`, `mesh`, `surf`, contours, special 3-D plots, `view`, colormaps, animation |
| **Symbolic Math** | `syms`, simplifying, solving equations, derivatives, integrals, limits, series, `dsolve`, Laplace transforms |
| **Simulink** | The Simulink environment, building and simulating models, subsystems, model-based design, hardware support |
| **Advanced MATLAB & Toolboxes** | FFT, filters, control systems, image processing, statistics, machine learning, OOP with `classdef`, GUIs, performance, debugging and testing |
| **Projects** | 30 projects: circuit solvers, power-system studies, solar PV, microgrid dispatch, signal analysis, control, numerical simulations, ML from scratch and more |

## 👤 Author

**Prasanna Kumar Pandey**, NIT Kurukshetra · GitHub: [@prasanna6110](https://github.com/prasanna6110)

Also by the author: [Python-Zero-to-Ultra-Advanced](https://github.com/prasanna6110/Python-Zero-to-Ultra-Advanced) · [Machine-Learning-Zero-to-Advanced](https://github.com/prasanna6110/Machine-Learning-Zero-to-Advanced)

If this course helps you, please ⭐ star the repo and share it!

# 📅 Day-wise Contents

## Getting Started (Day 1 – Day 7)

_Installing MATLAB, the desktop, the Command Window, arithmetic, variables and your first script files._

| Day | Topic | Files |
|-----|-------|-------|
| 001 | [What is MATLAB? Installation and the MATLAB Desktop](Day-001-What-is-MATLAB-Installation-and-the-MATLAB-Desktop/README.md) | 3 |
| 002 | [Working in the Command Window and Arithmetic with Scalars](Day-002-Working-in-the-Command-Window-and-Arithmetic-with-Scalars/README.md) | 3 |
| 003 | [Display Formats and Elementary Math Built-in Functions](Day-003-Display-Formats-and-Elementary-Math-Built-in-Functions/README.md) | 3 |
| 004 | [Variables: Assignment, Naming Rules and Predefined Variables](Day-004-Variables-Assignment-Naming-Rules-and-Predefined-Variables/README.md) | 3 |
| 005 | [Managing Variables: who, whos, clear, clc and the Workspace](Day-005-Managing-Variables-who-whos-clear-clc-and-the-Workspace/README.md) | 3 |
| 006 | [Script Files, Sections and the Current Folder](Day-006-Script-Files-Sections-and-the-Current-Folder/README.md) | 4 |
| 007 | [Getting Help, Reading Errors and MATLAB Applications](Day-007-Getting-Help-Reading-Errors-and-MATLAB-Applications/README.md) | 3 |

## Creating Arrays (Day 8 – Day 16)

_Vectors and matrices, transpose, indexing with the colon and end, adding and deleting elements, array functions, logical indexing and text._

| Day | Topic | Files |
|-----|-------|-------|
| 008 | [Creating Vectors: Row, Column, Colon and linspace](Day-008-Creating-Vectors-Row-Column-Colon-and-linspace/README.md) | 3 |
| 009 | [Creating Matrices: zeros, ones, eye, rand, magic and Concatenation](Day-009-Creating-Matrices-zeros-ones-eye-rand-magic-and-Concatenation/README.md) | 3 |
| 010 | [The Transpose Operator and Array Addressing](Day-010-The-Transpose-Operator-and-Array-Addressing/README.md) | 3 |
| 011 | [Using the Colon in Addressing Arrays and the end Keyword](Day-011-Using-the-Colon-in-Addressing-Arrays-and-the-end-Keyword/README.md) | 3 |
| 012 | [Adding Elements, Deleting Elements and Reshaping Arrays](Day-012-Adding-Elements-Deleting-Elements-and-Reshaping-Arrays/README.md) | 3 |
| 013 | [Built-in Functions for Handling Arrays](Day-013-Built-in-Functions-for-Handling-Arrays/README.md) | 3 |
| 014 | [Logical Indexing: Selecting Data with Conditions](Day-014-Logical-Indexing-Selecting-Data-with-Conditions/README.md) | 3 |
| 015 | [Text in MATLAB: Character Arrays](Day-015-Text-in-MATLAB-Character-Arrays/README.md) | 3 |
| 016 | [String Arrays and Converting Between Numbers and Text](Day-016-String-Arrays-and-Converting-Between-Numbers-and-Text/README.md) | 3 |

## Mathematics with Arrays (Day 17 – Day 25)

_Matrix vs element-wise operations, solving linear systems, built-in analysis functions, random numbers, linear algebra and complex numbers._

| Day | Topic | Files |
|-----|-------|-------|
| 017 | [Addition, Subtraction and Operations with Scalars](Day-017-Addition-Subtraction-and-Operations-with-Scalars/README.md) | 3 |
| 018 | [Matrix Multiplication and the Dot Product](Day-018-Matrix-Multiplication-and-the-Dot-Product/README.md) | 3 |
| 019 | [Array Division: Inverse, Determinant and Solving Linear Equations](Day-019-Array-Division-Inverse-Determinant-and-Solving-Linear-Equations/README.md) | 3 |
| 020 | [Element-by-Element Operations](Day-020-Element-by-Element-Operations/README.md) | 3 |
| 021 | [Using Arrays in Built-in Math Functions (Vectorisation)](Day-021-Using-Arrays-in-Built-in-Math-Functions-Vectorisation/README.md) | 3 |
| 022 | [Built-in Functions for Analyzing Arrays (Statistics)](Day-022-Built-in-Functions-for-Analyzing-Arrays-Statistics/README.md) | 3 |
| 023 | [Generation of Random Numbers](Day-023-Generation-of-Random-Numbers/README.md) | 3 |
| 024 | [Linear Algebra: rank, norm, eig, lu, qr and svd](Day-024-Linear-Algebra-rank-norm-eig-lu-qr-and-svd/README.md) | 3 |
| 025 | [Complex Numbers and Phasors](Day-025-Complex-Numbers-and-Phasors/README.md) | 3 |

## Scripts and Data (Day 26 – Day 31)

_The workspace, input from the user, disp and fprintf output, save/load, and reading and writing CSV, Excel and text files._

| Day | Topic | Files |
|-----|-------|-------|
| 026 | [The Workspace and Input to a Script File](Day-026-The-Workspace-and-Input-to-a-Script-File/README.md) | 3 |
| 027 | [Output Commands: disp and fprintf](Day-027-Output-Commands-disp-and-fprintf/README.md) | 3 |
| 028 | [Building Text with sprintf, num2str and Formatted Tables](Day-028-Building-Text-with-sprintf-num2str-and-Formatted-Tables/README.md) | 3 |
| 029 | [The save and load Commands](Day-029-The-save-and-load-Commands/README.md) | 3 |
| 030 | [Importing and Exporting Data: CSV, Text and Excel Files](Day-030-Importing-and-Exporting-Data-CSV-Text-and-Excel-Files/README.md) | 3 |
| 031 | [Low-level File I/O: fopen, fprintf, fgetl, fscanf, textscan](Day-031-Low-level-File-I-O-fopen-fprintf-fgetl-fscanf-textscan/README.md) | 3 |

## Two-Dimensional Plots (Day 32 – Day 40)

_plot and fplot, several graphs in one plot, formatting, log axes, error bars, special graphics, histograms, polar plots and subplots._

| Day | Topic | Files |
|-----|-------|-------|
| 032 | [The plot Command and Line Specifiers](Day-032-The-plot-Command-and-Line-Specifiers/README.md) | 3 |
| 033 | [The fplot Command](Day-033-The-fplot-Command/README.md) | 3 |
| 034 | [Plotting Multiple Graphs: plot with Several Pairs, hold, and line](Day-034-Plotting-Multiple-Graphs-plot-with-Several-Pairs-hold-and-line/README.md) | 3 |
| 035 | [Formatting a Plot: Labels, Title, Text, Legend, Axis and Grid](Day-035-Formatting-a-Plot-Labels-Title-Text-Legend-Axis-and-Grid/README.md) | 3 |
| 036 | [Plots with Logarithmic Axes and Error Bars](Day-036-Plots-with-Logarithmic-Axes-and-Error-Bars/README.md) | 3 |
| 037 | [Plots with Special Graphics: bar, stairs, stem, pie, area](Day-037-Plots-with-Special-Graphics-bar-stairs-stem-pie-area/README.md) | 3 |
| 038 | [Histograms](Day-038-Histograms/README.md) | 3 |
| 039 | [Polar Plots](Day-039-Polar-Plots/README.md) | 3 |
| 040 | [Multiple Plots on a Page, Multiple Figures and Saving Figures](Day-040-Multiple-Plots-on-a-Page-Multiple-Figures-and-Saving-Figures/README.md) | 3 |

## Programming in MATLAB (Day 41 – Day 49)

_Relational and logical operators, if/elseif/else, switch-case, for and while loops, nesting, break and continue, preallocation and error handling._

| Day | Topic | Files |
|-----|-------|-------|
| 041 | [Relational and Logical Operators](Day-041-Relational-and-Logical-Operators/README.md) | 3 |
| 042 | [Conditional Statements: if, else and elseif](Day-042-Conditional-Statements-if-else-and-elseif/README.md) | 3 |
| 043 | [The switch-case Statement](Day-043-The-switch-case-Statement/README.md) | 3 |
| 044 | [for Loops](Day-044-for-Loops/README.md) | 3 |
| 045 | [while Loops](Day-045-while-Loops/README.md) | 3 |
| 046 | [Nested Loops and Nested Conditional Statements](Day-046-Nested-Loops-and-Nested-Conditional-Statements/README.md) | 3 |
| 047 | [The break and continue Commands](Day-047-The-break-and-continue-Commands/README.md) | 3 |
| 048 | [Preallocation, Vectorisation and Timing Code](Day-048-Preallocation-Vectorisation-and-Timing-Code/README.md) | 3 |
| 049 | [Error Handling: try/catch, error, warning and assert](Day-049-Error-Handling-try-catch-error-warning-and-assert/README.md) | 3 |

## User-Defined Functions (Day 50 – Day 57)

_Function files, inputs and outputs, local/global/persistent variables, scripts vs functions, anonymous functions, function handles, subfunctions, nested functions and recursion._

| Day | Topic | Files |
|-----|-------|-------|
| 050 | [Creating a Function File and Its Structure](Day-050-Creating-a-Function-File-and-Its-Structure/README.md) | 4 |
| 051 | [Input and Output Arguments: nargin, nargout, Defaults and varargin](Day-051-Input-and-Output-Arguments-nargin-nargout-Defaults-and-varargin/README.md) | 4 |
| 052 | [Local, Global and Persistent Variables](Day-052-Local-Global-and-Persistent-Variables/README.md) | 5 |
| 053 | [Scripts vs Functions, and Local Functions in Scripts](Day-053-Scripts-vs-Functions-and-Local-Functions-in-Scripts/README.md) | 3 |
| 054 | [Anonymous Functions](Day-054-Anonymous-Functions/README.md) | 3 |
| 055 | [Function Handles and Function Functions (feval)](Day-055-Function-Handles-and-Function-Functions-feval/README.md) | 3 |
| 056 | [Subfunctions and Nested Functions](Day-056-Subfunctions-and-Nested-Functions/README.md) | 3 |
| 057 | [Recursion](Day-057-Recursion/README.md) | 3 |

## Data Types (Day 58 – Day 64)

_Cell arrays, structures, tables, numeric types and conversions, dates and times, regular expressions, sets and key-value maps._

| Day | Topic | Files |
|-----|-------|-------|
| 058 | [Cell Arrays](Day-058-Cell-Arrays/README.md) | 3 |
| 059 | [Structures](Day-059-Structures/README.md) | 3 |
| 060 | [Tables](Day-060-Tables/README.md) | 3 |
| 061 | [Numeric Types, Logical Type and Type Conversion](Day-061-Numeric-Types-Logical-Type-and-Type-Conversion/README.md) | 3 |
| 062 | [Date and Time](Day-062-Date-and-Time/README.md) | 3 |
| 063 | [Regular Expressions and Advanced Text Processing](Day-063-Regular-Expressions-and-Advanced-Text-Processing/README.md) | 3 |
| 064 | [Set Operations and Key-Value Maps](Day-064-Set-Operations-and-Key-Value-Maps/README.md) | 3 |

## Polynomials, Curve Fitting and Interpolation (Day 65 – Day 70)

_Polynomial values and roots, polynomial arithmetic and derivatives, polyfit, fitting other functions, interpolation and nonlinear fits._

| Day | Topic | Files |
|-----|-------|-------|
| 065 | [Polynomials: polyval, roots and poly](Day-065-Polynomials-polyval-roots-and-poly/README.md) | 3 |
| 066 | [Polynomial Arithmetic: conv, deconv, polyder, polyint and residue](Day-066-Polynomial-Arithmetic-conv-deconv-polyder-polyint-and-residue/README.md) | 3 |
| 067 | [Curve Fitting with Polynomials: polyfit](Day-067-Curve-Fitting-with-Polynomials-polyfit/README.md) | 3 |
| 068 | [Curve Fitting with Functions Other than Polynomials](Day-068-Curve-Fitting-with-Functions-Other-than-Polynomials/README.md) | 3 |
| 069 | [Interpolation: interp1, spline and interp2](Day-069-Interpolation-interp1-spline-and-interp2/README.md) | 3 |
| 070 | [The Basic Fitting Interface and Nonlinear Least-Squares Fits](Day-070-The-Basic-Fitting-Interface-and-Nonlinear-Least-Squares-Fits/README.md) | 3 |

## Numerical Analysis (Day 71 – Day 77)

_Solving equations with fzero and fsolve, finding minima, numerical integration, ordinary differential equations with ode45, and numerical derivatives._

| Day | Topic | Files |
|-----|-------|-------|
| 071 | [Solving an Equation with One Variable: fzero](Day-071-Solving-an-Equation-with-One-Variable-fzero/README.md) | 3 |
| 072 | [Finding a Minimum or a Maximum: fminbnd and fminsearch](Day-072-Finding-a-Minimum-or-a-Maximum-fminbnd-and-fminsearch/README.md) | 3 |
| 073 | [Numerical Integration: integral, trapz and cumtrapz](Day-073-Numerical-Integration-integral-trapz-and-cumtrapz/README.md) | 3 |
| 074 | [Ordinary Differential Equations: ode45](Day-074-Ordinary-Differential-Equations-ode45/README.md) | 3 |
| 075 | [Systems of ODEs and Higher-Order ODEs](Day-075-Systems-of-ODEs-and-Higher-Order-ODEs/README.md) | 3 |
| 076 | [Systems of Nonlinear Equations: fsolve and Newton-Raphson](Day-076-Systems-of-Nonlinear-Equations-fsolve-and-Newton-Raphson/README.md) | 3 |
| 077 | [Numerical Differentiation and Finite Differences](Day-077-Numerical-Differentiation-and-Finite-Differences/README.md) | 3 |

## Three-Dimensional Plots (Day 78 – Day 82)

_3-D line plots, meshgrid, mesh and surface plots, contours and special 3-D graphics, view, colormaps and lighting, and animation._

| Day | Topic | Files |
|-----|-------|-------|
| 078 | [Three-Dimensional Line Plots: plot3](Day-078-Three-Dimensional-Line-Plots-plot3/README.md) | 3 |
| 079 | [Mesh and Surface Plots: meshgrid, mesh and surf](Day-079-Mesh-and-Surface-Plots-meshgrid-mesh-and-surf/README.md) | 3 |
| 080 | [Contour Plots and Special 3-D Graphics](Day-080-Contour-Plots-and-Special-3-D-Graphics/README.md) | 3 |
| 081 | [The view Command, Colormaps, Shading and Lighting](Day-081-The-view-Command-Colormaps-Shading-and-Lighting/README.md) | 3 |
| 082 | [Animation in MATLAB](Day-082-Animation-in-MATLAB/README.md) | 3 |

## Symbolic Math (Day 83 – Day 90)

_Exact maths with the Symbolic Math Toolbox: symbolic variables, simplifying, solving equations, derivatives, limits, series, integrals, differential equations, Laplace transforms and turning results into numbers._

| Day | Topic | Files |
|-----|-------|-------|
| 083 | [Symbolic Objects and Symbolic Expressions](Day-083-Symbolic-Objects-and-Symbolic-Expressions/README.md) | 3 |
| 084 | [Changing the Form of an Expression: expand, factor, collect, simplify, pretty](Day-084-Changing-the-Form-of-an-Expression-expand-factor-collect-simplify-pretty/README.md) | 3 |
| 085 | [Solving Algebraic Equations: solve](Day-085-Solving-Algebraic-Equations-solve/README.md) | 3 |
| 086 | [Differentiation, Partial Derivatives, Limits and Taylor Series](Day-086-Differentiation-Partial-Derivatives-Limits-and-Taylor-Series/README.md) | 3 |
| 087 | [Symbolic Integration: int](Day-087-Symbolic-Integration-int/README.md) | 3 |
| 088 | [Solving Ordinary Differential Equations Symbolically: dsolve](Day-088-Solving-Ordinary-Differential-Equations-Symbolically-dsolve/README.md) | 3 |
| 089 | [Plotting Symbolic Expressions and Numerical Calculations](Day-089-Plotting-Symbolic-Expressions-and-Numerical-Calculations/README.md) | 3 |
| 090 | [Laplace and Fourier Transforms](Day-090-Laplace-and-Fourier-Transforms/README.md) | 3 |

## Simulink (Day 91 – Day 95)

_Block-diagram modelling and simulation: the Simulink environment, building and running models, subsystems and model-based design, physical modelling with Simscape, hardware support and control-loop simulation._

| Day | Topic | Files |
|-----|-------|-------|
| 091 | [Introduction to Simulink and the Simulink Environment](Day-091-Introduction-to-Simulink-and-the-Simulink-Environment/README.md) | 2 |
| 092 | [Building and Running Your First Simulink Model](Day-092-Building-and-Running-Your-First-Simulink-Model/README.md) | 3 |
| 093 | [Model-Based Design: Subsystems, Transfer Functions and MATLAB Function Blocks](Day-093-Model-Based-Design-Subsystems-Transfer-Functions-and-MATLAB-Function-Blocks/README.md) | 3 |
| 094 | [Physical Modelling with Simscape and Simulink-Supported Hardware](Day-094-Physical-Modelling-with-Simscape-and-Simulink-Supported-Hardware/README.md) | 3 |
| 095 | [Simulink Examples: Feedback Control with a PID Controller](Day-095-Simulink-Examples-Feedback-Control-with-a-PID-Controller/README.md) | 3 |

## Advanced MATLAB and Toolboxes (Day 96 – Day 107)

_Signal processing, control systems, image processing, statistics, machine learning, object-oriented programming, GUIs, debugging, testing, performance and interview preparation._

| Day | Topic | Files |
|-----|-------|-------|
| 096 | [Signal Processing 1: Sampling, FFT and the Frequency Spectrum](Day-096-Signal-Processing-1-Sampling-FFT-and-the-Frequency-Spectrum/README.md) | 3 |
| 097 | [Signal Processing 2: Designing and Applying Filters](Day-097-Signal-Processing-2-Designing-and-Applying-Filters/README.md) | 3 |
| 098 | [Control Systems 1: Transfer Functions, Poles and Step Response](Day-098-Control-Systems-1-Transfer-Functions-Poles-and-Step-Response/README.md) | 3 |
| 099 | [Control Systems 2: Bode, Root Locus, Margins and PID Design](Day-099-Control-Systems-2-Bode-Root-Locus-Margins-and-PID-Design/README.md) | 3 |
| 100 | [Image Processing Basics: Images as Matrices](Day-100-Image-Processing-Basics-Images-as-Matrices/README.md) | 3 |
| 101 | [Statistics and Probability Distributions](Day-101-Statistics-and-Probability-Distributions/README.md) | 3 |
| 102 | [Machine Learning in MATLAB](Day-102-Machine-Learning-in-MATLAB/README.md) | 4 |
| 103 | [Object-Oriented Programming: classdef, Properties and Methods](Day-103-Object-Oriented-Programming-classdef-Properties-and-Methods/README.md) | 5 |
| 104 | [Building GUIs: App Designer and Programmatic Apps](Day-104-Building-GUIs-App-Designer-and-Programmatic-Apps/README.md) | 3 |
| 105 | [Debugging, the Code Analyzer and Unit Testing](Day-105-Debugging-the-Code-Analyzer-and-Unit-Testing/README.md) | 4 |
| 106 | [Performance, Parallel Computing and Good Coding Practice](Day-106-Performance-Parallel-Computing-and-Good-Coding-Practice/README.md) | 3 |
| 107 | [MATLAB with Python and Other Tools, Interview Questions and Common Mistakes](Day-107-MATLAB-with-Python-and-Other-Tools-Interview-Questions-and-Common-Mistakes/README.md) | 3 |

## Projects (Day 108 – Day 137)

_Complete programs that combine everything: menus, data handling, circuit and power-system analysis, renewable energy, control, signal and image processing, numerical simulation, machine learning, games and OOP._

| Day | Topic | Files |
|-----|-------|-------|
| 108 | [Project 1: Scientific Calculator with a Menu](Day-108-Project-1-Scientific-Calculator-with-a-Menu/README.md) | 1 |
| 109 | [Project 2: Student Result Management System](Day-109-Project-2-Student-Result-Management-System/README.md) | 1 |
| 110 | [Project 3: Smart Unit Converter](Day-110-Project-3-Smart-Unit-Converter/README.md) | 1 |
| 111 | [Project 4: Electricity Bill Generator with Slab and Time-of-Day Tariffs](Day-111-Project-4-Electricity-Bill-Generator-with-Slab-and-Time-of-Day-Tariffs/README.md) | 1 |
| 112 | [Project 5: DC Circuit Solver using Nodal Analysis](Day-112-Project-5-DC-Circuit-Solver-using-Nodal-Analysis/README.md) | 1 |
| 113 | [Project 6: AC Circuit Analyzer and Power Factor Correction](Day-113-Project-6-AC-Circuit-Analyzer-and-Power-Factor-Correction/README.md) | 1 |
| 114 | [Project 7: RLC Transient Analyzer](Day-114-Project-7-RLC-Transient-Analyzer/README.md) | 1 |
| 115 | [Project 8: Three-Phase System Analyzer](Day-115-Project-8-Three-Phase-System-Analyzer/README.md) | 1 |
| 116 | [Project 9: Solar PV Module: I-V and P-V Curves and MPPT](Day-116-Project-9-Solar-PV-Module-I-V-and-P-V-Curves-and-MPPT/README.md) | 1 |
| 117 | [Project 10: Microgrid Energy Management with PV, Battery and Grid](Day-117-Project-10-Microgrid-Energy-Management-with-PV-Battery-and-Grid/README.md) | 1 |
| 118 | [Project 11: Load Flow Analysis by the Gauss-Seidel Method](Day-118-Project-11-Load-Flow-Analysis-by-the-Gauss-Seidel-Method/README.md) | 1 |
| 119 | [Project 12: Economic Load Dispatch](Day-119-Project-12-Economic-Load-Dispatch/README.md) | 1 |
| 120 | [Project 13: Transmission Line Performance Calculator](Day-120-Project-13-Transmission-Line-Performance-Calculator/README.md) | 1 |
| 121 | [Project 14: DC Motor Speed Control with a PI Controller](Day-121-Project-14-DC-Motor-Speed-Control-with-a-PI-Controller/README.md) | 1 |
| 122 | [Project 15: Signal Analyzer and Noise Remover](Day-122-Project-15-Signal-Analyzer-and-Noise-Remover/README.md) | 1 |
| 123 | [Project 16: Image Analysis: Detecting and Counting Objects](Day-123-Project-16-Image-Analysis-Detecting-and-Counting-Objects/README.md) | 1 |
| 124 | [Project 17: Projectile Motion Simulator with Air Drag](Day-124-Project-17-Projectile-Motion-Simulator-with-Air-Drag/README.md) | 1 |
| 125 | [Project 18: Heat Conduction in a Plate (Finite Differences)](Day-125-Project-18-Heat-Conduction-in-a-Plate-Finite-Differences/README.md) | 1 |
| 126 | [Project 19: Epidemic Spread Model (SIR) with Vaccination](Day-126-Project-19-Epidemic-Spread-Model-SIR-with-Vaccination/README.md) | 1 |
| 127 | [Project 20: Experimental Data Analysis and Automatic Report](Day-127-Project-20-Experimental-Data-Analysis-and-Automatic-Report/README.md) | 1 |
| 128 | [Project 21: Numerical Methods Toolkit: Comparing Root-Finding Methods](Day-128-Project-21-Numerical-Methods-Toolkit-Comparing-Root-Finding-Methods/README.md) | 1 |
| 129 | [Project 22: Electricity Load Forecasting with Regression](Day-129-Project-22-Electricity-Load-Forecasting-with-Regression/README.md) | 1 |
| 130 | [Project 23: Transmission Line Fault Classification with k-NN](Day-130-Project-23-Transmission-Line-Fault-Classification-with-k-NN/README.md) | 1 |
| 131 | [Project 24: Tic-Tac-Toe with an Unbeatable Computer Player](Day-131-Project-24-Tic-Tac-Toe-with-an-Unbeatable-Computer-Player/README.md) | 1 |
| 132 | [Project 25: Library Management System with Object-Oriented Programming](Day-132-Project-25-Library-Management-System-with-Object-Oriented-Programming/README.md) | 3 |
| 133 | [Project 26: PID Controller Tuning by Optimisation](Day-133-Project-26-PID-Controller-Tuning-by-Optimisation/README.md) | 1 |
| 134 | [Project 27: Battery State-of-Charge Estimation with a Kalman Filter](Day-134-Project-27-Battery-State-of-Charge-Estimation-with-a-Kalman-Filter/README.md) | 1 |
| 135 | [Project 28: Hill Cipher Encryption with Matrices](Day-135-Project-28-Hill-Cipher-Encryption-with-Matrices/README.md) | 1 |
| 136 | [Project 29: Weather Data Dashboard](Day-136-Project-29-Weather-Data-Dashboard/README.md) | 1 |
| 137 | [Project 30: Sudoku Solver with Backtracking](Day-137-Project-30-Sudoku-Solver-with-Backtracking/README.md) | 1 |

---

Made with ❤️ by **Prasanna Kumar Pandey** · [github.com/prasanna6110](https://github.com/prasanna6110)
