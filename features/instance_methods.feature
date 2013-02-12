Feature: Instance methods

    @done
    Scenario: A class with an empty method
        Given source code:
            """
            class ClassWithMethod {
                def foo {
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
            CRASK_OBJECT M_ClassWithMethod_foo(CRASK_OBJECT self, ...) {
                return CRASK_NIL;
            }
            """
        And generated C code should contain:
            """
            crask_addMethodToClass(&M_ClassWithMethod_foo, "foo", C_ClassWithMethod);
            """
        And generated C code should compile

    @wip
    Scenario: A class with a method with arguments
        Given source code:
            """
            class X {
                def bar(first, second, third) {
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
            CRASK_OBJECT M_X_bar_first_second_third(CRASK_OBJECT self, ...) {
                CRASK_OBJECT L_first, L_second, L_third;
                va_list rask_args;
                va_start(rask_args, classSelf);
                L_first = va_arg(rask_args, CRASK_OBJECT);
                L_second = va_arg(rask_args, CRASK_OBJECT);
                L_third = va_arg(rask_args, CRASK_OBJECT);
                va_end(rask_args);
                return CRASK_NIL;
            }
            """
        And generated C code should contain lines:
            """
            crask_addMethodToClass(&M_X_bar_first_second_third, "bar:first,second,third", C_X);
            """
        And generated C code should compile

    Scenario: Method name based on sorted argument names
        Given source code:
            """
            class A {
                ctor bla(d, b, a, c) {
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
            CRASK_OBJECT M_A_bla_a_b_c_d(CRASK_OBJECT classSelf, ...)
            """
        And generated C code should contain:
            """
                L_d = va_arg(rask_args, CRASK_OBJECT);
                L_b = va_arg(rask_args, CRASK_OBJECT);
                L_a = va_arg(rask_args, CRASK_OBJECT);
                L_c = va_arg(rask_args, CRASK_OBJECT);
            """
        And generated C code should contain:
            """
            crask_addMethodToClass(&M_A_bla_a_b_c_d, "bla:a,b,c,d", C_A);
            """
        And generated C code should compile

    @wip
    Scenario: A class with multiple methods
        Given source code:
            """
            class Z {
                def foo(x) {
                }
                def bar(y) {
                }
            }
            """
        When I translate it to C
        Then generated C code should contain lines:
            """
            CRASK_OBJECT M_Z_foo_x(CRASK_OBJECT self, ...)
            CRASK_OBJECT M_Z_bar_y(CRASK_OBJECT self, ...)
            crask_addMethodToClass(&M_Z_foo_x, "foo:x", C_Z);
            crask_addMethodToClass(&M_Z_bar_y, "bar:y", C_Z);
            """
        And generated C code should compile
