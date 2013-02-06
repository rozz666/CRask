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
    @done
    Scenario: Default destructor
        Given source code:
            """
            class Foo {
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
            void class_Foo_class_dtor(CRASK_OBJECT self) {
            }
            """
        And generated C code should contain:
            """
            crask_addDestructorToClass(&class_Foo_class_dtor, C_Foo);
            """
        And generated C code should compile
    @done
    Scenario: A class with destructor
        Given source code:
            """
            class ClassWithDtor {
                dtor {
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
            void class_ClassWithDtor_class_dtor(CRASK_OBJECT self) {
            }
            """
        And generated C code should contain:
            """
            crask_addDestructorToClass(&class_ClassWithDtor_class_dtor, C_ClassWithDtor);
            """
        And generated C code should compile
    @done
    Scenario: A class with constructor
        Given source code:
            """
            class A {
                ctor new {
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
            CRASK_OBJECT class_A_class_ctor_new(CRASK_OBJECT classSelf, ...) {
                CRASK_OBJECT self = crask_createInstance(C_A);
                return self;
            }
            """
        And generated C code should contain:
            """
            crask_addClassMethodToClass(&class_A_class_ctor_new, "new", C_A);
            """
        And generated C code should compile

    Scenario: A class with constructor with arguments
        Given source code:
            """
            class A {
                ctor foo(bar, baz) {
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
            void class_A_class_ctor_foo(CRASK_OBJECT classSelf, ...) {
                CRASK_OBJECT local_bar, local_baz;
                va_list rask_args;
                va_start(rask_args, classSelf);
                local_bar = va_arg(rask_args, CRASK_OBJECT);
                local_baz = va_arg(rask_args, CRASK_OBJECT);
                va_end(rask_args);
                CRASK_OBJECT self = crask_createInstance(C_A);
                return self;
            }
            """
        And generated C code should contain:
            """
            crask_addClassMethodToClass(&class_A_class_ctor_foo, "foo:bar,baz", C_A);
            """
        And generated C code should compile
    