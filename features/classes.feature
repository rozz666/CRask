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
            CRASK_CLASS class_SomeClass;
            class_SomeClass = crask_registerClass("SomeClass");
            CRASK_CLASS class_AnotherClass;
            class_AnotherClass = crask_registerClass("AnotherClass");
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
            CRASK_OBJECT class_ClassWithMethods_class_method_foo(CRASK_OBJECT self, ...) {
                return CRASK_NIL;
            }
            """
        And generated C code should contain:
            """
            CRASK_OBJECT class_ClassWithMethods_class_method_bar(CRASK_OBJECT self, ...) {
                return CRASK_NIL;
            }
            """
        And generated C code should contain:
            """
            crask_addMethodToClass(&class_ClassWithMethods_class_method_foo, "foo", class_ClassWithMethods);
            """
        And generated C code should contain:
            """
            crask_addMethodToClass(&class_ClassWithMethods_class_method_bar, "bar", class_ClassWithMethods);
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
            CRASK_OBJECT class_X_method_foo_arg_one(CRASK_OBJECT self, ...)
            CRASK_OBJECT class_X_method_bar_arg_first_arg_second_arg_third(CRASK_OBJECT self, ...)
            CRASK_OBJECT class_X_method_baz_arg_a_first_arg_m_middle_arg_z_last(CRASK_OBJECT self, ...)
            """
        And generated C code should contain lines:
            """
            crask_addMethodToClass(&class_X_method_foo_arg_one, "foo:one", class_X);
            crask_addMethodToClass(&class_X_method_bar_arg_first_arg_second_arg_third, "bar:first,second,third", class_X);
            crask_addMethodToClass(&class_X_method_baz_arg_a_first_arg_m_middle_arg_z_last, "baz:a_first,m_middle,z_last", class_X);
            """
        And generated C code should compile
    
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
            void class_ClassWithDtor(CRASK_OBJECT self) {
            }
            """
        And generated C code should contain:
            """
            crask_addDestructorToClass(&class_ClassWithDtor, class_ClassWithDtor);
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
                CRASK_OBJECT self = crask_createInstance(class_A);
                return self;
            }
            """
        And generated C code should contain:
            """
            crask_addClassMethodToClass(&class_A_class_ctor_new, "new", class_A);
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
                CRASK_OBJECT self = crask_createInstance(class_A);
                return self;
            }
            """
        And generated C code should contain:
            """
            crask_addClassMethodToClass(&class_A_class_ctor_foo, "foo:bar,baz", class_A);
            """
        And generated C code should compile
    