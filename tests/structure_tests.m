addpath ..\classes
val = debug_on_interrupt(1);
% generate one node
function struct_loads()
    z = dbstack;
    a = z(1).name;
    disp(["starting ",a])
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
    disp("test passed")
end

function stiffness()
    z = dbstack;
    a = z(1).name;
    disp(["starting ",a])
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
    K = s1.get_stiffness();
    assert(abs(K(4,4)-2.7183)<1e4)
    disp("test passed")
end
struct_loads()
stiffness()