% this m-file calculates the displacements due to a support
% settlement.

j=0;

deltas = zeros((ndof - nfdof),1);

i=input('Do you want to input any support settlements? [N] --> ','s');

 if ((~isempty(i)) & ((i == 'Y') | (i == 'y')))

 
   nssett = input('enter the number of support nodes that settle --->  ');


 for j = 1:nssett

  supnod = input('enter the support node that settles ---> ');

    sx = input('settlement in the x-direction --->  ');

    sy = input('settlement in the y-direction --->  ');

    sz = input('constrained rotation  --->  ');



  if ((sx ~= 0) & (dofnum(1,supnod) > nfdof))
     deltas((dofnum(1,supnod)-nfdof)) = sx;
  end

  if ((sy ~= 0) & (dofnum(2,supnod) > nfdof))
     deltas((dofnum(2,supnod)-nfdof)) = sy;
  end
 
  if ((sz ~= 0) & (dofnum(3,supnod) > nfdof))
     deltas((dofnum(3,supnod)-nfdof)) = sz;
  end
     
 end

end            