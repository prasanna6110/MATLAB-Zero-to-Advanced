% Day 015 · Text in MATLAB: Character Arrays — Joining text and numbers
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

name = 'Motor-3';
speed = 1440;
msg = ['Speed of ' name ' is ' num2str(speed) ' rpm'];
disp(msg)
v = 230.456;
disp(['Voltage = ' num2str(v, 5) ' V'])      % 5 significant digits
rows = char('Monday', 'Tue', 'Wednesday')    % padded to equal length
size(rows)
