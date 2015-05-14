% test code for the extracting the face structure, skin detail, and color
% layers

clc;
clear;

img = imread('colors.jpg');

l = getLayers(img);

imshow(l.original);