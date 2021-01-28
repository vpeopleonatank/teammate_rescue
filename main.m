function main()
%% Global variables
global TimeSteps;
TimeSteps = 50000;
global RedsNum;
global Targets;
global BluesNum;
global Blues;
global RangeView;
global MaxBlueNum MaxRedNum FightsNum;
MaxBlueNum =20;
MaxRedNum =15;
FightsNum =2;
% Set global variables
SET_GLOBAL_VARIABLES()
SetObstacles()
BluesNum = 6; % Choose number of Boids to demo
RedsNum = 6; % Choose number of Boids to demo
Targets = zeros(1,RedsNum);
RangeView=0;
Behaviour__SeekBlue()
end