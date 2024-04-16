function simple_test(function_set)
    for i=1:numel(function_set)
        func = function_set{i};
        a = functions(func).function;
        disp(["starting ",a])
        func();
        disp("test passed")
    end
endfunction
        

