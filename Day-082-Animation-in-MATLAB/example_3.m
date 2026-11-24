% Day 082 · Animation in MATLAB — Saving an animation as a GIF and a video
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% MATLAB-ONLY: getframe/VideoWriter need a graphics display
x = linspace(0, 2*pi, 100);
h = plot(x, sin(x)); ylim([-1 1])
v = VideoWriter('wave.mp4', 'MPEG-4');
open(v)
for k = 1:30
    set(h, 'YData', sin(x + k/5));
    frame = getframe(gcf);
    writeVideo(v, frame);
    [im, map] = rgb2ind(frame2im(frame), 256);
    if k == 1
        imwrite(im, map, 'wave.gif', 'gif', 'LoopCount', Inf, 'DelayTime', 0.05);
    else
        imwrite(im, map, 'wave.gif', 'gif', 'WriteMode', 'append', 'DelayTime', 0.05);
    end
end
close(v)
delete('wave.mp4'); delete('wave.gif');
