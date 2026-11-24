% Day 107 · MATLAB with Python and Other Tools, Interview Questions and Common Mistakes — Calling Python from MATLAB
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% MATLAB-ONLY: needs a supported Python installation (check with pyenv)
pe = pyenv;
fprintf('Using Python %s\n', pe.Version);
py.math.sqrt(16)
words = py.str('power system analysis').split();
n = int64(py.len(words))
x = pyrun("import statistics as s; m = s.mean([4, 8, 15, 16, 23, 42])", "m")
