% Day 004 · Variables: Assignment, Naming Rules and Predefined Variables — Valid names, case sensitivity and keywords
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

Volt = 230; volt = 110;
disp([Volt volt])            % two different variables
motor_speed_rpm = 1440;
R2 = 4.7e3;
iskeyword('for')             % 1 = true, 'for' is reserved
isvarname('2ndValue')        % 0 = false, cannot start with a digit
isvarname('value_2')         % 1 = true
% Shadowing a function by mistake:
sum = 10;                    % now 'sum' is a variable...
clear sum                    % ...clear it so sum() works again
sum([1 2 3])
