function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q2.2.3

%%%

    n = size(locs1,1);
    
    bestH2to1 = zeros(3,3);
    inliers = zeros(n,1);
    n_correct = 0;
    
    for i = 1:1000
        index = randperm(n,4);
        H2to1 = computeH(locs1(index,:),locs2(index,:));
        X_2 = [locs2,ones(n,1)];
        X_1_estimate = H2to1 * X_2';
        X_1_estimate = X_1_estimate';
        
        % Calculated x_1 from H2to1*x_2
        X_1_estimate = X_1_estimate./X_1_estimate(:,3);
        
        % Calculate Distance
        X_1_estimate = X_1_estimate - [locs1, ones(n,1)];
        distance = sqrt(X_1_estimate(:,1).^2 + X_1_estimate(:,2).^2);
        distance(distance<5) = 1;
        distance(distance>=5) = 0;
        
        temp = sum(distance);
        if temp>n_correct
           n_correct = temp;
           bestH2to1 = H2to1;
           inliers = distance;
        end
    end

end

