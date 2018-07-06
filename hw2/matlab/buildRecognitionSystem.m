% buildRecognitionSystem.m
% This script loads the visual word dictionary (in dictionaryRandom.mat or dictionaryHarris.mat) and processes
% the training images so as to build the recognition system. The result is
% stored in visionRandom.mat and visionHarris.mat.

% Set Path
alpha = 50;
k = 100;
RandomORHarris = '_H/';
path = strcat('../result_p',num2str(alpha),'_k',num2str(k),RandomORHarris);

%load('dictionaryRandom.mat');
load('dictionaryHarris.mat');

%process training image
load('../data/traintest.mat');
filterBank = createFilterBank();

%train_imagenames{:} = train_imagenames{:}(1:end-3);

trainFeatures = zeros(size(train_imagenames,2),k);

for i = 1:size(train_imagenames,2)
    eachPath = train_imagenames{i}(1:end-3);
    eachPath = strcat(path,eachPath,'mat');
    wordMap = load(eachPath);
    wordMap = wordMap.wordMap;
    trainFeatures(i,:) = getImageFeatures(wordMap,k);
end


save('visionHarris','dictionaryHarris','filterBank','trainFeatures','train_labels');
%save('visionRandom','dictionaryRandom','filterBank','trainFeatures','train_labels');