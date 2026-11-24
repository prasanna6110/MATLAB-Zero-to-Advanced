% Day 104 · Building GUIs: App Designer and Programmatic Apps — Dialog boxes for quick interaction
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

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
