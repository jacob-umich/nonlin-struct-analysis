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
	   for j=1:nnod
		 supflag=0;
		 for j1=1:2
		    if (supp(j1,j)==1)
			  	supflag=1;
		     end
		  end
		  if (supflag==0)
		    plot(coord(1,j),coord(2,j),'o');
		  else
		    plot(coord(1,j),coord(2,j),'ro');
		  end
		  hold on;
	   end
	   for k=1:nbc
	     i1=idbc(1,k);
		 i2=idbc(2,k);
		 xcoor=[coord(1,i1),coord(1,i2)];
		 ycoor=[coord(2,i1),coord(2,i2)];
		 plot(xcoor,ycoor,'-c');
		 hold on;
	   end
	   axis('off');
	   axis('equal');

