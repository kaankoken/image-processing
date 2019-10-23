clc;
clear all;

img = im2double(imread("Q4_Input", "tif"));
%Create filter in order to apply
filter = [0 -1 0; -1 4 -1; 0 -1 0];
[M, N] = size(img);

newImg = zeros(M,N);
%apply the filter to the pixels
for i = 2: M - 1
    for j = 2: N - 1
        newImg(i, j) =  sum(sum(img(i - 1: i + 1, j - 1: j + 1) .* filter));
    end
end
% combine original and filtered image
newImg2 = img + newImg;
figure;
subplot(1,2,1);
imshow(newImg, []);
subplot(1,2,2);
imshow(newImg2, []);