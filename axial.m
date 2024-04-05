% this script file prints the axial force in a member given
% the end nodal displacements.

i = [];
i = input('Would you like to list the axial force for each member? [Y] ','s');
    if isempty(i)
       i='Y';
    end
    if (i == 'y' | i == 'Y' )

       fprintf('\n\n');
       fprintf('member            force  \n');
       fprintf('-----------------------  \n\n');

       for j = 1:nbc

         fprintf('%g               %g   \n',j,mforce(3,j));

       end

        fprintf('\n');
    end



