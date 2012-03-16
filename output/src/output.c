#include <stdio.h>
#include <stdlib.h>

#include <output.h>
#include <message.h>

API
int
	output(void)
{
	char * msg = message();

	printf("message: %s\n", msg);

	return (EXIT_SUCCESS);

} /* end output */

/* EOF */
