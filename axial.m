% this script file prints the axial force in a member given
% the end nodal displacements.

i = [];
i = input('Would you like to list the axial force for each member? [Y] ','s');
    if isempty(i)
        i='Y';
    end
    if (i == 'y' || i == 'Y' )

        fprintf('\n\n');
        fprintf('member            force  \n');
        fprintf('-----------------------  \n\n');

        for j = 1:numel(structure.elements)
            element = structure.elements{j};
            fprintf('%g               %g   \n',j,element.get_internal()(3));

        end

        fprintf('\n');
    end



