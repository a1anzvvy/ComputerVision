function [points] = getHarrisPoints(I, alpha, k)
% Finds the corner points in an image using the Harris Corner detection algorithm
% Input:
%   I:                      grayscale image
%   alpha:                  number of points
%   k:                      Harris parameter
% Output:
%   points:                    point locations
%
    % -----fill in your implementation here --------
    w = size(I,2);
    h = size(I,1);
    
    if size(I,3) == 3
        I = rgb2gray(I);
    end
    
    % Image Gradient
    xSobel = fspecial('Sobel')';
    ySobel = fspecial('Sobel');
    Ix = imfilter(double(I),xSobel,'replicate');
    Iy = imfilter(double(I),ySobel,'replicate');
    
    filter = ones(3);
    % Mean Shift
    
%     meanFilter = filter/(size(filter,1)*size(filter,2));
%     Ixmean = imfilter(Ix,meanFilter,'replicate');
%     Iymean = imfilter(Iy,meanFilter,'replicate');
%     Ix = Ix-Ixmean;
%     Iy = Iy-Iymean;

    %Padding
    Ix = [repmat(Ix(:,1),1,2) Ix];
    Ix = [Ix repmat(Ix(:,end),1,2)];
    Ix = [Ix; repmat(Ix(end,:),2,1)];
    Ix = [repmat(Ix(1,:),2,1);Ix];
    
    Iy = [repmat(Iy(:,1),1,2) Iy];
    Iy = [Iy repmat(Iy(:,end),1,2)];
    Iy = [Iy; repmat(Iy(end,:),2,1)];
    Iy = [repmat(Iy(1,:),2,1);Iy];
    
    vecIx = im2col(Ix,[5 5]);
    vecIy = im2col(Iy,[5 5]);
    vecIx = vecIx-ones(25,1)*mean(vecIx);
    vecIy = vecIy-ones(25,1)*mean(vecIy);
    
    Ixx = sum(vecIx.*vecIx);
    Iyy = sum(vecIy.*vecIy);
    Ixy = sum(vecIx.*vecIy);
        
%     Ixx = Ix.^2;
%     Iyy = Iy.^2;
%     Ixy = Ix.*Iy;
%     
%     Ixx = imfilter(Ixx,filter,'replicate');
%     Iyy = imfilter(Iyy,filter,'replicate');
%     Ixy = imfilter(Ixy,filter,'replicate');
    
    R = zeros(size(I));
    for i = 1:h
       for j = 1:w
           H = [Ixx((j-1)*h+i), Ixy((j-1)*h+i);
                Ixy((j-1)*h+i), Iyy((j-1)*h+i)];
           R(i,j) = det(H) - k*(trace(H)^2);
       end
    end
    
    %R = imhmax(R,6000,8);
    for i = 3:size(R,1)-2
       for j = 3:size(R,2)-2
          temp = [R(i-1,j-1),R(i-1,j),R(i-1,j+1),R(i,j-1),R(i,j+1),R(i+1,j-1),R(i+1,j),R(i+1,j+1),R(i-2,j-2),R(i-2,j-1),R(i-2,j),R(i-2,j+1),R(i-2,j+2),R(i-1,j-2),R(i-1,j+2),R(i,j-2),R(i,j+2),R(i+1,j-2),R(i+1,j+2),R(i+2,j-2),R(i+2,j-1),R(i+2,j),R(i+2,j+1),R(i+2,j+2)];
          maxR = max(temp);
          if R(i,j) < maxR
              R(i,j)=0;
          end
       end
    end
    
    [sv, si] = sort(R(:),'descend');
    points = zeros(alpha,2);
    [points(:,2) points(:,1)] = ind2sub(size(R),si(1:alpha));

    % ------------------------------------------

end
