% Day 137 · Project 30: Sudoku Solver with Backtracking — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear;
puzzle = [5 3 0 0 7 0 0 0 0
          6 0 0 1 9 5 0 0 0
          0 9 8 0 0 0 0 6 0
          8 0 0 0 6 0 0 0 3
          4 0 0 8 0 3 0 0 1
          7 0 0 0 2 0 0 0 6
          0 6 0 0 0 0 2 8 0
          0 0 0 4 1 9 0 0 5
          0 0 0 0 8 0 0 7 9];
hard = [0 0 0 0 0 0 0 1 2
        0 0 0 0 3 5 0 0 0
        0 0 0 6 0 0 0 7 0
        7 0 0 0 0 0 3 0 0
        0 0 0 4 0 0 8 0 0
        1 0 0 0 0 0 0 0 0
        0 0 0 1 2 0 0 0 0
        0 8 0 0 0 0 0 4 0
        0 5 0 0 0 0 6 0 0];
puzzles = {'Classic', puzzle; 'Hard (17 clues)', hard};
for p = 1:2
    G = puzzles{p, 2};
    fprintf('%s puzzle, %d clues:\n', puzzles{p, 1}, nnz(G));
    tic; [S, ok, guesses] = solve(G, 0); t = toc;
    if ok
        print_grid(S);
        fprintf('Solved with %d guesses in %.2f s. Valid: %d\n\n', guesses, t, is_valid(S) && isequal(S(G > 0), G(G > 0)));
    else
        disp('No solution.');
    end
end

function [G, ok, guesses] = solve(G, guesses)
    best = []; best_c = 1:10;
    for idx = find(G == 0)'                         % choose the cell with the fewest candidates
        [r, c] = ind2sub([9 9], idx);
        cand = candidates(G, r, c);
        if numel(cand) < numel(best_c)
            best = idx; best_c = cand;
            if numel(cand) <= 1, break; end
        end
    end
    if isempty(best), ok = true; return; end       % no empty cell: solved
    if isempty(best_c), ok = false; return; end    % dead end: backtrack
    for v = best_c
        G2 = G; G2(best) = v;
        if numel(best_c) > 1, guesses = guesses + 1; end
        [S, ok, guesses] = solve(G2, guesses);
        if ok, G = S; return; end
    end
    ok = false;
end

function cand = candidates(G, r, c)
    br = 3*floor((r - 1)/3) + (1:3); bc = 3*floor((c - 1)/3) + (1:3);
    used = [G(r, :), G(:, c)', reshape(G(br, bc), 1, [])];
    cand = setdiff(1:9, used);
end

function ok = is_valid(S)
    ok = true;
    for k = 1:9
        br = 3*floor((k - 1)/3) + (1:3); bc = 3*mod(k - 1, 3) + (1:3);
        ok = ok && isequal(sort(S(k, :)), 1:9) && isequal(sort(S(:, k))', 1:9) && isequal(sort(reshape(S(br, bc), 1, [])), 1:9);
    end
end

function print_grid(S)
    for r = 1:9
        if mod(r - 1, 3) == 0, fprintf(' +-------+-------+-------+\n'); end
        fprintf(' | %d %d %d | %d %d %d | %d %d %d |\n', S(r, :));
    end
    fprintf(' +-------+-------+-------+\n');
end
