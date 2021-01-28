function [ambulancePlot] = initAmbulance(v_ImageAmbu,v_AlphaAmbu)
global Ambu
angle = -180;	% imrotate rotates ccw     
img_i = imrotate(v_ImageAmbu, angle);
alpha_i = imrotate(v_AlphaAmbu, angle );
% img_i = flipdim(img_i, 2);
% alpha_i = flipdim(alpha_i, 2);
ambulancePlot= image(Ambu(1), Ambu(2), img_i);
ambulancePlot.AlphaData = alpha_i;
end
