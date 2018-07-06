function [points] = getRandomPoints(I, alpha)
% Generates random points in the image
% Input:
%   I:                      grayscale image
%   alpha:                  random points
% Output:
%   points:                    point locations
%
	% -----fill in your implementation here --------
    h = size(I,1);
    w = size(I,2);
    x = rand(alpha,1);
    y = rand(alpha,1);
%     points = [x * w, y * h];
    points = zeros(alpha,2);
    points(:,1) = x * w;
    points(:,2) = y * h;
    points = uint16(points);
    points = points - 1;
    points(points==0)=1;
    points(points<0)=1;
    % ------------------------------------------

end

