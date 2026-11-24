% Day 051 · Input and Output Arguments: nargin, nargout, Defaults and varargin — Calling bmi_calc in different ways
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

b = bmi_calc(68, 1.72)
[b, cat] = bmi_calc(68, 1.72)
[b2, cat2] = bmi_calc(160, 66, 'imperial')
try
    bmi_calc(70)
catch ME
    disp(ME.message)
end
