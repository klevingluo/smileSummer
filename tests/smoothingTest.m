img = imread('obama.jpg');


% degree of smoothing to use for the guided smooth
DOS = 500;

% neightborhood size, for the guided smooth
NHS = [10 10];

smooth = imguidedfilter(img, 'DegreeOfSmoothing', DOS, 'NeighborhoodSize', NHS);

subplot(1,2,1);
imshow(img);

subplot(1,2,2);
imshow(smooth);