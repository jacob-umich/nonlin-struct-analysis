% semi.m is a script file that calculates the 
% semi-bandwidth of the Kff matrix.
% this script file needs the global variables
% ndof, idbc.

% for a 2-d frame, each node has 3 degrees of freedom
dofpernode = 3;

% calculate the maximum difference between the
% member connectivity matrix

diffmax = 0;

for i = 1:nbc
    diff = abs(idbc(2,i) - idbc(1,i));
    if (diff > diffmax)
       diffmax = diff;
    end
end

% calculate the semi-bandwidth
    
semiband = diffmax * dofpernode +1;
        

