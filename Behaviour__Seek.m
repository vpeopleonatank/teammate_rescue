function Behaviour__Seek()
global TimeSteps;
global BoidsNum;
global Boids;

global Reds;
global RedsNum;
global Blues;
global BluesNum;

global Targets;
global SaveMousePosition;
global saveText;
global ImageWidth;
Wingspan = ImageWidth;
global FleeDistance;

global DameOfBlue;
global DameOfRed;

global ThresholdRed;
global ThresholdBlue;

global Obstacles;
global ObstaclesNum;
global k ;

%% first draw
[v_ImageB,v_AlphaB,BluesPlot,v_ImageR,v_AlphaR,RedsPlot,fHandler,RangerViewPlotBlues,RangerViewPlotReds,HPPlotBlues,HPPlotReds]=InitializeGraphics()

Target = [-400 -400 0];
SaveTarget = plot(Target(1), Target(2), 'o','MarkerSize',10, 'MarkerFaceColor','r','Color','r');

MousePosition = [0 0 0];
titleStr = 'Combination of Flocking and Collision Avoidance Behaviors';
titleStr = [titleStr newline '(Use mouse to create a new obstacle)']
title(titleStr);
set(fHandler, 'WindowButtonDownFcn',@cursorClickCallback);
k=1;

%% 
%Event Mouse click
    function cursorPosition = cursorClickCallback(o,e)
        p = get(gca,'CurrentPoint');
        cursorPosition(1:2) = p(1,1:2);
        cursorPosition(3) = 0;
        MousePosition = cursorPosition;
        ObstaclesNum = ObstaclesNum + 1;
        Obstacles(ObstaclesNum, 1:3) = zeros(1, 3);
        %Draw Circle - position 
        SaveMousePosition = plot(MousePosition(1), MousePosition(2), 'o','MarkerSize',6, 'MarkerFaceColor','blue','Color','blue');
        Obstacles(ObstaclesNum, 1:3) = MousePosition(1:3);
        k= ObstaclesNum;
    end

%% calculate agent
timeTick = 1;
while (timeTick < TimeSteps)
    if( k < BluesNum )
        for Index = ( k +1) : ( BluesNum +1)
            Obstacles( Index ,(1:3)) = Target(1:3);
        end
    end
    
    for BlueIndex = 1:BluesNum
        Blues = updateAtBoundary(Blues,BlueIndex);
        CurrentBoid = Blues(BlueIndex, :);
        force = steer_seek(CurrentBoid, Obstacles(BlueIndex + 1,1:3));
        Blues(BlueIndex,:) = applyForce(CurrentBoid, force);
    end
    % redraw
    RedrawGraphics(Blues,BluesNum,v_ImageB,v_AlphaB,BluesPlot,HPPlotBlues);
    timeTick = timeTick+1;
end
end