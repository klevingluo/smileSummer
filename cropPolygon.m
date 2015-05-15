function crop = cropPolygon(img, Px, Py)
% crops img to include only the area inside of the polygon defined by
% c-coordinates vector Px and y coordinate vectors Py.  the background is
% black.
%
% Input:
% img - input file (image)
% Px - the x coordinates of the points that define the polygon
% Py - the y coordinates of the points that define the polygon
%
% Output:
% crop - the crop

[width, height, ~]=size(img);
mask = poly2mask(Px,Py,width,height);

R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);
R(~mask)=0;
G(~mask)=0;
B(~mask)=0;
crop = cat(3,R,G,B);

return;