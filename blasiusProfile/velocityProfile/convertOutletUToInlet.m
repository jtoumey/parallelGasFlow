
clear all
close all
clc

topAirU = importdata('./dataFiles/topAir_line_U.xy');
bottomAirU = importdata('./dataFiles/bottomAir_line_U.xy');

%% Write the data--topAir
fileIdTopAir = fopen('topAirU', 'w');

% Write the BC header 
fprintf(fileIdTopAir, '    minX\n');
fprintf(fileIdTopAir, '    {\n');
fprintf(fileIdTopAir, '        type            fixedValue;\n');
fprintf(fileIdTopAir, '        value           nonuniform List<vector>\n');
fprintf(fileIdTopAir, '        (\n');   

% Inner loop is on y-axis
for jj = 1:50
    fprintf(fileIdTopAir, '            (%s  0.0  0.0)\n', num2str(topAirU(jj, 2)));
end

% End the BC file
fprintf(fileIdTopAir, '        );\n');
fprintf(fileIdTopAir, '    }\n');
fclose(fileIdTopAir);

%% Write the data--bottomAir
fileIdBottomAir = fopen('bottomAirU', 'w');

% Write the BC header 
fprintf(fileIdBottomAir, '    minX\n');
fprintf(fileIdBottomAir, '    {\n');
fprintf(fileIdBottomAir, '        type            fixedValue;\n');
fprintf(fileIdBottomAir, '        value           nonuniform List<vector>\n');
fprintf(fileIdBottomAir, '        (\n');   

% Inner loop is on y-axis
for jj = 1:50
    fprintf(fileIdBottomAir, '            (%s  0.0  0.0)\n', num2str(bottomAirU(jj, 2)));
end

% End the BC file
fprintf(fileIdBottomAir, '        );\n');
fprintf(fileIdBottomAir, '    }\n');
fclose(fileIdBottomAir);