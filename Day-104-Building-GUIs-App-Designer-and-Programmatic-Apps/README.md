# Day 104 · Building GUIs: App Designer and Programmatic Apps

_Advanced MATLAB and Toolboxes_

## App Designer
**App Designer** (type `appdesigner`) builds apps with a drag-and-drop **Design View** and a **Code View**:
1. Drag components onto the canvas: **Button, Edit Field (Numeric/Text), Slider, Knob, Drop Down, Check Box, Switch, Lamp, Gauge, Table, UIAxes, Tab Group**.
2. Set their properties (text, limits, colours) in the Component Browser.
3. Right-click a component → **Callbacks** → add a callback function: the code that runs when the user clicks or changes it.
4. Inside callbacks, read and write components through `app`: `R = app.ResistanceEditField.Value; plot(app.UIAxes, t, v);`
5. Save as `.mlapp`. **Share → MATLAB App** (installer), **Standalone desktop app** or **Web app** (with MATLAB Compiler).

## Programmatic apps
You can also create the window and components in code (good for small tools and for understanding how apps work):
```matlab
fig = uifigure('Name', 'My app');
ef  = uieditfield(fig, 'numeric', 'Position', [20 20 100 22]);
btn = uibutton(fig, 'Text', 'Go', 'ButtonPushedFcn', @(src, evt) disp(ef.Value));
```
Older code uses `figure` + `uicontrol('Style', 'pushbutton', ...)` and **GUIDE** (removed in recent versions; migrate with the GUIDE to App Designer Migration Tool).

## Simple dialog boxes
`inputdlg`, `questdlg`, `msgbox`, `errordlg`, `uigetfile`, `uiputfile`, `waitbar`, `listdlg`: quick interaction without building a full app.

## Examples

### Example 1: A programmatic app: RC circuit explorer  ([`example_1.m`](example_1.m))

```matlab
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
```

### Example 2: Dialog boxes for quick interaction  ([`example_2.m`](example_2.m))

```matlab
% MATLAB-ONLY: dialog boxes need a display
answer = inputdlg({'Voltage (V)', 'Resistance (ohm)'}, 'Ohm''s law', 1, {'12', '220'});
if ~isempty(answer)
    V = str2double(answer{1});  R = str2double(answer{2});
    choice = questdlg(sprintf('I = %.4f A. Show power too?', V/R), 'Result', 'Yes', 'No', 'Yes');
    if strcmp(choice, 'Yes')
        msgbox(sprintf('P = %.4f W', V^2/R), 'Power');
    end
end
w = waitbar(0, 'Working...');
for k = 1:20
    pause(0.05); waitbar(k/20, w);
end
close(w)
```

### Example 3: The logic behind an app, tested without the window  ([`example_3.m`](example_3.m))

```matlab
% Good practice: keep the calculations in plain functions so they can be tested
% without clicking. The app's callbacks just call these functions.
inputs = struct('V', {230, 230, 415}, 'P_kW', {1.5, 5, 22}, 'pf', {0.9, 0.85, 0.88}, 'phases', {1, 1, 3});
for k = 1:numel(inputs)
    r = cable_current(inputs(k));
    fprintf('%d-phase, %5.1f kW at %d V: I = %6.2f A -> choose a %d A breaker\n', ...
        inputs(k).phases, inputs(k).P_kW, inputs(k).V, r.I, r.breaker);
end

function r = cable_current(in)
    if in.phases == 3
        r.I = in.P_kW*1e3 / (sqrt(3) * in.V * in.pf);
    else
        r.I = in.P_kW*1e3 / (in.V * in.pf);
    end
    sizes = [6 10 16 20 25 32 40 50 63 80 100];
    r.breaker = sizes(find(sizes >= 1.25*r.I, 1));
end
```

## Practice

1. Open App Designer and build an app with two numeric fields, a button and a label that shows their sum.
2. Add a UIAxes to your app and plot `sin(f t)` where f comes from a slider.
3. Use `uigetfile` to let the user pick a CSV file and plot its first two columns.
4. Package your app with **Share → MATLAB App** and install it from the APPS tab.

---

[⬅ Day 103](../Day-103-Object-Oriented-Programming-classdef-Properties-and-Methods/README.md) · [🏠 Home](../README.md) · [Day 105 ➡](../Day-105-Debugging-the-Code-Analyzer-and-Unit-Testing/README.md)
