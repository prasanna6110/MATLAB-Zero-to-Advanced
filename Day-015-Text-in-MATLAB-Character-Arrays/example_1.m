% Day 015 · Text in MATLAB: Character Arrays — Characters are numbers underneath
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

city = 'Satna';
length(city)
city(1)
city([1 end])
codes = double(city)            % Unicode codes
shifted = char(codes + 1)       % a tiny "Caesar cipher"
reversed = fliplr(city)
upper(city)
