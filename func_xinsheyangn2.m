%func_xinsheyangn2.m - Xin-She Yang N. 2 Function
function scores = func_xinsheyangn2(x)
    n = size(x, 2);
    scores = sum(abs(x), 2) .* exp(-sum(sin(x .^2), 2));
end 