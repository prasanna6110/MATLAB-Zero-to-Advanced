% Day 052 · Local, Global and Persistent Variables — persistent and global in action
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

clear counter_tick                 % reset the persistent counter
for k = 1:3
    fprintf('called %d times\n', counter_tick());
end
global G_ACCEL
G_ACCEL = 9.81;
fprintf('Weight on Earth: %.1f N\n', gravity_force(70));
G_ACCEL = 1.62;                    % every function that uses it sees the change
fprintf('Weight on the Moon: %.1f N\n', gravity_force(70));
clear global G_ACCEL
