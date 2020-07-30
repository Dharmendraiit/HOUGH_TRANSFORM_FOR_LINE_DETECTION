function []=original_image()
a=double(rgb2gray(imread('AB_1.jpg'))); %input of image
imshow(a,gray(256));
end

