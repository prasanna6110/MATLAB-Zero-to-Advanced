% Day 012 · Adding Elements, Deleting Elements and Reshaping Arrays — reshape, flip, rotate and shift
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

x = 1:12;
R = reshape(x, 3, 4)          % filled column by column
R2 = reshape(x, [], 2)'       % let MATLAB find the rows
fliplr(R)
flipud(R)
rot90(R)
circshift(1:6, 2)             % 5 6 1 2 3 4
% Hourly data (24 values) as a 4x6 table of 4-hour blocks
hourly = round(100 + 20 * sin((1:24) / 24 * 2 * pi));
blocks = reshape(hourly, 6, 4)'
