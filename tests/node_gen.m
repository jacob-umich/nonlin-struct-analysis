addpath ..\classes

% generate one node
function node_gen_test()
    z = dbstack;
    a = z(1).name;
    disp(["starting ",a])
    pos = [1,1];
    n = Node(pos);
    assert (n.pos(1)==1)
    disp("test passed")
end

% generate anoter node and add them to a list
function list_of_nodes()
    z = dbstack;
    a = z(1).name;
    disp(["starting ",a])
    pos_1 = [0,0];
    pos_2 = [1,1];
    node_list(1)= Node(pos_1);
    node_list(2)= Node(pos_2);
    assert(node_list(1).pos(1)==0)
    assert(numel(node_list)==2)
    disp("test passed")
end
% run tests

node_gen_test();
list_of_nodes();