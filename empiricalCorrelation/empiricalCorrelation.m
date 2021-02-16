% Correlation for HTCs
clear all
close all
clc
%% Global properties
xLength = 0.2*0.975;

%% topAir: Fluid region 0
mu1 = 5.831e-5; 
rho1 = 0.1963;
Ux1 = 0.7432;

k1 = 0.1028755;
ReX1 = (rho1*Ux1*xLength)/mu1;
Pr1 = 0.7;

% Empirical
htc1 = (k1*rho1/xLength)*0.332*ReX1^0.5*Pr1^(1./3.); 

%% bottomAir: Fluid region 1
mu2 = 1.845e-5;
rho2 = 1.177; % -> air at 300k;
Ux2 = 0.0392;

k2 = 0.026515286;
ReX2 = (rho2*Ux2*xLength)/mu2;
Pr2 = 0.7;

htc2 =(k2*rho2/xLength)*0.332*ReX2^0.5*Pr2^(1./3.); 

%% Load simulation data
topAirT0 = 1800;
topAirT = 1545.652;
% topAirT = dlmread('./dataFiles/pgf03/postProcessing/pp0/topAir/23.85/T', '', 3);
% topAirT = dlmread('./dataFiles/pgf04/postProcessing/pp0/topAir/7.19/T', '', 3);

bottomAirT0 = 300;
bottomAirT = 1539.9612;
% bottomAirT = dlmread('./dataFiles/pgf03/postProcessing/pp1/bottomAir/23.85/T', '', 3);
% bottomAirT = dlmread('./dataFiles/pgf04/postProcessing/pp1/bottomAir/7.19/T', '', 3);


%% Compute the correlation equations
eq1 = htc1*(topAirT0 - topAirT)%topAirT(:, 2))
% eq2 = htc2*(bottomAirT(:, 2) - bottomAirT0)
eq2 = htc2*(bottomAirT - bottomAirT0)
% plot(topAirT(:,1), eq1, 'linewidth', 2);
% hold on;
% plot(bottomAirT(:,1), eq2, 'linewidth', 2);
% legend('Top Air', 'Bottom Air');



