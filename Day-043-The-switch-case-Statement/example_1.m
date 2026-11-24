% Day 043 · The switch-case Statement — A unit converter with text cases
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

value = 12;
unit = 'km';
switch lower(unit)
    case {'mm'}
        meters = value / 1000;
    case 'cm'
        meters = value / 100;
    case {'m', 'meter', 'metre'}
        meters = value;
    case 'km'
        meters = value * 1000;
    case {'in', 'inch'}
        meters = value * 0.0254;
    otherwise
        meters = NaN;
        disp('Unknown unit')
end
fprintf('%g %s = %g m\n', value, unit, meters);
