#ifndef CRASK_H
#define CRASK_H

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

struct CRASK_CLASS_;
typedef struct CRASK_CLASS_ *CRASK_CLASS;

extern CRASK_CLASS CRASK_NIL;

CRASK_CLASS crask_registerClass(const char *className);
CRASK_CLASS crask_getClass(const char *className);


#ifdef __cplusplus
}
#endif // __cplusplus

#endif /* CRASK_H */