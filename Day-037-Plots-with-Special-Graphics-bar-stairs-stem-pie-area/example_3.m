% Day 037 · Plots with Special Graphics: bar, stairs, stem, pie, area — Pie chart and area plot
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

share = [55 12 10 9 14];               % % share of generation
labels = {'Coal', 'Hydro', 'Wind', 'Solar', 'Other'};
subplot(1, 2, 1)
pie(share, [0 0 1 1 0], labels)        % explode the renewables
title('Generation mix')
subplot(1, 2, 2)
t = 0:23;
load_kW = 40 + 25*sin((t - 8)/24*2*pi).^2;
area(t, load_kW, 'FaceColor', [0.6 0.8 1])
xlabel('Hour'); ylabel('kW'); title('Daily load (area = energy)')
fprintf('Energy over the day: %.0f kWh\n', trapz(t, load_kW));
