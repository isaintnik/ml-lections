solveStudents(1);

function theta = solveStudents (verbose)
	%% Load Data
	data = csvread('students.txt');
	i = length(transpose(data(1:1, :)));
	X = data(:, 1:i-1);
	y = data(:, i);
	m = length(y);

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

	L=[];
	yl=[];
	T=[];
	yt=[];

	rnd=rand(length(y),1);
	for i = 1:length(y);
		if (rnd(i,1) > 0.5)
			%printf("L\n");
			L=[L; X(i,:)];
			yl=[yl;y(i)];
		else
			%printf("T\n");
			T=[T; X(i,:)];
			yt=[yt;y(i)];
		endif
	endfor

	% Calculate the parameters from the normal equation
	b=sum(yl)/m;
	theta = pinv(transpose(L)*L)*transpose(L)*(yl.-b);

	%
	predictl = transpose((transpose(theta) * transpose(L))).+ b;
	diffl = (predictl .- yl) .* (predictl .- yl);
	resultl = [predictl yl];

	predictt = transpose((transpose(theta) * transpose(T))).+ b;
	difft = (predictt .- yt) .* (predictt .- yt);
	resultt = [predictt yt];

	% Display normal equations result
	if (verbose != 0)
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
		fprintf('\\\\ \n');
		fprintf('T_l&= %.2f \\\\ \n', sum(diffl));
		fprintf('\\sqrt{\\frac{T_l(w_0, b_0)}{n}} &= %.2f \\\\ \n',sqrt(sum(diffl)/length(diffl)));
		fprintf('T_t&= %.2f \\\\ \n', sum(difft));
		fprintf('\\sqrt{\\frac{T_t(w_0, b_0)}{n}} &= %.2f \\\\ \n',sqrt(sum(difft)/length(difft)));

		fprintf('Learn predict and real values: \n');
		resultl

		fprintf('Test predict and real values: \n');
		resultt
	endif
	theta=[theta;b];
endfunction
