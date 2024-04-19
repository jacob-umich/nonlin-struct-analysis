%	CES 4101 - Structural Analysis II
%
%	Instructor:	Sherif El-Tawil
%			Dept. of Civil and Env. Eng.
%			University of Central Florida
%			Orlando, FL 32816-2450
%			Ph: 407-823-3743, E-Mail: sherif@maha.engr.ucf.edu
%
%       Description:    This is the postprocessor to list the input structure
%			information, plot the structure configuration, and
%			list the output results.
%
%       History:
%
%       08-25-94        David Chen     		Original version finished
%	12-31-96	Sherif El-Tawil
%



% enter the input listing opitions
%
i=input('Do you want to list the input data?  Y/N  [Y]:','s');
if isempty(i)
	i='Y';
end
%
%  print the nodal coordinates
%
if (i == 'y' || i == 'Y' )
	fprintf('          *****  STRUCTURE DEFINITION   *****\n');
	fprintf('                       COORDINATE               \n');
	fprintf('JOINT #             X                  Y         \n');
	fprintf('-------------------------------------------------------\n');
	for j=1:numel(structure.nodes)
		node = structure.nodes{j};
		fprintf('  %i          %e        %e  \n',j,node.orig_pos(1),node.orig_pos(2));
	end
%
%  print the restraint conditions
%
	fprintf('\n');
	fprintf('                       RESTRAINTS               \n');
	fprintf('JOINT #        X-TRANS      Y-TRANS   \n');
	fprintf('---------------------------------------------\n');
	xtrans=' free';
	ytrans=' free';
	zrot=' free';
	for j=1:numel(structure.nodes)
		node = structure.nodes{j};
		xtrans=' free';
		ytrans=' free';

		if (node.fixity(1)==1)
			xtrans='fixed';
		end
		if (node.fixity(2)==1)
			ytrans='fixed';
		end
		fprintf('  %i             %s        %s\n',j,xtrans,ytrans);
	end
%
%  print the member connectivity
%
	fprintf('\n')
	fprintf('              END JOINTS              PROPERTIES\n');
		fprintf('MEMBER #    I      J         E              A              I \n');
	fprintf('-------------------------------------------------------------------\n');
	for n=1:numel(structure.elements)
		element = structure.elements{n};
		fprintf(...
			'  %i         %i      %i     %g  %g   %g\n', ...
			n, ...
			element.nodes{1}.id, ...
			element.nodes{2}.id, ...
			element.material.e_base, ...
			element.material.area, ...
			element.material.moi);
	end
end
%

% give option for plotting the structure

plotreg2

% give the option for plotting the displaced shape

plotdisp

% response curve
if load_deflect
	plot_response
end


