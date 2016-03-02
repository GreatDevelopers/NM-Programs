clear
clc
format compact
%%  Read or Input any square Matrix
 str = inputdlg('Enter a list of numbers separated by spaces or commas');
 numbers = str2num(str{1});
 D=reshape(numbers,3,3);
 A=D'% coefficients matrix
str1 = inputdlg('Enter a list of numbers separated by spaces or commas');% constants vector
num= str2num(str1{1});
C= reshape(num,3,1);
C
n = length(C);
X = zeros(n,1);
Error_eval = ones(n,1);

%% Start the Iterative method
iteration = 0;
while max(Error_eval) > 0.001
    iteration = iteration + 1;
    Z = X;  % save current values to calculate error later
    for i = 1:n
        j = 1:n; % define an array of the coefficients' elements
        j(i) = [];  % eliminate the unknow's coefficient from the remaining coefficients
        Xtemp = X;  % copy the unknows to a new variable
        Xtemp(i) = [];  % eliminate the unknown under question from the set of values
        X(i) = (C(i) - sum(A(i,j) * Xtemp)) / A(i,i);
    end
    Xsolution(:,iteration) = X;
    Error_eval = sqrt((X - Z).^2);
end
%% Display Results
GaussSeidelTable = [1:iteration;Xsolution]'

