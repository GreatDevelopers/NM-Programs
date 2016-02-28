%nm132_2: nested structure
clc
N = 1000; x = rand(1,N); % a random sequence x[n] for n = 0:N-1
W = [-100:100]*pi/100; % frequency range
tic
for k = 1:length(W)
X1(k) = 0; %for for loop
for n = 1:N, X1(k) = X1(k) + x(n)*exp(-j*W(k)*(n-1)); end
end
toc
tic
X2 = 0;
for n = 1:N %for vector loop
X2 = X2 +x(n)*exp(-j*W*(n-1));
end
toc
discrepancy = norm(X1-X2) %transpose for dimension compatibility