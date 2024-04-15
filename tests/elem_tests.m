addpath ..\classes
addpath ..

function elem = elem_gen()
    n1 = Node([0,0]);
    n2 = Node([5,0]);
    mat_func = @(x,e_base) e_base;
    mat1 = Material(1,1,1,1,mat_func);
    elem = Element(n1,n2,mat1);
    assert(numel(elem.nodes)==2)
end

elem = elem_gen();