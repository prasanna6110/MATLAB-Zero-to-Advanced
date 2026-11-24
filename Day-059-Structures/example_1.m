% Day 059 · Structures — Building and using a structure
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

bus.id = 3;
bus.name = 'Kurukshetra 220 kV';
bus.voltage_pu = 0.98;
bus.load = struct('P_MW', 120, 'Q_MVAr', 45);    % a structure inside a structure
bus
fprintf('%s carries %d MW at %.2f pu\n', bus.name, bus.load.P_MW, bus.voltage_pu);
fieldnames(bus)'
isfield(bus, 'generation')
bus = rmfield(bus, 'id');
f = 'voltage_pu';
bus.(f) = 1.01;                                   % dynamic field name
fprintf('New voltage: %.2f pu\n', bus.voltage_pu);
