% this script file gives the user the option to list the
% nodal displacements. the file requires the delta matrix.


i = input('would you like to list the nodal displacements? [Y] ','s');

if (isempty(i) | (i == 'Y') | (i == 'y'))

fprintf('\n\nnode                displacement\n');
fprintf('--------------------------------\n\n');

    for j = 1:numel(structure.nodes)
        node = strucutre.nodes{j}
        dx = node.pos(1)-node.orig_pos(1);
        dy = node.pos(2)-node.orig_pos(2);


    fprintf('node %g                        \n',j);
    fprintf('delta x =                   %g   \n',dx);
    fprintf('delta y                     %g   \n',dy);

    end
else

    i = input('would you like to see an individual nodal displacement? [Y] ','s');

    while (isempty(i) | (i == 'Y') | (i == 'y'))

        node_ind = input('enter the node to be displayed ---> ');

        if ((node_ind > numel(structure.nodes)) | (node_ind < 1))
            fprintf('\n\nthis is an invalid selection\n\n');
        else
        node = strucutre.nodes{node_ind}
        dx = node.pos(1)-node.orig_pos(1);
        dy = node.pos(2)-node.orig_pos(2);

        fprintf('\n\nnode %g \n\n',node_ind)
        fprintf('delta x = %g\n',dx)
        fprintf('delta y = %g\n',dy)

        end  % if

        i = input('would you like to see another nodal displacement? [Y] ','s');

    end   % while loop

end   % if
