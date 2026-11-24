% Day 040 · Multiple Plots on a Page, Multiple Figures and Saving Figures — tiledlayout, sgtitle and exportgraphics
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% MATLAB-ONLY: tiledlayout (R2019b), exportgraphics (R2020a)
t = linspace(0, 2, 500);
tl = tiledlayout(2, 1, 'TileSpacing', 'compact');
title(tl, 'Step responses')
nexttile; plot(t, 1 - exp(-3*t)); title('First order')
nexttile; plot(t, 1 - exp(-2*t).*cos(8*t)); title('Second order, underdamped')
exportgraphics(gcf, 'steps.png', 'Resolution', 200);
delete('steps.png');
