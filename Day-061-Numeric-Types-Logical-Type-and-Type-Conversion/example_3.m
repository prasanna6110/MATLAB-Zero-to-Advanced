% Day 061 · Numeric Types, Logical Type and Type Conversion — Logical values and conversions
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

flags = logical([1 0 2 -3 0])        % any non-zero -> true
class(flags)
sum(flags)
v = 10:10:50;
v(flags)                             % logical indexing
n = double('A') + 1                  % char -> number
char(n)
k = cast(3.99, 'int16')
isa(k, 'integer'), isa(k, 'numeric'), isfloat(k)
bitand(uint8(12), uint8(10))         % bit operations on integers: 1100 & 1010 = 1000
dec2bin(bitshift(5, 2))              % 101 shifted left by 2 -> 10100
