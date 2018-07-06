function [u,v] = LucasKanadeInverseCompositional(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u, v] in the x- and y-directions.

    p = [0;0];
    delta_p = [0.1;0.1];
    [x_grid,y_grid] = meshgrid(rect(1):rect(3), rect(2):rect(4));
    T = interp2(double(It),x_grid,y_grid);
    [x_gradient,y_gradient] = gradient(T);
    u = p(1);
    v = p(2);
    Hessian = [x_gradient(:),y_gradient(:)]'*[x_gradient(:),y_gradient(:)];
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