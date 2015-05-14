function layers = getLayers(img)
% Separates an image into lightness, shape, and detail layers as speficied
% by the paper
%
% Input:
% img - input file
%
% Output:
% layers - a struct with lightness, shape, detail, color, and original 
% layers as fields

% degree of smoothing to use for the guided smooth
DOS = 160;

% neightborhood size, for the guided smooth
NHS = [10 10];

layers = struct();
layers = setfield(layers, 'original', img);

[width, height, ~] = size(img);
z = zeros(width, height);

lab = rgb2lab(img);
lightness = lab(:,:,1);
lightness = cat(3, lightness, z, z);
lightness = lab2rgb(lightness);
layers = setfield(layers, 'lightness', lightness);

astar = lab(:,:,2);
bstar = lab(:,:,3);
color = cat(3, z, astar, bstar);
color = lab2rgb(color);
layers = setfield(layers, 'color', color);

shape = imguidedfilter(color, 'DegreeOfSmoothing', DOS, 'NeighborhoodSize', NHS);
layers = setfield(layers, 'shape', shape);

subplot(1,4,4);
detail = color - shape;
layers = setfield(layers, 'detail', detail);

return;