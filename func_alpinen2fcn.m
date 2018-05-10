%func_alpinen2fcn.m - Alpine N.2 Function
function scores = func_alpinen2fcn(x)
     scores = -(prod(sqrt(x) .* sin(x), 2));
end 