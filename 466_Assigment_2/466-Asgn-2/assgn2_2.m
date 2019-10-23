clear all;
clc;

image = imread("Q2_Input.tif");
neg_img = 255 - image;
figure;
imshow(image);
imshow(neg_img);