/*
 * Copyright (c) 2017 Mohamed A. Fouad <zautomata@hackspree.com>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
#define _POSIX_C_SOURCE 199309L

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <err.h>
#include <getopt.h>
#include <syslog.h>
/* #include <fcntl.h> */
/* #include <pcre.h>  */

//#define POLL_STDOUT	3
//#define BUFSIZE		16384
//#define DEFAULT_CA_FILE	"/etc/ssl/cert.pem"

/* Command Line Options */
int	dflag;					     /* detached, no stdin */
int	Fflag;					     /* fdpass sock to stdout */

/* show usage */
static  void usage(void);

/*
 * enrich data by computing and adding information this function could be useful
 * while implementing datastore utitlies
 */
int enrich(FILE, FILE);

/* refines data by concentrating or extracting information */
int refine(FILE, FILE);

/* transforms data by delivering the data in other representation */
int transform(FILE, FILE);


//main(char *mylist)
int
main()
{

#ifdef __OpenBSD__
	if (-1 == pledge("stdio", NULL))
		err(EXIT_FAILURE, "pledge");
#endif
	usage();
	printf("utility snippet with enrich() called\n");
	//enrich();

	//openlog(basename(argv[0], LOG_PID, LOG_LOCAL3));
	//syslog(LOG_WARNING, "Attempting: %s",argv[1]);
	//syslog(LOG_AUTHPRIV|LOG_ERR,argv[1]);
	//syslog(LOG_ERR, "Success/Failure?: %");
	//closelog();
	return 0;
}

/*
  void
  usage(int ret)
  {
  fprintf(stderr,
  "usage: nc [-46cDdFhklNnrStUuvz] [-C certfile] [-e name] "
  "[-H hash] [-I length]\n"
  "\t  [-i interval] [-K keyfile] [-M ttl] [-m minttl] [-O length]\n"
  "\t  [-o staplefile] [-P proxy_username] [-p source_port] "
  "[-R CAfile]\n"
  "\t  [-s source] [-T keyword] [-V rtable] [-W recvlimit] "
  "[-w timeout]\n"
  "\t  [-X proxy_protocol] [-x proxy_address[:port]] "
  "[-Z peercertfile]\n"
  "\t  [destination] [port]\n");
  if (ret)
  exit(1);
}
*/
static void
usage(void)
{
	extern char *__progname;
	(void)fprintf(stderr,
	    "usage: %s [-h] [-d] [-abf] [-c value] \n"
	    "\t[-H hash] [-I length]\n"
	    "\t[-s source] [-T keyword] [-V rtable] [-W recvlimit]"
	    ,__progname);
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
	    LOG_PID  |
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
