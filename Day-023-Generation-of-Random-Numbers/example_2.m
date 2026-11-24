% Day 023 · Generation of Random Numbers — Shuffling and sampling
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

rng(7);
students = 1:30;
order = randperm(30)                  % a shuffled presentation order
team_A = sort(order(1:15))
lucky_three = randperm(100, 3)        % 3 different numbers from 1..100
names = {'Asha', 'Ravi', 'Meena', 'Kabir', 'Ishaan'};
picked = names{randi(numel(names))}
