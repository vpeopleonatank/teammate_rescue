function [Boids, BoidsIndex]  = steer_Arrival_Formation_Arc(Target, Boids, BoidsNum, Leader, D_Behind, D_Beside,...
                    Alpha_Horizontal, NumberBoidsOnTop, NumberBoidsOnBranch)

% Array of flags for boids to mark what boid is arranged to the left or the right
% BoidsFlag(i) = 1 means the Boid i-th was arranged to the left or the right
BoidsFlag = zeros(1, BoidsNum);
BoidsFlag(1) = 1;

% Calculate the Weights for each Boid
WeightsMatrix = WeightFunction_Arrival_Formation_V(Target, Boids, BoidsNum, Alpha_Horizontal, D_Behind, D_Beside);
BoidsIndex(1) = 1;

[RightBesideLeader, LeftBesideLeader] = FindBesideLeader(Leader, Alpha_Horizontal, D_Behind, D_Beside);
[LeaderRight,BoidsFlag,MinRightIndex] = NearestBoid(Boids, BoidsNum,RightBesideLeader, BoidsFlag);
BoidsIndex(2) = MinRightIndex;
Weight = WeightsMatrix(MinRightIndex);
[LeaderRight,Boids] = Move_Arrival_Formations(Target, Weight, Boids, BoidsNum, LeaderRight,Leader,RightBesideLeader, MinRightIndex);

[LeaderLeft,BoidsFlag,MinLeftIndex] = NearestBoid(Boids, BoidsNum,LeftBesideLeader, BoidsFlag);
BoidsIndex(3) = MinLeftIndex;
Weight = WeightsMatrix(MinLeftIndex);
[LeaderLeft, Boids] = Move_Arrival_Formations(Target, Weight, Boids,BoidsNum,LeaderLeft,Leader,LeftBesideLeader,MinLeftIndex);

while (sum(BoidsFlag) < BoidsNum)
    BoidIndex = sum(BoidsFlag) + 1;
    D_Beside_tmp = D_Beside;
    D_Behind_tmp = D_Behind;
    if ((BoidIndex > NumberBoidsOnTop) && (BoidIndex <= NumberBoidsOnTop + 2*NumberBoidsOnBranch))
        D_Behind_tmp = D_Behind + 10;
        D_Beside_tmp = D_Beside_tmp - 10;
    else
        if (BoidIndex >= NumberBoidsOnTop + NumberBoidsOnBranch)          
            D_Behind_tmp = D_Behind + 20;
        end
    end
    
    [RightBesideLeader, ~] = FindBesideLeader(LeaderRight, Alpha_Horizontal, D_Behind_tmp, D_Beside_tmp);
    [NearestRight, BoidsFlag, MinRightIndex] = NearestBoid(Boids, BoidsNum,RightBesideLeader, BoidsFlag);
    BoidsIndex(BoidIndex) =  MinRightIndex;  
    Weight = WeightsMatrix(MinRightIndex);
    [NearestRight, Boids] = Move_Arrival_Formations(Target, Weight, Boids, BoidsNum, NearestRight,LeaderRight,RightBesideLeader, MinRightIndex);
    LeaderRight = NearestRight;
    
    [~, LeftBesideLeader] = FindBesideLeader(LeaderLeft, Alpha_Horizontal, D_Behind_tmp, D_Beside_tmp);
    [NearestLeft,BoidsFlag,MinLeftIndex] = NearestBoid(Boids, BoidsNum,LeftBesideLeader, BoidsFlag);
    BoidsIndex(BoidIndex + 1) =  MinLeftIndex;
    Weight = WeightsMatrix(MinLeftIndex);
    [NearestLeft, Boids] = Move_Arrival_Formations(Target, Weight, Boids, BoidsNum, NearestLeft,LeaderLeft,LeftBesideLeader, MinLeftIndex);
    LeaderLeft = NearestLeft;
end
end