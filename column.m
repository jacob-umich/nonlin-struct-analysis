function column = column()
    a_pos = [0,0];
    b_pos = [0,5];
    a_fix = [1,1];
    b_fix = [1,0];
    a = Node(a_pos);
    b = Node(b_pos);
    a.set_fixity(a_fix);
    b.set_fixity(b_fix);
    b.set_load([0,-56000]);
    mat_func = @(strain,e_base) e_base;
    mat = Material(1,29000,10,100,mat_func);
    ab = Element(a,b,mat);
    bc = Element(b,c,mat);
    arch = Structure({a,b,c},{ab,bc});
end