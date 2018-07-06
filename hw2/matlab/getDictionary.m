function [dictionary] = getDictionary(imgPaths, alpha, K, method)
% Generate the filter bank and the dictionary of visual words
% Inputs:
%   imgPaths:        array of strings that repesent paths to the images
%   alpha:          num of points
%   K:              K means parameters
%   method:         string 'random' or 'harris'
% Outputs:
%   dictionary:         a length(imgPaths) * K matrix where each column 
%                       represents a single visual word
    % -----fill in your implementation here --------
    
    load(imgPaths);
    filterBank = createFilterBank();
    pixelResponses = zeros(alpha*size(train_imagenames,2),3*size(filterBank,1));
    n = size(train_imagenames,2);
    
    if method == 'random'
        for i = 1:n% T pictures
            path = strcat('../data/',train_imagenames{i});
            I = imread(path);
            filterResponses = extractFilterResponses(I, filterBank);
            points = getRandomPoints(I,alpha);
            for j = 1:size(filterResponses,3)   % 3*n filterResponse
                for k = 1: alpha                 % alpha points
                    x = uint8(points(alpha,1));
                    y = uint8(points(alpha,2));
                    pixelResponses((i-1)*alpha+k,j) = filterResponses(y,x,j);
                end
            end
        end
    end
    
    if method == 'harris'
        for i = 1:n% T pictures
            path = strcat('../data/',train_imagenames{i});
            I = imread(path);
            filterResponses = extractFilterResponses(I, filterBank);
            points = getHarrisPoints(I,alpha,0.05);
            for j = 1:size(filterResponses,3)    % 3*n filterResponse
                for k = 1: alpha                 % alpha points
                    x = points(alpha,1);
                    y = points(alpha,2);
                    pixelResponses((i-1)*alpha+k,j) = filterResponses(y,x,j);
                end
            end
        end
    end
    
    [~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');
    

    % ------------------------------------------
    
end