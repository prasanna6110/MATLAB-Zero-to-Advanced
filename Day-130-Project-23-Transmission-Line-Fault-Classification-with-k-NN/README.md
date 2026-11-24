# Day 130 · Project 23: Transmission Line Fault Classification with k-NN

_Projects_

## Goal
Classify the **type of a fault** on a three-phase line (normal, single line-to-ground, line-to-line, double line-to-ground, three-phase) from the measured **phase currents**, using features from **symmetrical components** and a **k-nearest-neighbour** classifier written from scratch. Evaluate it with a confusion matrix.

## Physics behind the features
- Normal and three-phase faults: only positive-sequence current (but very different magnitudes).
- Line-to-line: positive and negative sequence, no zero sequence.
- Ground faults (LG, LLG): a zero-sequence current appears.
Features: |I1|, |I2|/|I1|, |I0|/|I1| and the largest phase current (all scaled).

Because these physics-based features separate the fault types so well, the accuracy on this simulated data is very high. Real relay data (CT saturation, DC offset, evolving faults) is harder: the practice questions make the task more realistic.

## Concepts used
Complex numbers, simulated data with random fault resistance and load, feature scaling, k-NN with distance sorting, confusion matrix, accuracy per class.

## Code

### Full program  ([`main.m`](main.m))

```matlab
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
```

## Extend this project

- Also identify the faulted phase (a, b or c) for LG faults.
- Add the fault location (distance) as a regression target.
- Compare k-NN with a decision tree (`fitctree`) in MATLAB.
- Add 10% noise and see how the accuracy drops.

---

[⬅ Day 129](../Day-129-Project-22-Electricity-Load-Forecasting-with-Regression/README.md) · [🏠 Home](../README.md) · [Day 131 ➡](../Day-131-Project-24-Tic-Tac-Toe-with-an-Unbeatable-Computer-Player/README.md)
