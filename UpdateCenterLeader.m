function [Boids] = UpdateCenterLeader(Boids,BoidsNum)

avg_x = 0;
avg_y = 0;
pos = 0;
count = 0;
temp_dist = 999999;
for i = 1:BoidsNum
    if(Boids(i,15) > 0)
        avg_x = avg_x + Boids(i, 1);
        avg_y = avg_y + Boids(i, 2);
        count = count + 1;
    end
end
avg_x = avg_x / count;
avg_y = avg_y / count;
for i = 1:BoidsNum
    distance = dist(Boids(i,1:3), [avg_x avg_y 0]);
    if(Boids(i, 15) > 0 && distance < temp_dist)
       temp_dist = distance;
       pos = i;
    end
end
if (pos ~= 0)
   temp = Boids(1, :);
   Boids(1, :) = Boids(pos, :);
   Boids(pos, :) = temp;
end
end

