Feature: Class definitions
    Scenario: Empty class definitions
        Given a file named "someClass.rask" with:
            """
            class SomeClass {
            }
            class AnotherClass {
            }
            """
        When I translate "someClass.rask" to C into "someClass.c"
        Then file "someClass.c" should contain:
            """
            CRASK_CLASS class_SomeClass = crask_registerClass("SomeClass");
            """
        And file "someClass.c" should contain:
            """
            CRASK_CLASS class_AnotherClass = crask_registerClass("AnotherClass");
            """
        And file "someClass.c" should compile
    Scenario: A class with methods
        Given a file named "classWithMethods.rask" with:
            """
            class ClassWithMethods {
                def foo {
                }
                def bar {
                }
            }
            """
        When I translate "classWithMethods.rask" to C into "classWithMethods.c"
        Then file "classWithMethods.c" should contain:
            """
            CRASK_OBJECT class_ClassWithMethods_method_foo(CRASK_OBJECT self, ...) {
                return CRASK_NIL;
            }
            """
        And file "classWithMethods.c" should contain:
            """
            CRASK_OBJECT class_ClassWithMethods_method_bar(CRASK_OBJECT self, ...) {
                return CRASK_NIL;
            }
            """
        And file "classWithMethods.c" should contain:
            """
            crask_addMethodToClass(&class_ClassWithMethods_method_foo, "foo", class_ClassWithMethods);
            """
        And file "classWithMethods.c" should contain:
            """
            crask_addMethodToClass(&class_ClassWithMethods_method_bar, "bar", class_ClassWithMethods);
            """
        And file "classWithMethods.c" should compile
