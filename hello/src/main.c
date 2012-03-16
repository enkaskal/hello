#include <stdio.h>
#include <stdlib.h>

#include <output.h>

int
main(void)
{
	int status;

	status = output();

	if ( status != EXIT_SUCCESS )
	{
		return (status); /* EXIT */
	}

	return(EXIT_SUCCESS);

} /* end main */

/* EOF */
