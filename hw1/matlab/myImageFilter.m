function [img1] = myImageFilter(img0, hm)
    
    % Flip the image
    hm = fliplr(hm);
    hm = flipud(hm);
    
    %Get the size of the filter and the original image
    [h, w] = size(hm);
    [H, W] = size(img0);
    img1 = zeros([H,W]);
    
    % Construct expand matrix
    a11 = ones((h-1)/2,(w-1)/2) * img0(1,1);
    a13 = ones((h-1)/2,(w-1)/2) * img0(1,W);
    a31 = ones((h-1)/2,(w-1)/2) * img0(H,1);
    a33 = ones((h-1)/2,(w-1)/2) * img0(H,W);
    a12 = repmat(img0(1,:),(h-1)/2,1);
    a32 = repmat(img0(H,:),(h-1)/2,1);
    a21 = repmat(img0(:,1),1,(w-1)/2);
    a23 = repmat(img0(:,W),1,(w-1)/2);
    
    img_expand = [a11 a12 a13;
                  a21 img0 a23;
                  a31 a32 a33];
                  
    % For each pixel, calculate the filter
    for i = (h+1)/2:H+(h-1)/2
       for j = (w+1)/2:W+(w-1)/2
           img1(i-(h-1)/2,j-(w-1)/2) = sum(sum(img_expand(i-(h-1)/2:i-(h-1)/2+h-1,j-(w-1)/2:j-(w-1)/2+w-1).*double(hm)));
       end
    end
    
end

