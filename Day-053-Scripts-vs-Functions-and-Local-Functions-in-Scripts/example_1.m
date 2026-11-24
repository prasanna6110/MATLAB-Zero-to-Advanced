% Day 053 · Scripts vs Functions, and Local Functions in Scripts — A script with local functions
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

temps_c = [-10 0 25 37 100];
temps_f = c_to_f(temps_c);
for k = 1:numel(temps_c)
    fprintf('%6.1f C = %6.1f F  (%s)\n', temps_c(k), temps_f(k), describe(temps_c(k)));
end

function f = c_to_f(c)
    f = c * 9/5 + 32;
end

function txt = describe(c)
    if c <= 0
        txt = 'freezing';
    elseif c < 30
        txt = 'pleasant';
    elseif c < 45
        txt = 'hot';
    else
        txt = 'boiling region';
    end
end
