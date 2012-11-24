#include <crask.h>
#include <unordered_map>
#include <string>
#include <memory>

extern "C" {

struct CRASK_CLASS_ { };

CRASK_CLASS CRASK_NIL = 0;

}

namespace {

std::unordered_map<std::string, std::unique_ptr<CRASK_CLASS_> > g_classes;

}

void crask_reset() {
    g_classes.clear();
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
    if (it == g_classes.end()) return CRASK_NIL;
    return &*it->second;
}


}