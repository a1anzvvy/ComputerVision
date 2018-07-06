function M = LucasKanadeAffine(It, It1)

% input - image at time t, image at t+1 
% output - M affine transformation matrix

    p = zeros(2,3);
    delta_p = 0.1 * ones(2,3);
    [x_grid,y_grid] = meshgrid(1:size(It,2), 1:size(It,1));
    
    while norm(delta_p)>0.1
        M = [1+p(1,1),p(1,2),p(1,3);
             p(2,1),1+p(2,2),p(2,3);
             0,0,1];
        X = M(1,1).*x_grid + M(1,2).*y_grid + ones(size(x_grid)).*M(1,3);
        Y = M(2,1).*x_grid + M(2,2).*y_grid + ones(size(x_grid)).*M(2,3);
        I =  interp2(double(It1), X, Y);
%         I = warpH(It1, M, [size(It1,1), size(It1,2)]);
        I(isnan(I)) = 0;
        diff = double(It) - I;
        diff(I==0) = 0;
        
        [x_gradient,y_gradient] = gradient(I);
        x_gradient(I==0) = 0;
        y_gradient(I==0) = 0;
        
        temp = [x_gradient(:).*x_grid(:), x_gradient(:).*y_grid(:), x_gradient(:), y_gradient(:).*x_grid(:), y_gradient(:).*y_grid(:),y_gradient(:)];
        H = temp' * temp;
        delta_p = inv(H)*(temp'*diff(:));
        p = p + [delta_p(1),delta_p(2),delta_p(3);
                 delta_p(4),delta_p(5),delta_p(6)];
    end


end
