% Day 026 · The Workspace and Input to a Script File — Asking the user with input
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

R = input('Enter the resistance in ohm: ');
V = input('Enter the voltage in volt: ');
name = input('Name of the circuit: ', 's');
I = V / R;
P = V * I;
fprintf('\nCircuit "%s": I = %.3f A, P = %.3f W\n', name, I, P);
