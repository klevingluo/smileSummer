function [Xp Yp] = getLandmark(img)
%
% Description: Thin-Plane spline warping of the input image (img) to
% output image (imgw). The warping is defined by a set of reference points
% (Zp=[Xp Yp]) on the [img] image and a set of corresponding points (Zs)
% on the (imgw) image. The warping will translate Zp in img to Zs in imgw.
%
% Input:
% img - input file
% outDim - Output canvas ([W H])
% Zp - landmark in img
% Zs - landmark in canvas
% interp.method - interpolation mode('nearest', 'invdist', 'none')
% interp.radius - Max radius for nearest neighbor interpolation or
%                 Radius of inverse weighted interpolation
% interp.power - power for inverse weighted interpolation
%
% Output:
% imgw - warped image with no holes
% imgwr - warped image with holes
% map - Map of the canvas with 0 indicating holes and 1 indicating pixel

% Load input your API_KEY & API_SECRET
API_KEY = '3e6bf2228704f676d98a3a4a086492f3';
API_SECRET = 'k7shsPGa3Jx2cN0-T_jEIbxrIN3J4zoV';

% Loads API
api = facepp(API_KEY, API_SECRET, 'US');

% img_width, session_id, url, attributes)
rst = detect_file(api, img, 'all');
face = rst{1}.face;
img_width1 = rst{1}.img_width;
img_height1 = rst{1}.img_height;

inface = face{1};
inputMarks = api.landmark(inface.face_id, '83p');
inputMarks = inputMarks{1}.result{1}.landmark;

fields = fieldnames(inputMarks);
Xp = zeros(83,1);
Yp = zeros(83,1);

for i = 1:numel(fields);
  Xp(i) = inputMarks.(fields{i}).x * img_width1 / 100;
  Yp(i) = inputMarks.(fields{i}).y * img_height1 / 100;
end

return;


