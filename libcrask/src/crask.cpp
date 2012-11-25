#include <crask.h>
#include <unordered_map>
#include <string>
#include <memory>

extern "C" {

struct CRASK_METHOD_ {
    std::string name;
    CRASK_METHOD_(std::string&& name) : name(name) { }
};

struct CRASK_OBJECT_ {
    CRASK_CLASS cls;
    std::unordered_map<CRASK_METHOD, CRASK_METHOD_IMPL> methods;
};

struct CRASK_CLASS_ {
    CRASK_OBJECT_ self;
};

CRASK_CLASS CRASK_CLASS_NIL = 0;
CRASK_OBJECT CRASK_NIL = 0;

}

namespace {

std::unordered_map<std::string, std::unique_ptr<CRASK_CLASS_> > g_classes;
std::unordered_map<std::string, std::unique_ptr<CRASK_METHOD_> > g_methods;

}

void crask_reset() {
    g_classes.clear();
    g_methods.clear();
}

extern "C" {

CRASK_CLASS crask_registerClass(const char *className) {
    std::unique_ptr<CRASK_CLASS_> classInfo(new CRASK_CLASS_);
    CRASK_CLASS ptr = &*classInfo;
    g_classes.insert({className, std::move(classInfo)});
    return ptr;
}
CRASK_CLASS crask_getClass(const char *className) {
    auto it = g_classes.find(className);
    if (it == g_classes.end()) return CRASK_CLASS_NIL;
    return &*it->second;
}

CRASK_METHOD crask_registerMethod(const char *methodName) {
    std::unique_ptr<CRASK_METHOD_> methodInfo(new CRASK_METHOD_(methodName));
    auto it = g_methods.insert({methodName, std::move(methodInfo)});
    return &*it.first->second;
}

void crask_addClassMethodToClass(CRASK_METHOD method, CRASK_METHOD_IMPL methodImpl, CRASK_CLASS cls) {
    cls->self.methods.insert({method, methodImpl});
}

CRASK_OBJECT crask_getClassObject(CRASK_CLASS cls) {
    return &cls->self;
}

CRASK_METHOD_IMPL crask_getMethodImplForObject(CRASK_METHOD method, CRASK_OBJECT object) {
    return object->methods.find(method)->second;
}

}