function [compareA, compareB] = makeTestPattern(patchWidth, nbits)  
% input
% patchWidth - the width of the image patch (usually 9)
% nbits - the number of tests n in the BRIEF descriptor
% output
% compareA and compareB - linear indices into the patchWidth x patchWidth image patch and are each nbits x 1 vectors. 
%
% Run this routine for the given parameters patchWidth = 9 and n = 256 and save the results in testPattern.mat.

%%%

    % normal distrubution of (cneter,1/25 S^2)
    indexX1 = normrnd(patchWidth/2,1/25 * patchWidth * patchWidth,nbits,1);
    indexY1 = normrnd(patchWidth/2,1/25 * patchWidth * patchWidth,nbits,1);
    indexX2 = normrnd(patchWidth/2,1/25 * patchWidth * patchWidth,nbits,1);
    indexY2 = normrnd(patchWidth/2,1/25 * patchWidth * patchWidth,nbits,1);
    
    indexX1 = floor(indexX1);
    indexY1 = floor(indexY1);
    indexX2 = floor(indexX2);
    indexY2 = floor(indexY2);
    
    indexX1(indexX1 > patchWidth) = patchWidth;
    indexY1(indexY1 > patchWidth) = patchWidth;
    indexX2(indexX2 > patchWidth) = patchWidth;
    indexY2(indexY2 > patchWidth) = patchWidth;
    
%     indexX1(indexX1 > floor(patchWidth/2)) = floor(patchWidth/2);
%     indexY1(indexY1 > floor(patchWidth/2)) = floor(patchWidth/2);
%     indexX2(indexX2 > floor(patchWidth/2)) = floor(patchWidth/2);
%     indexY2(indexY2 > floor(patchWidth/2)) = floor(patchWidth/2);
    
    indexX1(indexX1 < 1) = 1;
    indexY1(indexY1 < 1) = 1;
    indexX2(indexX2 < 1) = 1;
    indexY2(indexY2 < 1) = 1;
    
    compareA = (indexX1-1) .* patchWidth + indexY1;
    compareB = (indexX2-1) .* patchWidth + indexY2;

end