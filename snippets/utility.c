#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <err.h>
#include <getopt.h>
#include <syslog.h>

/* show usage */
static void usage(void);

/* enrich data by computing and adding information this function
   could be useful while implementing datastore utitlies */
int enrich(FILE, FILE);

/* refines data by concentrating or extracting information */
int refine(FILE, FILE);

/* transforms data by delivering the data in other representation */
int transform(FILE, FILE);


//main(char *mylist)
int
main()
{
	// usage();
	printf("utility snippet with enrich() called\n");
	//enrich();
	return 0;
}

static void
usage(void)
{
	extern char *__progname;
	(void)fprintf(stderr,
	    "usage: %s [-h] [-d] [-abf] [-c value] \n",
	    __progname);
	exit(1);
}

int
enrich()
{
        int c;
        printf("enrich data by computing ");
        printf("and adding information");
        openlog("exampleprog",
                LOG_CONS |
                LOG_PID |
                LOG_NDELAY,
                LOG_LOCAL1);
                switch (c) {
                case 'h':
                        printf("log");
                case '?':
                        printf("log");
                }

        return 0;
}
