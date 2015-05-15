
%[Xp, Yp] = getLandmark('swift.jpg');

%% points acquired

figure(1);
img = imread('swift.jpg');

face = getFeatures(img, Xp, Yp);

imshow(face.mouthin);