function face = getFeatures(img, Xp, Yp)
% takes an image, and x/y coordinates of the landmark points to create a
% structure that holds masks of all the features of the face
%
% Input:
%
%
% Output:
%

lefteye = [21,22,19,23,25,28,26,27] + 1;
lefteye2brow = [21,27,26,28,25,55,33,32,31,30,29] + 1;
righteye = [67,68,65,69,71,74,72,73] + 1;
righteye2brow = [71,74,72,73,67,59,75,76,77,78,79] + 1;
leftbrow = [29,30,31,32,33,36,35,34] + 1;
rightbrow = [75,76,77,78,79,82,81,80] + 1;
check = [1,2,3,4,5,6,7,8,9,0,18,17,16,15,14,13,12,11,10] + 1;
mouthout = [37,40,41,38,44,43,46,52,51,54,48,49] + 1;
mouthin = [39,42,45,47,50,53] + 1;
nose = [62,63,64,58,55,59,56,60] + 1;
UP = [37,49,48,54,51,52,46,53,47,50] + 1;
LO = [37,40,41,38,44,43,46,42,45,39] + 1;

face = struct();
face = setfield(face, 'lefteye', fromSet(lefteye, Xp, Yp, img));
face = setfield(face, 'lefteye2brow', fromSet(lefteye2brow, Xp, Yp, img));
face = setfield(face, 'righteye', fromSet(righteye, Xp, Yp, img));
face = setfield(face, 'righteye2brow', fromSet(righteye2brow, Xp, Yp, img));
face = setfield(face, 'leftbrow', fromSet(leftbrow, Xp, Yp, img));
face = setfield(face, 'rightbrow', fromSet(rightbrow, Xp, Yp, img));
face = setfield(face, 'check', fromSet(check, Xp, Yp, img));
face = setfield(face, 'mouthout', fromSet(mouthout, Xp, Yp, img));
face = setfield(face, 'mouthin', fromSet(mouthin, Xp, Yp, img));
face = setfield(face, 'nose', fromSet(nose, Xp, Yp, img));
face = setfield(face, 'UP', fromSet(UP, Xp, Yp, img));
face = setfield(face, 'LO', fromSet(LO, Xp, Yp, img));

return;

function result = fromSet(set, Xp, Yp, img)
len = length(set);
xpoints = zeros(1,len);
ypoints = zeros(1,len);
for i=1:len
    xpoints(i) = Xp(set(i));
    ypoints(i) = Yp(set(i));
end

result = cropPolygon(img, xpoints, ypoints);

return;


