% Day 046 · Nested Loops and Nested Conditional Statements — Comparing every pair: closest two substations
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

names = {'A', 'B', 'C', 'D', 'E'};
xy = [0 0; 4 3; 1 7; 6 1; 3 4];         % km
best = Inf;
for p = 1:size(xy, 1) - 1
    for q = p + 1:size(xy, 1)
        d = norm(xy(p, :) - xy(q, :));
        if d < best
            best = d; pair = [p q];
        end
    end
end
fprintf('Closest: %s and %s, %.2f km apart\n', names{pair(1)}, names{pair(2)}, best);
