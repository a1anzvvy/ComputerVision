% your code here

load('../data/sylvseq.mat');
load('../data/sylvbases.mat');
rect = [102, 62, 156, 108]';
rect1 = [102, 62, 156, 108]';

n = size(frames,3);
%bound_leftup = [];
%bound_rightbottom = [];
rects = zeros(n,4);
for i = 1:n-1
    [u,v] = LucasKanadeBasis(frames(:,:,i), frames(:,:,i+1), rect, bases);
    rect = rect+[u,v,u,v]';
    rects(i,:) = rect;
%     [u1,v1] = LucasKanadeInverseCompositional(frames(:,:,i), frames(:,:,i+1), rect);
%     rect1 = rect1+[u1,v1,u1,v1]';
    
    % Visualization
    imshow(frames(:,:,i+1));hold on
    rectangle('Position',[rect(1),rect(2),rect(3)-rect(1),rect(4)-rect(2)],'EdgeColor','g');
%     rectangle('Position',[rect1(1),rect1(2),rect1(3)-rect1(1),rect1(4)-rect1(2)],'EdgeColor','r');
    i
    pause;
end