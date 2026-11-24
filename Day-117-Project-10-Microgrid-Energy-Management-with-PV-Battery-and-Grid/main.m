% Day 117 · Project 10: Microgrid Energy Management with PV, Battery and Grid — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear; close all;
h = 0:23;
load_kW = 30 + 15*exp(-(h - 9).^2/6) + 35*exp(-(h - 20).^2/5);
pv_kW = max(0, 60*sin(pi*(h - 6)/13)); pv_kW(h < 6 | h > 19) = 0;
price = 5*ones(1, 24); price(h >= 6 & h < 17) = 7; price(h >= 17 & h < 23) = 11;   % Rs/kWh import
feed_in = 3;                                                                      % Rs/kWh export
bat = struct('E', 120, 'Pmax', 40, 'soc0', 0.5, 'smin', 0.15, 'smax', 0.95, 'eta', 0.95);
strategies = {'no battery', 'self-consumption', 'price-aware'};
fprintf('%-18s %10s %10s %9s %9s %8s %12s\n', 'Strategy', 'Import kWh', 'Export kWh', 'Cost Rs', 'Batt kWh', 'SOC end', 'Fair cost Rs');
for s = 1:3
    r = simulate(strategies{s}, load_kW, pv_kW, price, bat);
    cost = sum(r.grid_in .* price) - feed_in*sum(r.grid_out);
    balance = pv_kW + r.grid_in + r.bat_dis - load_kW - r.grid_out - r.bat_ch;
    assert(max(abs(balance)) < 1e-9, 'energy balance violated');
    fair = cost - (r.soc(end) - bat.soc0) * bat.E * min(price);   % value the change of stored energy at the night price
    fprintf('%-18s %10.1f %10.1f %9.0f %9.1f %8.2f %12.0f\n', strategies{s}, sum(r.grid_in), sum(r.grid_out), cost, sum(r.bat_dis), r.soc(end), fair);
    results(s) = r; %#ok<SAGROW>
end
r = results(3);
subplot(3, 1, 1); plot(h, load_kW, 'k', h, pv_kW, 'Color', [1 0.6 0], 'LineWidth', 1.5); grid on
legend('load', 'PV'); ylabel('kW'); title('Microgrid, price-aware EMS')
subplot(3, 1, 2); bar(h, [r.grid_in' -r.grid_out' r.bat_dis' -r.bat_ch'], 'stacked'); grid on
legend('import', 'export', 'battery out', 'battery in', 'Location', 'eastoutside'); ylabel('kW')
subplot(3, 1, 3); stairs(h, r.soc(1:24)*100, 'LineWidth', 1.5); hold on
stairs(h, price*8, 'r--'); hold off; grid on; ylabel('SOC % / price x8'); xlabel('Hour')

function r = simulate(strategy, load_kW, pv_kW, price, b)
    n = numel(load_kW);
    r.grid_in = zeros(1, n); r.grid_out = zeros(1, n); r.bat_ch = zeros(1, n); r.bat_dis = zeros(1, n);
    soc = b.soc0; r.soc = zeros(1, n + 1); r.soc(1) = soc;
    cheap = price <= min(price);
    for k = 1:n
        net = pv_kW(k) - load_kW(k);                  % + surplus, - deficit
        room = (b.smax - soc) * b.E / b.eta;          % kWh that can be put in (1 h steps)
        avail = (soc - b.smin) * b.E * b.eta;         % kWh that can be taken out
        ch = 0; dis = 0;
        if ~strcmp(strategy, 'no battery')
            if net > 0
                ch = min([net, b.Pmax, room]);        % store the PV surplus
            elseif strcmp(strategy, 'price-aware') && cheap(k)
                ch = min(b.Pmax, room);               % cheap hours: charge from the grid, keep the battery
            else
                dis = min([-net, b.Pmax, avail]);     % cover the deficit from the battery
            end
        end
        soc = soc + (ch*b.eta - dis/b.eta) / b.E;
        flow = net - ch + dis;                         % what the grid must absorb (+) or supply (-)
        r.grid_out(k) = max(flow, 0);  r.grid_in(k) = max(-flow, 0);
        r.bat_ch(k) = ch;  r.bat_dis(k) = dis;  r.soc(k + 1) = soc;
    end
end
