%nm131_1: nested multiplication vs. plain multiple multiplication
clc
N = 1000000+1; a = [1:N]; x = 1;
tic % initialize the timer
p = sum(a.*x.^[N-1:-1:0]); %plain multiplication
p, toc % measure the time passed from the time of executing ’tic’
tic, pn=a(1);
for i = 2:N %nested multiplication
pn = pn*x + a(i);
end
pn, toc
tic, polyval(a,x), toc