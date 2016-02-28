%nm125_1:
x = 36; y = 1e16;
for n = [-20 -19 19 20]
fprintf("y^%2d/e^%2dx = %25.15e\n",n,n,y^n/exp(n*x));% To verify overflow underflow
fprintf("(y/e^x)^%2d = %25.15e\n",n,(y/exp(x))^n);
end