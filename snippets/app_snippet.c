/*
 * contains mechanism for getting SERVER_NAME and REQUEST_URI
 * as prefixes for redis storage
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <regex.h>

int
main(int argc, char *argv[argc])
{

	setenv("DOMAIN", "$SERVER_NAME::gamification", 1);
	return 0;
}


/*
  //redis-cli -x set $SERVER_NAME::gamification::points"

fp = popen("jq '.[].id' |				\
  redis-cli -x set $DOMAIN::points"
  ,"r");
*/
