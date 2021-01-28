function [v_ImageAmbu,v_AlphaAmbu] = LoadAmbulance()
AmbulanceWidth = 130; AmbulanceHeight = 180;
[v_ImageAmbu, ~, v_AlphaAmbu]	= imread('ambulance1.png');
v_ImageAmbu = imresize(v_ImageAmbu, [AmbulanceWidth AmbulanceHeight], 'lanczos3' );
v_AlphaAmbu = imresize(v_AlphaAmbu, [AmbulanceWidth AmbulanceHeight], 'lanczos3' );

end