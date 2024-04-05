%	CES 4101 - Structural Analysis II
%
%	Instructor:	Sherif El-Tawil
%			Dept. of Civil and Env. Eng.
%			University of Central Florida
%			Orlando, FL 32816-2450
%			Ph: 407-823-3743, E-Mail: sherif@maha.engr.ucf.edu
%
% This program controls the flow of the analysis. It creates the global stiffness matrix
% from the transformed element stiffness matrices.
%
% The functions estiff and etran are called to calculate the element stiffness
% matrix [elk] and the transformation matrix [gamma], respectively.

% clear all variables option

i = [];
i = input('Would you like to clear all variables [N] ','s');
	if isempty(i)
	  i='N';
	end
	if (i == 'y' || i == 'Y' )
	  fprintf('Warning: All variables are now cleared \n\n');
	  clear;
	end

% begin preprocessor

pre

% initialize the global stiffness matrix

K = zeros(ndof,ndof);

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

  % calculate element stiffnes matrix
    elk = estiff(e,a,Iz,l);

  % calculate the transformation matrix
    gamma = etran(phi);

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



% calculate the load vector

  pnode4;

% initialize the diplacement vector

delta = zeros(nfdof,1);
deltas = zeros((ndof-nfdof),1);

% calculate the global displacements

     delta = Kff\P;

% calculate the reactions

react

% compute member force

memf2

% ask to display the displacements

nodedisp

% ask to display the axial force

axial

% ask to display the shear



% ask to display the moment



% welcome to the post-processor

post3
