function [fobj] = load_var_mfo(func)
    switch func
        case 1
            fobj = @func_Ackley;
        case 2
            fobj = @func_zakharovfcn;
        case 3
            fobj = @func_qingfcn;
        case 4
            fobj = @func_xinsheyangn2;
        case 5
            fobj = @func_alpinen2fcn;
    end
end