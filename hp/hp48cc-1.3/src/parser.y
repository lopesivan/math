/*	$Id: parser.y,v 1.9 2001/08/18 23:29:23 sandro Exp $	*/

/*
 * This grammar should generate one shift-reduce conflict.
 * This is the tipical "dangling ELSE" conflict, and is resolved
 * correctly with a shift.
 */

%{
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <err.h>

#include "config.h"

extern int lineno;
#ifdef YYTEXT_POINTER
extern char *yytext;
#else
extern char yytext[];
#endif
extern FILE *output_file;

static void yyerror(char *);
static int count_arguments(const char *);
static void output(char *);
static char *declare_function(char *id, char *arg, char *stmt);
static char *emit(const char *, ...);
static char *cat(char *, ...);

#define MAX_LOCAL_VARS 128

static struct {
	char *name;
	char *value;
} local_vars[MAX_LOCAL_VARS];
int local_vars_num;

#define dup(s)		xstrdup(s)
#define EPSILON		dup("")
%}

%union {
	char *string;
}

%token ASSIGN CASE DECLARE DEFAULT DO ELSE FOR IF SWITCH WHILE

%token HP_OBRACKET HP_CBRACKET HP_OBRACE HP_CBRACE HP_OPAREN HP_CPAREN

%token IDENTIFIER CONSTANT
%token CONST_QUOTED CONST_RPN CONST_STRING CONST_RPN_PROG

%token SR_ASSIGN SL_ASSIGN SUM_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN
%token MOD_ASSIGN AND_ASSIGN XOR_ASSIGN OR_ASSIGN POW SR SL INC DEC
%token LOG_AND LOG_OR LE GE EQ NE

%type <string> expression_opt switch_statement switch_statement_list
%type <string> expression statement statement_list statement_list_opt
%type <string> argument_expression_list identifier string constant
%type <string> primary_expression postfix_expression unary_expression
%type <string> power_expression
%type <string> multiplicative_expression additive_expression
%type <string> shift_expression relational_expression equality_expression
%type <string> exclusive_or_expression inclusive_or_expression
%type <string> and_expression logical_and_expression logical_or_expression
%type <string> conditional_expression assignment_expression

%%

file:
	/* epsilon */
		{ warnx("no output is produced, since no input was provided"); }
	| statement_list
		{ output($1); }
	;

statement_list:
	statement
		{ $$ = $1; }
	| statement_list statement
		{ $$ = cat($1, $2, NULL); }
	;

statement_list_opt:
	/* epsilon */
		{ $$ = EPSILON; }
	| statement_list
		{ $$ = $1; }
	;

local_vars_opt:
	/* epsilon */
	| local_vars
	;

local_vars:
	':' local_vars_list
	;

local_vars_list:
	local_vars_list ',' local_var
	| local_var
	;

local_var:
	identifier '(' constant ')'
		{ local_vars[local_vars_num].name = $1;
		  local_vars[local_vars_num].value = $3;
		  ++local_vars_num; }
	;

declare:
	DECLARE
		{ local_vars_num = 0; }
	;

statement:
	declare identifier '(' argument_expression_list ')' local_vars_opt '{' statement_list_opt '}'
		{ $$ = declare_function($2, $4, $8); }
	| declare identifier '(' ')' local_vars_opt '{' statement_list_opt '}'
		{ $$ = declare_function($2, NULL, $7); }
	| IF '(' expression ')' statement
		{ $$ = emit("IF %s\nTHEN %s\nEND\n", $3, $5); }
	| IF '(' expression ')' statement ELSE statement
		{ $$ = emit("IF %s\nTHEN %s\nELSE %s\nEND\n", $3, $5, $7); }

	| FOR '(' expression_opt ';' expression ';' expression_opt ')' statement
		{ $$ = emit("%s WHILE %s\nREPEAT %s %s\nEND\n", $3, $5, $9, $7); }
	| FOR '(' expression_opt ';' ';' expression_opt ')' statement
		{ $$ = emit("%s WHILE 1\nREPEAT %s %s\nEND\n", $3, $8, $6); }

	| WHILE '(' expression ')' statement
		{ $$ = emit("WHILE %s\nREPEAT %s\nEND\n", $3, $5); }

	| DO statement WHILE '(' expression ')' ';'
		{ $$ = emit("DO %s UNTIL %s NOT\nEND\n", $2, $5); }

	| SWITCH '(' expression ')' '{' switch_statement_list '}'
		{ $$ = emit("%s \\-> $\n\\<<CASE\n%s\nEND\\>>", $3, $6); }

	| expression ';'
		{ $$ = emit("%s\n", $1); }
	| '{' statement_list_opt '}'
		{ $$ = $2; }
	| ASSIGN identifier '[' argument_expression_list ']' '=' expression ';'
		{ $$ = emit("%s '%s(%s)' STO\n", $7, $2, $4); }
	| ASSIGN HP_OBRACE argument_expression_list '}' '=' expression ';'
		{ char buf[16];
		  sprintf(buf, "%d", count_arguments($3));
		  $$ = emit("%s %s \\->LIST {%s} 2 \\<<STO\\>> DOLIST\n",
			    $6, dup(buf), $3); }
	| ';' /* Null statement. */
		{ $$ = EPSILON; }
	;

