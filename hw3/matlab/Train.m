function [W, b] = Train(W, b, train_data, train_label, learning_rate)
% [W, b] = Train(W, b, train_data, train_label, learning_rate) trains the network
% for one epoch on the input training data 'train_data' and 'train_label'. This
% function should returned the updated network parameters 'W' and 'b' after
% performing backprop on every data sample.


% This loop template simply prints the loop status in a non-verbose way.
% Feel free to use it or discard it

% epochs = 60;

% finalW = W;
% finalb = b;

% grad_W_group = cell(epochs,1);
% grad_b_group = cell(epochs,1);

% for k = 1:epochs
    index = randperm(size(train_data,1));
    for j = 1:size(train_data,1)

        i = index(j);
        [~, act_h, act_a] = Forward(W, b, train_data(i,:));
        [grad_W, grad_b] = Backward(W, b, train_data(i,:), train_label(i,:)', act_h, act_a);
        [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate);
        if mod(j, 100) == 0
            %fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b')
            %fprintf('Done %.2f %%\n', j/size(train_data,1)*100)
        end
    end

%     grad_W_group{k} = W;
%     grad_b_group{k} = b;
% end

% for i = 1:length(grad_W_group)
%     for j = 1:length(W)
%         finalW{j} = finalW{j}+grad_W_group{i}{j};
%         finalb{j} = finalb{j}+grad_b_group{i}{j};
%     end
% end
% 
% for i = 1:length(W)
%     finalW{i} = finalW{i}./epochs;
%     finalb{i} = finalb{i}./epochs;
% end

%fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b')


end
