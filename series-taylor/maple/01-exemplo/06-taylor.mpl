#
# função f (x) = sen (x) , determine a fórmula de MacLaurin
# para n=8.

with(plots):
f := sin(x);
# termo
T :=(n) -> diff(f,x$n)/n!;

a[0] := subs(x = 0, f);

for i to 8 do
	a[i] := subs(x = 0, T(i))
end do;

p := sum(a[n]*(x)^n, n=0..8);
R := 0;
g := eval(p);

plotsetup(jpeg, plotoutput=`06-taylor.jpeg`, plotoptions="height=1024,width=1024");
plot([f, g]);
#plot({f,g}, title="Taylor");
plotsetup(default);
