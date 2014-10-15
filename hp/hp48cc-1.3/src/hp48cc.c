/*	$Id: hp48cc.c,v 1.6 2001/08/18 23:29:23 sandro Exp $	*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <err.h>

#include "config.h"

extern int lineno;
extern FILE *yyin;
extern int yyparse(void);

FILE *output_file;

static void process_file(char *filename)
{
	if (filename != NULL && strcmp(filename, "-") != 0) {
		if ((yyin = fopen(filename, "r")) == NULL)
			err(1, "%s", filename);
	} else
		yyin = stdin;

	lineno = 1;
	yyparse();

	if (yyin != stdin)
		fclose(yyin);
}

/*
 * Output the program syntax then exit.
 */
static void usage(void)
{
	fprintf(stderr, "usage: hp48cc [-V] [-o file] [file ...]\n");
	exit(1);
}

/*
 * Used by the err() functions.
 */
char *progname;

int main(int argc, char **argv)
{
	int c;

	progname = argv[0];
	output_file = stdout;

	while ((c = getopt(argc, argv, "o:V")) != -1)
		switch (c) {
		case 'o':
			if (output_file != stdout)
				fclose(output_file);
			if ((output_file = fopen(optarg, "w")) == NULL)
				err(1, "%s", optarg);
			break;
		case 'V':
			fprintf(stderr, "%s\n", HP48CC_VERSION);
			exit(0);
		case '?':
		default:
			usage();
			/* NOTREACHED */
		}
	argc -= optind;
	argv += optind;

	if (argc < 1)
		process_file(NULL);
	else
		while (*argv)
			process_file(*argv++);

	return 0;
}
