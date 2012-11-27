#include <crask.h>
#include <unordered_map>
#include <string>
#include <memory>
#include <bits/stl_algo.h>

extern "C" {

struct CRASK_METHOD_ { };

struct CRASK_OBJECT_ {
    CRASK_CLASS cls;
    std::unordered_map<std::string, std::unique_ptr<CRASK_OBJECT> > vars;
    CRASK_OBJECT_(CRASK_CLASS cls) : cls(cls) { }
};

struct CRASK_CLASS_ {
    std::unique_ptr<CRASK_OBJECT_> self;
    std::unordered_map<CRASK_METHOD, CRASK_METHOD_IMPL> methods;
    
    CRASK_CLASS_(CRASK_CLASS metaClass)
        : self(new CRASK_OBJECT_(metaClass)) { }
    CRASK_CLASS_() { }
};

CRASK_CLASS CRASK_CLASS_NIL = 0;
CRASK_OBJECT CRASK_NIL = 0;

}

namespace {

std::vector<std::unique_ptr<CRASK_CLASS_> > g_classes;
std::unordered_map<std::string, CRASK_CLASS> g_namedClasses;
std::unordered_map<std::string, std::unique_ptr<CRASK_METHOD_> > g_methods;


CRASK_CLASS allocClassWithMetaClass(CRASK_CLASS metaClass) {
    std::unique_ptr<CRASK_CLASS_> classInfo(new CRASK_CLASS_(metaClass));
    g_classes.push_back(std::move(classInfo));
    return &*g_classes.back();
}

CRASK_CLASS allocClassWithoutMetaClass() {
    std::unique_ptr<CRASK_CLASS_> classInfo(new CRASK_CLASS_());
    g_classes.push_back(std::move(classInfo));
    return &*g_classes.back();
}

}

void crask_reset() {
    g_classes.clear();
    g_namedClasses.clear();
    g_methods.clear();
}

extern "C" {

CRASK_CLASS crask_registerClass(const char *className) {
    auto it = g_namedClasses.find(className);
    if (it != g_namedClasses.end())
        return it->second;
    CRASK_CLASS metaClass = allocClassWithoutMetaClass();
    CRASK_CLASS classInfo = allocClassWithMetaClass(metaClass);
    g_namedClasses.insert({className, classInfo});
    return classInfo;
}

CRASK_CLASS crask_getClass(const char *className) {
    auto it = g_namedClasses.find(className);
    if (it == g_namedClasses.end()) return CRASK_CLASS_NIL;
    return &*it->second;
}

CRASK_METHOD crask_registerMethod(const char *methodName) {
    std::unique_ptr<CRASK_METHOD_> methodInfo(new CRASK_METHOD_);
    auto it = g_methods.insert({methodName, std::move(methodInfo)});
    return &*it.first->second;
}

void crask_addClassMethodToClass(CRASK_METHOD method, CRASK_METHOD_IMPL methodImpl, CRASK_CLASS cls) {
    cls->self->cls->methods.insert({method, methodImpl});
}

CRASK_OBJECT crask_getClassObject(CRASK_CLASS cls) {
    return &*cls->self;
}

CRASK_METHOD_IMPL crask_getMethodImplForObject(CRASK_METHOD method, CRASK_OBJECT object) {
    return object->cls->methods.find(method)->second;
}

CRASK_OBJECT crask_createInstance(CRASK_CLASS cls) {
    return new CRASK_OBJECT_(cls);
}

void crask_dispose(CRASK_OBJECT object) {
    delete object;
}

void crask_addMethodToClass(CRASK_METHOD method, CRASK_METHOD_IMPL methodImpl, CRASK_CLASS cls) {
    cls->methods.insert({method, methodImpl});
}

CRASK_OBJECT *crask_getVariableFromObject(const char *name, CRASK_OBJECT object) {
    auto it = object->vars.find(name);
    if (it == object->vars.end())
        return 0;
    return &*it->second;
}

CRASK_OBJECT *crask_addVariableToObject(const char *name, CRASK_OBJECT object) {
    std::unique_ptr<CRASK_OBJECT> varPtr(new CRASK_OBJECT(CRASK_NIL));
    return &*object->vars.insert({name, std::move(varPtr)}).first->second;
}

CRASK_OBJECT crask_getObjectClassObject(CRASK_OBJECT object) {
    auto& classObject = object->cls->self;
    return classObject ? &*classObject : CRASK_NIL;
}

}