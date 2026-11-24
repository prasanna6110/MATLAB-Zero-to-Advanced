% Day 061 · Numeric Types, Logical Type and Type Conversion — Integer types: rounding and saturation
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

a = int8(2.7)
b = uint8(250) + 10           % saturates at 255
c = int8(-100) - 100          % saturates at -128
d = int32(7) / int32(2)       % 3.5 rounds to 4
e = idivide(int32(7), int32(2))   % 3 (fix division)
intmax('int16'), intmin('int16')
class(uint8(5) * 2.6)         % integer * double -> integer
uint8(5) * 2.6
