function mask = getBeta(face)
% takes an image, and x/y coordinates of the landmark points to create a
% structure that holds masks of all the features of the face
%
% Input:
% face - a struct with img, Xp, and Yp fields;
%
% Output:
% mask the beta mask for the face

check = [2,3,4,5,6,7,8,9,10,1,19,18,17,16,15,14,13,12,11,84,85,86,87,88,89,90,91];

rad = sqrt((face.Xp(11) - face.Xp(2))^2 + (face.Yp(11) - face.Yp(2))^2)/2;
centerx = (face.Xp(11) + face.Xp(2))/2;
centery = (face.Yp(11) + face.Yp(2))/2;

for i=1:8
    face.Xp(i+83) = cos((20/180 * pi)*i)*rad + centerx;
    face.Yp(i+83) = -0.7 * sin((20/180 * pi)*i)*rad + centery;
end

lefteye = [21,22,19,23,25,28,26,27] + 1;
righteye = [67,68,65,69,71,74,72,73] + 1;
leftbrow = [29,30,31,32,33,36,35,34] + 1;
rightbrow = [75,76,77,78,79,82,81,80] + 1;
mouthout = [37,40,41,38,44,43,46,52,51,54,48,49] + 1;
nose = [60,61,64,62,59,58,63,57,56];

visage = fromSet(check, face.Xp, face.Yp, face.img);
mouth = fromSet(mouthout, face.Xp, face.Yp, face.img);
brow1 = fromSet(leftbrow, face.Xp, face.Yp, face.img);
brow2 = fromSet(rightbrow, face.Xp, face.Yp, face.img);
eye1 = fromSet(lefteye, face.Xp, face.Yp, face.img);
eye2 = fromSet(righteye, face.Xp, face.Yp, face.img);
nose = fromSet(nose, face.Xp, face.Yp, face.img);

mask = visage - mouth - brow1- brow2 - eye1 - eye2 - nose;


% Clean up code and implement filter

return;

function result = fromSet(set, Xp, Yp, img)
len = length(set);
Px = zeros(1,len);
Py = zeros(1,len);

for i=1:len
    Px(i) = Xp(set(i));
    Py(i) = Yp(set(i));
end

[width, height, ~]=size(img);
mask = poly2mask(Px,Py,width,height);

R=zeros(width, height) + 255;
R(~mask)=0;

result = cat(3,R,R,R);


