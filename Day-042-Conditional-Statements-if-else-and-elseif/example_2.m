% Day 042 · Conditional Statements: if, else and elseif — if-elseif-else: an electricity bill with slabs
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

units = 345;
if units <= 100
    bill = units * 3.5;
elseif units <= 200
    bill = 100*3.5 + (units - 100) * 4.5;
elseif units <= 400
    bill = 100*3.5 + 100*4.5 + (units - 200) * 6.0;
else
    bill = 100*3.5 + 100*4.5 + 200*6.0 + (units - 400) * 7.5;
end
fixed = 60;
fprintf('Units %d -> energy charge Rs %.2f + fixed Rs %d = Rs %.2f\n', units, bill, fixed, bill + fixed);
