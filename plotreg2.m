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
			plot(node.orig_pos(1),node.orig_pos(2),'o');
		else
			plot(node.orig_pos(1),node.orig_pos(2),'ro');
		end
		  	hold on;
	end

	for k=1:numel(structure.elements)
		elem = structure.elements{k};
		node_i=elem.nodes{1};
		node_j=elem.nodes{2};
		xcoor=[node_i.orig_pos(1),node_j.orig_pos(1)];
		ycoor=[node_i.orig_pos(2),node_j.orig_pos(2)];
		plot(xcoor,ycoor,'-c');
		hold on;
	end

	axis('off');
	axis('equal');
	file_name = sprintf("%s_layout.png",struct_name);
	print(gcf,file_name,"-dpng","-r720");
	fprintf("figure saved at %s\n",file_name)

