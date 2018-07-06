% Your code here.
load('../data/nist36_train.mat');
load('../data/nist36_test.mat')
[U,S,V] = svd(train_data);

% U: m*m S:m*n V:n*n

% U: m*k S:k*k V:k*n

%%
total = sum(sum(S));
temp = 0;
index = 0;
for i = 1:size(S,2)
    temp = temp + S(i,i);
    if temp > 0.95*total
       index = i;
       break;
    end
end

%% Reduce D
newV = V(:,1:64);
Xreduced = test_data * newV;

Xreconstructed = Xreduced * newV';

k = 1011;
imshow(reshape(test_data(k,:),[32,32]));
a = reshape(test_data(k,:),[32,32]);
figure();
imshow(reshape(Xreconstructed(k,:),[32,32]));
b = reshape(Xreconstructed(k,:),[32,32]);

psnr(a,b)
