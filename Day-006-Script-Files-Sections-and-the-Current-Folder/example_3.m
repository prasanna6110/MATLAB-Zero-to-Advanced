% Day 006 · Script Files, Sections and the Current Folder — A script that calls another script
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% helper_constants.m is a script file in this same folder.
% Running it creates its variables in the workspace, as if typed here.
helper_constants
fprintf('Speed of light: %g m/s\n', c0);
fprintf('Charge of an electron: %g C\n', q_e);
wavelength = c0 / 50e6;          % wavelength of a 50 MHz signal
fprintf('Wavelength at 50 MHz: %.2f m\n', wavelength);
