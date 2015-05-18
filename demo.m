input = 'input.jpg';
example = 'example2.jpg';

template = getLayers(warpFace(input, example));
face = getLayers(imread(input));

detail = 0.8* rgb2lab(template.detail) + 0.2 * rgb2lab(face.detail);
shape = 0.8* rgb2lab(template.shape) + 0.2* rgb2lab(face.shape);

figure(2);
subplot(1,3,1);
imshow(imread(input))
subplot(1,3,2);
imshow(imread(example))
subplot(1,3,3)
imshow(lab2rgb(detail + shape + rgb2lab(face.lightness)));