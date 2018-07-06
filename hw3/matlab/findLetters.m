function [lines, bw] = findLetters(img)
% [lines, BW] = findLetters(im) processes the input RGB image and returns a cell
% array 'lines' of located characters in the image, as well as a binary
% representation of the input image. The cell array 'lines' should contain one
% matrix entry for each line of text that appears in the image. Each matrix entry
% should have size Lx4, where L represents the number of letters in that line.
% Each row of the matrix should contain 4 numbers [x1, y1, x2, y2] representing
% the top-left and bottom-right position of each box. The boxes in one line should
% be sorted by x1 value.
       

    % Preprocessing
    img = imfilter(img,fspecial('Gaussian'),[5 5],1);
    imgGray = rgb2gray(img); % To grayscale
    imgGray(imgGray>100) = 255; % Threshold
    imgBW = im2bw(imgGray); % Transfer to binary
    bw = imgBW;
    bw = double(bw);
    
    %erosion/dilation 
    SE = strel('square',15);
    SE2 = strel('square',10);
    imgBW = imerode(imgBW,SE);
    imgBW = imdilate(imgBW,SE2);
    
    % bwconncomp
    imgBW = 1.-imgBW;
    CC = bwconncomp(imgBW);
    labeled = labelmatrix(CC);
    
%     figure();
    
    leftUpPoints = [];
    lowerRightPoints = [];
    index = [];
    for i = 1 : CC.NumObjects
        %Threshold small points and dots
        if size(CC.PixelIdxList{i},1) > 500
            index = [index;i];
            letterImg = labeled;
            letterImg(letterImg~=i)=0;

            %Show each letter
%             RGB_label = label2rgb(letterImg);
    %         imshow(RGB_label);
    %         hold on;
    %         pause;

            %Find bounding box
            [I,J] = find(letterImg);
            maxI = max(I);
            maxJ = max(J);
            minI = min(I);
            minJ = min(J);
            leftUpPoints = [leftUpPoints; minI, minJ];
            lowerRightPoints = [lowerRightPoints; maxI, maxJ];
        end
    end
    
    %Expand the bounding box a little
    leftUpPoints = leftUpPoints-20;
    lowerRightPoints = lowerRightPoints+20;
    leftUpPoints(leftUpPoints<1) = 1;
    
    imshow(img);
    % Draw Bounding Boxes
    for i = 1:size(leftUpPoints,1)
        height = lowerRightPoints(i,1) - leftUpPoints(i,1);
        width = lowerRightPoints(i,2) - leftUpPoints(i,2);
        rectangle('Position',[leftUpPoints(i,2),leftUpPoints(i,1),width,height],'EdgeColor','g','LineWidth',2);
    end
    
    C = regionprops(CC,'Centroid');
    C = C(index);
    centerY = cat(1,C.Centroid);
    hold on;
    plot(centerY(:,1),centerY(:,2),'bx');
    centerY = centerY(:,2);
    
    
    % Group them up
    Y = pdist(centerY);
    Z = linkage(Y);
%     dendrogram(Z);

%     img = imread('../images/04_deep.jpg'); % 600
%     img = imread('../images/03_haiku.jpg'); % 200
%     img = imread('../images/02_letters.jpg'); % 100  1.153
%     img = imread('../images/01_list.jpg');  % 80

    T = cluster(Z,'cutoff',1.151); % 02
%     T = cluster(Z,'cutoff',1.1546); % 03 04

    lines = cell(max(T),1);
    for i = 1:length(T)
        lines{T(i)} = [lines{T(i)};leftUpPoints(i,:),lowerRightPoints(i,:)];
    end
    
    %Sort each text line with x position
    for i = 1:length(lines)
        lines{i} = sortrows(lines{i},2);
    end
    
    %Sort lines with y
    newLines = cell(length(lines),1);
    y1 = [];
    for i = 1:length(lines)
        y1 = [y1;lines{i}(1,1)];
    end
    [~,order] = sort(y1);
    for i = 1:length(lines)
        newLines{i} = lines{order(i)};
    end
    
    lines = newLines;
    
end
