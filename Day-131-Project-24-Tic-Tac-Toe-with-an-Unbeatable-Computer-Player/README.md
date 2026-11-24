# Day 131 · Project 24: Tic-Tac-Toe with an Unbeatable Computer Player

_Projects_

## Goal
A complete Tic-Tac-Toe game where the computer plays perfectly using the **minimax** algorithm (a recursive search of all future moves). Play against it, or watch it play against a random player and against itself.

## Minimax
- Score a finished board: +1 if the computer wins, -1 if the human wins, 0 for a draw.
- On the computer's turn, choose the move with the **maximum** score; on the opponent's turn assume they choose the **minimum**.
- Recursively evaluate every possible continuation. Prefer quicker wins by subtracting the depth.
- **Alpha-beta pruning** skips moves that cannot change the decision, which makes the search many times faster.

## Concepts used
A 3×3 matrix board, recursion, logical tests of rows/columns/diagonals, `find`, `input` for human moves (with `INTERACTIVE = true`), statistics over many games.

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear;
INTERACTIVE = false;                     % true: you play X against the computer (O)
rng(3);
if INTERACTIVE
    B = zeros(3); player = 1;            % 1 = X (you), -1 = O (computer)
    while winner(B) == 0 && any(B(:) == 0)
        show(B);
        if player == 1
            m = input('Your move (1-9, numbered row by row): ');
            [c, r] = ind2sub([3 3], m);  % 1-9 counted across the rows
            if B(r, c) ~= 0, disp('Taken!'); continue; end
            B(r, c) = 1;
        else
            B(best_move(B, -1)) = -1;
        end
        player = -player;
    end
    show(B); fprintf('Result: %s\n', result_text(winner(B)));
else
    disp('Demo: the computer (O) against itself:');
    B = zeros(3); p = 1;
    while winner(B) == 0 && any(B(:) == 0)
        B(best_move(B, p)) = p;  p = -p;
    end
    show(B); fprintf('Result: %s (perfect play always ends in a draw)\n\n', result_text(winner(B)));
    tally = [0 0 0];                     % computer wins, random wins, draws
    for g = 1:10
        B = zeros(3); p = 1;             % the random player starts as X
        while winner(B) == 0 && any(B(:) == 0)
            if p == 1
                free = find(B == 0); B(free(randi(numel(free)))) = 1;
            else
                B(best_move(B, -1)) = -1;
            end
            p = -p;
        end
        w = winner(B);
        tally = tally + [w == -1, w == 1, w == 0];
    end
    fprintf('10 games, random player (X) vs minimax (O): minimax won %d, random won %d, draws %d\n', tally);
end

function show(B)
    s = '.XO';
    for r = 1:3
        fprintf(' %c %c %c\n', s(B(r, :) + 1 + 3*(B(r, :) == -1)));     % 0 -> '.', 1 -> 'X', -1 -> 'O'
    end
end

function w = winner(B)
    lines_sum = [sum(B, 1), sum(B, 2)', trace(B), trace(fliplr(B))];
    if any(lines_sum == 3), w = 1; elseif any(lines_sum == -3), w = -1; else, w = 0; end
end

function txt = result_text(w)
    if w == 1, txt = 'X wins'; elseif w == -1, txt = 'O wins'; else, txt = 'draw'; end
end

function m = best_move(B, p)
    free = find(B == 0);
    best = -Inf;
    for k = free'
        B(k) = p;
        score = -negamax(B, -p, 1, -Inf, Inf);
        B(k) = 0;
        if score > best, best = score; m = k; end
    end
end

function s = negamax(B, p, depth, alpha, beta)
% Best score for player p (minimax written as negamax, with alpha-beta pruning)
    w = winner(B);
    if w ~= 0, s = (w*p)*(10 - depth); return; end     % from the point of view of player p
    if all(B(:) ~= 0), s = 0; return; end
    s = -Inf;
    for k = find(B == 0)'
        B(k) = p;
        v = -negamax(B, -p, depth + 1, -beta, -alpha);
        B(k) = 0;
        s = max(s, v);
        alpha = max(alpha, v);
        if alpha >= beta, break; end                   % the opponent will never allow this line: prune
    end
end
```

## Extend this project

- Count how many positions are searched with and without the alpha-beta pruning.
- Draw the board in a figure and let the user click with `ginput`.
- Make a 4×4 version with a depth limit.
- Keep a score over several games and save it to a file.

---

[⬅ Day 130](../Day-130-Project-23-Transmission-Line-Fault-Classification-with-k-NN/README.md) · [🏠 Home](../README.md) · [Day 132 ➡](../Day-132-Project-25-Library-Management-System-with-Object-Oriented-Programming/README.md)
