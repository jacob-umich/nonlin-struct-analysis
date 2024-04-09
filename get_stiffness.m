function[K]=get_stiffness[coord, dofnum ]
K = zeros(ndof,ndof);

for i = 1:nbc

  % get nodal coordinates
    x1 = coord(1,idbc(1,i));
    y1 = coord(2,idbc(1,i));
    x2 = coord(1,idbc(2,i));
    y2 = coord(2,idbc(2,i));

    [l,phi] = meminf(x1,y1,x2,y2);

  % calculate the transformation matrix
    gamma = etran(phi);

    node_i= idbc(1,i)
    node_j= idbc(2,i)
    elem_delta = delta([dofnum(1,node_i),dofnum(2,node_i),dofnum(1,node_2),dofnum(1,node_2)])
    delta_local = gamma*elem_delta
    strain = delta_local[3]-delta_local[1]/l

    e_base = prop(1, idbc(3,i));
    e = get_moi(e_base,strain)
    a = prop(2, idbc(3,i));
    Iz = prop(3, idbc(3,i));

  % calculate element stiffnes matrix
    elk = estiff(e,a,Iz,l);

  % calculate the global stiffness matrix
    [Ke] =  [gamma]' * [elk] * [gamma];

  % partition the global stiffness matrix and assemble
    a = idbc(1,i);
    b = idbc(2,i);

    eledof = [dofnum(1,a);
	      dofnum(2,a);
	      dofnum(1,b);
	      dofnum(2,b);];


% create global K matrix

for l = 1:4
  for m = 1:4

    % if ((eledof(l)<=nfdof) | (eledof(m)<=nfdof))
       K(eledof(l),eledof(m)) = K(eledof(l),eledof(m)) + Ke(l,m);

    % end
  end
end

end

% partition Kff and Kfs

Kff = K(1:nfdof,1:nfdof);

Ksf = K((nfdof+1):ndof, 1:nfdof);

Kfs = K(1:nfdof, (nfdof+1):ndof);

Kss = K((nfdof+1):ndof, (nfdof+1):ndof);
