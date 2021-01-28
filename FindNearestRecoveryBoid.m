function [pos] = FindNearestRecoveryBoid(currentBoid, Boids, boidStatus, status, BoidsNum, thresholdHP)

temp = 99999;   pos = 0;
for i = 1:BoidsNum
    distance = dist(Boids(i, 1:3), currentBoid(1:3));
   if(distance < temp && Boids(i, 15) > thresholdHP && boidStatus(status, i) == 0)
      pos = i;
      temp = distance;
   end
end
end

