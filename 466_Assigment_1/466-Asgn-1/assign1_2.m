clc;
profImg = imread("profile.jpeg"); %load the image to the variable
figure; %creates the figure
imshow(profImg); %shows the image on the top of figure

title("Kaan Taha Köken"); %title of the figure
xlabel(size(profImg, 2)); %shows the length of the x axis
ylabel(size(profImg, 1)); %shows the length of the y axis