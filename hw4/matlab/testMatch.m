img = imread('chickenbroth_01.jpg');
img_gray = double(rgb2gray(img));
[locs, desc] = briefLite(img_gray);

img2 = imread('model_chickenbroth.jpg');
img_gray2 = double(rgb2gray(img2));
[locs2, desc2] = briefLite(img_gray2);

%%
ratio = 0.8;
[matches] = briefMatch(desc, desc2, ratio);
plotMatches(img, img2, matches, locs, locs2);