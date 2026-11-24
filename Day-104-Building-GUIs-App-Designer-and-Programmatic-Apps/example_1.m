% Day 104 · Building GUIs: App Designer and Programmatic Apps — A programmatic app: RC circuit explorer
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% MATLAB-ONLY: uifigure apps need MATLAB R2016a+ with a display
fig = uifigure('Name', 'RC charging explorer', 'Position', [100 100 620 420]);
ax = uiaxes(fig, 'Position', [200 40 400 360]);
uilabel(fig, 'Text', 'R (kohm)', 'Position', [20 360 80 22]);
R_field = uieditfield(fig, 'numeric', 'Value', 10, 'Position', [100 360 80 22]);
uilabel(fig, 'Text', 'C (uF)', 'Position', [20 320 80 22]);
C_slider = uislider(fig, 'Limits', [1 100], 'Value', 47, 'Position', [30 300 150 3]);
info = uilabel(fig, 'Text', '', 'Position', [20 200 170 60], 'WordWrap', 'on');
btn = uibutton(fig, 'Text', 'Plot', 'Position', [60 240 80 30]);
btn.ButtonPushedFcn = @(~, ~) update_plot(ax, R_field, C_slider, info);
C_slider.ValueChangedFcn = @(~, ~) update_plot(ax, R_field, C_slider, info);
update_plot(ax, R_field, C_slider, info);

function update_plot(ax, R_field, C_slider, info)
    tau = R_field.Value*1e3 * C_slider.Value*1e-6;
    t = linspace(0, 5*tau, 300);
    plot(ax, t, 12*(1 - exp(-t/tau)), 'LineWidth', 2);
    xlabel(ax, 't (s)'); ylabel(ax, 'v_C (V)'); grid(ax, 'on');
    info.Text = sprintf('tau = %.3f s, 99%% charged at %.3f s', tau, 4.6*tau);
end
