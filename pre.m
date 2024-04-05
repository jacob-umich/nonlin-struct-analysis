%	CES 4101 - Structural Analysis II
%
%	Instructor:	Sherif El-Tawil
%			Dept. of Civil and Env. Eng.
%			University of Central Florida
%			Orlando, FL 32816-2450
%			Ph: 407-823-3743, E-Mail: sherif@maha.engr.ucf.edu
%
%       Description:    This is a preprocessor to create the input data
%                       for the analysis of two-dimensional rigid-jointed
%                       frames using the matrix displacement method.
%
%       History:
%
%       08-25-94        David Chen     		Original version finished
%       08-02-95	David Chen     		Revised version
%	12-31-96	Sherif El-Tawil
%

heat = [];


i = input('Would you like to retrieve a stored structure? [Y] ','s');
	if isempty(i)
	  i='Y';
	end
	if (i == 'y' || i == 'Y' )
           load (input('enter the filename ---> ','s'));

       % calculate the global degree of freedom numbers
       dofn;


        else

%
% enter the input data
%
	nnod=input('numbers of nodes (nnod) =   ');
	nbc=input('numbers of elements (nbc) =   ');
	nsup=input('numbers of support nodes (nsup) =   ');
	nmat=input('numbers of material property types (nmat) =   ');

% enter the nodal coordinate
	for i=1:nnod
	  fprintf('\nEnter the nodal coordinates for node %i\n',i);
	  coord(1,i)=input('x coordinate (coord (1,i)) =   ');
	  coord(2,i)=input('y coordinate (coord (2,i)) =   ');
	 end
% enter the member connectivity and type
	fprintf('\nEnter the member connectivity and type');
	for i=1:nbc
	  fprintf('\nMember identity for member %i\n',i)
	  idbc(1,i)=input('NODE I  (idbc(1,i)) =  ');
	  idbc(2,i)=input('NODE J  (idbc(2,i)) =  ');
	  idbc(3,i)=input('Material Type  (idbc(3,i)) =   ');
	end
% assign the member properties
    for i=1:nmat
	  fprintf('\nMember properties for type %i\n',i);
	  prop(1,i)=input('E  (prop(1,i)) = ' );
	  prop(2,i)=input('A (prop(2,i)) = ' );
	  prop(3,i)=input('I (prop(3,i)) = ');
	end
% assign the boundary conditions
	for i=1:nsup
	  fprintf('\nAssign boundary conditions for the supports');
	  fprintf('\n(0 for free, 1 for fixed)\n');
	  fprintf('Within the program, the support information is contained\n');
	  fprintf('in the array called  supp(j,i)  where j=1,2,3 and i=nnod\n');
	  support(1,i)=input('NODE NUMBER (support(1,i)) =  ');
	  support(2,i)=input('x translation (0-free/1-fixed) ');
	  support(3,i)=input('y translation (0-free/1-fixed) ');
	end
%
%  Reorganize restraint date
%
	supp(1:2,1:nnod)=zeros(2,nnod);
	for i=1:nsup
	     supp(1:2,support(1,i))=support(2:3,i);
	end
% enter the nodal loads
	nload=0;
        i = [];
	i=input('Do you want to input concentrated nodal loads?  Y/N  [Y]:','s');
	if isempty(i)
	  i='Y';
	end
	if (i == 'y' | i == 'Y' )
	  nload=input('How many nodes ?  ');
	  for j=1:nload
	    loading(1,j)=input('NODE NUMBER = ');
		loading(2,j)=input('Fx = ');
		loading(3,j)=input('Fy = ');
	  end
	end
% enter the member loads
	nmemld=0;
	i=input('Do you want to input member loads?  Y/N  [N]:','s');
	if isempty(i)
	  i='N';
	end
	if (i == 'y' | i == 'Y' )
	  nmemld=input('How many members ?  ');
	  for j=1:nmemld
		mload(1,j)=input('MEMBER NUMBER = ');
		mload(2,j)=input('Tangent Distributed Load = ');
	  end
	end

% calculate the global degree of freedom numbers
    dofn

% give option for settlement
%   settle

% give option for heat gradients
%   thermal

% save the input file
    i=input('Do you want to save the input file?  Y/N  [Y]:','s');
	if isempty(i)
	  i='Y';
	end
	if (i == 'y' | i == 'Y' )
          save (input('what is the filename---> ','s'));
    	end
end

