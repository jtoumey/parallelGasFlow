% velocityProfile.m
%
% This script reads the velocity profile extracted from a previous run and
% interpolates the data to use at the inflow of an additional run.
%

%% Preliminaries
clear all
close all
clc

format long
format compact

%% Load and parse the data
topAirU = importdata('pgf12_topAir_xL0.975_t999s.csv');

simData.yLocation = topAirU.data(:, 10);
simData.UX = topAirU.data(:, 2);
yLocUX = [simData.yLocation simData.UX];
yLocUX = yLocUX(2:end, :);

% Quick plot
figure (1)
plot(simData.UX, simData.yLocation, 'linewidth', 2)
xlabel('U_x (m/s)', 'fontsize', 16);
ylabel('y Location (m)', 'fontsize', 16);
saveas(gcf, 'yUx.pdf')
%% 
numCellsY = 100;
numPointsY = numCellsY + 1;
yPoints = linspace(0.055, 0.105, numPointsY);
yCellCenters = (yPoints(1:end-1) + yPoints(2:end))/2.0;

UInterp = interpolateVelocity(yCellCenters, yLocUX);

numCellsZ = 1;
zPoints = 0.0005; 

%% Write the data in OF format
% Points file
fileId = fopen('points', 'w');
% Write the header 
fprintf(fileId, '// Points\n');
fprintf(fileId, '%s\n', num2str(numCellsY));
fprintf(fileId, '(\n');

% Outer loop is on z axis
for kk = 1:numCellsZ
    % Inner loop is on y-axis
    for jj = 1:numCellsY
        fprintf(fileId, '    (0.0  %s  %s)\n', num2str(yCellCenters(jj)), num2str(zPoints));
    end
end

% Finalize the file
fprintf(fileId, ')\n');
fclose(fileId);

% Velocity file
fileId = fopen('U', 'w');
% Write the header 
fprintf(fileId, '// U (velocity)\n');
fprintf(fileId, '%s\n', num2str(numCellsY));
fprintf(fileId, '(\n');

% Outer loop is on z axis
for kk = 1:numCellsZ
    % Inner loop is on y-axis
    for jj = 1:numCellsY
        fprintf(fileId, '    (%s  0.0  0.0)\n', num2str(UInterp(jj)));
    end
end

% Finalize the file
fprintf(fileId, ')\n');
fclose(fileId);
