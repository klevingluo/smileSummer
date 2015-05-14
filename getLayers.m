function layers = getLayers(img)
% Separates an image into lightness, shape, and detail layers as speficied
% by the paper
%
% Input:
% img - input file (image)
%
% Output:
% layers - a struct with lightness, shape, detail, color, and original 
% layers as fields

% degree of smoothing, a parameter in the smoothing process
DOS = 500;

% neightborhood size, a parameter in the smoothing process
NHS = [10 10];

layers = struct();
layers = setfield(layers, 'original', img);

% convenience variables
[width, height, ~] = size(img);
z = zeros(width, height);

% saves the lightness layer
lab = rgb2lab(img);
lightness = lab(:,:,1);
lightness = cat(3, lightness, z, z);
lightness = lab2rgb(lightness);
layers = setfield(layers, 'lightness', lightness);

% extracts the 2 color layers
astar = lab(:,:,2);
bstar = lab(:,:,3);
color = cat(3, z, astar, bstar);
color = lab2rgb(color);
layers = setfield(layers, 'color', color);

% the blurred shape layer
shape = imguidedfilter(color, 'DegreeOfSmoothing', DOS, 'NeighborhoodSize', NHS);
layers = setfield(layers, 'shape', shape);

% the detail layer
detail = color - shape;
layers = setfield(layers, 'detail', detail);

return;