
xLength = 0.2;

%% topAir: Fluid region 0
mu1 = 58.31e-6; 
rho1 = 0.1963;
Ux1 = 0.7432;

k1 = 0.1028755;
ReX1 = (rho1*Ux1*xLength)/mu1;
Pr1 = 0.7;

% Empirical
htc1 = 0.332*ReX1^0.5*Pr1^(1./3.); 

%% bottomAir: Fluid region 1
mu2 = 1.845e-5;
rho2 = 1.177;
Ux2 = 0.0392;

k2 = 0.026515286;
ReX2 = (rho2*Ux2*xLength)/mu2;
Pr2 = 0.7;

htc2 = 0.332*ReX2^0.5*Pr2^(1./3.); 

%% 
time = [3.33 6.5]
TCenter1 = [808.124 ] 
TCenter2 = [798.931 798.99]
  
lhs = htc1*(1800 - 810.66589)
rhs = htc2*(300 - 798.88963)


