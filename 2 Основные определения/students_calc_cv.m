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

function [theta, error] = solveStudents (X,y,verbose)
	%% Load Data
	m = length(y);

	L=[];
	yl=[];
	T=[];
	yt=[];

	rnd=rand(length(y),1);
	for i = 1:length(y);
		if (rnd(i,1) > 0.5)
			L=[L; X(i,:)];
			yl=[yl;y(i)];
		else
			T=[T; X(i,:)];
			yt=[yt;y(i)];
		endif
	endfor

	% Calculate the parameters from the normal equation
	b=sum(yl)/length(yl);
	theta = pinv(transpose(L)*L)*transpose(L)*(yl.-b);

	%
	predictl = L * theta.+ b;
	diffl = (predictl .- yl) .* (predictl .- yl);
	resultl = [predictl yl];

	predictt = T * theta.+ b;
	difft = (predictt .- yt) .* (predictt .- yt);
	resultt = [predictt yt];

	% Display normal equations result
	if (verbose != 0)
		printf('Theta computed from the normal equations: \n');
		printf('T_L= %.2f & ', sum(diffl));
		printf('T_T&= %.2f \\\\ \n', sum(difft));
		printf('\\sqrt{\\frac{T_L(w_0, b_0)}{n}} = %.2f & ',sqrt(sum(diffl)/length(diffl)));
		printf('\\sqrt{\\frac{T_T(w_0, b_0)}{n}} = %.2f \\\\ \n',sqrt(sum(difft)/length(difft)));

		printf('\\multicolumn{2}{l}{');
		printf(" w_0 = (%.2f ")
		for i = 1:length(theta)
			if (i != 1)
				printf(", ");
			endif
			printf("%.2f", theta(i));
		endfor
		printf(")~~ b_0 = %.2f} \\\\ \n", b);
		fprintf('\\\\ \n');

		fprintf('Learn predict and real values: \n');
		resultl

		fprintf('Test predict and real values: \n');
		resultt
	endif
	theta=[theta;b];
	error=sqrt(sum(difft)/length(difft));
endfunction
