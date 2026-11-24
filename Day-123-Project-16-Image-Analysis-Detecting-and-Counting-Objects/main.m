% Day 123 · Project 16: Image Analysis: Detecting and Counting Objects — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear; close all;
rng(5);
[X, Y] = meshgrid(1:240, 1:180);
img = 0.2*ones(180, 240);
centers = [40 50 14; 120 40 22; 200 60 14; 70 130 22; 160 130 14; 215 150 9; 30 160 9];   % x, y, radius
for k = 1:size(centers, 1)
    img((X - centers(k, 1)).^2 + (Y - centers(k, 2)).^2 <= centers(k, 3)^2) = 0.85;
end
img = img + 0.12*randn(size(img));                      % noise
smooth = conv2(img, ones(3)/9, 'same');
bw = smooth > 0.5;
[L, nlab] = label_regions(bw);
stats = measure_regions(L, nlab);
keep = [stats.area] >= 30;                              % ignore specks of noise
stats = stats(keep);
fprintf('Raw regions %d, objects after removing specks: %d\n\n', nlab, numel(stats));
fprintf('%4s %7s %16s %8s %8s\n', '#', 'Area', 'Centroid (x, y)', 'Radius', 'Class');
for k = 1:numel(stats)
    r = sqrt(stats(k).area/pi);
    if r > 18, cls = 'large'; elseif r > 11, cls = 'medium'; else, cls = 'small'; end
    stats(k).class = cls;
    fprintf('%4d %7d %8.1f, %6.1f %8.1f %8s\n', k, stats(k).area, stats(k).centroid, r, cls);
end
classes = {stats.class};
fprintf('\nlarge: %d, medium: %d, small: %d\n', sum(strcmp(classes, 'large')), sum(strcmp(classes, 'medium')), sum(strcmp(classes, 'small')));
subplot(1, 2, 1); imagesc(img); colormap(gray); axis image; title('Input image')
subplot(1, 2, 2); imagesc(L .* ismember(L, find(keep))); axis image; title('Labelled objects'); hold on
for k = 1:numel(stats)
    bb = stats(k).bbox;
    plot([bb(1) bb(2) bb(2) bb(1) bb(1)], [bb(3) bb(3) bb(4) bb(4) bb(3)], 'y');
    text(stats(k).centroid(1), stats(k).centroid(2), num2str(k), 'Color', 'r', 'HorizontalAlignment', 'center');
end
hold off

function [L, n] = label_regions(bw)
    [R, C] = size(bw);  L = zeros(R, C);  n = 0;
    queue = zeros(R*C, 2);
    for c = 1:C
        for r = 1:R
            if bw(r, c) && L(r, c) == 0
                n = n + 1;  head = 1;  tail = 1;
                queue(1, :) = [r c];  L(r, c) = n;
                while head <= tail
                    p = queue(head, :);  head = head + 1;
                    nb = p + [-1 0; 1 0; 0 -1; 0 1];
                    for j = 1:4
                        rr = nb(j, 1); cc = nb(j, 2);
                        if rr >= 1 && rr <= R && cc >= 1 && cc <= C && bw(rr, cc) && L(rr, cc) == 0
                            L(rr, cc) = n;  tail = tail + 1;  queue(tail, :) = [rr cc];
                        end
                    end
                end
            end
        end
    end
end

function s = measure_regions(L, n)
    s = struct('area', cell(1, n), 'centroid', [], 'bbox', []);
    for k = 1:n
        [r, c] = find(L == k);
        s(k).area = numel(r);
        s(k).centroid = [mean(c) mean(r)];
        s(k).bbox = [min(c) max(c) min(r) max(r)];
    end
end