switch_statement_list:
	switch_statement
		{ $$ = $1; }
	| switch_statement_list switch_statement
		{ $$ = cat($1, $2, NULL); }
	;

switch_statement:
	CASE expression ':' statement
		{ $$ = emit("\n$ %s == THEN\n%s END\n", $2, $4); }
	| DEFAULT ':' statement
		{ $$ = emit("\n%s", $3); }
	;

primary_expression:
	identifier
		{ $$ = $1; }
	| constant
		{ $$ = $1; }
	| '(' expression ')'
		{ $$ = $2; }
	| '(' expression ')' '!'
		{ $$ = emit("%s !", $2); }
	| HP_OBRACKET argument_expression_list ']'
		{ $$ = emit("[%s]", $2); }
	| HP_OBRACE argument_expression_list '}'
		{ $$ = emit("{%s}", $2); }
	| HP_OBRACE '}'
		{ $$ = dup("{}"); }
	| HP_OPAREN assignment_expression ',' assignment_expression ')'
		{ $$ = emit("(%s,%s)", $2, $4); }
	;

argument_expression_list:
	assignment_expression
		{ $$ = $1; }
	| argument_expression_list ',' assignment_expression
		{ $$ = emit("%s,%s", $1, $3); }
	;

postfix_expression:
	primary_expression
		{ $$ = $1; }
	| postfix_expression '[' expression ']'
		{ $$ = emit("'%s(%s)' EVAL", $1, $3); }
	| postfix_expression '(' ')'
		{ $$ = emit(" %s", $1); }
	| postfix_expression '(' argument_expression_list ')'
		{ $$ = emit(" %s %s", $3, $1); }
	| postfix_expression INC
		{ $$ = emit("'%s' 1 STO+", $1); }
	| postfix_expression DEC
		{ $$ = emit("'%s' 1 STO-", $1); }
	;

unary_expression:
	postfix_expression
		{ $$ = $1; }
	| INC unary_expression
		{ $$ = emit("'%s' 1 STO+", $2); }
	| DEC unary_expression
		{ $$ = emit("'%s' 1 STO-", $2); }
	| '+' unary_expression
		{ $$ = $2; }
	| '-' unary_expression
		{ $$ = emit("%s NEG", $2); }
	| '~' unary_expression
		{ $$ = emit("%s NOT", $2); }
	| '!' unary_expression
		{ $$ = emit("%s NOT", $2); }
	;

power_expression:
	unary_expression
		{ $$ = $1; }
	| power_expression POW unary_expression
		{ $$ = emit("%s %s ^", $1, $3); }
	;
	
multiplicative_expression:
	power_expression
		{ $$ = $1; }
	| multiplicative_expression '*' power_expression
		{ $$ = emit("%s %s *", $1, $3); }
	| multiplicative_expression '/' power_expression
		{ $$ = emit("%s %s /", $1, $3); }
	| multiplicative_expression '%' power_expression
		{ $$ = emit("%s %s MOD", $1, $3); }
	;

additive_expression:
	multiplicative_expression
		{ $$ = $1; }
	| additive_expression '+' multiplicative_expression
		{ $$ = emit("%s %s +", $1, $3); }
	| additive_expression '-' multiplicative_expression
		{ $$ = emit("%s %s -", $1, $3); }
	;

shift_expression:
	additive_expression
		{ $$ = $1; }
/* XXX to implement shift
        | shift_expression SL additive_expression
		{ $$ = emit("%s %s SL", $1, $3); }
        | shift_expression SR additive_expression
		{ $$ = emit("%s %s SR", $1, $3); }
*/
 	;

