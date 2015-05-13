% Applies the makeup of example.jpg to input.jpg
clc;
clear;

% Load input image and example image
input = 'input.jpg';
example = 'example.jpg';

%
[inMarkx inMarky] = getLandmark(input);
subplot(2,2,1)
imshow(input);
hold on;
% Draw facial key points
for j = 1 : length(inMarkx)
   scatter(inMarkx(j), inMarky(j), 'g.');
end

[exMarkx exMarky] = getLandmark(example);
% Draw facial key points
subplot(2,2,3)
imshow(example);
hold on;
for i = 1 : length(exMarkx)
   scatter(exMarkx(i), exMarky(i), 'g.');
end

interp.method = 'invdist'; %'nearest'; %'none' % interpolation method
interp.radius = 5; % radius or median filter dimension
interp.power = 2; %power for inverse wwighting interpolation method

imgIn = imread(example);

img2 = imread(input);
[img_height img_width scrap] = size(img2);

%% Warping
[imgW, imgWr]  = tpswarp(imgIn,[img_width img_height],[exMarky exMarkx],[inMarky inMarkx],interp); % thin plate spline warping
imgW = uint8(imgW);

subplot(2,2,4); 
imshow(imgW);

subplot(2,2,2); 
% img_width, session_id, url, attributes)
imshow(imgW)
hold on;
% Draw facial key points
for j = 1 : length(inMarkx)
   scatter(inMarkx(j), inMarky(j), 'g.');
end
