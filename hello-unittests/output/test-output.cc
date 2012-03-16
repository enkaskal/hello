#include <gtest/gtest.h>

extern "C"
{
#include <output.h>
}

TEST(Output,OutputSuccess)
{
	int status;

	status = output();

	ASSERT_EQ(EXIT_SUCCESS,status);

} /* end OutputSuccess */



/* EOF */
