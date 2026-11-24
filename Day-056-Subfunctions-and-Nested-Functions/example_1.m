% Day 056 · Subfunctions and Nested Functions — Using subfunctions and nested functions
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

disp(motor_report(15, 415, 0.85, 0.9))
disp(motor_report(55, 415, 0.88, 0.93))
b = running_account(1000, [500 500 500], 0.1);
fprintf('Balance: %.2f\n', b);
try
    input_power(10, 0.9)        % a subfunction cannot be called from outside
catch ME
    disp('input_power is not visible outside motor_report.m')
end
