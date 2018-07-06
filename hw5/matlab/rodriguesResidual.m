function residuals = rodriguesResidual(K1, M1, p1, K2, p2, x)
% rodriguesResidual:
% Inputs:
%   K1 - 3x3 camera calibration matrix 1
%   M1 - 3x4 projection matrix 1
%   p1 - Nx2 matrix of (x, y) coordinates
%   K2 - 3x3 camera calibration matrix 2
%   p2 - Nx2 matrix of (x, y) coordinates
%   x - (3N + 6)x1 flattened concatenation of P, r_2 and t_2

% Output:
%   residuals - 4Nx1 vector
    n = size(p1,1);
    P = x(1:3*n);
    P = reshape(P,[n,3]);
    r_2 = x(n*3+1:n*3+3);
    R_2 = rodrigues(r_2);
    % Composite M2 using R_2 and t_2
    M2 = [R_2,x(n*3+4:n*3+6)];
    P1 = K1*M1;
    P2 = K2*M2;
    
    P_homo = [P,ones(n,1)];
    p_2d_1 = P1*P_homo';
    p_2d_2 = P2*P_homo';
    p_2d_1 = p_2d_1';
    p_2d_1 = p_2d_1./p_2d_1(:,3);
    p_2d_2 = p_2d_2';
    p_2d_2 = p_2d_2./p_2d_2(:,3);
    
    diff1 = p1-p_2d_1(:,1:2);
    diff2 = p2-p_2d_2(:,1:2);
    
    residuals = [diff1(:,1);diff1(:,2);diff2(:,1);diff2(:,2)];
    

end
