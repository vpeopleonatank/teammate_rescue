function [v_ImageF,v_AlphaF]=LoadImageFight()

[v_ImageF, ~, v_AlphaF]	= imread('Fight.png');
v_ImageF = imresize(v_ImageF, [100 400], 'lanczos3' );
v_AlphaF = imresize(v_AlphaF, [100 400], 'lanczos3' );
