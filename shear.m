% this script file prints the axial force in a member given
% the end nodal displacements.

i = [];
i = input('Would you like to list the shear force for each member? [Y] ','s');
    if isempty(i)
       i='Y';
    end
    if (i == 'y' | i == 'Y' )

       fprintf('\n\n');
       fprintf('member     shear at i     shear at  j  \n');
       fprintf('--------------------------------------  \n\n');

       for j = 1:nbc

         fprintf('%g          %g             %g\n',j,mforce(2,j),mforce(5,j));    

       end
       
       fprintf('\n');
    end 


   