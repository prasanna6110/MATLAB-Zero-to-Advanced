% Day 026 · The Workspace and Input to a Script File — Validating what the user typed
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

age = input('Enter your age: ');
if isempty(age) || ~isnumeric(age) || age < 0
    disp('That is not a valid age.')
else
    fprintf('In 10 years you will be %d.\n', age + 10);
end
% Re-ask until the value is valid (a while loop, Day 45)
n = -1;
tries = 0;
while (isempty(n) || n <= 0) && tries < 3
    n = input('Enter a positive number of samples: ');
    tries = tries + 1;
end
fprintf('Using %d samples.\n', n);
