#include <stdio.h>
#include <stdlib.h>

#include <plugins.h>

#include <output.h>


int
main(void)
{
	int status;
	void *handle;
	output_ptr fn;

	/* open the kernel */
	handle = load("liboutput.so");
	if ( !handle )
	{
		handle = load("../lib/liboutput.so");
	}

	/* lookup the output function */
	fn = (output_ptr)lookup(handle, "output");

	/* output the txt */
	status = fn();

	if ( status != EXIT_SUCCESS )
	{
		return (status); /* EXIT */
	}

	return(EXIT_SUCCESS);

} /* end main */

/* EOF */
