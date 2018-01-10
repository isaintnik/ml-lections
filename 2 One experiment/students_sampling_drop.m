students_calc_cv;
data = csvread('students.txt');
i = length(transpose(data(1:1, :)));
X = data(:, 1:i-1);
y = data(:, i);

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


for f=1:columns(X);
	Xf = [];
	if (f > 1);
		Xf = X(:, 1:f-1);
	endif
	if (f < columns(X));
		Xf = [Xf,X(:, f+1:end)];
	endif

	totalError = 0;
	count=10000;
	for i = 1:count;
		[ti,error] = solveStudents(Xf,y,0);
		totalError += error;
	endfor

	printf("Feature %d error: %.2f\n", f, totalError/count);
endfor

% for i = 1:length(m);
% 	printf ("{w_0}_{%d} & %.2f \\pm %.2f \\\\\n", i, m(i), r(i));
% endfor
