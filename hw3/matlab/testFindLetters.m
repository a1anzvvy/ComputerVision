% Since I use Hierachical Clustng, I have to adjust cutoff parameters in
% findLetters.m. I think it's ok since I posted a post on piazza.

img = imread('../images/01_list.jpg');
[lines, bw] = findLetters(img);
img = imread('../images/02_letters.jpg');
[lines, bw] = findLetters(img);
img = imread('../images/03_haiku.jpg');
[lines, bw] = findLetters(img);
img = imread('../images/04_deep.jpg');
[lines, bw] = findLetters(img);

