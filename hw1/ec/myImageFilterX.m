function [img1] = myImageFilterX(img0, hm)

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
   for i = 1:H*W
        row = 1 + floor((i-1)/W); % coordinates in original matrix
        col = mod(i,W);
        if col == 0
            col = W;
        end
        eRow = row + (h-1)/2; % coordinates in expanded matrix
        eCol = col + (w-1)/2;
        img1(row,col) = sum(sum(img_expand(eRow-(h-1)/2:eRow-(h-1)/2+h-1,eCol-(w-1)/2:eCol-(w-1)/2+w-1).*double(hm)));
    end

end