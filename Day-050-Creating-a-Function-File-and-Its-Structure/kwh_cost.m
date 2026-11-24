function cost = kwh_cost(power_W, hours, tariff)
% KWH_COST  Cost of running an appliance.
%   COST = KWH_COST(POWER_W, HOURS, TARIFF) gives the cost in rupees of a
%   load of POWER_W watts running for HOURS hours at TARIFF Rs/kWh.
energy_kWh = power_W .* hours / 1000;
cost = energy_kWh * tariff;
end

% (Course file for Day 050 · Creating a Function File and Its Structure)
