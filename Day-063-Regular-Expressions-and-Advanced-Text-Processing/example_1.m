% Day 063 · Regular Expressions and Advanced Text Processing — Extracting numbers and words
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

txt = 'Bus 7: V = 0.982 pu, angle -3.45 deg, load 120.5 MW';
nums = regexp(txt, '-?\d+\.?\d*', 'match')
values = str2double(nums)
words = regexp(txt, '[A-Za-z]+', 'match')
parts = regexp(txt, ',\s*', 'split')
first_number = regexp(txt, '\d+', 'match', 'once')
