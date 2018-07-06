function r = invRodrigues(R)
% invRodrigues
% Input:
%   R: 3x3 rotation matrix
% Output:
%   r: 3x1 vector
% 
%     theta = acos((trace(R)-1)/2);
%     r = 1/(2*sin(theta))*[R(3,2)-R(2,3);R(1,3)-R(3,1);R(2,1)-R(1,2)];
    
    A = (R-R')/2;
    rho = [A(3,2); A(1,3); A(2,1)];
    s = norm(rho);
    c = (R(1,1)+R(2,2)+R(3,3)-1)/2;
    if s == 0 && c == 1
        r = zeros(3,1);
    elseif s == 0 && c == -1
        R_I = R + eye(3);
        v = zeros(3,1);
        for i = 1:3
            if all(R_I(:,i))
                v = R_I(:,i);
            end
        end
        u = v./norm(v);
        r = u*pi;
        if norm(r) == pi
            r = -r;
        end
    else
        u = rho/s;
        theta = atan(s/c);
        r = u*theta;
    end
        
    
end
