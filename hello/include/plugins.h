#ifndef PLUGINS_H
#define PLUGINS_H

void *load(const char *pluginName);
void *lookup(void *handle, const char *functionName);
void close(void *handle);

#endif /* PLUGINS_H */

/* EOF */
