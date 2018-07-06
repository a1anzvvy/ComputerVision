function [locs, desc] = computeBrief(im, locs, compareX, compareY)
% Compute the BRIEF descriptor for detected keypoints.
% im is 1 channel image, 
% locs are locations
% compareX and compareY are idx in patchWidth^2
% Return:
% locs: m x 2 vector which contains the coordinates of the keypoints
% desc: m x nbits vector which contains the BRIEF descriptor for each
%   keypoint.

%%%
    %Default Patch Size = 9
    patchSize = 9;
    nbits = 256;
    
    % find points within valid range
    [h, w] = size(im);
    realLocs = [];
    for i = 1:size(locs,1)
        if locs(i,1) > (patchSize-1)/2 && locs(i,2) > (patchSize-1)/2 && locs(i,1) < w - (patchSize-1)/2 && locs(i,2) < h - (patchSize-1)/2
            realLocs = [realLocs; locs(i,:)];
        end
    end
    
    compareXCoor = zeros(size(compareX,1),2);
    compareYCoor = zeros(size(compareX,1),2);
    for i = 1:size(compareX,1)
        compareXCoor(i,1) = ceil(compareX(i)/patchSize);
        compareXCoor(i,2) = mod(compareX(i),patchSize);
        
        compareYCoor(i,1) = ceil(compareY(i)/patchSize);
        compareYCoor(i,2) = mod(compareY(i),patchSize);
    end
    compareXCoor(compareXCoor==0) = patchSize;
    compareYCoor(compareYCoor==0) = patchSize;
    
    
    desc = zeros(size(realLocs,1),nbits);
    for i = 1:size(realLocs,1)
        for j = 1:size(compareX,1)
            x1 = realLocs(i,2)+compareXCoor(j,1)-(patchSize-1)/2;
            y1 = realLocs(i,1)+compareXCoor(j,2)-(patchSize-1)/2;
            x2 = realLocs(i,2)+compareYCoor(j,1)-(patchSize-1)/2;
            y2 = realLocs(i,1)+compareYCoor(j,2)-(patchSize-1)/2;
            if im(x1,y1) > im(x2,y2)
                desc(i,j) = 1;
            end
        end
    end
    
    locs = realLocs;

end