#! /bin/sed -f

s|=delta-estrela=|\d155\d173Y|g
s|=estrela-delta=|Y\d173\d155|g

s|=DEG-RAD=|D\d142\d141R|g
s|=XYZ-POLAR=|XY\d142\d141P|g
s|=nabla=|\d130|g
s|=@127@=|\d127|g
s|=@angulo@=|\d129|g
s|=@x@=|\d130|g
s|=@nabla@=|\d131|g
s|=@raiz@=|\d132|g
s|=@integral@=|\d133|g
s|=@somatorio@=|\d134|g
s|=@produtorio@=|\d156|g

s|\\omega|\d154|g
s|\\Delta|\d155|g
s|\\Omega|\d157|g
s|\\Sigma|\d133|g
s|\\gama|\d145|g
s|\\delta|\d146|g
s|\\epsilon|\d147|g
s|\\infinity|\d159|g
s|\\theta|\d149|g
s|\\sigma|\d152|g
s|\\lambda|\d150|g
s|\\tau|\d153|g
s|\\eta|\d148|g
s|\\sum|\d133|g
s|\\rho|\d151|g
s|\\beta|\d223|g

s|\\\|>|\d134|g
s|\\\|^|\d144|g
s|\\\.d|\d136|g
s|\\\.S|\d132|g
s|\\\.V|\d130|g
s|\\\.x |\d215|g
s|\\\|v|\d143|g

s|\\<<|\d171|g
s|\\<-|\d142|g
s|\\<=|\d137|g
s|\\<)|\d128|g
s|\\x-|\d129|g
s|\\v\/|\d131|g
s|\\\!=|\d139|g
s|\\>>|\d187|g
s|\\>=|\d138|g
s|\\->|\d141|g
s|\\:-|\d247|g

s|\\Ga|\d140|g
s|\\Gb|\d223|g
s|\\Gd|\d146|g
s|\\GD|\d155|g
s|\\Ge|\d147|g
s|\\Gg|\d145|g
s|\\Gh|\d149|g
s|\\Gl|\d150|g
s|\\Gm|\d181|g
s|\\Gn|\d148|g
s|\\GP|\d156|g
s|\\Gr|\d151|g
s|\\GS|\d133|g
s|\\Gs|\d152|g
s|\\Gt|\d153|g
s|\\Gw|\d154|g
s|\\GW|\d157|g
s|\\^o|\d176|g
s|\\mu|\d181|g
s|\\O\/|\d216|g
s|\\oo|\d159|g
s|\\pi|\d135|g
s|\\Pi|\d156|g

s|\[\]|\d158|g

