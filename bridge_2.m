function bridge = bridge_1()
    func_var = @mat_func;
    function moe =  mat_func(strain,e_base)
        if abs(strain)>= 36/e_base % 36 ksi yield
            moe = e_base*0.02;
        else
            moe = e_base;
        end
    end
    mat1 = Material(1,29000,20,210,@mat_func);
    mat2 = Material(1,29000,30,210,@mat_func);
    mat3 = Material(1,29000,40,210,@mat_func);

    nodes={
        Node([0,0]),
        Node([240,0]),
        Node([240,120]),
        Node([120,240]),
        Node([240,240]), %5
        Node([360,240]),
        Node([360,360]),
        Node([600,360]),
        Node([240,480]),
        Node([360,480]), %10
        Node([360,600]), 
        Node([480,600]), 
        Node([600,600]), 
        Node([720,600]), 
        Node([720,720]), %15 
        Node([960,720]),  
        Node([960,840]),  
        Node([1080,840]),  
        Node([1080,960]),  
        Node([1200,840]), %20 
        Node([1200,720]), 
        Node([1440,720]), 
        Node([1440,600]), 
        Node([1560,600]), 
        Node([1680,600]), %25
        Node([1800,600]),
        Node([1800,480]),
        Node([1920,480]),
        Node([1560,360]),
        Node([1800,360]), %30
        Node([1800,240]),
        Node([1920,240]),
        Node([2040,240]),
        Node([1920,120]),
        Node([1920,0]),%35
        Node([2160,0]),
    };

    elements = {
        Element(nodes{1},nodes{2},mat3),
        Element(nodes{1},nodes{4},mat3),
        Element(nodes{1},nodes{3},mat3),
        Element(nodes{2},nodes{3},mat3),
        Element(nodes{3},nodes{4},mat3), %5
        Element(nodes{3},nodes{5},mat3),
        Element(nodes{3},nodes{6},mat3),
        Element(nodes{4},nodes{5},mat3),
        Element(nodes{5},nodes{6},mat3),
        Element(nodes{6},nodes{8},mat2), %10
        Element(nodes{4},nodes{9},mat2),
        Element(nodes{5},nodes{9},mat2),
        Element(nodes{5},nodes{7},mat2),
        Element(nodes{6},nodes{7},mat2),
        Element(nodes{7},nodes{9},mat2), %15
        Element(nodes{7},nodes{10},mat2),
        Element(nodes{7},nodes{8},mat2),
        Element(nodes{8},nodes{10},mat2),
        Element(nodes{8},nodes{13},mat2),
        Element(nodes{8},nodes{14},mat2), %20
        Element(nodes{9},nodes{11},mat2),
        Element(nodes{9},nodes{10},mat2),
        Element(nodes{10},nodes{11},mat2),
        Element(nodes{10},nodes{12},mat2),
        Element(nodes{10},nodes{13},mat2), %25
        Element(nodes{11},nodes{12},mat2),
        Element(nodes{12},nodes{13},mat2),
        Element(nodes{13},nodes{14},mat1),
        Element(nodes{12},nodes{15},mat2),
        Element(nodes{13},nodes{15},mat2), %30
        Element(nodes{14},nodes{15},mat1),
        Element(nodes{14},nodes{16},mat1),
        Element(nodes{15},nodes{17},mat1),
        Element(nodes{15},nodes{16},mat1),
        Element(nodes{16},nodes{17},mat1), %35
        Element(nodes{16},nodes{18},mat1),
        Element(nodes{17},nodes{19},mat1),
        Element(nodes{17},nodes{18},mat1),
        Element(nodes{18},nodes{19},mat1),
        Element(nodes{19},nodes{20},mat1), %40
        Element(nodes{18},nodes{20},mat1),
        Element(nodes{18},nodes{21},mat1),
        Element(nodes{20},nodes{21},mat1),
        Element(nodes{21},nodes{22},mat1),
        Element(nodes{20},nodes{22},mat1), %45
        Element(nodes{21},nodes{23},mat1),
        Element(nodes{22},nodes{23},mat1),
        Element(nodes{22},nodes{24},mat2),
        Element(nodes{22},nodes{25},mat2),
        Element(nodes{25},nodes{26},mat2), %50
        Element(nodes{23},nodes{24},mat1),
        Element(nodes{24},nodes{25},mat2),
        Element(nodes{23},nodes{29},mat2),
        Element(nodes{24},nodes{29},mat2),
        Element(nodes{24},nodes{27},mat2), %55
        Element(nodes{25},nodes{27},mat2),
        Element(nodes{26},nodes{27},mat2),
        Element(nodes{26},nodes{28},mat2),
        Element(nodes{27},nodes{29},mat2),
        Element(nodes{27},nodes{28},mat2), %60
        Element(nodes{29},nodes{30},mat2),
        Element(nodes{27},nodes{30},mat2),
        Element(nodes{28},nodes{30},mat2),
        Element(nodes{28},nodes{32},mat2),
        Element(nodes{28},nodes{33},mat2), %65
        Element(nodes{29},nodes{31},mat2),
        Element(nodes{30},nodes{31},mat2),
        Element(nodes{31},nodes{32},mat3),
        Element(nodes{30},nodes{32},mat2),
        Element(nodes{32},nodes{33},mat3), %70
        Element(nodes{31},nodes{34},mat3),
        Element(nodes{32},nodes{34},mat3),
        Element(nodes{33},nodes{34},mat3),
        Element(nodes{33},nodes{36},mat3),
        Element(nodes{34},nodes{35},mat3), %75
        Element(nodes{34},nodes{36},mat3),
        Element(nodes{35},nodes{36},mat3),
    };

    pinned = [1,1];
    nodes{1}.set_fixity(pinned);
    nodes{2}.set_fixity(pinned);
    nodes{35}.set_fixity(pinned);
    nodes{36}.set_fixity(pinned);
    % horizontal loads
    h = 75;

    % vertical loads
    p = -1000;

    nodes{4}.set_load([h,0]);
    nodes{9}.set_load([h,0]);
    nodes{11}.set_load([h,p]);
    nodes{12}.set_load([0,p]);
    nodes{13}.set_load([0,p]);
    nodes{14}.set_load([0,p]);
    nodes{15}.set_load([h,0]);
    nodes{17}.set_load([h,0]);
    nodes{19}.set_load([h,0]);
    nodes{23}.set_load([0,p]);
    nodes{24}.set_load([0,p]);
    nodes{25}.set_load([0,p]);
    nodes{26}.set_load([0,p]);
    bridge = Structure(nodes,elements);
end