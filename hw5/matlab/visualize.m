% Q4.2:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3
clear;
load ("../data/some_corresp.mat");
load('../data/intrinsics.mat');
load('../data/templeCoords.mat');
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');


[h, w, d] = size(im1);
M = max(w,h);
F = eightpoint(pts1,pts2,M);
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
    if min(P(:,3))>0
       M2 = M2_test;
       break;
    end
end

M2 = M2(:,:,1);
P2 = K2*M2;
P1 = K1*M1;

x2 = zeros(size(x1,1),1);
y2 = zeros(size(x1,1),1);
for i = 1:size(x1,1)
    [ x2(i), y2(i) ] = epipolarCorrespondence( im1, im2, F, x1(i), y1(i) );
end

[ P_288, err ] = triangulate( P1, [x1,y1], P2, [x2,y2] );

scatter3(P_288(:,1),P_288(:,2),P_288(:,3),'.');