# solves the system using the specified solution method

i = [];
cond=true;
while (cond)
  i = input("Which solution method do you want to use?\n[1] Newton Raphson \n[2] Work Control \n  input:");
  if isempty(i)
    i=1;
  end
  if (i!=1&&i!=2)
    printf("[ERROR] please input a valid number\n")
  else
    cond=false;
  end
end
if (i==1)
  nraph
elseif (i==2)
  work_control

end

