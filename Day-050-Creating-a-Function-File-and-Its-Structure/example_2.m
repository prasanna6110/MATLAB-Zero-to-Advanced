% Day 050 · Creating a Function File and Its Structure — Using kwh_cost for several appliances
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

names = {'Fan', 'LED TV', 'Fridge', 'AC'};
watts = [75 90 150 1500];
hours = [12 5 24 6];
monthly = kwh_cost(watts, hours * 30, 7.5);
for k = 1:numel(names)
    fprintf('%-7s Rs %8.2f per month\n', names{k}, monthly(k));
end
fprintf('Total   Rs %8.2f\n', sum(monthly));
