%Load Data

% Set Path
alpha = 50;
k = 50;
RandomORHarris = '_H/';
path = strcat('../result_p',num2str(alpha),'_k',num2str(k),RandomORHarris);
%method = 'euclidean';
method = 'chi2';

%process testing image
load('../data/traintest.mat');
filterBank = createFilterBank();

%SVM train
t = templateSVM('KernelFunction','polynomial');
MODEL = fitcecoc(trainFeatures,train_labels,'Learners',t);

%read test hists into a matrix
hist1 = zeros(size(test_imagenames,2),k);
for i = 1:size(test_imagenames,2)
    eachPath = test_imagenames{i}(1:end-3);
    eachPath = strcat(path,eachPath,'mat');
    wordMap = load(eachPath);
    wordMap = wordMap.wordMap;
    hist1(i,:) = getImageFeatures(wordMap,k);
end

result = predict(MODEL,hist1);

%%

%Support Vector Machine
diff = result' - test_labels;
diff(diff~=0) = 1;
accuracy = 1-sum(diff)/size(test_imagenames,2)
confusionmat(result,test_labels)