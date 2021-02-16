
format compact
Ux  = 0.7423;

%% Transformed coordinates
etaMax = 10;
nSteps = 20;
deltaEta = etaMax/nSteps;

eta = 0.0;
fs(1) = 0.0;
fs(2) = 0.0;
fs(3) = 0.332

fSolution = fs;

iter = 0
while eta < etaMax
    iter = iter+ 1
    %
    K1 = rhs(fs);
    K2 = 
    K3 = 
    K4 = 
    fs2 = fs + deltaEta*(K2 + 2.0*K2 + 2.0*K3 + K4)/6.;
    % 
    eta = eta + deltaEta; 
    k1 = fs + 0.5*deltaEta*rhs(fs);
    k2 = fs + 0.5*deltaEta*rhs(k1);
    k3 = fs + deltaEta*rhs(k2);
    fs = (k1 + 2.0*k2 + k3 - fs)/3. + deltaEta*rhs(k3)/6.;
    
    fSolution = [fSolution; fs];

end

plot(fSolution(:, 2), fSolution (:, 1))

%%
function [rhsEval] = rhs(gg)
    rhsEval(1) = gg(2); 
    rhsEval(2) = gg(3);
    rhsEval(3) = -0.5*gg(1)*gg(3);
end

function [advancedState] = rungeKutta4(state, statePrime, h)

%     k1 = 
%     k2 =
%     k3 =
%     k4 = 
% 
%     advancedState = state + (h/6.)*(k1 + 2.0*k2 + 2.0*k3 + k4);
% end