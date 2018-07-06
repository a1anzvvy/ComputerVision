% evaluateRecognitionSystem.m
% This script evaluates nearest neighbour recognition system on test images
% load traintest.mat and classify each of the test_imagenames files.
% Report both accuracy and confusion matrix

%Load Data
load('visionHarris.mat');

% Set Path
alpha = 50;
k = 100;
RandomORHarris = '_H/';
path = strcat('../result_p',num2str(alpha),'_k',num2str(k),RandomORHarris);
%method = 'euclidean';
method = 'chi2';

%read path
load('../data/traintest.mat');
filterBank = createFilterBank();

result = zeros(size(test_imagenames,2),1);

%Classify
for i = 1:size(test_imagenames,2)
    eachPath = test_imagenames{i}(1:end-3);
    eachPath = strcat(path,eachPath,'mat');
    wordMap = load(eachPath);
    wordMap = wordMap.wordMap;
    hist1 = getImageFeatures(wordMap,k);
    dist = getImageDistance(hist1,trainFeatures,method);
    [~,index] = min(dist);
    result(i) = train_labels(index);
end

diff = result' - test_labels;
diff(diff~=0) = 1;
accuracy = 1-sum(diff)/size(test_imagenames,2)

confusionmat(result,test_labels)
