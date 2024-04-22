function column = column()
    function moe =  mat_func(strain,e_base)
        if abs(strain)>= 36/e_base % 36 ksi yield
            moe = e_base*0.02;
        else
            moe = e_base;
        end
    end
    mat1 = Material(1,29000,10,210,@mat_func);

    a_pos = [0,0];
    b_pos = [0,100];
    a_fix = [1,1];
    b_fix = [1,0];
    a = Node(a_pos);
    b = Node(b_pos);
    a.set_fixity(a_fix);
    b.set_fixity(b_fix);
    b.set_load([0,-400]);
    ab = Element(a,b,mat1);
    column = Structure({a,b},{ab});
end