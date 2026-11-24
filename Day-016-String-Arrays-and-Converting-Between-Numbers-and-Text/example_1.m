% Day 016 · String Arrays and Converting Between Numbers and Text — String arrays
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% MATLAB-ONLY: string arrays need MATLAB R2017a or newer
s = "Power System";
strlength(s)
words = split(s)                  % ["Power"; "System"]
fruits = ["apple" "kiwi" "watermelon"];
strlength(fruits)                 % 5 4 10, no padding needed
greeting = "Hello " + "NIT"       % + joins strings
contains(fruits, "w")
upper(fruits(end))
fruits == "kiwi"                  % == works for strings
