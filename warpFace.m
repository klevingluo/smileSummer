function warp = warpFace(img, canvas)
% warps the face in img to match the face in canvas
%
% Input:
% img - input file name
% canvas - the canvas file name
%
% Output:
% warp the warped face image
% facial warping demo

[inMarkx, inMarky] = getLandmark(img);

[exMarkx, exMarky] = getLandmark(canvas);

interp.method = 'invdist'; %'nearest'; %'none' % interpolation method
interp.radius = 5; % radius or median filter dimension
interp.power = 2; %power for inverse wwighting interpolation method

imgIn = imread(canvas);
imgOut = imread(img);

[img_height, img_width, ~] = size(imgOut);

%% Warping
[imgW, ~]  = tpswarp(imgIn,[img_width img_height],[exMarky exMarkx],[inMarky inMarkx],interp); % thin plate spline warping
warp = uint8(imgW);

return;
