% Applies the makeup of example.jpg to input.jpg

clc; clear;

% Load input your API_KEY & API_SECRET
API_KEY = '3e6bf2228704f676d98a3a4a086492f3';
API_SECRET = 'k7shsPGa3Jx2cN0-T_jEIbxrIN3J4zoV';

% Load input image and example image
input = 'input.jpg';
example = 'example.jpg';

% Loads API
api = facepp(API_KEY, API_SECRET, 'US');

% Detect faces in the image, obtain related information (faces, img_id, img_height, 
% img_width, session_id, url, attributes)
rst = detect_file(api, input, 'all');
face = rst{1}.face;
img_width1 = rst{1}.img_width;
img_height1 = rst{1}.img_height;

inface = face{1};
inputMarks = api.landmark(inface.face_id, '83p');
inputMarks = inputMarks{1}.result{1}.landmark;

fields = fieldnames(inputMarks);
inMarkx = zeros(1,83);
inMarky = zeros(1,83);
for i = 1:numel(fields);
  inMarkx(i) = inputMarks.(fields{i}).x;
  inMarky(i) = inputMarks.(fields{i}).y;
end

figure(2);
% drawing the face 1
subplot(1,2,1);
im = imread(input);
imshow(im);
hold on;
for i = 1 : length(face)
    % Detect facial key points
    face_i = face{i};
    rst2 = api.landmark(face_i.face_id, '83p');
    landmark_points = rst2{1}.result{1}.landmark;
    landmark_names = fieldnames(landmark_points);
    
    % Draw facial key points
    for j = 1 : length(landmark_names)
        pt = getfield(landmark_points, landmark_names{j});
        scatter(pt.x * img_width1 / 100, pt.y * img_height1 / 100, 'g.');
    end
end

% Detect faces in the image, obtain related information (faces, img_id, img_height, 
% img_width, session_id, url, attributes)
rst = detect_file(api, example, 'all');
img_width = rst{1}.img_width;
img_height = rst{1}.img_height;
face = rst{1}.face;

exface = face{1};
exMarks = api.landmark(exface.face_id, '83p');
exMarks = exMarks{1}.result{1}.landmark;

exMarkx = zeros(1,83);
exMarky = zeros(1,83);
for i = 1:numel(fields);
  exMarkx(i) = exMarks.(fields{i}).x;
  exMarky(i) = exMarks.(fields{i}).y;
end

subplot(1,2,2);
% draw the other face
im = imread(example);
imshow(im);
hold on;
for i = 1 : length(face)
    % Detect facial key points
    face_i = face{i};
    rst2 = api.landmark(face_i.face_id, '83p');
    landmark_points = rst2{1}.result{1}.landmark;
    landmark_names = fieldnames(landmark_points);
    
    % Draw facial key points
    for j = 1 : length(landmark_names)
        pt = getfield(landmark_points, landmark_names{j});
        scatter(pt.x * img_width / 100, pt.y * img_height / 100, 'g.');
    end
end

interp.method = 'invdist';
interp.radius = 5;
interp.power = 2;

Xp = exMarky * img_width1 / 100;
Yp = exMarkx * img_width1 / 100;
Xs = inMarky * img_width1 / 100;
Ys = inMarkx * img_width1 / 100;

save('cods.mat', 'Xp', 'Xs', 'Yp', 'Ys');
tpsWarpDemo('example.jpg','map.mat','cods.mat')

