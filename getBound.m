function [Cx, Cy, w, h, Xp, Yp] = getBound(img)
% Uses the face++ api to get an ordered list of the landmarks of the face
% indicated by the filename 'img'
%
% Input:
% img - the name of the input file
%
% Output:
% Xp - the x-coordinates of the facial landmarks in order
% Yp - the y-coordinates of the facial landmarks in order
% Landmarks - the

% Loads the Api with keys
API_KEY = '3e6bf2228704f676d98a3a4a086492f3';
API_SECRET = 'k7shsPGa3Jx2cN0-T_jEIbxrIN3J4zoV';
api = facepp(API_KEY, API_SECRET, 'US');

% Detect faces in the image, obtain related information (faces, img_id, img_height, 
% img_width, session_id, url, attributes)
rst = detect_file(api, img, 'all');
img_width = rst{1}.img_width;
img_height = rst{1}.img_height;
face = rst{1}.face;

im = imread(img);

Xp = zeros(83,1);
Yp = zeros(83,1);

for i = 1 : length(face)
    % Draw face rectangle on the image
    face_i = face{i};
    center = face_i.position.center;
    w = face_i.position.width / 100 * img_width;
    h = face_i.position.height / 100 * img_height;
    Cx = center.y * img_height / 100 - h/2;
    Cy = center.x * img_width / 100 -  w/2;
    
    % Detect facial key points
    rst2 = api.landmark(face_i.face_id, '83p');
    landmark_points = rst2{1}.result{1}.landmark;
    landmark_names = fieldnames(landmark_points);
    Xc = center.x * img_width / 100 -  w/2;
    Yc = center.y * img_height / 100 - h/2;

    fields = fieldnames(landmark_points);
    
    width = rst{1}.img_width;
    height = rst{1}.img_height;

    for i = 1:numel(fields);
      Xp(i) = landmark_points.(fields{i}).x * width / 100;
      Yp(i) = landmark_points.(fields{i}).y * height/ 100;
    end
end

return