#include <crask.h>
#include <unordered_map>
#include <string>
#include <memory>
#include <bits/stl_algo.h>

extern "C" {

struct CRASK_METHOD_ {
    std::string name;
    CRASK_METHOD_(std::string&& name) : name(name) { }
};

struct CRASK_OBJECT_ {
    CRASK_CLASS cls;
    CRASK_OBJECT_() : cls(0) { }
};

struct CRASK_CLASS_ {
    CRASK_OBJECT_ self;
    std::unordered_map<CRASK_METHOD, CRASK_METHOD_IMPL> methods;
};

CRASK_CLASS CRASK_CLASS_NIL = 0;
CRASK_OBJECT CRASK_NIL = 0;

}

namespace {

std::vector<std::unique_ptr<CRASK_CLASS_> > g_classes;
std::unordered_map<std::string, CRASK_CLASS> g_namedClasses;
std::unordered_map<std::string, std::unique_ptr<CRASK_METHOD_> > g_methods;

}

void crask_reset() {
    g_classes.clear();
    g_methods.clear();
}

extern "C" {

CRASK_CLASS crask_registerClass(const char *className) {
    std::unique_ptr<CRASK_CLASS_> classInfo(new CRASK_CLASS_);
    std::unique_ptr<CRASK_CLASS_> metaClassInfo(new CRASK_CLASS_);
    classInfo->self.cls = &*metaClassInfo;
    g_classes.push_back(std::move(metaClassInfo));
    CRASK_CLASS ptr = &*classInfo;
    g_classes.push_back(std::move(classInfo));
    g_namedClasses.insert({className, ptr});
    return ptr;
}

CRASK_CLASS crask_getClass(const char *className) {
    auto it = g_namedClasses.find(className);
    if (it == g_namedClasses.end()) return CRASK_CLASS_NIL;
    return &*it->second;
}

CRASK_METHOD crask_registerMethod(const char *methodName) {
    std::unique_ptr<CRASK_METHOD_> methodInfo(new CRASK_METHOD_(methodName));
    auto it = g_methods.insert({methodName, std::move(methodInfo)});
    return &*it.first->second;
}

void crask_addClassMethodToClass(CRASK_METHOD method, CRASK_METHOD_IMPL methodImpl, CRASK_CLASS cls) {
    cls->self.cls->methods.insert({method, methodImpl});
}

CRASK_OBJECT crask_getClassObject(CRASK_CLASS cls) {
    return &cls->self;
}

CRASK_METHOD_IMPL crask_getMethodImplForObject(CRASK_METHOD method, CRASK_OBJECT object) {
    return object->cls->methods.find(method)->second;
}

CRASK_OBJECT crask_createInstance(CRASK_CLASS cls) {
    auto object = new CRASK_OBJECT_;
    object->cls = cls;
    return object;
}

void crask_dispose(CRASK_OBJECT object) {
    delete object;
}

void crask_addMethodToClass(CRASK_METHOD method, CRASK_METHOD_IMPL methodImpl, CRASK_CLASS cls) {
    cls->methods.insert({method, methodImpl});
}

}