% Day 093 · Model-Based Design: Subsystems, Transfer Functions and MATLAB Function Blocks — What a MATLAB Function block contains
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% A MATLAB Function block holds a function like this one. Simulink calls it at every
% time step with the block's input signals and uses the returned values as outputs.
% Here it is tested as an ordinary function on some sample inputs.
p_load = 4.0;                       % kW
p_pv = [1.0 2.5 6.0 6.0 9.0];       % kW of solar at five moments
soc  = [10  50  50  95  40];        % % state of charge at those moments
for k = 1:numel(soc)
    [p_bat, mode] = battery_logic(p_load, p_pv(k), soc(k));
    fprintf('PV %.1f kW, SOC %3d %%: battery power %+5.2f kW (%s)\n', p_pv(k), soc(k), p_bat, mode);
end

function [p_bat, mode] = battery_logic(p_load, p_pv, soc)
% Inputs: load power, PV power (kW) and state of charge (%). Output: battery power (+ = discharge)
    p_net = p_load - p_pv;
    if p_net > 0 && soc > 20
        p_bat = min(p_net, 3);  mode = 'discharging';
    elseif p_net < 0 && soc < 90
        p_bat = max(p_net, -3); mode = 'charging';
    else
        p_bat = 0;              mode = 'idle';
    end
end
