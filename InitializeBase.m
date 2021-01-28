function [BasesPlot]=InitializeBase(v_ImageBB,v_AlphaBB,v_ImageBR,v_AlphaBR,v_ImageBF,v_AlphaBF)
global BaseB;
global BaseR;

%%base field
angle = -180;	% imrotate rotates ccw
img_i = imrotate(v_ImageBF, angle);
alpha_i = imrotate(v_AlphaBF, angle );
img_i = flipdim(img_i, 2);
alpha_i = flipdim(alpha_i, 2);

BasesPlot= image(-600, -600, img_i);
BasesPlot.AlphaData = alpha_i;
%%base 1
% angle = -180;	% imrotate rotates ccw
% img_i = imrotate(v_ImageBR, angle);
% alpha_i = imrotate(v_AlphaBR, angle );
% BasesPlot= image(BaseR(1)-200, BaseR(2)-200, img_i);
% BasesPlot.AlphaData = alpha_i;

%%base 2
angle = -180;	% imrotate rotates ccw
img_i = imrotate(v_ImageBB, angle);
alpha_i = imrotate(v_AlphaBB, angle );
BasesPlot= image(BaseB(1), BaseB(2), img_i);
BasesPlot.AlphaData = alpha_i;
