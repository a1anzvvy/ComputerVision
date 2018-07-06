function [wordMap] = getVisualWords(I, dictionary, filterBank)
% Convert an RGB or grayscale image to a visual words representation, with each
% pixel converted to a single integer label.   
% Inputs:
%   I:              RGB or grayscale image of size H * W * C
%   filterBank:     cell array of matrix filters used to make the visual words.
%                   generated from getFilterBankAndDictionary.m
%   dictionary:     matrix of size 3*length(filterBank) * K representing the
%                   visual words computed by getFilterBankAndDictionary.m
% Outputs:
%   wordMap:        a matrix of size H * W with integer entries between
%                   1 and K

    % -----fill in your implementation here --------
    
    filterResponses = extractFilterResponses(I,filterBank);
    %distance = pdist2(filterResponses,dictionary);
    
    wordMap = zeros(size(I,1),size(I,2));
    temp = zeros(1,3*size(filterBank,1));
    for i = 1:size(I,1)
       for j = 1:size(I,2)
           temp(1,:) = filterResponses(i,j,:);
           distance = pdist2(temp,dictionary);
           [~,index] = min(distance);
           wordMap(i,j) = index;
       end
    end

    % ------------------------------------------
end
