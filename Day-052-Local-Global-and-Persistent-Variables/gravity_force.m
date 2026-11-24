function F = gravity_force(m)
% GRAVITY_FORCE  Weight of a mass, using the global G_ACCEL.
global G_ACCEL
F = m * G_ACCEL;
end

% (Course file for Day 052 · Local, Global and Persistent Variables)
