clc;
clear all;
figure;
img = imread("Q3_Input", "tif");
img = double(img);
subplot(1,3,1);
imshow(img, []);
[M, N] = size(img);

filter = averageFilter(img, M, N);
subplot(1,3,2);
imshow(filter, []);

subplot(1,3,3);

threshold = 255 * 35 / 100;
binaryImg = thresholding(filter, threshold, M, N);
subplot(1,3,3);
imshow(binaryImg, []);


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