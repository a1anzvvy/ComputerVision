img = imread('model_chickenbroth.jpg');
img_gray = double(rgb2gray(img));
[locs, desc] = briefLite(img_gray);

img2 = imread('model_chickenbroth.jpg');
img_gray2 = double(rgb2gray(img2));
[locs2, desc2] = briefLite(img_gray2);

ratio = 0.8;
[matches] = briefMatch(desc, desc2, ratio);

n_matches = zeros(10,1);
n_matches(1) = size(matches,1);

for i = 1:9
    img_rotate = imrotate(img_gray2,i*10);
    [locs_temp, desc_temp] = briefLite(img_rotate);
    [matches] = briefMatch(desc, desc_temp, ratio);
    n_matches(i+1) = size(matches,1);
end

bar(n_matches)