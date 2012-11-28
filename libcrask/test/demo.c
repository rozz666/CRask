#include <crask.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

CRASK_METHOD new_;
CRASK_METHOD dealloc;
CRASK_METHOD setA;
CRASK_METHOD setB;
CRASK_METHOD mult;
CRASK_METHOD print;
CRASK_METHOD area;

void initMethods() {
    new_ = crask_registerMethod("new");
    dealloc = crask_registerMethod("dealloc");
    setA = crask_registerMethod("setA:");
    setB = crask_registerMethod("setB:");
    mult = crask_registerMethod("mult:");
    print = crask_registerMethod("print");
    area = crask_registerMethod("area");
}

CRASK_CLASS intClass;
CRASK_CLASS rectClass;

CRASK_OBJECT Rect_new(CRASK_OBJECT self, ...) {
    return crask_createInstance(crask_getClass("Rect"));
}

CRASK_OBJECT Rect_setA(CRASK_OBJECT self, ...) {
    va_list ap;
    va_start(ap, self);
    *crask_getVariableFromObject("a", self) = va_arg(ap, CRASK_OBJECT);
    va_end(ap);
    return self;
}

CRASK_OBJECT Rect_setB(CRASK_OBJECT self, ...) {
    va_list ap;
    va_start(ap, self);
    *crask_getVariableFromObject("b", self) = va_arg(ap, CRASK_OBJECT);
    va_end(ap);
    return self;
}

CRASK_OBJECT int_new(CRASK_OBJECT self, ...) {
    va_list ap;
    va_start(ap, self);
    CRASK_OBJECT i = crask_createInstance(crask_getClass("int"));
    int val = va_arg(ap, int);
    void *valPtr = malloc(sizeof(val));
    memcpy(valPtr, &val, sizeof(val));
    crask_setObjectData(i, valPtr);
}

CRASK_OBJECT int_dealloc(CRASK_OBJECT self, ...) {
    free(crask_getObjectData(self));
}

CRASK_OBJECT int_mult(CRASK_OBJECT self, ...) {
    va_list ap;
    va_start(ap, self);
    CRASK_OBJECT rhs = va_arg(ap, CRASK_OBJECT);
    int *val1 = crask_getObjectData(self);
    int *val2 = crask_getObjectData(rhs);
    return int_new(CRASK_NIL, *val1 * *val2);
}

CRASK_OBJECT int_print(CRASK_OBJECT self, ...) {
    int *val = crask_getObjectData(self);
    printf("%i\n", *val);
}

void initClasses() {
    intClass = crask_registerClass("int");
    crask_addClassMethodToClass(new_, int_new, intClass);
    crask_addMethodToClass(dealloc, int_dealloc, intClass);
    crask_addMethodToClass(mult, int_mult, intClass);
    crask_addMethodToClass(print, int_print, intClass);

    rectClass = crask_registerClass("Rect");
    crask_addClassMethodToClass(new_, Rect_new, rectClass);
    crask_addMethodToClass(setA, Rect_setA, rectClass);
    crask_addMethodToClass(setB, Rect_setB, rectClass);
}

CRASK_OBJECT sendMsg(CRASK_OBJECT object, CRASK_METHOD method)
{
    return crask_getMethodImplForObject(method, object)(object);
}

CRASK_OBJECT sendMsg1(CRASK_OBJECT object, CRASK_METHOD method, CRASK_OBJECT arg0)
{
    return crask_getMethodImplForObject(method, object)(object, arg0);
}

int main() {
    initMethods();
    initClasses();
    
    CRASK_OBJECT rectClassObject = crask_getClassObject(rectClass);
    CRASK_OBJECT rect =  crask_getMethodImplForObject(new_, rectClassObject)(rectClassObject);
    crask_addVariableToObject("a", rect);
    crask_addVariableToObject("b", rect);
    CRASK_OBJECT a = int_new(CRASK_NIL, 7);
    CRASK_OBJECT b = int_new(CRASK_NIL, 3);
    sendMsg1(rect, setA, a);
    sendMsg1(rect, setB, b);

    sendMsg(a, print);
    sendMsg(b, print);
    CRASK_OBJECT res = sendMsg1(a, mult, b);
    sendMsg(res, print);

    crask_dispose(rect);
    sendMsg(a, dealloc);
    crask_dispose(a);
    sendMsg(b, dealloc);
    crask_dispose(b);
    sendMsg(res, dealloc);
    crask_dispose(res);
    return 0;
}