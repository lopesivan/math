# Considere a função f(x)=ln(x) , determine a fórmula de Taylor
# para n=3 e a=1.

f := (x) -> ln(x);
P := convert(taylor(f(x),x=1,3),polynom);

with(plots):

P := convert(taylor(f(x),x=1,20),polynom);
plotsetup(jpeg, plotoutput = `05-taylor.jpeg`, plotoptions="height=1024,width=1024");
plot([f(x),P],x=0..2,y=-5..1,color=[black,red],thickness=[3,1]);
plotsetup(default);
