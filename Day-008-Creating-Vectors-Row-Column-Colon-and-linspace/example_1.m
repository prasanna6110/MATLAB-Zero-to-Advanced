% Day 008 · Creating Vectors: Row, Column, Colon and linspace — Different ways to make a vector
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

years = [2019 2020 2021 2022 2023]      % row vector, typed in
load_MW = [210; 235; 228; 260]          % column vector, semicolons
x = 1:6                                 % step 1
t = 0:0.25:1                            % step 0.25
down = 20:-5:0                          % negative step
odd = 1:2:12                            % stops at 11, never passes 12
empty = 5:1                             % empty 1x0 vector
size(empty)
