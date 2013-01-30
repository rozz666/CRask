#ifndef CRASK_H
#define CRASK_H

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

struct CRASK_CLASS_;
typedef struct CRASK_CLASS_ *CRASK_CLASS;

struct CRASK_OBJECT_;
typedef struct CRASK_OBJECT_ *CRASK_OBJECT;

struct CRASK_METHOD_;
typedef struct CRASK_METHOD_ *CRASK_METHOD;

typedef CRASK_OBJECT (*CRASK_METHOD_IMPL)(CRASK_OBJECT, ...);
typedef void (*CRASK_DESTRUCTOR_IMPL)(CRASK_OBJECT);

extern CRASK_CLASS CRASK_CLASS_NIL;
extern CRASK_OBJECT CRASK_NIL;

CRASK_CLASS crask_registerClass(const char *className);
CRASK_CLASS crask_getClass(const char *className);
CRASK_METHOD crask_registerMethod(const char *methodName);
void crask_addClassMethodToClass(CRASK_METHOD_IMPL methodImpl, const char *methodName, CRASK_CLASS cls);
CRASK_OBJECT crask_getClassObject(CRASK_CLASS cls);
CRASK_METHOD_IMPL crask_getMethodImplForObject(CRASK_METHOD method, CRASK_OBJECT object);
CRASK_OBJECT crask_createInstance(CRASK_CLASS cls);
void crask_release(CRASK_OBJECT object);
void crask_retain(CRASK_OBJECT object);
void crask_addMethodToClass(CRASK_METHOD method, CRASK_METHOD_IMPL methodImpl, CRASK_CLASS cls);
CRASK_OBJECT *crask_getVariableFromObject(const char *name, CRASK_OBJECT object);
CRASK_OBJECT *crask_addVariableToObject(const char *name, CRASK_OBJECT object);
CRASK_OBJECT crask_getObjectClassObject(CRASK_OBJECT object);
void crask_setObjectData(CRASK_OBJECT object, void *data);
void *crask_getObjectData(CRASK_OBJECT object);
void crask_addDestructorToClass(CRASK_DESTRUCTOR_IMPL dtorImpl, CRASK_CLASS cls);

#ifdef __cplusplus
}
#endif // __cplusplus

#endif /* CRASK_H */