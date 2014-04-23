# Considere a função f(x)=ln(x) , determine a fórmula de Taylor
# para n=3 e a=1.

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


mygrid := coordplot (cartesian,
                     labelling=middle,
                     view=[-0..2, -6..4]):

plotsetup(jpeg, plotoutput = `03-taylor.jpeg`, plotoptions="height=1024,width=1024");
#p := plot({f, g}, x = 0..2);
plot({f, g}, x = 0..2, title="Taylor", thickness=3, color=["Blue", "Coral"]);
#display ({p}, title="Taylor", thickness=3, color=["Blue Violet", "Coral"]);
plotsetup(default);
