% test code for the extracting the face structure, skin detail, and color
% layers

clc;
clear;

img = imread('colors.jpg');

l = getLayers(img);

subplot(2,3,1)
imshow(l.original);

subplot(2,3,2)
imshow(l.lightness);

subplot(2,3,3)
imshow(l.color);

subplot(2,3,4)
imshow(l.shape);

subplot(2,3,5)
imshow(l.detail);