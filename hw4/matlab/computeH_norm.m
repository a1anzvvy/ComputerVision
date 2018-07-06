function [H2to1] = computeH_norm(p1, p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation

%%%

    mean_p1 = mean(p1);
    mean_p2 = mean(p2);

    p1 = p1 - mean_p1;
    p2 = p2 - mean_p2;
    
    n = size(p1,1);
    
    p1_norm = sum(p1.^2,2);
    p2_norm = sum(p2.^2,2);
    
    [norm_max_1,index_1] = max(p1_norm);
    [norm_max_2,index_2] = max(p2_norm);

    p1 = p1./sqrt(norm_max_1).*sqrt(2);
    p2 = p2./sqrt(norm_max_2).*sqrt(2);
    
    [H2to1] = computeH(p1,p2);
    
end