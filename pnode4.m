% this script file creates a one dimensional array
% called p(nfdof) that includes all the applied nodal
% loads in the order of the dof numbering system.

% initialize the p array
p = zeros(nfdof,1);

% calculate ptotal by sequentially testing each element
% in the dofnum matrix.

i = 0; j =0; k = 0;

% initialize the ptotal matrix
ptotal = zeros(ndof,1);

for i = 1:nload
  lnode = loading(1, i);
  for j = 1:2
     if (dofnum(j,lnode) <= nfdof)
        ptotal(dofnum(j,lnode)) = loading(j+1, i);
     end
  end
end


% add in the loads between nodes

% initialize the PF array
PF = zeros(ndof,1);

for i = 1:nmemld

    node1 = idbc(1,mload(1,i));
    node2 = idbc(2,mload(1,i));
    [meml,phi] = meminf(coord(1,node1),coord(2,node1),coord(1,node2),coord(2,node2));

% define PFele

PFele = [(mload(2,i)*meml)/2;
         0;

         (mload(2,i)*meml)/2;
         0];

% convert the element loads to global coordinates


gamma = etran(phi);
PFeg = gamma' * PFele;
disp(PFeg)
% assemble in PF matrix

for j = 1:2

PF(dofnum(j, node1)) = PF(dofnum(j, node1)) + PFeg(j);
PF(dofnum(j, node2)) = PF(dofnum(j, node2)) + PFeg(j+2);

end

end


% set up the PT matrix for thermal gradients

if (~isempty(heat))

   % initialize the PT array; PT is the fixed end forces from the gradients
   PT = zeros(ndof,1);

   for i = 1:ntemp

if (coord(2,idbc(1,heat(1,i))) < coord(2,idbc(2,heat(1,i))))

       node1 = idbc(1,heat(1,i));
       node2 = idbc(2,heat(1,i));
       [meml,phi] = meminf(coord(1,node1),coord(2,node1),coord(1,node2),coord(2,node2));
else
       node2 = idbc(1,heat(1,i));
       node1 = idbc(2,heat(1,i));
       [meml,phi] = meminf(coord(1,node1),coord(2,node1),coord(1,node2),coord(2,node2));

end    % if



   % store the properties of the members
     hE = prop(1,heat(1,i));
     hA = prop(2,heat(1,i));
     hI = prop(3,heat(1,i));


   % define PTele

   PTele = [(heat(3,i)*hE*hA*heat(2,i));
            (0);
            (-hE*hI*heat(2,i)*heat(4,i)/heat(5,i));
            (-heat(3,i)*hE*hA*heat(2,i));
            (0);
            (hE*hI*heat(2,i)*heat(4,i)/heat(5,i))];

   % convert the element loads to global coordinates


   gamma = etran(phi);
   PTeg = gamma' * PTele;

   % assemble in PT matrix

   for j = 1:3

   PT(dofnum(j, node1)) = PT(dofnum(j, node1)) + PTeg(j);
   PT(dofnum(j, node2)) = PT(dofnum(j, node2)) + PTeg(j+3);

   end   % for loop

   end   % for loop

% add in the thermal gradients to PF(fixed end forces) array

PF = PF + PT;

end   % check if there is thermal gradients






% factor in PF array into the Ptotal matrix

format long
ptotalf = ptotal + PF;

% partition the ptotalf vector

P = ptotalf(1:nfdof);

supload = ptotalf((nfdof+1):ndof);







