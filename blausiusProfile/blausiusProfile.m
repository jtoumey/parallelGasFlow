
%% Problem parameters
nu = 5.831e-05; % m^2/s
xLength = 0.2;
U0 = 0.7432;

y = linspace(0, 0.05, 100);
%% Blausius solution for eta << 1
blThickness = sqrt(nu*xLength/U0);
eta = y./blThickness;

alpha = 0.332057336215196;
% Stream function
f = 0.5*alpha*eta.^2;

fPrime = alpha*eta;


blausiusSol = [0 0 0;
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


