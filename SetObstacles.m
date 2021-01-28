function SetObstacles()
global Obstacles;
global ObstaclesNum;
Obstacles(: ,3) = 0;
Obstacles(1,1) =200; Obstacles(1,2) =-200; Obstacles(1,4) = 60;
% Obstacles(2,1) =200; Obstacles(2,2) =200; Obstacles(2,4) = 60;
Obstacles(2,1) =2000; Obstacles(2,2) =2000; Obstacles(2,4) = 60;

% Obstacles(3,1) =-50; Obstacles(3,2) =-50; Obstacles(3,4) = 75;
Obstacles(3,1) =-5000; Obstacles(3,2) =-5000; Obstacles(3,4) = 75;

Obstacles(4,1) =0; Obstacles(4,2) =200; Obstacles(4,4) = 60;
% Obstacles(5,1) =-500; Obstacles(5,2) =-100; Obstacles(5,4) = 75;
% Obstacles(6,1) =-100; Obstacles(6,2) =-450; Obstacles(6,4) = 80;
Obstacles(5,1) =-500; Obstacles(5,2) =-10000; Obstacles(5,4) = 75;
Obstacles(6,1) =-70; Obstacles(6,2) =-70; Obstacles(6,4) = 80;
end