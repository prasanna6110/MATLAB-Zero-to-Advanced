% Day 063 · Regular Expressions and Advanced Text Processing — Tokens, named groups and replacement
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

log_text = sprintf('2026-11-24 10:05 TRIP CB12\n2026-11-24 10:07 CLOSE CB12\n2026-11-24 11:40 TRIP CB03');
tok = regexp(log_text, '(\d{2}:\d{2}) (TRIP|CLOSE) (CB\d+)', 'tokens');
for k = 1:numel(tok)
    fprintf('At %s breaker %s: %s\n', tok{k}{1}, tok{k}{3}, tok{k}{2});
end
s = regexp('V=231.4', '(?<name>\w+)=(?<value>[\d.]+)', 'names')
swapped = regexprep('Kumar, Ravi', '(\w+), (\w+)', '$2 $1')
% MATLAB can also run code in the replacement: regexprep(s, '(^|\s)(\w)', '$1${upper($2)}')
