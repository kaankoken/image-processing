clc;
profImg = imread("profile.jpeg");

%{
Shrinked pictures using built in function imresize
with the three different interpolation technique.
%}
shrkImgNear = imresize(profImg, [128, 128], "nearest");
shrkImgLin = imresize(profImg, [128, 128], "bilinear");
shrkImgCub = imresize(profImg, [128, 128], "bicubic");

%{
Zoomed pictures using built in function imresize
with the three different interpolation technique.
%}
zoomImgNear = imresize(shrkImgNear, [1024, 1024], "nearest");
zoomImgLin = imresize(shrkImgLin, [1024, 1024], "bilinear");
zoomImgCub = imresize(shrkImgCub, [1024, 1024], "bicubic");

%{
Rotated pictures using built in function imrotate
with the three different interpolation technique.
%}
rotImgNear = imrotate(profImg, 35 , "nearest");
rotImgLin = imrotate(profImg, 35, "bilinear");
rotImgCub = imrotate(profImg, 35, "bicubic");

%{
Resized again rotated pictures using built in function imresize
with the nearest neighbour interpolation technique.
%}
imgNear = imresize(rotImgNear, [size(profImg, 1), size(profImg, 2)], "nearest");
imgLin = imresize(rotImgLin, [size(profImg, 1), size(profImg, 2)], "nearest");
imgCub = imresize(rotImgCub, [size(profImg, 1), size(profImg, 2)], "nearest");

%Stores thepictures as an array of pictures in order to loop it
imgArray = {profImg, shrkImgNear, shrkImgLin, shrkImgCub, zoomImgNear ...
    zoomImgLin ,zoomImgCub, imgNear, imgLin, imgCub};
%Stores the name of the pictures as an array
imgArrayName =  {'Original'  'Shrinked Nearest' 'Shrinked Bilinear' ...
    'Shrinked Bicubic' 'Zoomed Nearest' 'Zoomed Bilinear' ...
    'Zoomed Bicubic' 'Rotated' 'Rotated' 'Rotated'};
figure;
i = 1;
for c = 1:length(imgArray)
    if (c == 2) %in order to pass 3rd element on the matrix
        i = i + 1;
    end
    subplot(4,3, i + 1); %4 by 3 matrix & puts the all pictures on same figure
    imshow(imgArray{c});
    title(imgArrayName{c});
    xlabel(size(imgArray{c}, 2));
    ylabel(size(imgArray{c}, 1)); %1 height, 2 width
    i = i + 1;
end    
    

