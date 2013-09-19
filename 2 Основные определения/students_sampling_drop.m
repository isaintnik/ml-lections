students_calc_cv;
t1 = solveStudents(0);
count=1000;
s=t1;
s2=t1.*t1;
for i = 2:count;
	ti=solveStudents(0);
	s=s+ti;
	ti2=ti.*ti;
	s2=s2 .+ ti2;
endfor
m = s ./ count;
r = sqrt((s2 .- ((s .* s)./count))./count);

for i = 1:length(m);
	printf ("{w_0}_{%d} & %.2f \\pm %.2f \\\\\n", i, m(i), r(i));
endfor
