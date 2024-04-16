addpath ..\classes
addpath ..

function moe = mat_func(strain,e_base)
    if strain<0.001
        moe = e_base
    else
        moe = 0.01*e_base
    end
end

function elem = elem_gen()
    n1 = Node([0,0]);
    n2 = Node([3,4]);
    n1.fixity = [1,1];
    n1.fixity = [0,1];
    mat1 = Material(1,29000,10,120,@mat_func);
    elem = Element(n1,n2,mat1);
    assert(numel(elem.nodes)==2)
    assert(elem.original_length==5)
    assert(elem.orig_pos(3)==3)
end

function get_length()
    elem = elem_gen();
    assert(elem.get_elem_len()==5)
end


simple_test({
    @elem_gen
    @get_length
})