relational_expression:
	shift_expression
		{ $$ = $1; }
        | relational_expression '<' shift_expression
		{ $$ = emit("%s %s <", $1, $3); }
        | relational_expression '>' shift_expression
		{ $$ = emit("%s %s >", $1, $3); }
        | relational_expression LE shift_expression
		{ $$ = emit("%s %s \\<=", $1, $3); }
        | relational_expression GE shift_expression
		{ $$ = emit("%s %s \\>=", $1, $3); }
	;

equality_expression:
	relational_expression
		{ $$ = $1; }
        | equality_expression EQ relational_expression
		{ $$ = emit("%s %s ==", $1, $3); }
        | equality_expression NE relational_expression
		{ $$ = emit("%s %s \\=/", $1, $3); }
	;

and_expression:
	equality_expression
		{ $$ = $1; }
        | and_expression '&' equality_expression
		{ $$ = emit("%s %s &", $1, $3); }
	;

exclusive_or_expression:
	and_expression
		{ $$ = $1; }
        | exclusive_or_expression '^' and_expression
		{ $$ = emit("%s %s ^", $1, $3); } /* XXX */
	;

inclusive_or_expression:
	exclusive_or_expression
		{ $$ = $1; }
        | inclusive_or_expression '|' exclusive_or_expression
		{ $$ = emit("%s %s |", $1, $3); }
	;

logical_and_expression:
	inclusive_or_expression
		{ $$ = $1; }
        | logical_and_expression LOG_AND inclusive_or_expression
		{ $$ = emit("%s %s AND", $1, $3); }
	;

logical_or_expression:
	logical_and_expression
		{ $$ = $1; }
        | logical_or_expression LOG_OR logical_and_expression
		{ $$ = emit("%s %s OR", $1, $3); }
	;

conditional_expression:
	logical_or_expression
		{ $$ = $1; }
	| logical_or_expression '?' expression ':' conditional_expression
		{ $$ = emit("IF %s\nTHEN %s\nELSE %s\nEND\n", $1, $3, $5); }
	;

assignment_expression:
	conditional_expression
		{ $$ = $1; }
	| unary_expression '=' assignment_expression
		{ $$ = emit("%s '%s' STO", $3, $1); }
	| unary_expression SUM_ASSIGN assignment_expression
		{ $$ = emit("%s '%s' STO+", $3, $1); }
	| unary_expression SUB_ASSIGN assignment_expression
		{ $$ = emit("%s '%s' STO-", $3, $1); }
	| unary_expression MUL_ASSIGN assignment_expression
		{ $$ = emit("%s '%s' STO*", $3, $1); }
	| unary_expression DIV_ASSIGN assignment_expression
		{ $$ = emit("%s '%s' STO/", $3, $1); }
	| unary_expression MOD_ASSIGN assignment_expression
		{ $$ = emit("%s %s MOD '%s' STO", dup($1), $3, $1); }
/* XXX to implement shift
	| unary_expression SL_ASSIGN assignment_expression
		{ $$ = emit("%s %s SL '%s' STO", dup($1), $3, $1); }
	| unary_expression SR_ASSIGN assignment_expression
		{ $$ = emit("%s %s SR '%s' STO", dup($1), $3, $1); }
*/
	| unary_expression AND_ASSIGN assignment_expression
		{ $$ = emit("%s %s & '%s' STO", dup($1), $3, $1); }
	| unary_expression XOR_ASSIGN assignment_expression
		{ $$ = emit("%s %s ^ '%s' STO", dup($1), $3, $1); }
	| unary_expression OR_ASSIGN assignment_expression
		{ $$ = emit("%s %s | '%s' STO", dup($1), $3, $1); }
	;

expression:
	assignment_expression
		{ $$ = $1; }
	| expression ',' assignment_expression
		{ $$ = emit("%s,%s", $1, $3); }
	;

expression_opt:
	/* epsilon */
		{ $$ = EPSILON; }
	| expression
		{ $$ = $1; }
	;

identifier:
	IDENTIFIER
		{ char *p;
		  /* Filter strings like "foo\-\>" to "foo->" */
		  for (p = yytext; *p != '\0'; ++p)
			if (*p == '\\') {
				strcpy(p, p + 1);
				if (*p == '\0')
					break;
			}
		  $$ = dup(yytext); }
	;

