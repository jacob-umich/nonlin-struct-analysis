function [gamma] = etran(phi)

% a function that creates the 6 X 6 transformation matrix for an
% element given the angle of orientation.  The transformation 
% matrix is stored in a matrix called gamma. 

gamma(:, :) = [ cos(phi) sin(phi) 0 0;
                -sin(phi) cos(phi) 0 0;
                0 0 cos(phi) sin(phi);
                0 0 -sin(phi) cos(phi)];
