% Day 031 · Low-level File I/O: fopen, fprintf, fgetl, fscanf, textscan — Writing and appending a text log
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

fid = fopen('events.log', 'w');
fprintf(fid, '%s\n', 'Breaker CB1 closed', 'Load increased to 80%');
fclose(fid);
fid = fopen('events.log', 'a');                % append mode
fprintf(fid, 'Fault cleared in %d ms\n', 85);
fclose(fid);
txt = fileread('events.log');
disp(txt)
delete('events.log');
