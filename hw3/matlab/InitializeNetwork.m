function [W, b] = InitializeNetwork(layers)
% InitializeNetwork([INPUT, HIDDEN, OUTPUT]) initializes the weights and biases
% for a fully connected neural network with input data size INPUT, output data
% size OUTPUT, and HIDDEN number of hidden units.
% It should return the cell arrays 'W' and 'b' which contain the randomly
% initialized weights and biases for this neural network.
    W = cell(1,length(layers)-1);
    b = cell(1,length(layers)-1);
    %b = -1 + 2.*rand(length(layers)-1,1);
    
    for i = 1:length(layers)-1
       W{i} = -1 + 2.*rand(layers(i+1),layers(i));
       b{i} = -1 + 2.*rand(layers(i+1),1);
    end

end
