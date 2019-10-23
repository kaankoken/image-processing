clc;
clear all;

img = im2double(imread("Q5_Input", "jpg"));
%Converting RGB image to gray scale
img = .299*img(:,:,1) + .587*img(:,:,2) + .114*img(:,:,3);
%Create to filter in order to get
%horizontal and vertical edges
%As well as we did this on 4th question
filter = [-1 -2 -1; 0 0 0; 1 2 1];
reverseFilter = [-1 0 1; -2 0 2; -1 0 1];
[M, N] = size(img);

horz = zeros(M,N);
vert = zeros(M,N);

% Getting only the edges when we applied
% the each filter

for i = 2: M - 1
    for j = 2: N - 1
        horz(i, j) =  sum(sum(img(i - 1: i + 1, j - 1: j + 1) .* filter));
        vert(i, j) =  sum(sum(img(i - 1: i + 1, j - 1: j + 1) .* reverseFilter));
    end
end

%Combining the vertical & horizontal images as 1
edgedImg = sqrt(horz.^2 + vert.^2);
figure;
subplot(1,2,1);
imshow(img, []);
subplot(1,2,2);
imshow(edgedImg);


