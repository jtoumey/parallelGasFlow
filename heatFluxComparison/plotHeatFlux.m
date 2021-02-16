%--------------------------------------------------------------------------
% plotHeatFlux
% Jan. 2021
% Julian M. Toumey
% julian.toumey@uconn.edu
%
%--------------------------------------------------------------------------
clear all
close all
clc

%% Load the heat flux data
whfSolid =  readtable('./dataFiles/wallHeatFlux_solid_100.0to101.1.dat');
whfTopAir = readtable('./dataFiles/wallHeatFlux_topAir_100.0to101.1.dat');

%% Plot The Data
plot(whfSolid.x_Time, whfSolid.integral, 'o', 'MarkerIndices', 1:4:length(whfSolid.integral));% 'linewidth', 2)
hold on;
plot(whfTopAir.x_Time, -whfTopAir.integral, '+', 'MarkerIndices', 1:4:length(whfTopAir.integral));% 'linewidth', 2, 'linestyle', '--')

% Format the plot
legend('$\phantom{-}$Solid', '$-$TopAir', 'Interpreter', 'latex', 'fontsize', 14, 'location','eastoutside');
xlabel('Time (sec)', 'Interpreter', 'latex', 'fontsize', 18);
ylabel('Integrated Heat Flux (W)', 'Interpreter', 'latex', 'fontsize', 18);

saveas(gcf, 'pgf07_heatFlux_100.0to101.1.pdf');