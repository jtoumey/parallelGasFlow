clear all
close all
clc
%% Problem parameters
nu = 2.97e-4;  % m^2/s
xLength = 0.1;
U0 = 0.7432;

y = linspace(0, 0.05, 100);
%% Blasius solution for eta << 1
blThickness = sqrt(nu*xLength/U0);
eta = y./blThickness;

alpha = 0.332057336215196;
% Stream function
f = 0.5*alpha*eta.^2;

fPrime = alpha*eta;

%%
% topAirData = readmatrix('topAir_plotOverLine_t33s.csv', 'NumHeaderLines',1);
topAirData = readmatrix('UX_xL_t33s.csv', 'NumHeaderLines', 1);

[etaNum, fNum] = shooting;

blasiusSol = [0 0 0;
0.5 0.0415 0.1659;
1.0 0.1656 0.3298;
1.5 0.3701 0.4868;
2.0 0.6500 0.6298;
2.5 0.9963 0.7513; 
3.0 1.3968 0.8460; 
3.5 1.8377 0.9130; 
4.0 2.3057 0.9555; 
4.5 2.7901 0.9795; 
5.0 3.2833 0.9915; 
5.5 3.7806 0.9969; 
6.0 4.2796 0.9990; 
6.5 4.7793 0.9997; 
7.0 5.2792 0.9999; 
7.5 5.7792 1.0000; 
8.0 6.2792 1.0000];

plot(topAirData(:, 2), topAirData(:, 12)-0.055, '--*', 'MarkerIndices', 1:10:length(topAirData(:, 13)));
hold on
plot(blasiusSol(:,3).*U0, blasiusSol(:,1).*blThickness, 'LineWidth', 2);
xlabel('Ux [m/s]', 'fontsize', 16);
ylabel('y-Location [m]', 'fontsize', 16);

% hold on
% plot(fNum(:,2).*U0, etaNum.*blThickness, '-o')

legend('Simulation: topAir', 'Blasius Solution', 'Location', 'northwest', 'fontsize', 16);
saveas(gcf, 'topAirVsBlasius.png');






%% Solving the Blasius Equation for Boundary Layer Flow Over a Flat Plate
%Created by Mohammad A Alkhadra on November 3, 2018
%The equation we wish to solve is f''' + (1/2)*f*f'' with f(0) = 0, f'(0) = 0,
%f'(inf) = 1. We recast this problem as a system of first-order ODEs: y =
%[f; f'; f''] = [y(1); y(2); y(3)] so that dy/dEta = y' = [f'; f''; f'''] =
%[y(2); y(3); -(1/2)*y(1)*y(3)] with y(1)(0) = 0, y(2)(0) = 0, y(2)(inf) = 1.


%% Supplementary Functions
function [x,y] = shooting
% Use fsolve to ensure the boundary function is zero. The result is the
% unknown initial condition.
opt = optimset('Display','off','TolFun',1E-20);
F = fsolve(@(F) eval_boundary(F),[0,0,0.33],opt);
% Solve the ODE-IVP with the converged initial condition
[x,y] = solve_ode(F);
end
function [x,y] = solve_ode(F)
% Solve the ODE-IVP with initial condition F on [0 100] (arbitrary upper
% bound)
[x,y] = ode45(@(x,y) [y(2); y(3); -0.5*y(1)*y(3)],[0 100],F); %solve BVP                
end
function [g] = eval_boundary(F)
% Get the solution to the ODE with inital condition F
[x,y] = solve_ode(F);
% Get the function values (for BCs) at the starting/end points
f_start = y(1,1); %f(0) = 0
df_start = y(1,2); %f'(0) = 0
df_end = y(end,2); %f'(inf) - 1 = 0
% Evaluate the boundary function
g = [f_start
     df_start
     df_end - 1];
end

