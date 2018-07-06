function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the next contained in the image as a string.
    
    % Select Models
    load('nist36_model.mat','W','b');
%     load('nist26_model.mat','W','b');
    
    img = imread(fname);
    [lines, bw] = findLetters(img);
    
%     imgtext = bw(lines{1}(1,1):lines{1}(1,3),lines{1}(1,2):lines{1}(1,4));
%     imshow(imgtext);
%     pause;
%     imshow(imresize(imgtext,[32 32]));

    dictionary = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

    text = cell(length(lines),1);
    for i = 1:length(lines)
        for j = 1:size(lines{i},1)
            textImage = bw(lines{i}(j,1):lines{i}(j,3),lines{i}(j,2):lines{i}(j,4));
            resized = imresize(textImage,[32 32]);
%             imshow(resized);
%             pause;
            input = reshape(resized,1024,1);
%             input = reshape(resized',1024,1);
            textClass = Classify(W, b, input');
            [~,index] = max(textClass);
            tempText = dictionary(index);
            text{i}(j) = tempText;
        end
    end

end
