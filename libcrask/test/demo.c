#include <crask.h>
#include <stdarg.h>

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

int main() {
    CRASK_CLASS intClass = crask_registerClass("int");
    CRASK_CLASS rectClass = crask_registerClass("Rect");
    CRASK_METHOD new_ = crask_registerMethod("new");
    CRASK_METHOD setA = crask_registerMethod("setA:");
    CRASK_METHOD setB = crask_registerMethod("setB:");
    crask_addClassMethodToClass(new_, Rect_new, rectClass);
    crask_addMethodToClass(setA, Rect_setA, rectClass);
    crask_addMethodToClass(setB, Rect_setB, rectClass);
    CRASK_OBJECT rectClassObject = crask_getClassObject(rectClass);
    CRASK_OBJECT rect =  crask_getMethodImplForObject(new_, rectClassObject)(rectClassObject);
    crask_addVariableToObject("a", rect);
    crask_addVariableToObject("b", rect);
    CRASK_OBJECT a = crask_createInstance(intClass);
    CRASK_OBJECT b = crask_createInstance(intClass);
    crask_getMethodImplForObject(setA, rect)(rect, a);
    crask_getMethodImplForObject(setB, rect)(rect, b);
    
    crask_dispose(rect);
    crask_dispose(a);
    crask_dispose(b);
    return 0;
}