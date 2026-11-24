% Day 035 · Formatting a Plot: Labels, Title, Text, Legend, Axis and Grid — Changing a plot through handles
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

x = 1:10;
h = plot(x, x.^1.5, 'o-');
set(h, 'LineWidth', 2)              % in MATLAB R2014b+ you can also write h.LineWidth = 2
set(h, 'MarkerFaceColor', 'g')
ax = gca;
set(ax, 'FontSize', 11, 'XGrid', 'on', 'YGrid', 'on')
title('Changed through handles')
fprintf('The line has %d points and colour %s\n', numel(get(h, 'XData')), mat2str(get(h, 'Color'), 3));
