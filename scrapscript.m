img = imread('obama.jpg');

Px = [0 300 300 150 0];
Py = [0 0 300 150 300];

crop = cropPolygon(img, Px, Py);
imshow(crop);