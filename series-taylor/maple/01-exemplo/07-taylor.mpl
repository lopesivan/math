#
# função f (x) = sen (x) , determine a fórmula de MacLaurin
# para n=8.

f := (x) -> sin(x);
P := convert(taylor(f(x),x=0,8),polynom);

with(plots):

plotsetup(jpeg, plotoutput = `07-taylor.jpeg`, plotoptions="height=1024,width=1024");
plot([f(x),P]);
plotsetup(default);
