#include <crask.h>
#include <gtest/gtest.h>

void crask_reset();

struct Classes : testing::Test {
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