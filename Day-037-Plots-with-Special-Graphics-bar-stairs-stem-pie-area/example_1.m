% Day 037 · Plots with Special Graphics: bar, stairs, stem, pie, area — Bar charts: simple, grouped and stacked
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

months = 1:6;
solar = [310 360 420 450 400 330];
wind  = [220 180 160 250 300 280];
subplot(1, 3, 1)
bar(months, solar, 'FaceColor', [1 0.7 0])
title('Solar (MWh)')
subplot(1, 3, 2)
bar([solar' wind'])                    % grouped
legend('Solar', 'Wind'); title('Grouped')
subplot(1, 3, 3)
bar([solar' wind'], 'stacked')
title('Stacked')
set(gca, 'XTickLabel', {'J', 'F', 'M', 'A', 'M', 'J'})
