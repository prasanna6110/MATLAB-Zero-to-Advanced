% Day 059 · Structures — A structure array of students
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

students(1) = struct('name', 'Asha',  'marks', [78 82 91]);
students(2) = struct('name', 'Ravi',  'marks', [65 70 58]);
students(3) = struct('name', 'Meena', 'marks', [88 95 90]);
for k = 1:numel(students)
    students(k).avg = mean(students(k).marks);   % add a new field to each
end
avgs = [students.avg]
names = {students.name}
[~, top] = max(avgs);
fprintf('Topper: %s with %.2f\n', students(top).name, avgs(top));
passed = students(avgs >= 70);
fprintf('Passed with 70+: %s\n', strjoin({passed.name}, ', '));
