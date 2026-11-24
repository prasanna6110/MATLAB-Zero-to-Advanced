% Day 031 · Low-level File I/O: fopen, fprintf, fgetl, fscanf, textscan — Reading line by line with fgetl
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

fid = fopen('stations.txt', 'w');
fprintf(fid, 'Panipat 230\nKurukshetra 228\nAmbala 233\nKarnal 226\n');
fclose(fid);
fid = fopen('stations.txt', 'r');
line = fgetl(fid);
count = 0;
while ischar(line)
    parts = strsplit(line, ' ');
    v = str2double(parts{2});
    flag = '';
    if v < 228, flag = '  <- low'; end
    fprintf('%-12s %d V%s\n', parts{1}, v, flag);
    count = count + 1;
    line = fgetl(fid);
end
fclose(fid);
fprintf('%d lines read\n', count);
delete('stations.txt');
