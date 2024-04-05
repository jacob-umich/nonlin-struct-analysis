% this script file gives the user the option to list the
% nodal displacements. the file requires the delta matrix.


i = input('would you like to list the nodal displacements? [Y] ','s');

if (isempty(i) | (i == 'Y') | (i == 'y'))

fprintf('\n\nnode                displacement\n');
fprintf('--------------------------------\n\n');

  for j = 1:nnod

  if (dofnum(1,j) <= nfdof)
     dx = delta(dofnum(1,j));
  else
     dx = deltas(dofnum(1,j) - nfdof);
  end

  if (dofnum(2,j) <= nfdof)
     dy = delta(dofnum(2,j));
  else
     dy = deltas(dofnum(2,j) - nfdof);
  end

  fprintf('node %g                        \n',j);
  fprintf('delta x =                   %g   \n',dx);
  fprintf('delta y                     %g   \n',dy);

  end
else

   i = input('would you like to see an individual nodal displacement? [Y] ','s');

   while (isempty(i) | (i == 'Y') | (i == 'y'))

       node = input('enter the node to be displayed ---> ');

       if ((node > nnod) | (node < 1))
          fprintf('\n\nthis is an invalid selection\n\n');
       else
  	  if (dofnum(1,node) <= nfdof)
 	     dx = delta(dofnum(1,node));
	  else
	     dx = deltas(dofnum(1,node) - nfdof);
	  end

	  if (dofnum(2,node) <= nfdof)
	     dy = delta(dofnum(2,node));
	  else
	     dy = deltas(dofnum(2,node) - nfdof);
	  end

       fprintf('\n\nnode %g \n\n',node)
       fprintf('delta x = %g\n',dx)
       fprintf('delta y = %g\n',dy)
       fprintf('z rotation = %g\n',zrot)

       end  % if

  i = input('would you like to see another nodal displacement? [Y] ','s');

  end   % while loop

end   % if
