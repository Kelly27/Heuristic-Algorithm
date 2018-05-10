clear all

a = ['Please choose an Heuristic Algorithm from the following to run\n' ...
            '1 - Cuckoo Search \n' ...
            '2 - Bat Algorithm \n'...
            '3 - Grey-Wolf Optimization \n'...
            '4 - Harmony Search \n' ...
            '5 - Moth-Flame Optimization \n' ...
            'Please enter your choice number: '];
        
func = ['Please choose an objective function from the following to run: \n' ...
            '1 - Ackley''s Function \n' ... 
            '2 - Zakharov''s Fucntion \n'...
            '3 - Qing Function \n'...
            '4 - Xin-She Yang N. 2 Function \n' ...
            '5 - Alpine N. 2 Function \n' ...
            'Please enter your choice number: '];

algo = input(a);        
func = input(func);

switch func
    case 1
        lbound = -32.768;
        ubound = 32.768;
    case 2
        lbound = -5;
        ubound = 10;
    case 3
        lbound = -500;
        ubound = 500;
    case 4
        lbound = -2*3.142;
        ubound = 2*3.142;
    case 5
        lbound = 0;
        ubound = 10;
end

switch algo
    case 1
        algo_Cuckoo(lbound, ubound, func);
    case 2
        algo_bat(lbound, ubound, func);
    case 3
        algo_grey_wolf(lbound, ubound, func);
    case 4
        algo_harmony(lbound, ubound, func);
    case 5
        algo_moth_flame(lbound, ubound, func);
end