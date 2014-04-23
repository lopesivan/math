with(plots):
f := ln(x);
# termo
T :=(n) -> diff(f,x$n)/n!;

a[0] := subs(x = a, f);
for i to 3 do
	a[i] := subs(x = a, T(i))
end do;

p := sum(a[n]*(x-a)^n, n = 0 .. 3);
R := 0;
p;
g := subs(a = 1, p);

plotsetup(jpeg, plotoutput = `02-taylor.jpeg`, plotoptions="height=1024,width=1024");
#plot({f, g}, x = 0 .. 2, title="Taylor");
plot({f, g}, x = 0..2, xtickmarks=10, xtickmarks=5, title="Taylor");
#plot({f, g}, x = 0..2, scaling=constrained, title="Taylor");
plotsetup(default);
