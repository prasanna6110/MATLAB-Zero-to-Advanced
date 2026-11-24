function varargout = stats_summary(varargin)
% STATS_SUMMARY  Mean of any number of vectors; also max and min if asked.
%   [MEANS, MAXS, MINS] = STATS_SUMMARY(V1, V2, ...)
n = numel(varargin);
means = zeros(1, n); maxs = zeros(1, n); mins = zeros(1, n);
for k = 1:n
    v = varargin{k};
    means(k) = mean(v);
    maxs(k) = max(v);
    mins(k) = min(v);
end
all_out = {means, maxs, mins};
varargout = all_out(1:max(1, nargout));
end

% (Course file for Day 051 · Input and Output Arguments: nargin, nargout, Defaults and varargin)
