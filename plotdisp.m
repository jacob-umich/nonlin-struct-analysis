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
	i = [];
	i=input('Do you want to plot the displaced shape?  Y/N  [Y]:','s');
	if isempty(i)
	  i='Y';
	end
	if (i == 'y' | i == 'Y' )

        % enter the amount the to magnify the displacements
        mag = input('enter the magnification of the displacements ---> ');

	for i = 1:nnod

	    coord2(1,i) = coord(1,i) + mag*deltat(dofnum(1,i));
	    coord2(2,i) = coord(2,i) + mag*deltat(dofnum(2,i));

	end

% give the option for plotting on the same graph


   fprintf('\n\nwould you like to plot the displaced and regular')
   an = input('structures on the same graph ? [Y/N] ','s');

   if ((an == 'Y') | (an == 'y'))

 	   plotreg2
   else
           clg
   end

	   for j=1:nnod
		 supflag=0;
		 for j1=1:2
		    if (supp(j1,j)==1)
			  	supflag=1;
		     end
		  end
		  if (supflag==0)
		    plot(coord2(1,j),coord2(2,j),'o');
		  else
		    plot(coord2(1,j),coord2(2,j),'ro');
		  end
		  hold on;
	   end
	   for k=1:nbc
	     i1=idbc(1,k);
		 i2=idbc(2,k);
		 xcoor=[coord2(1,i1),coord2(1,i2)];
		 ycoor=[coord2(2,i1),coord2(2,i2)];
		 plot(xcoor,ycoor,'-c');
		 hold on;
	   end
	   axis('off');
	   axis('equal');
	end
