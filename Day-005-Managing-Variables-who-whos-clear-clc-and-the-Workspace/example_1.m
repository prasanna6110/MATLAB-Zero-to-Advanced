% Day 005 · Managing Variables: who, whos, clear, clc and the Workspace — who and whos
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

clear                      % start with an empty workspace
voltage = 230;
current = [1.2 3.4 5.6];
name = 'Transformer-1';
M = magic(4);
who                        % just the names
whos                       % names, size, bytes, class
