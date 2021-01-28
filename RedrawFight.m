function RedrawFight(v_Image,v_Alpha,FightsPlot)
global FightsNum;
global Fights;

for i = 1: FightsNum
    angle = 0;	% imrotate rotates ccw     
    img_i = imrotate(v_Image, angle);
    alpha_i = imrotate(v_Alpha, angle);
    FightsPlot(i).CData=img_i;
    FightsPlot(i).AlphaData=alpha_i;
    try
        FightsPlot(i).XData=Fights(i,1) ;
        FightsPlot(i).YData=Fights(i,2) ;
    catch Me
        disp('hi')
        [Fights(i,1),Fights(i,2)]
    end
end
drawnow;
