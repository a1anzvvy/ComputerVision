
load('../data/usseq.mat');
load('usseqrects.mat');

n = size(frames,3);
%bound_leftup = [];
%bound_rightbottom = [];
rects = uint16(rects);
for i = 1:n-1
    mask = SubtractDominantMotion(frames(:,:,i), frames(:,:,i+1));
    binary_mask = zeros(size(frames(:,:,i)));
    binary_mask(rects(i,2):rects(i,4),rects(i,1):rects(i,3)) = 1;
%     binary_mask = uint8(binary_mask);
    mask = mask & binary_mask;
    
    imshow(imfuse(frames(:,:,i),mask));
    i
    pause;
end
