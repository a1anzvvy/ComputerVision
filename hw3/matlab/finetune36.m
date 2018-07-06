num_epoch = 5;
classes = 36;
layers = [32*32, 800, classes];
learning_rate = 0.01;

load('../data/nist36_train.mat', 'train_data', 'train_labels')
load('../data/nist36_test.mat', 'test_data', 'test_labels')
load('../data/nist36_valid.mat', 'valid_data', 'valid_labels')

load('nist26_model_60iters.mat','W','b');

%[W, b] = InitializeNetwork(layers);
% add additional layers
W{2} = [W{2};zeros(10,800)];
b{2} = [b{2};zeros(10,1)];

train_accc = zeros(num_epoch,1);
valid_accc = zeros(num_epoch,1);
train_losss = zeros(num_epoch,1);
valid_losss = zeros(num_epoch,1);

for j = 1:num_epoch
    [W, b] = Train(W, b, train_data, train_labels, learning_rate);

    [train_acc, train_loss] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    [valid_acc, valid_loss] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);

    train_accc(j) = train_acc;
    valid_accc(j) = valid_acc;
    train_losss(j) = train_loss;
    valid_losss(j) = valid_loss;

    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc, valid_acc, train_loss, valid_loss)
end

save('nist36_model.mat', 'W', 'b')

%% Plot

x = linspace(1,num_epoch,num_epoch);
figure();
plot(x,train_accc);
hold on;
plot(x,valid_accc);

figure();
plot(x,train_losss);
hold on;
plot(x,valid_losss);

%% Visualization
imageList = zeros(32,32,1,size(W{1},1));

for i = 1:size(W{1},1)
    temp = reshape(W{1}(i,:),[32 32]);
    imageList(:,:,1,i) = temp;
end
montage(imageList);

[W_i, b_i] = InitializeNetwork(layers);
imageList_i = zeros(32,32,1,size(W{1},1));
figure();
for i = 1:size(W_i{1},1)
    temp = reshape(W_i{1}(i,:),[32 32]);
    imageList_i(:,:,1,i) = temp;
end
montage(imageList_i);

%% Confusion Matrix
[outputs] = Classify(W, b, test_data);

test_result = zeros(size(outputs,1),1);
test_label = zeros(size(outputs,1),1);
for i = 1:size(outputs,1)
    [~,index1] = max(outputs(i,:));
    test_result(i) = index1;
    [~,index2] = max(test_labels(i,:));
    test_label(i) = index2;
end
confMat = confusionmat(test_label,test_result);

confMat = imresize(confMat,20,'nearest');
imshow(confMat/max(confMat(:)))

