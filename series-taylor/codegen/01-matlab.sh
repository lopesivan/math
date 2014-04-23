#!/bin/bash
filename=example.m

cat <<EOF > $filename
% It is matlab script
syms x y
z = 30*x^4/(x*y^2 + 10) - x^3*(y^2 + 1)^2
ccode(z)

syms x
f = taylor(sin(x),x, 3)
ccode(f)

syms t
f = diff(3*sin(t)^2,5)
ccode(f)
EOF
matlab -nodesktop -nosplash -nodisplay -r "run ./$filename ; quit;"
