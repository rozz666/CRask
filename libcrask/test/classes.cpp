#include <crask.h>
#include <gtest/gtest.h>

void crask_reset();

struct Classes : testing::Test {

    CRASK_CLASS cls;
    CRASK_OBJECT clsObj;
    CRASK_OBJECT object;

    Classes()
        : cls(crask_registerClass("SomeClass")), clsObj(crask_getClassObject(cls)),
        object(crask_createInstance(cls)) { }
       
    void TearDown() {
        crask_release(object);
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

TEST_F(Classes, registerClass_should_return_existing_class) {
    CRASK_CLASS cls1 = crask_registerClass("abc");
    CRASK_CLASS cls2 = crask_registerClass("abc");
    ASSERT_TRUE(cls1 == cls2);
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
    crask_addClassMethodToClass(dummyClassMethod1, "dummyClassMethod1", cls);
    crask_addClassMethodToClass(dummyClassMethod2, "dummyClassMethod2", cls);

    CRASK_METHOD_IMPL methodImpl1 = crask_getMethodImplForObject(method1, clsObj);
    ASSERT_TRUE(methodImpl1 == dummyClassMethod1);
    CRASK_METHOD_IMPL methodImpl2 = crask_getMethodImplForObject(method2, clsObj);
    ASSERT_TRUE(methodImpl2 == dummyClassMethod2);
}

TEST_F(Classes, registerMethod_should_return_existing_method) {
    CRASK_METHOD method1 = crask_registerMethod("abc");
    CRASK_METHOD method2 = crask_registerMethod("abc");
    ASSERT_TRUE(method1 == method2);
}

TEST_F(Classes, createInstance_should_return_a_new_instance) {
    CRASK_OBJECT inst1 = crask_createInstance(cls);
    CRASK_OBJECT inst2 = crask_createInstance(cls);
    ASSERT_TRUE(inst1 != inst2);
    crask_release(inst1);
    crask_release(inst2);
}

TEST_F(Classes, retain_should_increase_number_of_releases_needed_to_delete_an_object) {
    CRASK_OBJECT instance = crask_createInstance(cls);
    crask_retain(instance);
    crask_retain(instance);
    crask_release(instance);
    crask_release(instance);
    crask_release(instance);
}

CRASK_OBJECT dummyMethod1(CRASK_OBJECT, ...) {
    return CRASK_NIL;
}

CRASK_OBJECT dummyMethod2(CRASK_OBJECT, ...) {
    return CRASK_NIL;
}

TEST_F(Classes, getMethodImplForObject_for_class_should_return_NULL_for_unknown_methods) {
    CRASK_METHOD method1 = crask_registerMethod("dummyMethod1");
    ASSERT_TRUE(crask_getMethodImplForObject(method1, object) == 0);
}

TEST_F(Classes, getMethodImplForObject_should_return_added_object_methods) {
    CRASK_METHOD method1 = crask_registerMethod("dummyMethod1");
    CRASK_METHOD method2 = crask_registerMethod("dummyMethod2");
    crask_addMethodToClass(dummyMethod1, "dummyMethod1", cls);
    crask_addMethodToClass(dummyMethod2, "dummyMethod2", cls);

    CRASK_METHOD_IMPL methodImpl1 = crask_getMethodImplForObject(method1, object);
    ASSERT_TRUE(methodImpl1 == dummyMethod1);
    CRASK_METHOD_IMPL methodImpl2 = crask_getMethodImplForObject(method2, object);
    ASSERT_TRUE(methodImpl2 == dummyMethod2);
}

TEST_F(Classes, classMethods_are_separate_from_methods) {
    CRASK_METHOD method1 = crask_registerMethod("dummyMethod1");
    crask_addClassMethodToClass(dummyClassMethod1, "dummyMethod1", cls);
    crask_addMethodToClass(dummyMethod1, "dummyMethod1", cls);

    ASSERT_TRUE(crask_getMethodImplForObject(method1, clsObj) == dummyClassMethod1);
    ASSERT_TRUE(crask_getMethodImplForObject(method1, object) == dummyMethod1);
}

TEST_F(Classes, getObjectClass_should_return_class_of_an_object) {
    ASSERT_TRUE(crask_getObjectClassObject(object) == clsObj);
}

TEST_F(Classes, metaclasses_should_have_no_class_objects) {
    ASSERT_TRUE(crask_getObjectClassObject(clsObj) == CRASK_NIL);
}

TEST_F(Classes, getVariableFromObject_should_return_NULL_when_variables_does_not_exist)
{
    ASSERT_TRUE(crask_getVariableFromObject("dummy", object) == 0);
}

TEST_F(Classes, getVariableFromObject_should_return_added_variables) {
    CRASK_OBJECT *var1 = crask_addVariableToObject("abc", object);
    CRASK_OBJECT *var2 = crask_addVariableToObject("def", object);

    ASSERT_TRUE(var1 != 0);
    ASSERT_TRUE(var2 != 0);
    ASSERT_TRUE(crask_getVariableFromObject("abc", object) == var1);
    ASSERT_TRUE(crask_getVariableFromObject("def", object) == var2);
}

TEST_F(Classes, variable_should_be_initialized_to_nil) {
    CRASK_OBJECT *var = crask_addVariableToObject("dummy", object);
    
    ASSERT_TRUE(*var == CRASK_NIL);
}

TEST_F(Classes, addVariableToObject_should_return_existing_variable) {
    ASSERT_TRUE(crask_addVariableToObject("x", object) == crask_addVariableToObject("x", object));
}

TEST_F(Classes, object_should_provide_storage_for_one_pointer) {
    int dummy;
    void *ptr = &dummy;
    crask_setObjectData(object, ptr);
    ASSERT_TRUE(crask_getObjectData(object) == ptr);
}

TEST_F(Classes, object_storage_should_be_initialized_with_NULL) {
    ASSERT_TRUE(crask_getObjectData(object) == 0);
}