% Day 007 · Getting Help, Reading Errors and MATLAB Applications — Application: the cost of running a pump
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% A 7.5 kW pump runs 6 h a day. Efficiency 88%. Tariff Rs 8.10 per kWh.
P_out = 7.5;                 % kW of mechanical output
eta = 0.88;
P_in = P_out / eta;          % electrical input
energy_month = P_in * 6 * 30;
bill = energy_month * 8.10;
fprintf('Input power        : %.2f kW\n', P_in);
fprintf('Energy per month   : %.1f kWh\n', energy_month);
fprintf('Monthly bill       : Rs %.0f\n', bill);
