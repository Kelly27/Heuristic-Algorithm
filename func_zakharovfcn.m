%func_zakharovfcn.m - Zakharov Function
function z = func_zakharovfcn(x)

    n = size(x, 2);
    comp1 = 0;
    comp2 = 0;
    
    for i = 1:n
        comp1 = comp1 + (x(:, i) .^ 2);
        comp2 = comp2 + (0.5 * i * x(:, i));
    end
     
    z = comp1 + (comp2 .^ 2) + (comp2 .^ 4);
end
