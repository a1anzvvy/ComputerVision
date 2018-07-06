function [h] = getImageFeatures_IDF(wordMap, dictionarySize, IDF)
% Convert an wordMap to its feature vector. In this case, it is a histogram
% of the visual words
% Input:
%   wordMap:            an H * W matrix with integer values between 1 and K
%   dictionarySize:     the total number of words in the dictionary, K
% Outputs:
%   h:                  the feature vector for this image


	% -----fill in your implementation here --------
    h = size(dictionarySize,1);
    
    for i = 1:dictionarySize
       h(i) = sum(sum(wordMap==i)); 
    end
    
    h = h.*IDF;
    
    h = h/norm(h,1);

    % ------------------------------------------

end
