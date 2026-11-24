% Day 130 · Project 23: Transmission Line Fault Classification with k-NN — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear;
rng(8);
classes = {'Normal', 'LG', 'LL', 'LLG', 'LLL'};
nPer = 120;
X = []; y = [];
for c = 1:numel(classes)
    for k = 1:nPer
        X(end + 1, :) = features(simulate_fault(c)); %#ok<SAGROW>
        y(end + 1, 1) = c; %#ok<SAGROW>
    end
end
idx = randperm(size(X, 1));
ntr = round(0.7*numel(idx));
tr = idx(1:ntr);  te = idx(ntr + 1:end);
mu = mean(X(tr, :));  sd = std(X(tr, :));
Z = (X - mu) ./ sd;
k = 5;
pred = zeros(numel(te), 1);
for i = 1:numel(te)
    d = sum((Z(tr, :) - Z(te(i), :)).^2, 2);
    [~, order] = sort(d);
    pred(i) = mode(y(tr(order(1:k))));
end
truth = y(te);
CM = accumarray([truth pred], 1, [5 5]);
fprintf('Test accuracy: %.1f %% on %d cases\n\nConfusion matrix (rows = true, columns = predicted)\n', 100*mean(pred == truth), numel(te));
fprintf('%8s', ''); fprintf('%8s', classes{:}); fprintf('\n');
for r = 1:5
    fprintf('%8s', classes{r}); fprintf('%8d', CM(r, :)); fprintf('   (%.0f%% correct)\n', 100*CM(r, r)/sum(CM(r, :)));
end
new_case = features(simulate_fault(4));
d = sum((Z(tr, :) - (new_case - mu)./sd).^2, 2);
[~, o] = sort(d);
fprintf('\nA new LLG fault is classified as: %s\n', classes{mode(y(tr(o(1:k))))});

function I = simulate_fault(type)
    a = exp(1j*2*pi/3);
    Iload = (80 + 40*rand) * exp(-1j*acos(0.8 + 0.15*rand)) * [1; a^2; a];   % balanced load current
    If = (300 + 3500*rand) * exp(-1j*deg2rad(60 + 25*rand));                  % fault current (low for high-resistance faults)
    switch type
        case 1, I = Iload;
        case 2, I = Iload + [If; 0; 0];                                        % phase a to ground
        case 3, I = Iload + [0; If; -If];                                      % b to c
        case 4, I = Iload + [0; If; If*a*(0.6 + 0.4*rand)];                    % b-c to ground
        case 5, I = Iload + If*[1; a^2; a];                                    % three-phase
    end
    I = I .* (1 + 0.08*randn(3, 1)) .* exp(1j*0.05*randn(3, 1));               % measurement noise (magnitude and angle)
end

function f = features(I)
    a = exp(1j*2*pi/3);
    I012 = [1 1 1; 1 a a^2; 1 a^2 a] * I / 3;
    f = [log10(abs(I012(2))), abs(I012(3))/abs(I012(2)), abs(I012(1))/abs(I012(2)), log10(max(abs(I)))];
end
