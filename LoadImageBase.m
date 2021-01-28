function [v_ImageBB,v_AlphaBB,v_ImageBR,v_AlphaBR,v_ImageBF,v_AlphaBF,v_ImageF,v_AlphaF]=LoadImageBase()

[v_ImageBB, ~, v_AlphaBB]	= imread('baseB.png');
v_ImageBB = imresize(v_ImageBB, [320 280], 'lanczos3' );
v_AlphaBB = imresize(v_AlphaBB, [320 280], 'lanczos3' );

[v_ImageBR, ~, v_AlphaBR]	= imread('baseR.png');
v_ImageBR = imresize(v_ImageBR, [320 280], 'lanczos3' );
v_AlphaBR = imresize(v_AlphaBR, [320 280], 'lanczos3' );

[v_ImageBF, ~, v_AlphaBF]	= imread('baseF.png');
v_ImageBF = imresize(v_ImageBF, [1200 1200], 'lanczos3' );
v_AlphaBF = imresize(v_AlphaBF, [1200 1200], 'lanczos3' );

[v_ImageF, ~, v_AlphaF]	= imread('Fight.png');
v_ImageF = imresize(v_ImageF, [100 100], 'lanczos3' );
v_AlphaF = imresize(v_AlphaF, [100 100], 'lanczos3' );
