clc;
clear all;

% create empty array for images
butterflyarray = {};
crabarray = {};
dolphinarray = {};
elephantarray = {};
flamingoarray = {};
scorpionarray = {};

%folder direction for labels
butterfly = 'Dataset\butterfly';
crab = 'Dataset\crab';
dolphin = 'Dataset\dolphin';
elephant = 'Dataset\elephant';
flamingo = 'Dataset\flamingo';
scorpion = 'Dataset\scorpion';

%file direction for images in categories
butterflyfile = dir(fullfile(butterfly, '*.jpg'));
crabfile = dir(fullfile(crab, '*.jpg'));
dolphinfile = dir(fullfile(dolphin, '*.jpg'));
elephantfile = dir(fullfile(elephant, '*.jpg'));
flamingofile = dir(fullfile(flamingo, '*.jpg'));
scorpionfile = dir(fullfile(scorpion, '*.jpg'));

%Loads butterfly images to butterflyarray
for k = 1 : length(butterflyfile)
  butterflyarray{1,k} = imread(strcat(butterflyfile(k).folder, "\", butterflyfile(k).name));
end
%Loads crab images to crabarray
for k = 1 : length(crabfile)
  crabarray{1,k} = imread(strcat(crabfile(k).folder, "\", crabfile(k).name));
end
%Loads dolphin images to dolphinarray
for k = 1 : length(dolphinfile)
  dolphinarray{1,k} = imread(strcat(dolphinfile(k).folder, "\", dolphinfile(k).name));
end
%Loads elephant images to elephantarray
for k = 1 : length(elephantfile)
  elephantarray{1,k} = imread(strcat(elephantfile(k).folder, "\", elephantfile(k).name));
end
%Loads flamingo images to flamingoarray
for k = 1 : length(flamingofile)
  flamingoarray{1,k} = imread(strcat(flamingofile(k).folder, "\", flamingofile(k).name));
end
%Loads scorpion images to scorpionarray
for k = 1 : length(scorpionfile)
  scorpionarray{1,k} = imread(strcat(scorpionfile(k).folder, "\", scorpionfile(k).name));
end

%merge all the datasets
dataset = {};
for k = 1 : length(butterflyfile)
  dataset{1,k} = butterflyarray{1,k};
end
for k = 1 : length(crabfile)
  dataset{2,k} = crabarray{1,k};
end
for k = 1 : length(dolphinfile)
  dataset{3,k} = dolphinarray{1,k};
end
for k = 1 : length(elephantfile)
  dataset{4,k} = elephantarray{1,k};
end
for k = 1 : length(flamingofile)
  dataset{5,k} = flamingoarray{1,k};
end
for k = 1 : length(scorpionfile)
  dataset{6,k} = scorpionarray{1,k};
end
pixel_labels={};
for i = 1:6
    iteration = 0;
    if (i==1)
        iteration = size(butterflyarray,2);
    elseif (i==2)
        iteration = size(crabarray,2);
    elseif (i==3)
        iteration = size(dolphinarray,2);
    elseif (i==4)
        iteration = size(elephantarray,2);
    elseif (i==5)
        iteration = size(flamingoarray,2);
    else
        iteration = size(scorpionarray,2);
    end
    for j = 1:iteration
        try
            
            Ilab= rgb2lab(dataset{i,j});
            colorchannel = double(Ilab(:,:,1:2));
            nrows = size(colorchannel,1);
            ncols = size(colorchannel,2);

            colorchannel = reshape(colorchannel,nrows*ncols,2);

            nColors = 3;
            [cluster_idx, cluster_center] = kmeans(colorchannel,nColors,...
            'distance',     'sqEuclidean', ...
            'Replicates', 5);
            pixel_labels{i,j} = reshape(cluster_idx,nrows,ncols);
        catch ex
        end    
    end
end

%Creating train sets for butterfly
[size ,result] = lengthcalculation(pixel_labels(1,:));
trainbutterfly = uint8(2*size/3);
datatrainset = {};
for i = 1:trainbutterfly
    datatrainset{1,i} = result{1,i};
end
%Creating test sets for butterfly
testbutterfly = size-trainbutterfly;
datatestset = {};
for i = 1:testbutterfly
    datatestset{1,i} = result{1,trainbutterfly+i};
end

%Creating train sets for crab
[size ,result] = lengthcalculation(pixel_labels(2,:));
traincrab = uint8(2*size/3);
for i = 1:traincrab
    datatrainset{2,i} = result{1,i};
end
%Creating test sets for crab
testcrab = size-traincrab;
for i = 1:testcrab
    datatestset{2,i} = result{1,traincrab+i};
end

%Creating train sets for dolphin
[size ,result] = lengthcalculation(pixel_labels(3,:));
traindolphin= uint8(2*size/3);
for i = 1:traindolphin
    datatrainset{3,i} = result{1,i};
end
%Creating test sets for dolphin
testdolphin = size-traindolphin;
for i = 1:testdolphin
    datatestset{3,i} = result{1,traindolphin+i};
end

%Creating train sets for elephant
[size ,result] = lengthcalculation(pixel_labels(4,:));
trainelephant = uint8(2*size/3);
for i = 1:trainelephant
    datatrainset{4,i} = result{1,i};
end
%Creating test sets for elephant
testelephant = size-trainelephant;
for i = 1:testelephant
    datatestset{4,i} = result{1,trainelephant+i};
end

%Creating train sets for flamingo
[size ,result] = lengthcalculation(pixel_labels(5,:));
trainflamingo = uint8(2*size/3);
for i = 1:trainflamingo
    datatrainset{5,i} = result{1,i};
end
%Creating test sets for flamingo
testflamingo = size-trainflamingo;
for i = 1:testflamingo
    datatestset{5,i} = result{1,trainflamingo+i};
end

%Creating train sets for scorpion
[size ,result] = lengthcalculation(pixel_labels(6,:));
trainscorpion = uint8(2*size/3);
for i = 1:trainscorpion
    datatrainset{6,i} = result{1,i};
end
%Creating test sets for scorpion
testscorpion = size-trainscorpion;
for i = 1:testscorpion
    datatestset{6,i} = result{1,trainscorpion+i};
end

target = [1;2;3;4;5;6];
classNames = {'butterfly','crab','dolphin','elephant','flamingo','scorpion'};
nb = fitcnb(datatrainset,target,'ClassNames',classNames); % nb is the trained model. save it at end for doing testing
save('nb.mat','nb');
% train performance
label = predict(nb,datatrainset);
perf=sum(label==target)/size(label,1); % performance in the range of 0 to 1

% for testing load the trained model
load('nb.mat');
Group = predict(nb,datatestset);

function [size, result] = lengthcalculation(labels)
    count = 0;
    result = {};
    for i = 1:length(labels)
        if(isempty(labels{1,i})==0)
            count = count + 1;
            result{1, count} = labels{1,i};
        end
    end
    size = count;
end
