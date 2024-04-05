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
	if (i == 'y' | i == 'Y' )
	  fprintf('          *****  STRUCTURE DEFINITION   *****\n');
	  fprintf('                       COORDINATE               \n');
	  fprintf('JOINT #             X                  Y         \n');
	  fprintf('-------------------------------------------------------\n');
	  for j=1:nnod
	    fprintf('  %i          %e        %e  \n',j,coord(1,j),coord(2,j));
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
	  for j=1:nnod
	    xtrans=' free';
	    ytrans=' free';
	    zrot=' free';
	    if (supp(1,j)==1)
		  xtrans='fixed';
	    end
	    if (supp(2,j)==1)
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
	  for n=1:nbc
		 fprintf('  %i         %i      %i     %g  %g   %g\n',n,idbc(1,n),idbc(2,n)....
		 ,prop(1,idbc(3,n)),prop(2,idbc(3,n)),prop(3,idbc(3,n)));
      	  end
	end
%

% give option for plotting the structure

plotreg2

% give the option for plotting the displaced shape

plotdisp


