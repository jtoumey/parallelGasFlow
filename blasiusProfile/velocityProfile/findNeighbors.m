function [nbrIndexLt, nbrIndexGt] = findNeighbors(coord, data)

    nbrIndexLt = -1;
    nbrIndexGt = -1;
    % Compare yCc to each point from the DNS data and find neighbors
    minNbrDistLt = 1e6;
    minNbrDistGt = 1e6;
    for jj = 1:size(data, 1)
        yData = data(jj, 1);
        nbrDist = abs(yData - coord);
        % Find smaller neighbor
        if yData < coord + 1e-12
            if nbrDist < minNbrDistLt
                minNbrDistLt = nbrDist;
                nbrIndexLt = jj;
            end

        % Find larger neighbor
        else
            if nbrDist < minNbrDistGt
                minNbrDistGt = nbrDist;
                nbrIndexGt = jj;
            end
        end
    end
end