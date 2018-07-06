% Q3.3:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, C2, p1, p2, R and P to q3_3.mat

load ("../data/some_corresp.mat");
load('../data/intrinsics.mat');
img1 = imread('../data/im1.png');
img2 = imread('../data/im2.png');

[h, w, d] = size(img1);
M = max(w,h);
% 8 points
% F = eightpoint(pts1,pts2,M);
% 7 points
load('q2_2.mat');

M1 = [1, 0, 0, 0;
      0, 1, 0, 0;
      0, 0, 1, 0];
  
E = essentialMatrix(F,K1,K2);
M2 = camera2(E);

for i = 1:4
    M2_test = M2(:,:,i);
    P2 = K2*M2_test;
    P1 = K1*M1;
    [ P, err ] = triangulate( P1, pts1, P2, pts2 );
    err
    if min(P(:,3))>0
       M2 = M2_test;
       break;
    end
end

% save('q3_3.mat', 'P', 'M2', 'pts1', 'pts2');