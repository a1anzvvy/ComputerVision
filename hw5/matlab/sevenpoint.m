function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - 7x2 matrix of (x,y) coordinates
%   pts2 - 7x2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup

    n = 7;
    A = zeros(n,9);
    for i = 1:n
        x = pts1(i,1)/M;
        y = pts1(i,2)/M;
        x1 = pts2(i,1)/M;
        y1 = pts2(i,2)/M;
        A(i,:) = [x*x1, x*y1, x, y*x1, y*y1, y, x1, y1, 1];
    end
    
    [U, S, V] = svd(A);
    
    f1 = V(:,9);
    f2 = V(:,8);
    
    F1 = [f1(1:3)';
          f1(4:6)';
          f1(7:9)'];
      
    F2 = [f2(1:3)';
          f2(4:6)';
          f2(7:9)'];
      
    syms a;
    sol = solve(det(a*F1 + (1-a)*F2) == 0,a);
    s=vpa(sol);
    
    % change
    F = cell(3,1);
    
    T = [1/M, 0, 0;
         0, 1/M, 0;
         0, 0, 1];
    
    for i = 1:3
        F{i} = double(s(i)*F1 + (1-s(i))*F2);
        F{i} = T'*F{i}*T;
    end
     
%     save('q2_2.mat', 'F', 'M', 'pts1', 'pts2');
end

