function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
%Your implementation here
%Im - grayscale image - 
%threshold - prevents low gradient magnitude points from being included
%rhoRes - resolution of rhos - scalar
%thetaRes - resolution of theta - scalar
%    Im = Im - threshold;
%    Im(Im<0)=0;
%    Im(Im~=0) = Im(Im~=0) + threshold;
   
   rhoMax = norm(size(Im)/2,2);
   H = zeros(ceil(pi/thetaRes),ceil(rhoMax/rhoRes+1));
   
%% Original
%    for i = 1:size(Im,1)
%       for j = 1:size(Im,2)
%          if Im(i,j)>threshold
%              newX = j-size(Im,2)/2;
%              newY = -i+size(Im,1)/2;
%              for k = 1:size(H,1)
%                  theta = k*thetaRes; 
%                  rho = abs(newX * cos(theta) + newY * sin(theta));
%                  test = [test rho];
%                  if rho > 400
%                     rho = 400; 
%                  end
%                  if rho == 0
%                     rho = 1; 
%                  end
%                  %H(k,uint8(ceil(rho/rhoRes))+1) = H(k,uint8(ceil(rho/rhoRes))+1)+1;
%                  H(k,ceil(rho/rhoRes)) = H(k,ceil(rho/rhoRes))+1;
%              end
%          end
%       end
%    end
%    
%    max(test)
%    
%    H = [H zeros(size(H,1),1)];
%    H = H(:,2:size(H,2));
%    
%    rhoScale = 0:rhoRes:rhoMax;
%    thetaScale = thetaRes:thetaRes:pi;
   
%% Test
%    
%    rhoMax = norm(size(Im)/2,2);
%    H = zeros(ceil(2*pi/thetaRes),ceil(rhoMax/rhoRes+1));
% 
%     for i = 1:size(Im,1)
%       for j = 1:size(Im,2)
%          if Im(i,j)>threshold
%              newX = j-size(Im,2)/2;
%              newY = -i+size(Im,1)/2;
%              for k = 1:size(H,1)
%                  theta = k*thetaRes;
%                  rho = newX * cos(theta) + newY * sin(theta);
%                  if rho > 0
%                      if rho > 400
%                         rho = 400; 
%                      end
%                      if rho == 0
%                         rho = 1; 
%                      end
%                      %H(k,uint8(ceil(rho/rhoRes))+1) = H(k,uint8(ceil(rho/rhoRes))+1)+1;
%                      H(k,ceil(rho/rhoRes)) = H(k,ceil(rho/rhoRes))+1;
%                  end
%              end
%          end
%       end
%     end
%    
%    H = [H zeros(size(H,1),1)];
%    H = H(:,2:size(H,2));
%    
%    rhoScale = 0:rhoRes:rhoMax;
%    thetaScale = thetaRes:thetaRes:2*pi;


%% New Coordinate


   rhoMax = norm(size(Im),2);
   H = zeros(ceil(2*pi/thetaRes),ceil(rhoMax/rhoRes+1));

    for i = 1:size(Im,1)
      for j = 1:size(Im,2)
         if Im(i,j)>threshold
             for k = 1:size(H,1)
                 theta = k*thetaRes;
                 rho = j * cos(theta) + i * sin(theta);
                 if rho > 0
                     if rho > 800
                        rho = 800; 
                     end
                     if rho == 0
                        rho = 1; 
                     end
                     %H(k,uint8(ceil(rho/rhoRes))+1) = H(k,uint8(ceil(rho/rhoRes))+1)+1;
                     H(k,ceil(rho/rhoRes)) = H(k,ceil(rho/rhoRes))+1;
                 end
             end
         end
      end
    end
   
   %H = [H zeros(size(H,1),1)];
   %H = H(:,2:size(H,2));
   
   rhoScale = 0:rhoRes:rhoMax;
   thetaScale = thetaRes:thetaRes:2*pi;

end
        
        
