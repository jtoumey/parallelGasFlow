
clear all
close all
clc

topAirU = importdata('./dataFiles/topAir_line_U.xy');
bottomAirU = importdata('./dataFiles/bottomAir_line_U.xy');

%% Write the data--topAir
% Points file
topAir.y0 = 0.055;
topAir.y1 = 0.105;
topAir.ny = 50;
topAir.dy = (topAir.y1 - topAir.y0)/topAir.ny;
topAir.yCc = linspace(0.055 + 0.001/2., 0.105 - 0.001/2., 50);

pointsFileIdTopAir = fopen('topAirPoints', 'w');

fprintf(pointsFileIdTopAir, '// Points, topAir\n');
fprintf(pointsFileIdTopAir, '%s\n', num2str(topAir.ny));
fprintf(pointsFileIdTopAir, '(\n');
for ii = 1:topAir.ny
    fprintf(pointsFileIdTopAir, '    (0.0  %s  0.0005)\n', num2str(topAir.yCc(ii)));
end
fprintf(pointsFileIdTopAir, ')\n');
fclose(pointsFileIdTopAir);

%% Velocity file--topAir
UFileIdTopAir = fopen('topAirU', 'w');

% Write the BC header 
fprintf(UFileIdTopAir, '// Velocity, topAir\n');
fprintf(UFileIdTopAir, '%s\n', num2str(topAir.ny));
fprintf(UFileIdTopAir, '(\n');
for ii = 1:topAir.ny
    fprintf(UFileIdTopAir, '    (%s  0.0  0.0)\n', num2str(topAirU(ii, 2)));
end
fprintf(UFileIdTopAir, ')\n');
fclose(UFileIdTopAir);

%% Write the data--bottomAir
% Points file
bAir.y0 = 0.0;
bAir.y1 = 0.055;
bAir.ny = 50;
bAir.dy = (bAir.y1 - bAir.y0)/bAir.ny;
bAir.yCc = linspace(0.0 + 0.001/2., 0.05 - 0.001/2., 50);

pointsFileIdBottomAir = fopen('bottomAirPoints', 'w');

fprintf(pointsFileIdBottomAir, '// Points, bottomAir\n');
fprintf(pointsFileIdBottomAir, '%s\n', num2str(bAir.ny));
fprintf(pointsFileIdBottomAir, '(\n');
for ii = 1:topAir.ny
    fprintf(pointsFileIdBottomAir, '    (0.0  %s  0.0005)\n', num2str(bAir.yCc(ii)));
end
fprintf(pointsFileIdBottomAir, ')\n');
fclose(pointsFileIdBottomAir);

%% Velocity file
UFileIdBottomAir = fopen('bottomAirU', 'w');

% Write the BC header 
fprintf(UFileIdBottomAir, '// Velocity, bottomAir\n');
fprintf(UFileIdBottomAir, '%s\n', num2str(bAir.ny));
fprintf(UFileIdBottomAir, '(\n');
for ii = 1:topAir.ny
    fprintf(UFileIdBottomAir, '    (%s  0.0  0.0)\n', num2str(bottomAirU(ii, 2)));
end
fprintf(UFileIdBottomAir, ')\n');
fclose(UFileIdBottomAir);
