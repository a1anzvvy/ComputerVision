function [Im Io Ix Iy] = myEdgeFilter(img, sigma)
%Your implemention

    % Gaussian filter
    hsize=2*ceil(3*sigma)+1;
    H = fspecial('gaussian',hsize,sigma);
    img0 = myImageFilter(img,H);
    
    % Sobel filter
    xSobel = fspecial('Sobel');
    ySobel = fspecial('Sobel')';
    Ix = myImageFilter(img0,xSobel);
    Iy = myImageFilter(img0,ySobel);
    
    % Calculate Im and Io
    Im = sqrt(Ix.^2 + Iy.^2);
    Io = atan(Iy./Ix);
    
    % Find nearest direction of Io's each element
    for i = 1:size(Io,1)
       for j = 1:size(Io,2)
          if Io(i,j) <= pi/8 && Io(i,j) > -pi/8
              Io(i,j) = 0;
          elseif Io(i,j) <= pi/8*3 && Io(i,j) > pi/8
              Io(i,j) = pi/4;
          elseif Io(i,j) <= pi/8*5 && Io(i,j) > pi/8*3
              Io(i,j) = pi/2;
          else
              Io(i,j) = pi/4*3;
          end
       end
    end
    
    Imtemp = Im;
    
    % Replace non maximums with 0
    for i = 2:size(Im,1)-1
       for j = 2:size(Im,2)-1
           if Io(i,j) == 0
               if Imtemp(i+1,j) > Imtemp(i,j) || Imtemp(i-1,j) > Imtemp(i,j)
                   Im(i,j) = 0;
               end
           elseif Io(i,j) == pi/4
               if Imtemp(i+1,j+1) > Imtemp(i,j) || Imtemp(i-1,j-1) > Imtemp(i,j)
                   Im(i,j) = 0;
               end
           elseif Io(i,j) == pi/2   
               if Imtemp(i,j+1) > Imtemp(i,j) || Imtemp(i,j-1) > Imtemp(i,j)
                   Im(i,j) = 0;
               end
           elseif Io(i,j) == pi/4*3
               if Imtemp(i-1,j+1) > Imtemp(i,j) || Imtemp(i+1,j-1) > Imtemp(i,j)
                   Im(i,j) = 0;
               end
           end
       end
    end
    
    Im(1:2,:) = 0;
    Im(size(Im,1)-1:size(Im,1),:) = 0;
    Im(:,1:2) = 0;
    Im(:,size(Im,1)-1:size(Im,1)) = 0;
    
end
    

        
        
