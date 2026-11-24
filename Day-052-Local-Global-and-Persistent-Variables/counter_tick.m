function n = counter_tick()
% COUNTER_TICK  Returns how many times it has been called.
persistent count
if isempty(count)
    count = 0;
end
count = count + 1;
n = count;
end

% (Course file for Day 052 · Local, Global and Persistent Variables)
