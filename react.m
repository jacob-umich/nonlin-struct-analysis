% react.m is a script file that calculates the reactions
% at support dof given information on the appropriate
% nodal displacements and the K matrix.  The user is prompted
% for the node they would like to see displayed.

% calculate the reactions and store them in the array Ps

[P,PF] = structure.get_loads();
F = structure.get_internal_force();

Ps = F - PF;


i = input('would you like to find a reaction? [Y]','s');

while (isempty(i) || (i == 'Y') || (i == 'y'))

   rnode = input('enter the supported node you would like displayed ---> ');
   fprintf('\n')
   node = structure.nodes{rnode};

   if ((node.fixity(1) == 0)&&(node.fixity(2)==0))
      fprintf('\nthis is an unsupported node\n\n');
   else
   if (node.fixity(1) ~= 0)
    fprintf('the x reaction at node %g = %g\n',rnode,Ps(node.dof(1)));
   end
   if (node.fixity(2) ~= 0)
    fprintf('the y reaction at node %g = %g\n',rnode,Ps(node.dof(2)));
   end
end
i = input('would you like to find another reaction? [Y] ','s');
fprintf('\n')
end


