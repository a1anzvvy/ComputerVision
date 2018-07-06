function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

    n = size(pts1,1);
    A = zeros(n,9);
    for i = 1:n
        x = pts1(i,1)/M;
        y = pts1(i,2)/M;
        x1 = pts2(i,1)/M;
        y1 = pts2(i,2)/M;
        A(i,:) = [x*x1, x*y1, x, y*x1, y*y1, y, x1, y1, 1];
    end
    
    % Solve for SVD
    [~,~,V] = svd(A);
    
    % Reshape
    F = [V(1:3,9)';
         V(4:6,9)';
         V(7:9,9)'];
     
    T = [1/M, 0, 0;
         0, 1/M, 0;
         0, 0, 1];
     
    F = T'*F*T;
    
%     save('q2_1.mat', 'F', 'M', 'pts1', 'pts2');
end

