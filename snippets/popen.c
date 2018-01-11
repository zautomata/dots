int 
popen_func(void) 
{
	/* ls -al | grep '^d' */
	FILE *pp;
	pp = popen("ls -al", "r");
	if (pp != NULL) {
		while (1) {
			char *line;
			char buf[1000];
			line = fgets(buf, sizeof buf, pp);
			if (line == NULL) break;
			if (line[0] == 'd') printf("%s", line); /* line includes '\n' */
		}
		pclose(pp);
	}
	return 0;
}
