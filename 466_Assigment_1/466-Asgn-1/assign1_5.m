clc;
profImg = imread('profile.jpeg');

%Shrinked Image
shrkImgNear = imresize(profImg, [128, 128], "nearest");
shrkImgLin = imresize(profImg, [128, 128], "bilinear");
shrkImgCub = imresize(profImg, [128, 128], "bicubic");

%Image Ratio
ratio = 1024/128;

%{
    New image matrix. It is filled with 1's,
    and every one on the cell multiplied by
    starting 1 to 1024(size that we wanted to
    enhance or zoom.)
%}
%{ 
    If we create the newImg without 3 parameter,
    e.g newImg = ones(1024, 1) * (1: 1024);
    new image (that we are going to) will just
    gray scale.
%}
newImg = ones(1024, 1024, 3) .* (1: 1024);
%{
    Ratio between old and new image, so
    we could determine how many time we
    are going to repeat the pixels. Also,
    we are finding where the pixel will
    be repeated.
%}
newImg = ceil(newImg / ratio);
newImg = nearestNeigh(shrkImgNear, newImg);
%{
    converting the matrix to 8-bit integers
    with "uint8" function, so that we can
    see the image with imshow
%}
newImg = uint8(newImg);

figure;
imshow(newImg);
title("Kaan Taha Köken");
xlabel(size(newImg, 2));
ylabel(size(newImg, 1));


function destImg = nearestNeigh(srcImg, destImg)
    %size of the height of the picture
    for i = 1:size(destImg, 1)
        %size of the width of the picture
        for j = 1:size(destImg, 2)
            col = ceil(j / 8);
            row = ceil(i / 8);
            %size of the 3rd dimension of the picture
            for k = 1:size(destImg, 3)
                destImg(i, j, k) = srcImg(row, col, k);
            end
        end
        
    end
end