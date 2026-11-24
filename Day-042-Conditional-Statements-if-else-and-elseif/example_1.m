% Day 042 · Conditional Statements: if, else and elseif — if-else: pass or fail
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

marks = 37;
if marks >= 40
    fprintf('Pass with %d marks\n', marks);
else
    fprintf('Fail: %d more marks needed\n', 40 - marks);
end
