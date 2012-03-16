#ifndef OUTPUT_H
#define OUTPUT_H

#ifdef _WIN32
#ifdef __cplusplus
#ifdef EXPORT_API
#define API extern "C" __declspec(dllexport)
#else
#define API extern "C" __declspec(dllimport)
#endif /* EXPORT_API */
#else
#ifdef EXPORT_API
#define API extern __declspec(dllexport)
#else
#define API extern __declspec(dllimport)
#endif /* EXPORT_API */
#endif /* __cplusplus */
#else
#if defined (__cplusplus)
#define API extern "C"
#else
#define API extern
#endif /* __cplusplus */
#endif /* _WIN32 */

API int output(void);

#endif /* OUTPUT_H */

/* EOF */
