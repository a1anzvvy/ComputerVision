
load('../data/aerialseq.mat');
rect = [60,117,146,152]';

n = size(frames,3);
%bound_leftup = [];
%bound_rightbottom = [];
for i = 1:n-1
    mask = SubtractDominantMotion(frames(:,:,i), frames(:,:,i+1));
    
    
%     % Visualization
    imshow(frames(:,:,i+1));hold on
    rectangle('Position',[rect(1),rect(2),rect(3)-rect(1),rect(4)-rect(2)]);
    imshow(imfuse(frames(:,:,i),mask));
    i
    pause;
end
