%% Solving the Blasius Equation for Boundary Layer Flow Over a Flat Plate
%Created by Mohammad A Alkhadra on November 3, 2018
clc; clear all;
%The equation we wish to solve is f''' + (1/2)*f*f'' with f(0) = 0, f'(0) = 0,
%f'(inf) = 1. We recast this problem as a system of first-order ODEs: y =
%[f; f'; f''] = [y(1); y(2); y(3)] so that dy/dEta = y' = [f'; f''; f'''] =
%[y(2); y(3); -(1/2)*y(1)*y(3)] with y(1)(0) = 0, y(2)(0) = 0, y(2)(inf) = 1.
[x,y] = shooting;
figure; hold on;
plot(y(:,1),x,'k-','Linewidth',2)
plot(y(:,2),x,'r-','Linewidth',2)
plot(y(:,3),x,'b-','Linewidth',2)
figformat
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
function figformat
% This function simply formats the figure
xlabel('\it{f, f^{(1)}, f^{(2)}}');
ylabel('\eta');
xlim([0 2]);
xticks(0:0.5:2);
ylim([0 10]);
h = legend('\it{f}','\it{f}^{(1)}','\it{f^{(2)}}','Location','NorthEast');
legend boxoff;
set(h,'FontSize',18);
axis square
set(gca, 'box', 'on'); %creates a box border
set(gca,'FontWeight','normal','linewidth',1.05); fontname = 'Arial'; %the next few lines format the plot
set(0,'defaultaxesfontname',fontname); set(0,'defaulttextfontname',fontname);
fontsize = 20;
set(0,'defaultaxesfontsize',fontsize); set(0,'defaulttextfontsize',fontsize);
end