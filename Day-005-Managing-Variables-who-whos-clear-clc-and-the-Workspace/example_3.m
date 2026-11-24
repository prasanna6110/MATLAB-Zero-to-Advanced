% Day 005 · Managing Variables: who, whos, clear, clc and the Workspace — A clean script template
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

clc; clear; close all;     % clean start
% ---- inputs ----
P_kW = 5.5;                % motor power
hours_per_day = 8;
days = 30;
tariff = 7.25;             % Rs per kWh
% ---- calculation ----
energy_kWh = P_kW * hours_per_day * days;
cost = energy_kWh * tariff;
% ---- output ----
fprintf('Energy used: %.1f kWh\n', energy_kWh);
fprintf('Monthly cost: Rs %.2f\n', cost);
whos energy_kWh cost
