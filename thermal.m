% this script file prompts the user to enter information about 
% heat gradients.  the information is stored in an array heat(3,ntemp)


i = input('would you like to enter any heat gradients? [N]  ','s');

  if (~isempty(i) | (i == 'y') | (i == 'Y'))

% input how many members are affected

   ntemp = input('how many members are affected?  ');

% initialize the array heat(4,ntemp)
heat = zeros(4, ntemp);


% begin for loop

  for j = 1:ntemp

   mem = input('enter the member that is being affected --->  ');
   alpha = input('what is the coefficient of thermal expansion of the member?  ');
   
   fprintf('\n\nthe member is orientated such that the top and bottom\n');
   fprintf('are determined by the lower numbered node is on the left.\n\n');

  % input utemp and gtemp 

   utemp = input('what is the uniform temperature change? (delta T) --->  ');
   gtemp = input('what is the temperature differential? (T(lower) - T(upper)) ---> ');
   depth = input('what is the depth of the beam? ---->  ');

  % store the information in the matrix heat(4,ntemp)

   heat(1,j) = mem;
   heat(2,j) = alpha;
   heat(3,j) = utemp;
   heat(4,j) = gtemp;
   heat(5,j) = depth;

  end   % for loop

else
   heat = [];
end     % if


  

