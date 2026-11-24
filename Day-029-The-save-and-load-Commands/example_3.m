% Day 029 · The save and load Commands — Appending to a MAT-file and checking files
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

results = struct('run', 1, 'error', 0.031);
save('experiment.mat', 'results');
notes = 'second run used a finer mesh';
save('experiment.mat', 'notes', '-append');
if exist('experiment.mat', 'file') == 2
    info = whos('-file', 'experiment.mat');
    fprintf('The file holds: %s\n', strjoin({info.name}, ', '));
end
folder = tempdir;
full_name = fullfile(folder, 'backup.mat');
copyfile('experiment.mat', full_name);
fprintf('Backup written to %s\n', full_name);
delete(full_name); delete('experiment.mat');
