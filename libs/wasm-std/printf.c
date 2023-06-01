#include <stdarg.h>
#include <stddef.h>
#include <string.h>
#include "stb_sprintf.h"

extern int vsprintf(char *buf, char const *fmt, va_list va) {
  return stbsp_vsprintf(buf, fmt, va);
}

extern int sprintf(char *buf, char const *fmt, va_list va) {
  return stbsp_vsprintf(buf, fmt, va);
}

extern int snprintf(char *buf, int count, char const *fmt, va_list va) {
  return stbsp_vsnprintf(buf, (int)count, fmt, va);
}

extern int vsnprintf(char *buf, int count, char const *fmt, va_list va) {
  return stbsp_vsnprintf(buf, (int)count, fmt, va);
}

extern int vsprintfcb(STBSP_SPRINTFCB *callback, void *user, char *buf, char const *fmt, va_list va) {
  return stbsp_vsprintfcb(callback, user, buf, fmt, va);
}

extern void set_separators(char comma, char period) {
  stbsp_set_separators(comma, period);
}