

load('../data/usseq.mat');
rect = [255, 105, 310, 170]';

n = size(frames,3);
%bound_leftup = [];
%bound_rightbottom = [];
rects = zeros(n,4);
for i = 1:n-1
    [u,v] = LucasKanadeInverseCompositional(frames(:,:,i), frames(:,:,i+1), rect);
    rect = rect+[u,v,u,v]';
    rects(i,:) = rect;
    % Visualization
    imshow(frames(:,:,i+1));hold on
    rectangle('Position',[rect(1),rect(2),rect(3)-rect(1),rect(4)-rect(2)],'EdgeColor','y');
    i
    pause;
end

%%
save('usseqrects.mat','rects');