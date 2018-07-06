% Set Path
alpha = 50;
k = 50;
RandomORHarris = '_H/';
path = strcat('../result_p',num2str(alpha),'_k',num2str(k),RandomORHarris);
method = 'euclidean';
%method = 'chi2';

%read path
load('../data/traintest.mat');
filterBank = createFilterBank();

result = zeros(size(test_imagenames,2),1);

% Compute Inverse Document Frequency
IDF = computeIDF('Harris',k);

%% Train Features
trainFeatures = zeros(size(train_imagenames,2),k);
for i = 1:size(train_imagenames,2)
    eachPath = train_imagenames{i}(1:end-3);
    eachPath = strcat(path,eachPath,'mat');
    wordMap = load(eachPath);
    wordMap = wordMap.wordMap;
    trainFeatures(i,:) = getImageFeatures_IDF(wordMap,k,IDF);
end


%% Classify
% for i = 1:size(test_imagenames,2)
%     eachPath = test_imagenames{i}(1:end-3);
%     eachPath = strcat(path,eachPath,'mat');
%     wordMap = load(eachPath);
%     wordMap = wordMap.wordMap;
%     hist1 = getImageFeatures_IDF(wordMap,k,IDF);
%     %hist1 = getImageFeatures(wordMap,k);
%     dist = getImageDistance(hist1,trainFeatures,method);
%     [~,index] = min(dist);
%     result(i) = train_labels(index);
% end

%SVM train
t = templateSVM('KernelFunction','Gaussian');
MODEL = fitcecoc(trainFeatures,train_labels,'Learners',t);

%read test hists into a matrix
hist1 = zeros(size(test_imagenames,2),k);
for i = 1:size(test_imagenames,2)
    eachPath = test_imagenames{i}(1:end-3);
    eachPath = strcat(path,eachPath,'mat');
    wordMap = load(eachPath);
    wordMap = wordMap.wordMap;
    hist1(i,:) = getImageFeatures_IDF(wordMap,k,IDF);
end

result = predict(MODEL,hist1);

diff = result' - test_labels;
diff(diff~=0) = 1;
accuracy = 1-sum(diff)/size(test_imagenames,2)

confusionmat(result,test_labels)