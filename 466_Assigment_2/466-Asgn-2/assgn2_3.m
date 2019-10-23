clc;
clear all;
figure;
img = imread("Q3_Input", "tif");
img = double(img);
[M, N] = size(img);

filter = averageFilter(img, M, N);
imshow(filter, []);

%threshold is %35 percent
threshold = 255 * 35 / 100;
binaryImg = thresholding(filter, threshold, M, N);
imshow(binaryImg, []);

%{ 
    this function uses 3 by 3 area to average the pixels.
%}

function img = averageFilter(image, M, N)
    newImg = zeros(M, N);
    for i = 2: M - 1
        for j = 2: N - 1
            summation = 0;
            for k = i - 1: i + 1
                for l = j - 1: j + 1
                    summation = summation + image(k,l);
                end
            end
            newImg(i, j) = summation / 9;
        end
    end
    img = newImg;
end

%{ 
    This function converts blurred image to binary image according to
    threshold that provided.
%}

function thresh = thresholding(image, rate, dimX, dimY)
    binary=zeros(dimX, dimY);
    for i = 1: dimX
        for j = 1: dimY
            if image(i, j) <= rate
                binary(i, j) = 0;
            else
                binary(i, j) = 1;
            end
        end
    end
    thresh = binary;
end