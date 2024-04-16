% this script file plots the inputted structure
%	CES 4101 - Structural Analysis II
%
%	Instructor:	Sherif El-Tawil
%			Dept. of Civil and Env. Eng.
%			University of Central Florida
%			Orlando, FL 32816-2450
%			Ph: 407-823-3743, E-Mail: sherif@maha.engr.ucf.edu
%
% 	This script file plots the structure
%

	clf;
	for j=1:numel(structure.nodes)
		supflag=0;
		node = structure.nodes{j};
		if any(structure.nodes{j}.fixity)
			supflag==1;
		end

		if (supflag==0)
			plot(node.pos(1),node.pos(2),'o');
		else
			plot(node.pos(1),node.pos(2),'ro');
		end
		  	hold on;
	end

	for k=1:numel(structure.elements)
		elem = structure.elements{k};
		node_i=elem.nodes{1};
		node_j=elem.nodes{2};
		i1=idbc(1,k);
		i2=idbc(2,k);
		xcoor=[node_i.pos(1),node_j.pos(1)];
		ycoor=[node_i.pos(2),node_j.pos(2)];
		plot(xcoor,ycoor,'-c');
		hold on;
	end

	axis('off');
	axis('equal');

