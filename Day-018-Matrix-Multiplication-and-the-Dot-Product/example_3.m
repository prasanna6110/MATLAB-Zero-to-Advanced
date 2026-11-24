% Day 018 · Matrix Multiplication and the Dot Product — Shop bill and a 2-D rotation
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Bill: 3 shops x 4 items, quantities times prices
qty = [2 1 0 5; 1 3 2 0; 4 0 1 1];   % 3 customers x 4 items
price = [40; 25; 120; 10];           % 4 items x 1
bill = qty * price                   % 3x1 amount for each customer
% Rotate the point (1, 0) by 90 degrees
th = 90;
Rot = [cosd(th) -sind(th); sind(th) cosd(th)];
p = Rot * [1; 0]
