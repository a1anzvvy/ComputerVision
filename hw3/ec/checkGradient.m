function [error] = checkGradient(W,b,X,Y)
    Wtemp = W;
    btemp = b;

    epsilon = 10^-4;
    index1 = randi(length(W),1,1);
    
    %% Check W
    [R,C] = size(W{index1});
    indexR = randi(R,1,1);
    indexC = randi(C,1,1);
    
    sumW = 0;
    
%     for indexR = 1:R
%         for indexC = 1:C
            % add delta to a random w (theta + epsilon)
            W{index1}(indexR,indexC) = W{index1}(indexR,indexC) + epsilon;
            [~,loss1] = ComputeAccuracyAndLoss(W, b, X, Y);

            % subtract delta (theta - epsilon)
            W{index1}(indexR,indexC) = W{index1}(indexR,indexC) - 2*epsilon;
            [~,loss2] = ComputeAccuracyAndLoss(W, b, X, Y);

            % add it back (theta)
            W{index1}(indexR,indexC) = W{index1}(indexR,indexC) + epsilon;

            % Calculate actual gradient
            grad = (loss1-loss2)/(2*epsilon);

            % Calculate gradient with Backward()
            [~, act_h, act_a] = Forward(W, b, X);
            [grad_W, grad_b] = Backward(W, b, X, Y', act_h, act_a);

            errorW = (grad_W{index1}(indexR,indexC) - grad);
            errorW = abs(errorW);
        %     grad_W{index1}(indexR,indexC)
        %     grad
            sumW = sumW + errorW;
%         end
%     end
    
    fprintf('Error of W at layer %d is %f\n', index1);
    sumW

    
    %% Check b
    indexB = randi(R,1,1);
    W = Wtemp;
    b = btemp;
    
    % add delta to a random b (theta + epsilon)
    b{index1}(indexB) = b{index1}(indexB) + epsilon;
    [~,loss3] = ComputeAccuracyAndLoss(W, b, X, Y);
    
    % subtract delta (theta - epsilon)
    b{index1}(indexB) = b{index1}(indexB) - 2*epsilon;
    [~,loss4] = ComputeAccuracyAndLoss(W, b, X, Y);
    
    % add it back (theta)
    b{index1}(indexB) = b{index1}(indexB) + epsilon;
    
    % Calculate actual gradient
    grad2 = (loss3-loss4)/(2*epsilon);
    
    % Calculate gradient with Backward()
    [~, act_h, act_a] = Forward(W, b, X);
    [grad_W, grad_b] = Backward(W, b, X, Y', act_h, act_a);
    
    errorB = (grad_b{index1}(indexB) - grad2);
    errorB = abs(errorB);

    
    %Chekc error position
    fprintf('Error of b(%d) at layer %d is\n', indexB, index1);
    errorB
%     fprintf('True value: %f;  Backward(): %f\n', grad2, grad_b{index1}(indexB));
    
    %% Total Error
    error = errorB + sumW;

end