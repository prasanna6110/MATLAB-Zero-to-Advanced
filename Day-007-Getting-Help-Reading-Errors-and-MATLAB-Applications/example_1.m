% Day 007 · Getting Help, Reading Errors and MATLAB Applications — Catching and reading common errors
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% try/catch lets a script continue after an error (covered fully later)
try
    v = [1 2 3];
    v(5)                         % index too large
catch err
    disp(['Caught: ' err.message])
end
try
    a = [1 2 3]; b = [4 5 6];
    a * b                        % matrix multiplication needs inner dims to match
catch err
    disp(['Caught: ' err.message])
end
try
    a .* b                       % element-wise multiplication works
catch err
    disp(err.message)
end
