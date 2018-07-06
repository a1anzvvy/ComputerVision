function [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a)
% [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a) computes the gradient
% updates to the deep network parameters and returns them in cell arrays
% 'grad_W' and 'grad_b'. This function takes as input:
%   - 'W' and 'b' the network parameters
%   - 'X' and 'Y' the single input data sample and ground truth output vector,
%     of sizes Nx1 and Cx1 respectively
%   - 'act_h' and 'act_a' the network layer pre and post activations when forward
%     forward propogating the input smaple 'X'

    grad_W = W;
    grad_b = cell(length(b),1);
   
    Delta = cell(1,length(b)+1);
    
    grad_W{end} = (act_h{end}-Y)*act_h{end-1}';
    Delta{end} = act_h{end}-Y;
    grad_b{end} = Delta{end};
    
    for i = 2:length(b)
         Delta{end+1-i} = W{end+2-i}'*Delta{end+2-i}.*(act_h{end+1-i}.*(1.-act_h{end+1-i}));
         if i == length(b)
            grad_W{end+1-i} = Delta{end+1-i}*X;
         else
            grad_W{end+1-i} = Delta{end+1-i}*act_h{end-i}';
         end
         grad_b{end+1-i} = Delta{end+1-i};
    end

end
