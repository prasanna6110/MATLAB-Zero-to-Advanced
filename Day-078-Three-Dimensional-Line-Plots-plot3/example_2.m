% Day 078 · Three-Dimensional Line Plots: plot3 — A projectile with a cross wind
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

v0 = 30; elev = 45; g = 9.81; wind = 2.0;        % m/s^2 sideways acceleration
t = linspace(0, 2*v0*sind(elev)/g, 200);
x = v0*cosd(elev)*t;
y = 0.5*wind*t.^2;
z = v0*sind(elev)*t - 0.5*g*t.^2;
plot3(x, y, z, 'b', 'LineWidth', 2); hold on
plot3(x, zeros(size(x)), z, 'k--')                % the path without wind
hold off; grid on
xlabel('Downrange (m)'); ylabel('Drift (m)'); zlabel('Height (m)')
legend('with wind', 'no wind')
fprintf('Range %.1f m, sideways drift %.1f m\n', x(end), y(end));
