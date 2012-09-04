#include <stdio.h>

#if defined(WIN32)
#include <windows.h>
#else
#include <dlfcn.h>
#endif /* WIN32 */

void *
load(const char *pluginName)
{
	void *rv = 0;

	/* attempt to open the plugin */
#if defined(WIN32)
	rv = LoadLibrary(pluginName);
#else
	rv = dlopen(pluginName, RTLD_LAZY);
#endif /* WIN32 */

#if defined(_DEBUG)
	/* see if plugin was successfully loaded */
	if ( !rv )
	{
		printf("unable to open plugin %s\n", pluginName);
	}
#endif /* _DEBUG */

	return rv;

} /* end load */


void *
lookup(void *handle, const char *functionName)
{
	void *rv = 0;

#if defined(WIN32)
	rv = GetProcAddress((HMODULE)handle, functionName);
#else
	rv = dlsym(handle, functionName);
#endif /* WIN32 */

	return rv;

} /* end lookup */


void
close(void *handle)
{
#if defined(WIN32)
	FreeLibrary((HINSTANCE)handle);
#else
	dlclose(handle);
#endif /* WIN32 */

} /* end close */


/* EOF */
