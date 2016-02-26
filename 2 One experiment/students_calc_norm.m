clear ; close all; clc
%% Load Data
data = csvread('students.txt');
i = length(transpose(data(1:1, :)));
X = data(:, 1:i-1);
y = data(:, i);
m = length(y);

%fprintf('Solving with normal equations...\n');

% Add intercept term to X
X_norm = X;
mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));
for i = 1:length(mu)
    cur_column = X_norm(:, i);
    mu(i) = mean(cur_column);
    sigma(i) = std(cur_column);
    X_norm(:, i) -= mu(i);
    X_norm(:, i) /= sigma(i);
endfor
X=X_norm

b=sum(y)/m;
y=y.-b;

% Calculate the parameters from the normal equation
theta = pinv(transpose(X)*X)*transpose(X)*y;
predict = transpose((transpose(theta) * transpose(X))).+ b;
real = y.+ b;
%predict = transpose((transpose(theta) * transpose(X)));
%real = y;

diff = (predict .- real) .* (predict .- real);
%diff = (sqrt(diff/length(diff)) ./ real).* 100;
%diff = sum(diff); 
result = [predict real];

% Display normal equations result
fprintf('Theta computed from the normal equations: \n');
fprintf('w_0 &= %.2f ')
for i = 1:length(theta)
	if (i != 1)
		printf(", ");
	endif
	printf("%.2f", theta(i));
endfor
printf("\\\\\n");
fprintf('b_0 &= %.2f \\\\ \n', b);
fprintf('T&= %.2f \\\\ \n', sum(diff));
fprintf('\\sqrt{\\frac{T(w_0, b_0)}{n}} &= %.2f \\\\ \n',sqrt(sum(diff)/length(diff)));

fprintf('Predict and real values: \n');
result