constant:
	CONSTANT
		{ $$ = dup(yytext); }
	| CONST_QUOTED
		{ $$ = dup(yytext); }
	| CONST_RPN
		{ $$ = dup(yytext+1); $$[strlen($$)-1] = '\0'; }
	| CONST_RPN_PROG
		{ char *p = dup(yytext+3); p[strlen(p)-2] = '\0';
		  $$ = emit("\\<<%s\\>>", p); }
	| string
		{ $$ = $1; }
	;

string:
	CONST_STRING
		{ char *p;
		  /* Filter escape characters. */
		  for (p = yytext; *p != '\0'; ++p)
			if (*p == '\\') {
				if (*(p + 1) == 'n') {
					*p = '\n';
					strcpy(p + 1, p + 2);
				} else
					strcpy(p, p + 1);
				if (*p == '\0')
					break;
			}
		  $$ = dup(yytext); }
	;

%%

static void yyerror(char *s)
{
	errx(1, "%d: %s", lineno, s);
}

static int count_arguments(const char *s)
{
	int i = 0;
	for (; *s != '\0'; s++)
		if (*s == ',')
			i++;
	return i+1;
}

static void output(char *s)
{
	fprintf(output_file, "%%%%HP: T(3)A(R)F(.);\n\\<<\n%s\\>>\n", s);
}

static char *declare_function(char *id, char *arg, char *stmt)
{
	if (arg != NULL || local_vars_num > 0) {
		char buf[128], i;
		strcpy(buf, "\\<< ");
		for (i = 0; i < local_vars_num; ++i) {
			if (i > 0)	
				strcat(buf, ",");
			strcat(buf, local_vars[i].value);
			free(local_vars[i].value);
		}
		strcat(buf, " \\-> ");
		if (arg != NULL) {
			strcat(buf, arg);
			if (local_vars_num > 0)
				strcat(buf, ",");
		}
		for (i = 0; i < local_vars_num; ++i) {
			if (i > 0)	
				strcat(buf, ",");
			strcat(buf, local_vars[i].name);
			free(local_vars[i].name);
		}
		strcat(buf, " \\<< %s \\>> \\>> '%s' STO");
		return emit(buf, stmt, id);
	} else
		return emit("\\<<%s\\>> '%s' STO", stmt, id);
}

/*
 * Format the string into an allocated buffer according to the '%' escapes,
 * and return the buffer.  The arguments memory is automatically released.
 * Two successive newlines are replaced by one only.
 *
 * Supported escapes:
 *   Escape   Output
 *   %%       %
 *   %s       (include the next available string argument)
 */
static char *emit(const char *fmt, ...)
{
	va_list ap;
	char *buf, *p, *str, *sp;
	int bufmax;

	va_start(ap, fmt);

	bufmax = strlen(fmt);
	p = buf = (char *)xmalloc(bufmax);

	while (*fmt != '\0') {
		if (p - buf + 1 >= bufmax) {
			int off = p - buf;
			bufmax += 10;
			buf = (char *)xrealloc(buf, bufmax);
			p = buf + off;
		}
		if (*fmt == '%') {
			switch (*++fmt) {
			case '%':
				*p++ = '%';
				break;
			case 's':
				str = sp = va_arg(ap, char *);
				while (*sp != '\0') {
					if (p - buf + 1 >= bufmax) {
						int off = p - buf;
						bufmax += 10;
						buf = (char *)xrealloc(buf, bufmax);
						p = buf + off;
					}
					*p++ = *sp;
					sp++;
				}
				free(str);
			}
		} else
			*p++ = *fmt;
		++fmt;
	}

	*p = '\0';

	va_end(ap);

	return buf;
}

/*
 * Catenate the null-terminated strings into a newly allocated string.
 * The parameter list is terminated by a NULL pointer.
 * The parameters are deallocated after copy.
 */
static char *cat(char *s, ...)
{
	va_list ap;
	int size;
	char *p, *newstr;

	size = strlen(s) + 1;

	va_start(ap, s);
	while ((p = va_arg(ap, char *)) != NULL)
		size += strlen(p) + 1;
	va_end(ap);

	newstr = (char *)xmalloc(size);

	va_start(ap, s);
	strcpy(newstr, s);
	free(s);
	while ((p = va_arg(ap, char *)) != NULL) {
		strcat(newstr, p);
		free(p);
	}
	va_end(ap);

	return newstr;
}
