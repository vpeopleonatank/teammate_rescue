function [v_ImageR,v_AlphaR,v_ImageB,v_AlphaB,v_ImageE,v_AlphaE,...
    imageB_bithuong, alphaB_bithuong, imageR_bithuong, alphaR_bithuong]=LoadImageBoids()
global ImageWidth;
ImageWidth=70;
[v_ImageR, ~, v_AlphaR]	= imread('SoldierR.png');
v_ImageR = imresize(v_ImageR, [ImageWidth 50], 'lanczos3' );
v_AlphaR = imresize(v_AlphaR, [ImageWidth 50], 'lanczos3' );


[v_ImageB, ~, v_AlphaB]	= imread('SoldierB.png');
v_ImageB = imresize(v_ImageB, [ImageWidth 50], 'lanczos3' );
v_AlphaB = imresize(v_AlphaB, [ImageWidth 50], 'lanczos3' );

[v_ImageE, ~, v_AlphaE]	= imread('rip.png');
v_ImageE = imresize(v_ImageE, [ImageWidth ImageWidth], 'lanczos3' );
v_AlphaE = imresize(v_AlphaE, [ImageWidth ImageWidth], 'lanczos3' );

[imageB_bithuong, ~, alphaB_bithuong]	= imread('SoldierB_bithuong.png');
imageB_bithuong = imresize(imageB_bithuong, [ImageWidth 50], 'lanczos3' );
alphaB_bithuong = imresize(alphaB_bithuong, [ImageWidth 50], 'lanczos3' );

[imageR_bithuong, ~, alphaR_bithuong]	= imread('SoldierR_bithuong.png');
imageR_bithuong = imresize(imageR_bithuong, [ImageWidth 50], 'lanczos3' );
alphaR_bithuong = imresize(alphaR_bithuong, [ImageWidth 50], 'lanczos3' );

