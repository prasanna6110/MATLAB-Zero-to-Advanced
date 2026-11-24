% Day 032 · The plot Command and Line Specifiers — Plotting measured data
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

year = [2016 2017 2018 2019 2020 2021 2022 2023];
peak_GW = [159 164 177 183 183 200 211 243];
plot(year, peak_GW, '--rs', 'LineWidth', 1.5, 'MarkerFaceColor', 'r')
xlabel('Year'); ylabel('Peak demand (GW)')
title('Peak electricity demand')
grid on
fprintf('Growth over the period: %.1f %%\n', 100 * (peak_GW(end) / peak_GW(1) - 1));
