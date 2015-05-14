function [Xp Yp] = getLandmark(img)
% Uses the face++ api to get an ordered list of the landmarks of the face
% indicated by the filename 'img'
%
% Input:
% img - the name of the input file
%
% Output:
% Xp - the x-coordinates of the facial landmarks in order
% Yp - the y-coordinates of the facial landmarks in order

% Loads the Api with keys
API_KEY = '3e6bf2228704f676d98a3a4a086492f3';
API_SECRET = 'k7shsPGa3Jx2cN0-T_jEIbxrIN3J4zoV';
api = facepp(API_KEY, API_SECRET, 'US');

% gets data from f++ api
rst = detect_file(api, img, 'all');
face = rst{1}.face;

% saves image size
width = rst{1}.img_width;
height = rst{1}.img_height;

% extracts the first face found in the photo, and its landmarks
face = face{1};
inputMarks = api.landmark(face.face_id, '83p');
inputMarks = inputMarks{1}.result{1}.landmark;

fields = fieldnames(inputMarks);
Xp = zeros(83,1);
Yp = zeros(83,1);

for i = 1:numel(fields);
  Xp(i) = inputMarks.(fields{i}).x * width / 100;
  Yp(i) = inputMarks.(fields{i}).y * height / 100;
end

return;


