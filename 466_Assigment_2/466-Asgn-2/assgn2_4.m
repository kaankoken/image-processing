clc;
clear all;

img = im2double(imread("Q4_Input", "tif"));
filter = [0 -1 0; -1 4 -1; 0 -1 0];
[M, N] = size(img);

newImg = zeros(M,N);

for i = 2: M - 1
    for j = 2: N - 1
        newImg(i, j) =  sum(sum(img(i - 1: i + 1, j - 1: j + 1) .* filter));
    end
end
newImg2 = img + newImg;
figure;
subplot(1,3,1);
imshow(img, []);
subplot(1,3,2);
imshow(newImg, []);
subplot(1,3,3);
imshow(newImg2, []);