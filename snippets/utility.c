#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <err.h>
#include <getopt.h>
#include <ctype.h> /* for tolower */

/*
  `man 3posix getopt` getopt is also a IEEE Std 1003.1
//TODO watch https://www.youtube.com/watch?v=0PrXd9Wo6jA
// https://www.gnu.org/software/libc/manual/html_node/Example-of-Getopt.html
// https://www.ibm.com/developerworks/aix/library/au-unix-getopt-pdf.pdf
// https://www.cs.rutgers.edu/~pxk/416/notes/c-tutorials/getopt.html

// https://www.gnu.org/software/libc/manual/html_node/Syslog-Example.html

//DONE http://pubs.opengroup.org/onlinepubs/000095399/basedefs/xbd_chap12.html
man document
*/

/*****************************************************************************
### NAME                                                                   ###
### hackspreefilter                                                        ###
###                                                                        ###
### utility_name[-a][-b][-c option_argument]                               ###
### [-d|-e][-f[option_argument]][operand...]                               ###
###                                                                        ###
### DESCRIPTION                                                            ###
### Generic Unix Filter for [...]  in [...] the programming language.      ###
###                                                                        ###
### INPUT                                                                  ###
### - Filter Options and Operands:                                         ###
###   N/A                                                                  ###
### - Environment Variables:                                               ###
###   N/A                                                                  ###
*** - STDIN                                                                ***
***   N/A                                                                  ***
***                                                                        ***
*** TRANSFORMATIONS                                                        ***
*** - STEP A:                                                              ***
***   N/A                                                                  ***
*** - STEP B:                                                              ***
***   N/A                                                                  ***
*** - STEP C:                                                              ***
***   N/A                                                                  ***
***                                                                        ***
*** OUTPUT                                                                 ***
*** - STDOUT:                                                              ***
***   N/A                                                                  ***
******************************************************************************
******************************************************************************
*** Software Engineering Guidelines:                                        **
*** https://zautomata.github.io/guidelines                                  **
******************************************************************************
*****************************************************************************/


/* buffer vs stream */
/* online vs offline algorithm -o 1 is offline? default online? */
/*
  delimiter flag
  -d flag [space, newline, ',', custom].
   similar to https://en.wikipedia.org/wiki/Cut_(Unix)
*/
int lflag = 0; /* single line with ' ' seperator */
int mflag = 0; /* multiline \n seperator */
int fflag = 0; /* filepath */
int sflag = 0; /* seperator */
int pipein = 0; /* pipein */

int aflag = 0;
int bflag = 0;
char *cvalue = NULL;
int index;
int c;
/* const int retval;
 */
int retval;

char **in_buffer;   /* input buffer arrays? */
char **out_buffer;  /* output buffer */

void
usage(){
        /* Show Usage and exit */
        fprintf(stderr,
                "usage: TODO\n");
        exit(1);
}

/* filter */
int
transform(FILE *input, FILE *output){
        while (!feof(input)){
                if (ferror(input)){
                        return 1;
                }
                fputc(tolower(fgetc(input)), output);
                fflush(stdout);
        }
        return 0;
}

int
space_delimiter(){}

int
line_delimiter(){
        FILE *stream;
        char *line = NULL;
        size_t len = 0;
        ssize_t read;

/* PATH variable; should be global variable */
        const char *PATH;
        stream = fopen(PATH, "r");
        if (stream == NULL){
                exit(EXIT_FAILURE);
        }
        while ((read = getline(&line, &len, stream)) != -1) {
                printf("Retrieved line of length %zu :\n", read);
                printf("%s", line);
        }
        free(line);
        fclose(stream);
        exit(EXIT_SUCCESS);
}
/*
not needed? assume even the pipedin is delimited by space via another tool?
int
newline_delimiter(){}
*/
/*
`man tr` can be used to ease the input.
tr " " "\n"
tr "\n" " "
*/
int
piped_buffer(){
/*
  call transform
 */
}

int
inline_buffer(){
/*
  call transform
*/
}

int
flags(int argc, char **argv){
        while ((c = getopt (argc, argv, "habfc:")) != -1) {
                switch (c){
                case 'h':
                        usage();
                        break;
                case 'a':
                        aflag = 1;
                        break;
                case 'b':
                        bflag = 1;
                        break;
                case 'f':
                        fflag = 1;
                        pipein = 0;
                        break;
                case 'c':
                        /* if no stdin then optarg else stdin */
                        cvalue = optarg;
                        break;
                case '?':
                        if (optopt == 'c'){
                                fprintf (stderr,
                                         "Option -%c requires an argument.\n",
                                         optopt);
                        } else if (isprint (optopt)){
                                fprintf (stderr,
                                         "Unknown option `-%c'.\n",
                                         optopt);
                        } else{
                                fprintf (stderr,
                                         "Unknown option character `\\x%x'.\n",
                                         optopt);
                        }
                        return 1;
                default:
                        /*
                          retval = transform(stdin, stdout);
                        */
                        abort();
                }

        }

        printf ("\naflag = %d, bflag = %d, fflag = %d, cvalue = %s\n",
                aflag,      bflag,      fflag,      cvalue);
        for (index = optind; index < argc; index++) {
                printf ("Non-option argument %s\n", argv[index]);
        }
}


int
main(int argc, char **argv)
{
        opterr = 0;

/* unless a fromfile flag is activated and pipein deactivated use stdin */
        pipein = 1;

        flags(argc, argv);
        if (pipein){
                transform(stdin, stdout);
        }
        return 0;
}
