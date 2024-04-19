# solves the system using the specified solution method
i = [];
i=input('Do you want to store load-deflection history?  Y/N  [Y]:','s');
if isempty(i)
	i='Y';
end
if (i == 'y' || i == 'Y' )
    load_deflect = true;
else
    load_deflect = false;
end
i = [];
cond=true;
while (cond)
    i = input("Which solution method do you want to use?\n[1] Newton Raphson \n[2] Work Control\n[3] Linear  \n  input:");
    if isempty(i)
    i=1;
    end
    if (i!=1&&i!=2&&i!=3)
    printf("[ERROR] please input a valid number\n")
    else
    cond=false;
    end
end

if (i==1)
    delta_all = nraph(structure,load_deflect);
elseif (i==2)
    delta_all = work_control(structure,load_deflect);
elseif (i==3)
    [P,PF]=structure.get_loads()
    k_free = structure.get_stiffness()(1:structure.n_free,1:structure.n_free);
    delta_free=k_free\(P+PF)(1:structure.n_free);
    structure.update_disp(delta_free);
end


