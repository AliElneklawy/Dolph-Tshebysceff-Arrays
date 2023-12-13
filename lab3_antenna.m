num_elems = input('Enter the number of elements of array: ');
phase_shift = input('Enter the progressive phase shift: ');
spacing = input('Enter the spacing between elements (d): ');
Ro = input('Enter the main lobe to side lobe level (Ro): ');

lambda = 1;
beta = 2 * pi / lambda;
theta = 0:0.01:2*pi;
phi = 0:0.01:2*pi;
u = 0.5 * (phase_shift + beta * spacing .* cos(theta));
Ro = 10 ^ (Ro / 20);
m = num_elems - 1;
Zo = cosh((1/m) * acosh(Ro));
z = Zo * cos(u);

T = chebyshevT(m, z);
AF = abs(T);

% plot the array factor against z
figure(1)
plot(z, AF);
xlabel('z');
ylabel('Array Factor');
title('Array Factor vs z');

% 2D radiation pattern
figure(2)
polarplot(theta, AF)
title('2D Pattern')

% 3D radiation pattern
figure(3)
[theta2, phi2] = meshgrid(0:0.01:pi, phi);
u_3d = 0.5 * (phase_shift + beta * spacing .* cos(theta2));
z_3d = Zo * cos(u_3d);
T_3d = chebyshevT(m, z_3d);
AF = abs(T_3d);
AFx = AF .* sin(theta2) .* cos(phi2);
AFy = AF .* sin(theta2) .* sin(phi2);
AFz = AF .* cos(theta2);
mesh(AFx, AFy, AFz)
xlim([-4 4])
ylim([-4 4])
zlim([-10 10])
axis image;
title('3D Radiation Pattern')



