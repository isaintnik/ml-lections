clear; clc; close all;
data = csvread('students.txt');
i = length(transpose(data(1:1, :)));
X = data(:, 1:i-1);
y = data(:, i);

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
X=X_norm;

solveStudents(X,y,1);

