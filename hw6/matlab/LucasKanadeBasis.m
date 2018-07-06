function [u,v] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases 
% output - movement vector, [u,v] in the x- and y-directions.

    p = [0;0];
    delta_p = [0.1;0.1];
    [x_grid,y_grid] = meshgrid(rect(1):rect(3), rect(2):rect(4));
    T = interp2(double(It),x_grid,y_grid);
    [x_gradient,y_gradient] = gradient(T);
    u = p(1);
    v = p(2);
    bases = reshape(bases,size(bases,1)*size(bases,2),size(bases,3))';
    bases = bases(:,1:size(x_grid,1)*size(x_grid,2));
    A = [x_gradient(:),y_gradient(:)] - (bases'*bases)*[x_gradient(:),y_gradient(:)];
    Hessian = A'*A;
    
    while norm(delta_p) > 0.1
        [X, Y] = meshgrid((rect(1) : rect(3)) + u, (rect(2) : rect(4)) + v);
        I = interp2(double(It1), X, Y);
        Diff = T-I;
        temp = [x_gradient(:), y_gradient(:)]' * Diff(:);
        delta_p = inv(Hessian)*temp;
        u = u+delta_p(1);
        v = v+delta_p(2);
    end
end