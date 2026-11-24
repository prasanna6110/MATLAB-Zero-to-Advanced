% Day 045 · while Loops — Charging a battery until it is full
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

soc = 20;          % state of charge, %
capacity_kWh = 10;
P_charge = 2.2;    % kW
eff = 0.95;
hour = 0;
while soc < 100
    added = P_charge * eff / capacity_kWh * 100;   % % per hour
    soc = min(100, soc + added);
    hour = hour + 1;
    fprintf('Hour %d: SOC = %.1f %%\n', hour, soc);
end
