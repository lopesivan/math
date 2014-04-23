% It is matlab script
syms x y
z = 30*x^4/(x*y^2 + 10) - x^3*(y^2 + 1)^2
ccode(z)

syms x
f = taylor(sin(x))
ccode(f)

