% Day 041 · Relational and Logical Operators — AND, OR, NOT and the "between" trap
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

x = 10;
wrong = 3 < x < 7                  % (3 < 10) = 1, then 1 < 7 = 1 -> wrong!
right = x > 3 & x < 7              % 0, correct
~(x > 5)
xor(true, true)
temps = [12 18 25 31 38 42];
comfortable = temps(temps >= 18 & temps <= 30)
extreme = temps(temps < 15 | temps > 40)
