function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size

    M = LucasKanadeAffine(image1, image2);
%     [x_grid,y_grid] = meshgrid(1:size(image1,2), 1:size(image1,1));
%     X = M(1,1).*x_grid + M(1,2).*y_grid + ones(size(x_grid)).*M(1,3);
%     Y = M(2,1).*x_grid + M(2,2).*y_grid + ones(size(x_grid)).*M(2,3);
%     I =  interp2(double(image1), X, Y);

    I = warpH(image1, M, [size(image1,1), size(image2,2)]);

    diff = abs(double(I) - double(image2));
    diff(diff<=2) = 0;
    diff(diff>2) = 1;
%     imshow(diff);
%     imshow(diff/max(diff(:)));

    diff = bwareaopen(diff,30);
%     imshow(diff);
    se = strel('disk',2);  
    diff = imerode(diff, se);
%     imshow(diff);
    se = strel('disk',3);
    diff = bwareaopen(diff,15);
%     imshow(diff);
    diff = imdilate(diff, se);
%     imshow(diff);
    diff = medfilt2(diff);
%     imshow(diff);

    mask = diff;
    
  
end
