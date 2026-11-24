# Day 137 · Project 30: Sudoku Solver with Backtracking

_Projects_

## Goal
Solve any **Sudoku** puzzle with a **recursive backtracking** algorithm, speed it up with **constraint propagation** (fill cells with only one possible value first, and always branch on the cell with the fewest candidates), verify the solution, and count how many guesses each strategy needs.

## Algorithm
1. Find the empty cell with the **fewest candidates** (digits not already in its row, column and 3×3 box).
2. If a cell has **no** candidates, this branch is wrong: go back (**backtrack**).
3. Try each candidate in turn, recursing on the rest of the puzzle.
4. When there are no empty cells, the puzzle is solved.

## Concepts used
Recursion with multiple outputs, logical indexing on rows/columns/boxes, `setdiff`, persistent-free counting through return values, `isequal`, formatted printing of a grid.

## Code

### Full program  ([`main.m`](main.m))

```matlab
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
```

## Extend this project

- Count the solutions of a puzzle (stop after 2) to check that it has a unique solution.
- Write a puzzle generator that removes clues while the solution stays unique.
- Draw the grid in a figure with the given clues in black and the solved digits in blue.
- Compare the speed with a plain backtracking that always picks the first empty cell.

---

[⬅ Day 136](../Day-136-Project-29-Weather-Data-Dashboard/README.md) · [🏠 Home](../README.md)
