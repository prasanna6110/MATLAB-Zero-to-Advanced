% Day 031 · Low-level File I/O: fopen, fprintf, fgetl, fscanf, textscan — fscanf and textscan
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

fid = fopen('xy.txt', 'w');
fprintf(fid, '%.1f %.2f\n', [0:0.5:2; (0:0.5:2).^2]);
fclose(fid);
fid = fopen('xy.txt');
XY = fscanf(fid, '%f %f', [2 Inf]);           % 2 rows, as many columns as needed
fclose(fid);
disp(XY')
fid = fopen('parts.csv', 'w');
fprintf(fid, 'R101,10,0.25\nC205,47,0.10\nL330,3,1.50\n');
fclose(fid);
fid = fopen('parts.csv');
C = textscan(fid, '%s %f %f', 'Delimiter', ',');
fclose(fid);
codes = C{1}; qty = C{2}; cost = C{3};
for k = 1:numel(codes)
    fprintf('%s: %g pcs x Rs %.2f = Rs %.2f\n', codes{k}, qty(k), cost(k), qty(k)*cost(k));
end
delete('xy.txt'); delete('parts.csv');
