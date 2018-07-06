function [ F ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q5.1:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using eightpoint
%          - using ransac

%     In your writeup, describe your algorithm, how you determined which
%     points are inliers, and any other optimizations you made

    load('../data/intrinsics.mat');

    n = size(pts1,1);

    T = [1/M, 0, 0;
         0, 1/M, 0;
         0, 0, 1];
     
    correct_array = zeros(1000,1);
    F_array = cell(1000,1);
    for j = 1:10000
        A = zeros(8,9);
        index = randperm(size(pts2,1),8);
        
        for i = 1:8
            x = pts1(index(i),1)/M;
            y = pts1(index(i),2)/M;
            x1 = pts2(index(i),1)/M;
            y1 = pts2(index(i),2)/M;
            A(i,:) = [x*x1, x*y1, x, y*x1, y*y1, y, x1, y1, 1];
        end
        % Solve for SVD
        [~,~,V] = svd(A);
        % Reshape
        F = [V(1:3,9)';
             V(4:6,9)';
             V(7:9,9)']';
        F = T'*F*T;

        F_array{j} = F;
        
        x = [pts1,ones(n,1)]';
        l_dash = F*x;
        
        % see if on ax+by+c = 0
        line_value = zeros(size(pts2,1),1);
        for i = 1:size(pts2,1)
            line_value(i) = [pts2(i,:),1]*l_dash(:,i);
        end
        line_value_01 = line_value<0.001 & line_value>-0.001;
        correct = sum(line_value_01);
        correct_array(j) = correct;
    end
    
    [max_value,max_index] = max(correct_array);
    F = F_array{max_index};
    max_value/n
    
%     save('q2_1.mat', 'F', 'M', 'pts1', 'pts2');

  end

