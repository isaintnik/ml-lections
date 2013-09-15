clear ; close all; clc
fprintf('Loading data ...\n');
%% Load Data
data = csvread('students.txt');
i = length(data(1:1, :)');
X = data(:, 1:i-1);
y = data(:, i);
m = length(y);

fprintf('Solving with normal equations...\n');

% Add intercept term to X
X = [ones(m, 1) X];

% Calculate the parameters from the normal equation
theta = pinv(X'*X)*X'*y;
predict = (theta' * X')';
real = y;

diff = (predict .- real) .* (predict .- real);
diff = (diff ./ real) .* 100;
diff = sum(diff) / length(diff); 
result = [predict real];

% Display normal equation's result
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');
fprintf('Predict and real values: \n');
result
fprintf('Error in percent: \n');
fprintf(' %f \n', diff);


