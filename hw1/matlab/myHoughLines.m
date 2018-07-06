function [rhos, thetas] = myHoughLines(H, nLines)
%Your implemention here

   Htemp = H;

   for i = 2:size(H,1)-1
       for j = 2:size(H,2)-1
           temp = [
                   Htemp(i-1,j-1) 
                   Htemp(i-1,j) 
                   Htemp(i-1,j+1) 
                   Htemp(i,j-1)
                   Htemp(i,j) 
                   Htemp(i,j+1) 
                   Htemp(i+1,j-1) 
                   Htemp(i+1,j) 
                   Htemp(i+1,j+1)
                   ];
           if Htemp(i,j) ~= max(temp)
               H(i,j) = 0;
           end
       end
   end
   
   for i = 2:size(H,1)-1
      j = 1;
      temp = [ 
        Htemp(i-1,j) 
        Htemp(i-1,j+1)
        Htemp(i,j) 
        Htemp(i,j+1) 
        Htemp(i+1,j) 
        Htemp(i+1,j+1)
      ];
      if Htemp(i,j) ~= max(temp)
         H(i,j) = 0;
      end
   end
   
   for i = 2:size(H,1)-1
      j = size(H,2);
      temp = [ 
        Htemp(i-1,j) 
        Htemp(i-1,j-1)
        Htemp(i,j) 
        Htemp(i,j-1) 
        Htemp(i+1,j) 
        Htemp(i+1,j-1)
      ];
      if Htemp(i,j) ~= max(temp)
         H(i,j) = 0;
      end
   end
   
   for j = 2:size(H,2)-1
      i = 1;
      temp = [ 
        Htemp(i,j-1)
        Htemp(i,j) 
        Htemp(i,j+1) 
        Htemp(i+1,j-1) 
        Htemp(i+1,j) 
        Htemp(i+1,j+1)
      ];
      if Htemp(i,j) ~= max(temp)
         H(i,j) = 0;
      end
   end
   
   for j = 2:size(H,2)-1
      i = size(H,1);
      temp = [ 
        Htemp(i,j-1)
        Htemp(i,j) 
        Htemp(i,j+1) 
        Htemp(i-1,j-1) 
        Htemp(i-1,j) 
        Htemp(i-1,j+1)
      ];
      if Htemp(i,j) ~= max(temp)
         H(i,j) = 0;
      end
   end
   
   

%    for i = 3:size(H,1)-2
%        for j = 3:size(H,2)-2
%            temp = [
%                    Htemp(i-2,j-2) 
%                    Htemp(i-2,j-1) 
%                    Htemp(i-2,j)
%                    Htemp(i-2,j+1) 
%                    Htemp(i-2,j+2) 
%                    
%                    Htemp(i-1,j-2)
%                    Htemp(i-1,j-1) 
%                    Htemp(i-1,j) 
%                    Htemp(i-1,j+1) 
%                    Htemp(i-1,j+2) 
%                    
%                    Htemp(i,j-2) 
%                    Htemp(i,j-1)
%                    Htemp(i,j) 
%                    Htemp(i,j+1)
%                    Htemp(i,j+2)
%                    
%                    Htemp(i+1,j-2) 
%                    Htemp(i+1,j-1)
%                    Htemp(i+1,j) 
%                    Htemp(i+1,j+1)
%                    Htemp(i+1,j+2)
%                    
%                    Htemp(i+2,j-2) 
%                    Htemp(i+2,j-1)
%                    Htemp(i+2,j) 
%                    Htemp(i+2,j+1)
%                    Htemp(i+2,j+2)
%                    ];
%            if Htemp(i,j) ~= max(temp)
%                H(i,j) = 0;
%            end
%        end
%    end
   
%    H(1:2,:) = 0;
%    H(size(H,1)-1:size(H,1),:) = 0;
%    H(:,1:2) = 0;
%    H(:,size(H,1)-1:size(H,1)) = 0;
   
   [sv, si]=sort(H(:),'descend');
   [ thetas, rhos ] = ind2sub( size(H), si(1:nLines) );
   
   %rhos = rhos + size(H,2)/2;

end
        