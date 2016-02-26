students_calc_cv;
clc;
data = csvread('students.txt');
X = data(:, 1:end-1);
y = data(:, end);

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

count=1000;
s=zeros(columns(X) + 1, 1);
s2=zeros(columns(X) + 1, 1);
sumError = 0;
sum2Error = 0;
for i = 1:count;
	[ti,error] = solveStudents(X,y,0);
	s += ti;
	s2 += ti.*ti;
	sumError += error;
	sum2Error += error * error;
endfor
m = s ./ count;
r = sqrt((s2 .- ((s .* s)./count))./count);

theta=m(1:end-1);
b=m(end);

predict = X * theta .+ b;
diff = (predict .- y) .* (predict .- y);
result = [predict y]
sqrt(sum(diff)/length(diff))

printf("Mean error: %.2f \\pm %.2f\n\n", sumError/count, sqrt((sum2Error - sumError * sumError/count)/count));

for i = 1:length(m);
	printf ("{w_0}_{%d} & %.2f \\pm %.2f \\\\\n", i, m(i), r(i));
endfor
