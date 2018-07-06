% TODO: load test dataset
load('../data/nist36_test.mat', 'test_data', 'test_labels')
% load('../data/nist36_valid.mat', 'valid_data', 'valid_labels')

% TODO: reshape and adjust the dimensions to be in the order of [height,width,1,sample_index]
Xtest = zeros(32,32,1,size(test_data,1));
Ytest = zeros(size(test_data,1),1);

for i = 1:size(test_data,1)
    temp = reshape(test_data(i,:),[32 32]);
    Xtest(:,:,1,i) = temp;
    [~,index] = max(test_labels(i,:));
    Ytest(i) = index;
end

% TODO: run predict()
test_recon = predict(net,Xtest);

%%
k = 1011;
% imshow(test_recon(:,:,1,k));
% figure();
% imshow(Xtest(:,:,1,k));

psnr(double(test_recon(:,:,1,k)),double(Xtest(:,:,1,k)))