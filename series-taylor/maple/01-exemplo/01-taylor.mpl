#restart;
f :=(x) -> ln(x);

# termo
T :=(n) -> diff(f,x$n)/n!;

a[0] := f(a);
for i to 3 do
	a[i] := subs(x = a, T(i))
end do;

p := sum(a[n]*(x-a)^n, n = 0 .. 3);
R := 0;
p;
g := subs(a = 1, p);
plot({f(x), g}, x = 0 .. 2);

