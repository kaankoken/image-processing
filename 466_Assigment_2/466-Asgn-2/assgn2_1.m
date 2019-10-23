clc;
clear all;
%import images
input_1 = imread("Q1_Input_1.tif");
input_2 = imread("Q1_Input_2.tif");

figure;
%subplot(1,2,1);
%imshow(input_2);

%gray level range 0 to 255
[M, N] = size(input_1);
gray_level = grayLevel(M, N, input_1);
%Normalized the gray level by dividing area of the image
normalized_level = gray_level/(M * N);

transformation = trans(256, normalized_level);
transformation = round(transformation);
% After we get the integer values of each bit, we are
% again dividing transformed image to area of the image. 
histEq = transformation / (M * N);

%Lastly, We are assigning values to new Image.
final = assgnValue(histEq, M, N, input_1);
%subplot(1,2,2);
imshow(final, []);

%{
    With this function, I am finding the occurence of the grays in the
    image. For example, 0 (index 1 at the matrix) can be occured 100 times.
%}

function levels = grayLevel(dimX, dimY, image)
    level = zeros(1, 256);
    for i = 1: dimX
        for j = 1: dimY
            pos = image(i, j);
            level(1, pos + 1) = level(1, pos + 1  ) + 1;
        end
    end
    levels = level;
end

%{
    I transformed the normalized gray levels with this function. Size is
    the related with image. We are looking that how many bits the image contains. For example If image 8
    bit then size 0 to 255 or 1 to 256
    
    In each iteration, we are summing up the past values to new value, and
    we are multiplying with the size - 1 (because bits between 0 to 255)
%}

function tranf = trans(size, norm_level)
    arr = zeros(1, size);
    for i = 1: size
        summation = 0;
        for j = 1: i
            summation = summation + norm_level(1, j);
        end
        arr(1, i) = (size - 1) * summation;
    end
    tranf = arr;
end

function val = assgnValue(histEq, dimX, dimY, image)
    temp = zeros(dimX, dimY);
    for i = 1: dimX
        for j = 1: dimY
            temp(i,j) = histEq(1, image(i,j) + 1);
        end
    end
    val = temp;
end
