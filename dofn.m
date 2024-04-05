%	CES 4101 - Structural Analysis II
%
%	Instructor:	Sherif El-Tawil
%			Dept. of Civil and Env. Eng.
%			University of Central Florida
%			Orlando, FL 32816-2450
%			Ph: 407-823-3743, E-Mail: sherif@maha.engr.ucf.edu
%
% This script file assigns degree of freedom numbers to nodes.
% This script file needs the variables nnod and supp


% initialize the matrix

dofnum(1:2,1:nnod) = zeros(2,nnod);

count = 0;
i = 0; j = 0;

% assign free dof numbers to unsuported nodes

for i= 1:nnod
   if(supp(:,i) == zeros(2,1))
     count = count + 1; 
     dofnum(1,i) = count;
     count = count + 1; 
     dofnum(2,i) = count;
   end
end

count= count+1;
 
% assign free dof numbers to supported nodes

for i= 1:nnod
    for j = 1:2
       if (supp(j,i) == 0)
          if (dofnum(j,i) == 0)   
            dofnum(j,i) = count;
            count = count+1;
          end
       end
    end
end


% calculate the number of free degrees of freedom
nfdof = count - 1;

% asign fixed dof numbers

for i= 1:nnod
     for j = 1:2
       if (supp(j,i) ~= 0)
          if (dofnum(j,i) == 0)
            dofnum(j,i) = count;
            count = count+1;
          end
       end
     end
end

% count the number of total degrees of freedom
ndof = count - 1;
