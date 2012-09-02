#include <stdio.h>

#include <jni.h>

#include <net_cryp7_range_hello_NativeOutput.h>

#include <output.h>

/*
 * Class:     net_cryp7_range_hello_NativeOutput
 * Method:    output
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_net_cryp7_range_hello_NativeOutput_output
  (JNIEnv *env, jobject obj)
{
	int status;

	status = ( (jint) output() );

	return status;

} /* end Java_net_cryp7_range_hello_NativeOutput_output */

/* EOF */
