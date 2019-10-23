clc;
clear all;
%import images
input_1 = imread("Q1_Input_1.tif");
input_2 = imread("Q1_Input_2.tif");

figure;
subplot(3,2,1);
imshow(input_1);
subplot(3,2,2);
imhist(input_1, 64);
mod_img_1 = histeq(input_1);
subplot(3,2,3);
imshow(mod_img_1);
subplot(3,2,4);
imhist(mod_img_1, 64);

%s = whos("Q1_Input_1.tif");
%gray level range 0 to 255
[M, N] = size(input_2);
gray_level = grayLevel(M, N, input_2);
normalized_level = gray_level/(M * N);

transformation = trans(256, normalized_level);
transformation = round(transformation);
histEq = transformation / (M * N);

final = assgnValue(histEq, M, N, input_2);
subplot(3,2,5);
imshow(final, []);

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
