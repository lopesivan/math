#! /bin/sed -f

s|%%HP: T(3)A(R)F(.);|%%HP: T(0)A(D)F(.);|g
# Start of program delimiter (<<)
s|\\<<|\d171|g
# Angle symbol for polar notation
s/\\<\([^<]\)/\d128\1/g
# End of program delimiter (>>)
s|\\>>|\d187|g
# Lowercase Greek pi
s|\\pi|\d135|g
# x with bar above it
s|\\x-|\d129|g
# Lowercase Greek gamma
s|\\Gg|\d145|g
# Lowercase Greek delta
s|\\Gd|\d146|g
# Lowercase Greek epsilon
s|\\Ge|\d147|g
# Lowercase Greek eta
s|\\Gn|\d148|g
# Lowercase Greek theta
s|\\Gh|\d149|g
# Lowercase Greek lambda
s|\\Gl|\d150|g
# Lowercase Greek rho
s|\\Gr|\d151|g
# Lowercase Greek sigma
s|\\Gs|\d152|g
# Lowercase Greek tau
s|\\Gt|\d153|g
# Lowercase Greek omega
s|\\Gw|\d154|g
# Uppercase Greek Delta
s|\\GD|\d155|g
# Uppercase Greek Pi
s|\\GP|\d156|g
# Uppercase Greek Omega
s|\\GW|\d157|g

s|\\\.V|\d130|g
# square root symbol
s|\\v\/|\d131|g
# Integral symbol
s|\\\.S|\d132|g
# Uppercase Greek Sigma
s|\\GS|\d133|g
#
s|\\\|>|\d134|g
# Differentiation symbol
s|\\\.d|\d136|g
# Less-than or equal-to symbol
s|\\<=|\d137|g
# Greater-than or equal-to symbol
s|\\>=|\d138|g
# Not-equal-to symbol
s|\\=\/|\d139|g
# Lowercase Greek alpha
s|\\Ga|\d140|g
# Right arrow
s|\\->|\d141|g
# Left arrow
s|\\<-|\d142|g
# Down arrow
s|\\\|v|\d143|g
# Up arrow
s|\\\|^|\d144|g
#
s|\[\]|\d158|g
# Infinity symbol
s|\\oo|\d159|g
# Degree symbol
s|\\^o|\d176|g
# Lowercase Greek mu
s|\\Gm|\d181|g
# Cross-product operator
s|\\\.x |\d215|g
# Slashed Oh
s|\\O\/|\d216|g
# Lowercase Greek beta
s|\\Gb|\d223|g
# Division symbol
s|\\:-|\d247|g
