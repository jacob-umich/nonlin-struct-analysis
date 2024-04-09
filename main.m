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

addpath classes

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

% calculate the load vector

pnode4;

% initialize the diplacement vector

delta = zeros(nfdof,1);
deltas = zeros((ndof-nfdof),1);

% begin solution

solver

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
