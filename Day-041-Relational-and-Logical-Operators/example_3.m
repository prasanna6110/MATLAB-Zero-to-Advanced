% Day 041 · Relational and Logical Operators — Short-circuit operators and floating-point comparison
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

v = [];
if ~isempty(v) && v(1) > 0         % && stops before v(1), so no error
    disp('positive first element')
else
    disp('empty or not positive')
end
a = 0.1 + 0.2;
a == 0.3                           % 0 because of rounding
abs(a - 0.3) < 1e-12               % 1, compare with a tolerance
fprintf('%.20f\n', a);
