img = imread('../data/cv_cover.jpg');
% img_gray = double(rgb2gray(img));
[locs1, desc1] = briefLite(img);

img2 = imread('../data/cv_desk.png');
img_gray2 = rgb2gray(img2);
[locs2, desc2] = briefLite(img_gray2);

ratio = 0.8;
[matches] = briefMatch(desc1, desc2, ratio);
plotMatches(img, img_gray2, matches, locs1, locs2);

x1 = locs1(matches(:,1),:);
x2 = locs2(matches(:,2),:);

[bestH2to1, inliers] = computeH_ransac(x1,x2);

img3 = imread('../data/hp_cover.jpg');
img3 = imresize(img3,[440 350]);
% warp_im = warpH(img3, inv(bestH2to1), [548 731],0);
figure();
[ composite_img ] = compositeH( bestH2to1, img3, img2 );
imshow(composite_img);
