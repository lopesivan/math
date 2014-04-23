#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.68])

# AC_INIT(package, version, [bug-report], [tarname], [url])
AC_INIT([Taylor_series],
        [1.0],
		[code.bug@unite.com.br],
		[taylor-maple],
		[math.unite.com.br])

AM_INIT_AUTOMAKE($PACKAGE_NAME,$PACKAGE_VERSION)

#
# Verifica se o programa existe no PATH, se existe carrego a variável de mesmo
# nome mas em maiúscula com o nome do programa.
#
AC_PATH_PROG(LATEX,     latex,     "")
AC_PATH_PROG(PDFLATEX,  pdflatex,  "")
AC_PATH_PROG(PS2PDF,    ps2pdf,    "")
AC_PATH_PROG(MAKEINDEX, makeindex, "")
AC_PATH_PROG(DVIPS,     dvips,     "")

#
# se as variáveia abaixo não forem vazias eu crio a variável `HAS_TEX_TOOLS'
#
AM_CONDITIONAL(HAS_TEX_TOOLS, [
	test ! \( -z "$LATEX"     -o \
              -z "$MAKEINDEX" -o \
              -z "$PDFLATEX"  -o \
              -z "$DVIPS" \)])

AS_IF([test -z "$LATEX"    -o \
            -z "$PDFLATEX" -o \
			-z "$DVIPS"    -o \
			-z "$PS2PDF"],
		[AC_MSG_WARN(
			[Some documentation formats may not build, because latex/pdflatex/dvips is missing.]
		)])

# Verificando se existe o aplicativo matlab
AC_PATH_PROG(MATLAB, matlab, "")
AM_CONDITIONAL(HAS_MATLAB_CMD, [
	test ! \( -z "$MATLAB" \)])

# Verificando se existe o aplicativo maple
AC_PATH_PROG(MAPLE, maple, "")
AM_CONDITIONAL(HAS_MAPLE_CMD, [
	test ! \( -z "$MAPLE" \)])

AC_CONFIG_FILES([Makefile
                 maple/Makefile
                 maple/exemplo01/Makefile
                 maple/01-exemplo/Makefile])
AC_OUTPUT

AC_MSG_RESULT(
[
commands in system:
==================

LATEX     = $LATEX
PDFLATEX  = $PDFLATEX
PS2PDF    = $PS2PDF
MAKEINDEX = $MAKEINDEX
DVIPS     = $DVIPS

MAPLE     = $MAPLE
MATLAB    = $MATLAB
])
