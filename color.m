% test code for the extracting the face structure, skin detail, and color
% layers

clc;
clear;

img = imread('colors.jpg');
[width height scrap] = size(img);
subplot(1,4,1);
imshow(img);
z = zeros(width, height);

subplot(1,4,2);
lab = colorspace('lab<-rgb',img);
lightness = lab(:,:,1);
lightness = cat(3, lightness, z, z);
lightness = colorspace('rgb<-lab',lightness);
imshow(lightness);

subplot(1,4,3);
astar = lab(:,:,2);
bstar = lab(:,:,3);
colors = cat(3, z, astar, bstar);
colors = colorspace('rgb<-lab',colors);
imshow(colors)