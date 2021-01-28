function [Boids] = InitArcFormationForFlock(Boids,BoidsNum, LeaderPos, image, alpha, BoidsPlot)
    global D_Behind D_Beside NumberBoidsOnTop NumberBoidsOnBranch...
    v_ImageE v_AlphaE;
%% INITIALIZE ARC-FORMATION FOR FLOCK
Boids(1,1:3) = LeaderPos;
Boids(1,:) = applyForce(Boids(1,:), 0);
Leader = Boids(1, :);

% Calculate the horizontal angle of the Leader
Alpha_Horizontal = CalculationHorizontalAngle(Leader);

%Find the RightBeside and LeftBeside positions of Leader
[RightBesidePosition, LeftBesidePosition] = FindBesideLeader(Leader, ...
    Alpha_Horizontal, D_Behind, D_Beside);

% Assign 2-nd Boid to the right of 1-st Boid
Boids(2, 1:6) = RightBesidePosition;
Boids(2,:) = applyForce(Boids(2,:), 0);
RightBesidePosition = Boids(2, :);

% Assign 3-rd boid to the left of of 1-st Boid
Boids(3, 1:6) = LeftBesidePosition;
Boids(3,:) = applyForce(Boids(3,:), 0);
LeftBesidePosition = Boids(3, :);

BoidIndex = 4;
while BoidIndex <= BoidsNum
    D_Beside_tmp = D_Beside;
    D_Behind_tmp = D_Behind;
    if ((BoidIndex > NumberBoidsOnTop) && (BoidIndex <= NumberBoidsOnTop + 2*NumberBoidsOnBranch))
        D_Behind_tmp = D_Behind + 10;
        D_Beside_tmp = D_Beside_tmp - 10;
    else
        if (BoidIndex >= NumberBoidsOnTop + 2*NumberBoidsOnBranch)
            D_Behind_tmp = D_Behind + 20;
        end
    end
    %Find the RightBeside position of RightBesidePosition (2-nd Boid)
    [RightBesidePosition, ~] = FindBesideLeader(RightBesidePosition, ...
        Alpha_Horizontal, D_Behind_tmp, D_Beside_tmp);
    Boids(BoidIndex, 1:6) = RightBesidePosition;
    RightBesidePosition = Boids(BoidIndex,:);
    Boids(BoidIndex,:) = applyForce(Boids(BoidIndex,:), 0);
    
    BoidIndex = BoidIndex + 1;
    [~, LeftBesidePosition] = FindBesideLeader(LeftBesidePosition, ...
        Alpha_Horizontal, D_Behind_tmp, D_Beside_tmp);
    Boids(BoidIndex, 1:6) = LeftBesidePosition;
    LeftBesidePosition = Boids(BoidIndex,:);
    Boids(BoidIndex,:) = applyForce(Boids(BoidIndex,:), 0);
    
    BoidIndex = BoidIndex + 1;
end
RedrawBoid(Boids,BoidsNum,image,alpha,v_ImageE,v_AlphaE,BoidsPlot);
end

