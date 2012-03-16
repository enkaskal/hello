#include <gtest/gtest.h>

extern "C"
{
#include <message.h>
}

TEST(Message,ReturnsValidPtr)
{
	char *ptr;

	ptr = message();
	ASSERT_TRUE(ptr != 0);

} /* end ReturnsValidPtr */


/* EOF */
