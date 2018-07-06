function [ P, err ] = triangulate( C1, points1, C2, points2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

%       P - Nx3 matrix of 3D coordinates
%       err - scalar of the reprojection error

% Q4.2:
%       Implement a triangulation algorithm to compute the 3d locations
%

    n = size(points1,1);

    p1 = C1(1,:);
    p2 = C1(2,:);
    p3 = C1(3,:);
    p1_dash = C2(1,:);
    p2_dash = C2(2,:);
    p3_dash = C2(3,:);
    
    A = zeros(4,4,n);
    P = zeros(n,3);
    for i = 1:n
        A(:,:,i) = [points1(i,2)*p3 - p2;
                    p1 - points1(i,1)*p3;
                    points2(i,2)*p3_dash - p2_dash;
                    p1_dash - points2(i,1)*p3_dash];
                
        [~,~,V] = svd(A(:,:,i));
        X = V(:,4);
        X = X./(X(4));
        P(i,:) = X(1:3)';
    end

    P_homo = [P,ones(n,1)];
    p_2d_1 = C1*P_homo';
    p_2d_2 = C2*P_homo';
    p_2d_1 = p_2d_1';
    p_2d_1 = p_2d_1./p_2d_1(:,3);
    p_2d_2 = p_2d_2';
    p_2d_2 = p_2d_2./p_2d_2(:,3);
    
    err = 0;
    err1 = 0;
    err2 = 0;
    for i = 1:n
        v1 = [p_2d_1(i,1)-points1(i,1),p_2d_1(i,2)-points1(i,2)];
        v2 = [p_2d_2(i,1)-points2(i,1),p_2d_2(i,2)-points2(i,2)];
        err = err + (v1(1)^2 + v1(2)^2) + (v2(1)^2 + v2(2)^2);
        err1 = err1 + (v1(1)^2 + v1(2)^2);
        err2 = err2 + (v2(1)^2 + v2(2)^2);
    end
    
    err1;
    err2;
    
end
