with(CodeGeneration);

f:=(x,y) -> e^(x+y);
Java(f);
C(f);

C([x=2,
   y=x+z,
   z=x*y+5]);

Java([x=2,
      y=x+z,
      z=x*y+5]);


f:=(x) -> taylor(sin(x^2), x=4, 3);
Java(f);
C(f);
