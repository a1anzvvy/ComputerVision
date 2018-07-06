function [locs, desc] = briefLite(im)
% input
% im - gray image with values between 0 and 1
%
% output
% locs - an m x 3 vector, where the first two columns are the image coordinates of keypoints and the third column 
% 		 is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. 
%		 m is the number of valid descriptors in the image and will vary
% 		 n is the number of bits for the BRIEF descriptor

%%%

    load('testPattern.mat');

    % Use Harris corner detector to generate interest points
    corners = detectHarrisFeatures(im);
    locs = round(corners.Location);

    % compute BRIEF descriptor
    [locs, desc] = computeBrief(im, locs, compareA, compareB);

end