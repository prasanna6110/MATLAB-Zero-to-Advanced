% Day 029 · The save and load Commands — Saving and loading a MAT-file
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

clear
V = 230; I = [1.2 3.4 5.6]; site = 'Substation-A';
save('session1.mat');                 % everything
save('only_I.mat', 'I');              % one variable
clear
whos
load('session1.mat');
fprintf('Loaded V = %d and site = %s\n', V, site);
S = load('only_I.mat')                % into a structure
delete('session1.mat'); delete('only_I.mat');   % tidy up
