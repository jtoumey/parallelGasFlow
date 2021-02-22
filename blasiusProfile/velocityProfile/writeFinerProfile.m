
clear all
close all
clc

format long
format compact
topAirU = importdata('./dataFiles/topAir_line_U.xy');
bottomAirU = importdata('./dataFiles/bottomAir_line_U.xy');

% topAir: Interpolate velocity to ny = 100 grid
topAir.yCc = linspace(0.055 + 0.001/2., 0.105 - 0.001/2., 50);
topAir.yCcRef = linspace(0.055 + 0.0005/2., 0.105 - 0.0005/2., 100);
topAir.URef = interp1(topAir.yCc, topAirU(:, 2), topAir.yCcRef, 'linear', 'extrap');

% bottomAir
bottomAir.yCc = linspace(0.0 + 0.001/2., 0.05 - 0.001/2., 50);
bottomAir.yCcRef = linspace(0.0 + 0.0005/2., 0.05 - 0.0005/2., 100);
bottomAir.URef = interp1(bottomAir.yCc, bottomAirU(:, 2), bottomAir.yCcRef, 'linear', 'extrap');


%% Write the data--topAir
fileIdTopAir = fopen('topAirU_refined', 'w');

%% Write the BC header 
fprintf(fileIdTopAir, '    minX\n');
fprintf(fileIdTopAir, '    {\n');
fprintf(fileIdTopAir, '        type            fixedValue;\n');
fprintf(fileIdTopAir, '        value           nonuniform List<vector>\n');
fprintf(fileIdTopAir, '        (\n');   

% Inner loop is on y-axis
for jj = 1:100
    fprintf(fileIdTopAir, '            (%s  0.0  0.0)\n', num2str(topAir.URef(jj)));
end

% End the BC file
fprintf(fileIdTopAir, '        );\n');
fprintf(fileIdTopAir, '    }\n');
fclose(fileIdTopAir);

%% Write the data--bottomAir
fileIdBottomAir = fopen('bottomAirU_refined', 'w');

% Write the BC header 
fprintf(fileIdBottomAir, '    minX\n');
fprintf(fileIdBottomAir, '    {\n');
fprintf(fileIdBottomAir, '        type            fixedValue;\n');
fprintf(fileIdBottomAir, '        value           nonuniform List<vector>\n');
fprintf(fileIdBottomAir, '        (\n');   

% Inner loop is on y-axis
for jj = 1:100
    fprintf(fileIdBottomAir, '            (%s  0.0  0.0)\n', num2str(bottomAir.URef(jj)));
end

% End the BC file
fprintf(fileIdBottomAir, '        );\n');
fprintf(fileIdBottomAir, '    }\n');
fclose(fileIdBottomAir);