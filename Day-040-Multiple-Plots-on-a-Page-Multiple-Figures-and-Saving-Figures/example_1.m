% Day 040 · Multiple Plots on a Page, Multiple Figures and Saving Figures — A 2x2 dashboard of one signal
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

t = linspace(0, 1, 1000);
x = sin(2*pi*5*t) + 0.4*sin(2*pi*40*t);
subplot(2, 2, 1); plot(t, x); title('Signal'); xlabel('t (s)')
subplot(2, 2, 2); hist(x, 30); title('Histogram of values')
subplot(2, 2, 3); plot(t(1:200), x(1:200), '.-'); title('Zoom: first 0.2 s')
subplot(2, 2, 4); plot(t, cumsum(x)/1000); title('Running integral')
