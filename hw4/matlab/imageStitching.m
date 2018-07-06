function [panoImg] = imageStitching(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image

%%%

%     compositeH(H2to1,img1,img2);

    img2_warp = warpH(img2,H2to1,[1000,2000],0);
    
    [h_2, w_2, ~] = size(img2_warp);
    [h_1, w_1, ~] = size(img1);
    img1 = [img1, zeros(h_1,w_2-w_1,3);
            zeros(h_2-h_1,w_1,3), zeros(h_2-h_1, w_2-w_1,3)];
    
    img1(img1==0) = img2_warp(img1==0);
    panoImg = img1;
    %panoImg = max(img1,img2_warp);
end