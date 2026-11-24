% Day 025 · Complex Numbers and Phasors — Adding phasors of a three-phase system
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

Vm = 230;
Va = Vm * exp(1j*deg2rad(0));
Vb = Vm * exp(1j*deg2rad(-120));
Vc = Vm * exp(1j*deg2rad(120));
fprintf('Va + Vb + Vc = %.2e (balanced, so ~0)\n', abs(Va + Vb + Vc));
Vab = Va - Vb;
fprintf('Line voltage |Vab| = %.1f V at %.1f deg (sqrt(3) x 230 = %.1f)\n', abs(Vab), rad2deg(angle(Vab)), sqrt(3)*230);
