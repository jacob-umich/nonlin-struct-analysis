function arch = arch()
    a_pos = [0,0];
    b_pos = [5,5];
    c_pos = [10,0];
    a_fix = [1,1];
    c_fix = [1,1];
    a = Node(a_pos);
    b = Node(b_pos);
    c = Node(c_pos);
    a.set_fixity(a_fix);
    c.set_fixity(c_fix);
    b.set_load([0,-10]);
    mat_func = @(strain,e_base) e_base;
    mat = Material(1,29000,10,100,mat_func);
    ab = Element(a,b,mat);
    bc = Element(b,c,mat);
    arch = Structure({a,b,c},{ab,bc});
end