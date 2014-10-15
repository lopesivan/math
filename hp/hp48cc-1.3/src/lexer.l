/*	$Id: lexer.l,v 1.7 2001/08/18 23:29:23 sandro Exp $	*/

Digit		[0-9]
Literal		(\\.)|[a-zA-Z\$\.]
Exp		[Ee][+-]?{Digit}+

%{
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <err.h>

#include "parser.h"

static void comment(void);
static void skip_until_eol(void);

static int yywrap(void) { return 1; }

int lineno;
%}

%%

"/*"					{ comment(); }
"//"					{ skip_until_eol(); }
"#"					{ skip_until_eol(); }

"assign"				{ return ASSIGN; }
"case"					{ return CASE; }
"declare"				{ return DECLARE; }
"default"				{ return DEFAULT; }
"do"					{ return DO; }
"else"					{ return ELSE; }
"for"					{ return FOR; }
"if"					{ return IF; }
"switch"				{ return SWITCH; }
"while"					{ return WHILE; }

{Literal}({Literal}|{Digit})*		{ return IDENTIFIER; }

{Digit}+				{ return CONSTANT; }
{Digit}*\.{Digit}+({Exp})?		{ return CONSTANT; }
{Digit}+\.?{Digit}*({Exp})?		{ return CONSTANT; }

\'[^']*\'				{ return CONST_QUOTED; }
\`[^`]*\`				{ return CONST_RPN; }
\"((\\.)|[^"])*\"			{ return CONST_STRING; }
"@<<"(.)*">>"				{ return CONST_RPN_PROG; }
"@["					{ return HP_OBRACKET; }
"@]"					{ return HP_CBRACKET; }
"@{"					{ return HP_OBRACE; }
"@}"					{ return HP_CBRACE; }
"@("					{ return HP_OPAREN; }
"@)"					{ return HP_CPAREN; }

">>="					{ return SR_ASSIGN; }
"<<="					{ return SL_ASSIGN; }
"+="					{ return SUM_ASSIGN; }
"-="					{ return SUB_ASSIGN; }
"*="					{ return MUL_ASSIGN; }
"/="					{ return DIV_ASSIGN; }
"%="					{ return MOD_ASSIGN; }
"&="					{ return AND_ASSIGN; }
"^="					{ return XOR_ASSIGN; }
"|="					{ return OR_ASSIGN; }
"**"					{ return POW; }
">>"					{ return SR; }
"<<"					{ return SL; }
"++"					{ return INC; }
"--"					{ return DEC; }
"&&"					{ return LOG_AND; }
"||"					{ return LOG_OR; }
"<="					{ return LE; }
">="					{ return GE; }
"=="					{ return EQ; }
"!="					{ return NE; }

\n					{ lineno++; }
[ \t\v\f]				{ /* Skip whitespace. */ }
.					{ return yytext[0]; }

%%

static void comment(void)
{
	int c;

	while ((c = input()) != EOF) {
	resync:
		if (c == '\n')
			lineno++;
		else if (c == '*')
			if ((c = input()) == '/')
				return;
			else
				goto resync;
	}
}

static void skip_until_eol(void)
{
	int c;

	while ((c = input()) != EOF && c != '\n')
	       ;

	lineno++;
}
