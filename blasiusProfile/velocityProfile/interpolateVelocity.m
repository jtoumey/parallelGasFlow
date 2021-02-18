function [velocityInterp] = interpolateVelocity(yCoord, velData)

    nCellsY0 = size(yCoord, 2);
    velocityInterp = zeros(1, nCellsY0);
    
%     % The top wall extent: yByDeltaMax = (channelHeight/deltaBl)
%     % deltaBl/h = 0.2287
%     yByDeltaMax = 8.334492147331668;
    
    % Loop on our given y-coordinates
    for ii = 1:nCellsY0
        yCc = yCoord(ii);
%         fprintf('ii: %3i; yCc: %6.3f\n', ii, yCc);
        
        % Identify coordinates within the BL
        % BL thickness: scaled is 0.2287*stepHeight
%         if yCc < 1
            
            [nbrIndexGt, nbrIndexLt] = findNeighbors(yCc, velData);
            % Linear interpolation
            x0 = velData(nbrIndexLt, 1);
            x1 = velData(nbrIndexGt, 1);
            u0 = velData(nbrIndexLt, 2);
            u1 = velData(nbrIndexGt, 2);
            
            velocityInterp(ii) = linearInterpolate(x0, u0, x1, u1, yCc);
        
        % Top wall boundary layer
%         elseif (yByDeltaMax - yCc) < 1
%             yCcTop = yByDeltaMax - yCc;
%             [nbrIndexGt, nbrIndexLt] = findNeighbors(yCcTop, velData);
%             
%             % Interpolate velocity
%             x0 = velData(nbrIndexLt, 1);
%             x1 = velData(nbrIndexGt, 1);
%             u0 = velData(nbrIndexLt, 2);
%             u1 = velData(nbrIndexGt, 2);
%             
%             velocityInterp(ii) = linearInterpolate(x0, u0, x1, u1, yCcTop);
% 
%         % Freestream conditions
%         else
%             velocityInterp(ii) = 1;
%         end
    end
end