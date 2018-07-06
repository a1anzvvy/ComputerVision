function [accuracy, loss] = ComputeAccuracyAndLoss(W, b, data, labels)
% [accuracy, loss] = ComputeAccuracyAndLoss(W, b, X, Y) computes the networks
% classification accuracy and cross entropy loss with respect to the data samples
% and ground truth labels provided in 'data' and labels'. The function should return
% the overall accuracy and the average cross-entropy loss.

    outputs = Classify(W, b, data);
    loss = 0;
    correct = 0;

    for i = 1:size(outputs,1)
       %compute loss
       loss = loss + labels(i,:)*log(outputs(i,:))';
       
       % Transfer to one-hot vector       
       [~,index] = max(outputs(i,:));
       outputs(i,:) = 0;
       outputs(i,index) = 1;
    end
    loss = -loss;
    
    diff = abs(outputs - labels);    
    accuracy = 1-sum(sum(diff))/2/size(labels,1);
        
end
