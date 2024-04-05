% memdof.m is a script file that creats an array
% "mdof(6,nbc)" that describs the member connectivity
% in terms of the internal dof numbers.

mdof = zeros(6,nbc);

for i = 1:nbc
    a = idbc(1,i);
    b = idbc(2,i);
    for j = 1:3
        mdof(j,i) = dofnum(j,a);
    end

    for k = 4:6
        k2 = k-3;
        mdof(k,i) = dofnum(k2,b);
    end
end
