function [pos1,pos2] = findTwoNearestBoids(Boids,boidsNum, targetPos)
pos1 = 0; pos2 = 0;
min1 = 999999; min2 = 999999; % min1 nho nhat
for boidIndex = 1:boidsNum
    if (boidIndex ~= targetPos)
        d = dist(Boids(boidIndex,1:3), Boids(targetPos, 1:3));
        if( d< min1)
            min2 = min1;
            pos2 = pos1;
            min1 = d;
            pos1 = boidIndex;
        elseif(d < min2)
            min2 = d;
            pos2 = boidIndex;
        end
    end
    
end
end

