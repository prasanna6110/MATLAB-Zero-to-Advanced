% Day 005 · Managing Variables: who, whos, clear, clc and the Workspace — clear, exist and clearvars
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

a = 1; b = 2; c = 3;
exist('b')                 % 1 -> b is a variable
clear b
exist('b')                 % 0 -> gone
clearvars -except c        % remove everything except c
who
exist('sin')               % 2 or 5 -> sin is a function
