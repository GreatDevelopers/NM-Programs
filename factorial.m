
function m = fctrl(n)
if n < 0, error("The factorial of negative number ??");
else m = 1; for k = 2:n, m = m*k; end
end