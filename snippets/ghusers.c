#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <err.h>
#include <getopt.h>

int main(void)
{
	system("curl https://api.github.com/");
	return 0;
}
