% Correlation for HTCs
clear all
close all
clc

%% Prepare data for plotting
xLength = linspace(0.01, 0.19, 19);
xLength = [xLength 0.1925 0.195 0.1975];
topAirIntT = dlmread('dataFiles/topAirPatchProbeSolidXL/topAir/0/T', '', 24);
bottomAirIntT = dlmread('dataFiles/bottomAirPatchProbeSolidXL/bottomAir/0/T', '', 24);

figure (1)
subplot(2, 1, 1)
plot(xLength, topAirIntT(end, 2:end), '-o', 'linewidth', 2)

title('topAir')
ylabel('T (K)');


%% HTC calculation
% topAir: Fluid region 0
mu1 = 5.831e-5; 
rho1 = 0.1963;
Ux1 = 0.7432;

% Film properties
% mu1film = 5.596e-5; % x/L = 0.975
% rho1film = 0.211; % x/L = 0.975
mu1film = [5.582e-5 5.587e-5 5.591e-5 5.596e-5 5.599e-5 5.602e-5 5.605e-5 5.607e-5 5.608e-5 5.609e-5 5.61e-5 5.609e-5 5.608e-5 5.606e-5 5.605e-5 5.603e-5 5.6e-5 5.598e-5 5.596e-5 5.596e-5 5.596e-5 5.596e-5];
rho1film = [0.2119 0.2115 0.2113 0.211 0.2108 0.2105 0.2103 0.2102 0.2101 0.2101 0.2101 0.2101 0.2101 0.2102 0.2104 0.2105 0.2107 0.2108 0.2109 0.2109 0.211 0.211];
k1film = 0.09984;
 
k1 = 0.1028755;
ReX1 = (rho1film*Ux1.*xLength)./mu1film;
Pr1 = 0.7;
 
% Empirical
htc1 = (k1*rho1film./xLength)*0.332.*ReX1.^0.5*Pr1^(1./3.); 

subplot(2, 1, 2)
plot(xLength, htc1, '-+', 'linewidth', 2)
xlabel('x Location (m)');
ylabel('HTC (W/m^2-K)')
saveas(gcf, 'topAirTHtc.pdf');

%% bottomAir: Fluid region 1
mu2 = 1.845e-5;
rho2 = 1.177; % -> air at 300k;
Ux2 = 0.0392;

% Film properties 
% mu2film = 3.948e-5; % (x/L = 0.975)
% rho2film = 0.3836; % (x/L = 0.975)
mu2film = [3.89e-5 3.917e-5 3.928e-5 3.939e-5 3.945e-5 3.952e-5 3.957e-5 3.961e-5 3.964e-5 3.965e-5 3.966e-5 3.966e-5 3.965e-5 3.963e-5 3.961e-5 3.958e-5 3.954e-5 3.952e-5 3.949e-5 3.949e-5 3.949e-5 3.948e-5];
rho2film = [0.3932 0.3888 0.3869 0.3852 0.3842 0.3831 0.3822 0.3817 0.3812 0.3809 0.3808 0.3808 0.381 0.3813 0.3816 0.3822 0.3827 0.3831 0.3835 0.3836 0.3836 0.3836];
k2film = 0.06358;
 
k2 = 0.026515286;
ReX2 = (rho2film*Ux2.*xLength)./mu2film;
Pr2 = 0.7;
 
htc2 = (k2*rho2film./xLength)*0.332.*ReX2.^0.5*Pr2^(1./3.); 

figure (2)
subplot(2, 1, 1)
plot(xLength, bottomAirIntT(end, 2:end), '-o', 'linewidth', 2)
title('bottomAir')
ylabel('T (K)')

subplot(2, 1, 2)
plot(xLength, htc2, '-+', 'linewidth', 2)
xlabel('x Location (m)')
ylabel('HTC (W/m^2-K)')
saveas(gcf, 'bottomAirTHtc.pdf');

%% Simulation data
topAirT0 = 1800;
topAirT = 1545.652; % x/L = 0.975

bottomAirT0 = 300;
bottomAirT = 1539.8426; % x/L = 0.975

topAirTf = (topAirT0 + topAirIntT(end, 2:end))./2.0
bottomAirTf = (bottomAirT0 + bottomAirIntT(end, 2:end))./2.0

%% Compute the correlation equations
solidTopAirIntT = dlmread('dataFiles/solidPatchProbeTopAirXL/solid/0/T', '', 24);
solidBottomAirIntT = dlmread('dataFiles/solidPatchProbeBottomAirXL/solid/0/T', '', 24);

eq1 = htc1.*(topAirT0 - solidTopAirIntT(end, 2:end)); %topAirT)%topAirT(:, 2))
eq2 = htc2.*(solidBottomAirIntT(end, 2:end) - bottomAirT0);

figure (3)
plot(xLength./0.2, eq1, '-+', 'linewidth', 2)
hold on
plot(xLength./0.2, eq2, '-o', 'linewidth', 2)

xlabel('x/L')
legend('topAir: $h_1(T_1 - T_{s1})$', 'bottomAir: $h_2 (T_{s2} - T_2)$', 'interpreter', 'latex', 'fontsize', 18)
saveas(gcf, 'htcBalance.pdf')

figure (4)
plot(xLength, (eq1 - eq2)./eq2, 'linewidth', 2)