#include <crask.h>
#include <gtest/gtest.h>

void crask_reset();

struct Classes : testing::Test {

    CRASK_CLASS cls;
    CRASK_OBJECT clsObj;

    Classes()
        : cls(crask_registerClass("SomeClass")), clsObj(crask_getClassObject(cls)) { }

    void TearDown() {
        crask_reset();
    }
};

TEST_F(Classes, getClass_should_return_nil_for_unknown_class_name) {
    ASSERT_TRUE(CRASK_CLASS_NIL == crask_getClass("dummy"));
}

TEST_F(Classes, getClass_should_return_a_class_registered_with_registerClass) {
    CRASK_CLASS a = crask_registerClass("AClass");
    CRASK_CLASS b = crask_registerClass("BClass");
    ASSERT_TRUE(a != CRASK_CLASS_NIL);
    ASSERT_TRUE(b != CRASK_CLASS_NIL);
    ASSERT_TRUE(a == crask_getClass("AClass"));
    ASSERT_TRUE(b == crask_getClass("BClass"));
}

CRASK_OBJECT dummyClassMethod1(CRASK_OBJECT, ...) {
    return CRASK_NIL;
}

CRASK_OBJECT dummyClassMethod2(CRASK_OBJECT, ...) {
    return CRASK_NIL;
}

TEST_F(Classes, getMethodImplForObject_for_class_should_return_added_class_methods) {
    CRASK_METHOD method1 = crask_registerMethod("dummyClassMethod1");
    CRASK_METHOD method2 = crask_registerMethod("dummyClassMethod2");
    crask_addClassMethodToClass(method1, dummyClassMethod1, cls);
    crask_addClassMethodToClass(method2, dummyClassMethod2, cls);

    CRASK_METHOD_IMPL methodImpl1 = crask_getMethodImplForObject(method1, clsObj);
    ASSERT_TRUE(methodImpl1 == dummyClassMethod1);
    CRASK_METHOD_IMPL methodImpl2 = crask_getMethodImplForObject(method2, clsObj);
    ASSERT_TRUE(methodImpl2 == dummyClassMethod2);
}
