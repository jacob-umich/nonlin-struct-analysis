%	CES 4101 - Structural Analysis II
%
%	Instructor:	Sherif El-Tawil
%			Dept. of Civil and Env. Eng.
%			University of Central Florida
%			Orlando, FL 32816-2450
%			Ph: 407-823-3743, E-Mail: sherif@maha.engr.ucf.edu
%
% 	This script file calculates the new displaced coodinates and
% 	saves them in a new matrix called coord2.
%

% enter the option for plotting the structure
%
clf
i = [];
i=input('Do you want to plot the displaced shape?  Y/N  [Y]:','s');
if isempty(i)
	i='Y';
end
if (i == 'y' || i == 'Y' )

	% enter the amount the to magnify the displacements
	mag = input('enter the magnification of the displacements ---> ');


	% give the option for plotting on the same graph


	fprintf('\n\nwould you like to plot the displaced and regular')
	an = input('structures on the same graph ? [Y/N] ','s');

	if ((an == 'Y') || (an == 'y'))

		for j=1:numel(structure.nodes)
			supflag=0;
			node = structure.nodes{j};
			if any(structure.nodes{j}.fixity)
				supflag==1;
			end

			if (supflag==0)
				plot(node.orig_pos(1),node.orig_pos(2),Color="#767676",Marker="o");
			else
				plot(node.orig_pos(1),node.orig_pos(2),Color="#767676",Marker="^");
			end
				hold on;
		end

		for k=1:numel(structure.elements)
			elem = structure.elements{k};
			node_i=elem.nodes{1};
			node_j=elem.nodes{2};
			xcoor=[node_i.orig_pos(1),node_j.orig_pos(1)];
			ycoor=[node_i.orig_pos(2),node_j.orig_pos(2)];
			plot(xcoor,ycoor,Color="#767676",LineStyle=":");
			hold on;
		end
	else
		clf
	end

	for j=1:numel(structure.nodes)
		supflag=0;
		node = structure.nodes{j};
		if any(structure.nodes{j}.fixity)
			supflag==1;
		end

		if (supflag==0)
			plot(node.pos(1)*mag,node.pos(2)*mag,'o');
		else
			plot(node.pos(1)*mag,node.pos(2)*mag,'ro');
		end
		  	hold on;
	end


	for k=1:numel(structure.elements)
		elem = structure.elements{k};
		node_i=elem.nodes{1};
		node_j=elem.nodes{2};
		xcoor=[node_i.pos(1)*mag,node_j.pos(1)*mag];
		ycoor=[node_i.pos(2)*mag,node_j.pos(2)*mag];
		plot(xcoor,ycoor,'-c');
		hold on;
	end
	axis('off');
	axis('equal');
	file_name = sprintf("%s_deformed.png",struct_name);
	print(gcf,file_name,"-dpng","-r720");
	fprintf("figure saved at %s\n",file_name)
	clf
end
