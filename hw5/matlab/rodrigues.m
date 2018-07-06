function R = rodrigues(r)
% rodrigues:

% Input:
%   r - 3x1 vector
% Output:
%   R - 3x3 rotation matrix
    
    n = norm(r);
    r = r/n;
    R = eye(3)*cos(n) + (1-cos(n))*r*r' + sin(n)*[0, -r(3), r(2); r(3), 0, -r(1); -r(2), r(1), 0];

end
