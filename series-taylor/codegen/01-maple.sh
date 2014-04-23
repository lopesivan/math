#!/bin/bash
filename=01-example.mpl;

cat <<EOF > $filename
# It is maple script
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

f := (x) -> sin(x^2);
p := convert(taylor(f(x),x=0,8),polynom);

Java(p);
C(p);

f:= diff(sin(x^2), x, x);
Java(f);
C(f);

EOF
maple < ./$filename
rm $filename

exit 0
