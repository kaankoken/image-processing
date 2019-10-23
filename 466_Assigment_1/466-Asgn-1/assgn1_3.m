clc;
profImg = imread("profile.jpeg");
cropImg = profImg(500:590, 385:830); %manual adjustment to take eye part
figure;
imshow(cropImg);

title("Kaan Taha Köken");
xlabel(size(cropImg, 2));
ylabel(size(cropImg, 1));