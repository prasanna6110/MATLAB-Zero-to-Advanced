% Day 072 · Finding a Minimum or a Maximum: fminbnd and fminsearch — Several variables with fminsearch
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Minimum of the "banana" (Rosenbrock) function, a classic test
banana = @(v) 100*(v(2) - v(1)^2)^2 + (1 - v(1))^2;
[v, fv] = fminsearch(banana, [-1.2 1]);
fprintf('Minimum at (%.4f, %.4f), value %.2e\n', v, fv);
% Cheapest location for a warehouse serving 4 shops (sum of distances)
shops = [0 0; 10 0; 10 8; 2 9];
total_dist = @(p) sum(sqrt(sum((shops - p).^2, 2)));
best = fminsearch(total_dist, mean(shops));
fprintf('Warehouse at (%.2f, %.2f), total distance %.2f km\n', best, total_dist(best));
