function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q4.1:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q4_1.mat
%
%           Explain your methods and optimization in your writeup


    [h,w,~] = size(im1);
    x = [x1,y1,1]';
    l_dash = F*x;
    
    x1 = uint16(x1);
    y1 = uint16(y1);
    
    possible_points = [];
%     for i = 1:w
%         y = (-l_dash(1)*i-l_dash(3))/l_dash(2);
%         if y>0 && y<h
%             possible_points = [possible_points;[i,y]];
%         end
%     end
    for i = 7:h-7
        x = (-l_dash(2)*i-l_dash(3))/l_dash(1);
        if x>6 && x<w-6
            possible_points = [possible_points;[uint16(x),i]];
        end
    end
    
    distance = zeros(size(possible_points,1),1);
    im1_gray = double(rgb2gray(im1));
    im2_gray = double(rgb2gray(im2));
    for i = 1:size(possible_points,1)
        x_temp = possible_points(i,1);
        y_temp = possible_points(i,2);
        for j = 0:10
            for k = 0:10
               distance(i) = distance(i)+ (im1_gray(y1-5+j,x1-5+k)-im2_gray(y_temp-5+j,x_temp-5+k))^2;
            end
        end
    end
    
    [min_dst,index] = min(distance);
    x2 = possible_points(index,1);
    y2 = possible_points(index,2);
    
end

