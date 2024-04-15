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
	  node_list{i}=Node(coord(:,i)')
	 end
% assign the member properties
    for i=1:nmat
	  fprintf('\nMember properties for type %i\n',i);
	  e=input('E  (prop(1,i)) = ' );
	  a=input('A (prop(2,i)) = ' );
	  moi=input('I (prop(3,i)) = ');
	  funct = @(x,e_base) e_base;
	  mats{i}=Material(i,e,a,moi,funct)
	end
% enter the member connectivity and type
	fprintf('\nEnter the member connectivity and type');
	for i=1:nbc
	  fprintf('\nMember identity for member %i\n',i)
	  n_1=input('NODE I  (idbc(1,i)) =  ');
	  n_2=input('NODE J  (idbc(2,i)) =  ');
	  mat_id=input('Material Type  (idbc(3,i)) =   ');
	  elem_list{i}=Element(node_list(n_1),node_list(n_2),mats(mat_id))
	end
% assign the boundary conditions
	for i=1:nsup
	  fprintf('\nAssign boundary conditions for the supports');
	  fprintf('\n(0 for free, 1 for fixed)\n');
	  fprintf('Within the program, the support information is contained\n');
	  fprintf('in the array called  supp(j,i)  where j=1,2,3 and i=nnod\n');
	  node_id=input('NODE NUMBER (support(1,i)) =  ');
	  x_fixity=input('x translation (0-free/1-fixed) ');
	  y_fixity=input('y translation (0-free/1-fixed) ');
	  node_list{node_id}.set_fixity([x_fixity, y_fixity])
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
	    node_id=input('NODE NUMBER = ');
		x=input('Fx = ');
		y=input('Fy = ');
		node_list{node_id}.set_load([x y])
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
		elem_id=input('MEMBER NUMBER = ');
		input_load=input('Tangent Distributed Load = ');
		elem_list{elem_id}.set_loads(input_load)
	  end
	end

% calculate the global degree of freedom numbers
	strucutre = Structure(node_list,elem_list);


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

