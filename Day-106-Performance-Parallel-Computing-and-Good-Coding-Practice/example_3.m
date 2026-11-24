% Day 106 · Performance, Parallel Computing and Good Coding Practice — parfor and gpuArray
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% MATLAB-ONLY: needs the Parallel Computing Toolbox (and a supported GPU for gpuArray)
% Needs: Parallel Computing Toolbox
N = 200;
result = zeros(1, N);
tic
parfor k = 1:N                          % independent iterations run on several cores
    A = rand(300);
    result(k) = max(abs(eig(A)));
end
fprintf('parfor took %.2f s\n', toc);
if gpuDeviceCount > 0
    G = gpuArray(rand(4000, 'single'));
    tic; H = G * G; wait(gpuDevice); fprintf('GPU matrix multiply %.3f s\n', toc);
    H = gather(H);
end
