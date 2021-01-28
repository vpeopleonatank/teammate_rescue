function [FightsPlot]=InitializeFight(v_Image,v_Alpha)
global Fights;
global FightsNum;
global ObstaclesF;
angle = 0;	% imrotate rotates ccw     
for i = 1: FightsNum
    img_i = imrotate(v_Image, angle);
    alpha_i = imrotate(v_Alpha, angle );
    FightsPlot(i) = image(Fights(i,1), Fights(i,2), img_i);
    FightsPlot(i).AlphaData = alpha_i;   
    ObstaclesF(i,1)=-Fights(i,2);
    ObstaclesF(i,2)=-Fights(i,1);
end