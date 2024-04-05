% this script file prints the axial force in a member given
% the end nodal displacements.

i = [];
i = input('Would you like to list the moment for each member? [Y] ','s');
    if isempty(i)
       i='Y';
    end
    if (i == 'y' | i == 'Y' )

       fprintf('\n\n');
       fprintf('member     moment at i     momemt at  j  \n');
       fprintf('--------------------------------------  \n\n');

       for j = 1:nbc

         fprintf('%g          %g             %g\n',j,mforce(3,j),mforce(6,j));    

       end
       
       fprintf('\n');
    end 


   