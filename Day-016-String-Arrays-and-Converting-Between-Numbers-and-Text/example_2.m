% Day 016 · String Arrays and Converting Between Numbers and Text — Number to text and back (works everywhere)
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

x = 1234.5678;
a = num2str(x)                    % default 4 decimals for big numbers
b = num2str(x, 8)                 % 8 significant digits
c = sprintf('%.1f', x)
d = mat2str([1.5 2; 3 4])         % a matrix as text you can paste back
v = str2double('42.75') * 2
bad = str2double('abc')           % NaN, not an error
e = str2num('[1 2 3] * 2')        % evaluates an expression
dec2bin(13)
bin2dec('1101')
dec2hex(255)
