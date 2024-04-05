% this script file calculates the member force from the member
% displacements

% assign the fixed dof 0 displacement

% initialize the mforce vector
mforce = zeros(4,nbc);

for i = 1:nbc

    e = prop(1, idbc(3,i));
    a = prop(2, idbc(3,i));
    Iz = prop(3, idbc(3,i));

  % get nodal coordinates
    x1 = coord(1,idbc(1,i));
    y1 = coord(2,idbc(1,i));
    x2 = coord(1,idbc(2,i));
    y2 = coord(2,idbc(2,i));

[l,phi] = meminf(x1,y1,x2,y2);

    node1 = idbc(1,i);
    node2 = idbc(2,i);

    eledof = [dofnum(1,node1);
              dofnum(2,node1);
              dofnum(1,node2);
              dofnum(2,node2);];

% calculate the element stiffness matrix

kele = estiff(e,a,Iz,l);

% calculate the load vector

ptotal = p;

ptotal((nfdof+1):ndof) = zeros(ndof-nfdof,1);


% calculate global element displacements

deltat(1:nfdof) = delta;
deltat((nfdof+1):ndof) = zeros(ndof-nfdof,1);

gedisp = [deltat(eledof(1));
          deltat(eledof(2));
          deltat(eledof(3));
          deltat(eledof(4));];


% calculate the transformation matrix

egamma = etran(phi);

% transform to element displacements

eledisp = egamma * gedisp;


% calculate member forces in a vector mforce

mforce(:,i) = kele * eledisp;


end

