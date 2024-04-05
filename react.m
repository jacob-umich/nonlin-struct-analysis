% react.m is a script file that calculates the reactions
% at support dof given information on the appropriate
% nodal displacements and the K matrix.  The user is prompted
% for the node they would like to see displayed.

% calculate the reactios and store them in the array Ps


Ps = Ksf * delta + Kss * deltas - supload;


i = input('would you like to find a reaction? [Y]','s');

while (isempty(i) || (i == 'Y') || (i == 'y'))

   rnode = input('enter the supported node you would like displayed ---> ');
   fprintf('\n')

   if ((supp(1,rnode) == 0)&&(supp(2,rnode)==0))
      fprintf('\nthis is an unsupported node\n\n');
   else
   if (supp(1,rnode) ~= 0)
    fprintf('the x reaction at node %g = %g\n',rnode,Ps(dofnum(1,rnode)-nfdof));
   end
   if (supp(2,rnode) ~= 0)
    fprintf('the y reaction at node %g = %g\n',rnode,Ps(dofnum(2,rnode)-nfdof));
   end
   end
i = input('would you like to find another reaction? [Y] ','s');
fprintf('\n')
end


