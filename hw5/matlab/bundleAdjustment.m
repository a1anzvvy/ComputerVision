function [M2, P] = bundleAdjustment(K1, M1, p1, K2, M2_init, p2, P_init)
% bundleAdjustment:
% Inputs:
%   K1 - 3x3 camera calibration matrix 1
%   M1 - 3x4 projection matrix 1
%   p1 - Nx2 matrix of (x, y) coordinates
%   K2 - 3x3 camera calibration matrix 2
%   M2_init - 3x4 projection matrix 2
%   p2 - Nx2 matrix of (x, y) coordinates
%   P_init: Nx3 matrix of 3D coordinates
%
% Outputs:
%   M2 - 3x4 refined from M2_init
%   P - Nx3 refined from P_init

    n = size(p1,1);
    r2_init = invRodrigues(M2_init(:,1:3));
    before_opti = [P_init(:);r2_init;M2_init(:,4)];
    after_opti = lsqnonlin(@(x)rodriguesResidual(K1, M1, p1, K2, p2,x),before_opti);
    
    P = after_opti(1:3*n);
    P = reshape(P,[n,3]);
    r_2 = after_opti(3*n+1:3*n+3);
    R2 = rodrigues(r_2);
    t_2 = after_opti(3*n+4:3*n+6);
    M2 = [R2, t_2];
end
