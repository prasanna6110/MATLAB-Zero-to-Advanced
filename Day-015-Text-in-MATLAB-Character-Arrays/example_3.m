% Day 015 · Text in MATLAB: Character Arrays — Searching, replacing, splitting and comparing
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

line = 'V=230;I=12.5;PF=0.92';
parts = strsplit(line, ';')                  % a cell array of texts
for k = 1:numel(parts)
    kv = strsplit(parts{k}, '=');
    fprintf('%-3s -> %g\n', kv{1}, str2double(kv{2}));
end
strrep(line, ';', ', ')
strfind(line, '=')
strcmp('Yes', 'yes'), strcmpi('Yes', 'yes')
strtrim('   padded text   ')
