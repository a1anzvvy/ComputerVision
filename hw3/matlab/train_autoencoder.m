% TODO: load training dataset
load('../data/nist36_train.mat', 'train_data', 'train_labels')
% load('../data/nist36_test.mat', 'test_data', 'test_labels')
% load('../data/nist36_valid.mat', 'valid_data', 'valid_labels')


% TODO: reshape and adjust the dimensions to be in the order of [height,width,1,sample_index]

Xtrain = zeros(32,32,1,size(train_data,1));
Ytrain = zeros(size(train_data,1),1);

for i = 1:size(train_data,1)
    temp = reshape(train_data(i,:),[32 32]);
    Xtrain(:,:,1,i) = temp;
    [~,index] = max(train_labels(i,:));
    Ytrain(i) = index;
end

%Ytrain = categorical(Ytrain);

layers = define_autoencoder();

options = trainingOptions('sgdm',...
                          'InitialLearnRate',1e-3,...
                          'MaxEpochs',3,...
                          'MiniBatchSize',20,...
                          'Shuffle','every-epoch',...
                          'Plot','training-progress',...
                          'VerboseFrequency',20,...
                          'L2Regularization',0.0005);

% TODO: run trainNetwork()
net = trainNetwork(Xtrain,Xtrain,layers,options);

                      