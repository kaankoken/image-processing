clc;
clear all;

img = im2double(imread("Q5_Input", "jpg"));
img = .299*img(:,:,1) + .587*img(:,:,2) + .114*img(:,:,3);
filter = [-1 -2 -1; 0 0 0; 1 2 1];
reverseFilter = [-1 0 1; -2 0 2; -1 0 1];
[M, N] = size(img);


horz = zeros(M,N);
vert = zeros(M,N);



for i = 2: M - 1
    for j = 2: N - 1
        horz(i, j) =  sum(sum(img(i - 1: i + 1, j - 1: j + 1) .* filter));
        vert(i, j) =  sum(sum(img(i - 1: i + 1, j - 1: j + 1) .* reverseFilter));
    end
end

%horz = conv2(img, filter, 'same');
%vert = conv2(img, reverseFilter, 'same');

edgedImg = sqrt(horz.^2 + vert.^2);
figure;
subplot(1,4,1);
imshow(img, []);
%subplot(1,4,2);
%imshow(horz, []);
%subplot(1,4,3);
%imshow(vert);
subplot(1,4,4);
imshow(edgedImg);


