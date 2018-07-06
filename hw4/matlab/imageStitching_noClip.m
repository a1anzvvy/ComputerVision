function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image
%
% To prevent clipping at the edges, we instead need to warp both image 1 and image 2 into a common third reference frame 
% in which we can display both images without any clipping.

%%%

    [h_2, w_2, ~] = size(img2);
    [h_1, w_1, ~] = size(img1);
    
    corners = [1, 1,   w_2, w_2;
               1, h_2, 1,   h_2;
               1, 1,   1,   1  ];
    corners_transfered = H2to1 * corners;
    corners_transfered = corners_transfered./corners_transfered(3,:);
    
    out_size = [max(corners_transfered(2,:))-min(corners_transfered(2,:)),max(corners_transfered(1,:))];
    out_size = round(out_size);
    
    M = [1, 0, 0;
         0, 1, -min(corners_transfered(2,:));
         0, 0, 1];
    
    warp_im1 = warpH(img1, M, out_size); 
    warp_im2 = warpH(img2, M*H2to1, out_size);
    
    warp_im1(warp_im1==0) = warp_im2(warp_im1==0);
    panoImg = warp_im1;
end