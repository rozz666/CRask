Feature: Class definitions
    @done
    Scenario: Empty class definitions
        Given source code:
            """
            class SomeClass {
            }
            class AnotherClass {
            }
            """
        When I translate it to C
        Then generated C code should contain lines:
            """
            CRASK_CLASS C_SomeClass;
            C_SomeClass = crask_registerClass("SomeClass");
            CRASK_CLASS C_AnotherClass;
            C_AnotherClass = crask_registerClass("AnotherClass");
            """
        And generated C code should compile
    @done
    Scenario: A class with methods
        Given source code:
            """
            class ClassWithMethods {
                def foo {
                }
                def bar {
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
            CRASK_OBJECT M_ClassWithMethods_foo(CRASK_OBJECT self, ...) {
                return CRASK_NIL;
            }
            """
        And generated C code should contain:
            """
            CRASK_OBJECT M_ClassWithMethods_bar(CRASK_OBJECT self, ...) {
                return CRASK_NIL;
            }
            """
        And generated C code should contain:
            """
            crask_addMethodToClass(&M_ClassWithMethods_foo, "foo", C_ClassWithMethods);
            """
        And generated C code should contain:
            """
            crask_addMethodToClass(&M_ClassWithMethods_bar, "bar", C_ClassWithMethods);
            """
        And generated C code should compile
    @wip
    Scenario: A class with a method with arguments
        Given source code:
            """
            class X {
                def foo(one) {
                }
                def bar(first, second, third) {
                }
                def baz(z_last, m_middle, a_first) {
                }
            }
            """
        When I translate it to C
        Then generated C code should contain lines:
            """
            CRASK_OBJECT M_X_foo_one(CRASK_OBJECT self, ...)
            CRASK_OBJECT M_X_bar_first_second_third(CRASK_OBJECT self, ...)
            CRASK_OBJECT M_X_baz_a__first_m__middle_z__last(CRASK_OBJECT self, ...)
            """
        And generated C code should contain lines:
            """
            crask_addMethodToClass(&M_X_foo_one, "foo:one", C_X);
            crask_addMethodToClass(&M_X_bar_first_second_third, "bar:first,second,third", C_X);
            crask_addMethodToClass(&M_X_baz_a__first_m__middle_z__last, "baz:a_first,m_middle,z_last", C_X);
            """
        And generated C code should compile
    