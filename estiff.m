function[elk] = estiff(e,a,i,l)

% a function that calculates a 6 x 6 element stiffness matrix
% in local coordinates for a 2-d element given the modulus, area,
% moment of inertia, and the length.  the element stiffness matrix
% is stored in a matrix called elk.

elk(1,:) = [e.*a./l, 0, -e.*a./l, 0];

elk(2,:) = [0, 0,0,0];

elk(3,:) = [-e.*a./l, 0, e.*a./l, 0];

elk(4,:) = [0, 0,0,0];


