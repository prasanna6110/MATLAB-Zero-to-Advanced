% Day 016 · String Arrays and Converting Between Numbers and Text — Parsing a line from a sensor log
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

log_line = 'T=27.4C,H=63%,P=1008hPa';
fields = strsplit(log_line, ',');
values = zeros(1, numel(fields));
for k = 1:numel(fields)
    txt = fields{k};
    digits_only = txt(ismember(txt, '0123456789.'));   % keep digits and the point
    values(k) = str2double(digits_only);
end
fprintf('Temperature %.1f C, humidity %.0f %%, pressure %.0f hPa\n', values);
