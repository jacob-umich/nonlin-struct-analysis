addpath ..\classes
addpath ..


% generate one node
function struct_loads()
    pos = [0,0];
    pos2 = [0,1];
    n=Node(pos);
    n2=Node(pos2);
    nodes = {n,n2};
    mat_func = @(x,e) e;
    mat1 = Material(1,1,1,1,mat_func);
    el = Element(n,n2,mat1);
    el.set_loads(-2);
    elems = {el};
    s1 = Structure(nodes,elems);

    n.set_load([10,0]);

    [loads, pe] = s1.get_loads();

    assert(loads(1)==10)
end

function mixed_fixity()

    pos = [0,0];
    pos2 = [0,1];
    n=Node(pos);
    n2=Node(pos2);
    n.fixity = [1,1];
    n2.fixity = [1,0];
    nodes = {n,n2};
    mat_func = @(x,e) e;
    mat1 = Material(1,1,1,1,mat_func);
    el = Element(n,n2,mat1);
    el.set_loads(-2);
    elems = {el};
    s1 = Structure(nodes,elems);
    n.set_load([10,0]);
    assert(s1.n_free==1)
    assert(s1.n_dof==4)

end

function stiffness()
    pos = [0,0];
    pos2 = [0,1];
    n=Node(pos);
    n2=Node(pos2);
    nodes = {n,n2};
    mat_func = @(x,e_base) e_base;
    mat1 = Material(1,1,1,1,mat_func);
    el = Element(n,n2,mat1);
    el.set_loads(-2);
    elems = {el};
    s1 = Structure(nodes,elems);
    n.set_load([10,0]);
    K = s1.get_stiffness();
    assert(abs(K(4,4)-1)<1e-4)
end

function arch = make_arch()
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


function linear_arch()
    arch = make_arch();
    [P,PF]=arch.get_loads();

    k_free = arch.get_stiffness()(1:arch.n_free,1:arch.n_free);

    delta_free=k_free\(P+PF)(1:arch.n_free);
    assert(abs(delta_free(2)-(-2.4383e-4))/abs(2.4383e-4)<1e-4)
end

function wc_arch()
    arch = make_arch();
    delta = work_control(arch);
    assert(abs(delta(2)-(-2.4383e-4))/abs(2.4383e-4)<1e-4);
end

function nr_arch()
    arch = make_arch();
    delta = nraph(arch);
    assert(abs(delta(2)-(-2.4383e-4))/abs(2.4383e-4)<1e-4);
end


simple_test({
    @struct_loads,
    @stiffness,
    @mixed_fixity,
    @linear_arch,
    @wc_arch,
    @nr_arch,
})