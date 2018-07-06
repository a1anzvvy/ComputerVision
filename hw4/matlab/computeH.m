function [H2to1] = computeH(p1, p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation

%%%

    % Number of point pairs
    n = size(p1,1);
    
    % Construction of A
    A = zeros(2*n,9);
    
    for i = 1:n
        x_dash = p1(i,1);
        y_dash = p1(i,2);
        x = p2(i,1);
        y = p2(i,2);
        temp = [-x, -y, -1, 0, 0, 0, x*x_dash, y*x_dash, x_dash;
                0, 0, 0, -x, -y, -1, x*y_dash, y*y_dash, y_dash];
        A(2*i-1:2*i,:) = temp;
    end
    
    % Solve for SVD
    [~,~,V] = svd(A);
    
    % Reshape
    H2to1 = [V(1:3,9)';
             V(4:6,9)';
             V(7:9,9)'];

end