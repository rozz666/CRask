Feature: Class constructors
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
            CRASK_OBJECT CT_A_new(CRASK_OBJECT classSelf, ...) {
                CRASK_OBJECT self = crask_createInstance(C_A);
                return self;
            }
            """
        And generated C code should contain:
            """
            crask_addClassMethodToClass(&CT_A_new, "new", C_A);
            """
        And generated C code should compile
    @done
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
            CRASK_OBJECT CT_A_foo_bar_baz(CRASK_OBJECT classSelf, ...) {
                CRASK_OBJECT L_bar, L_baz;
                va_list rask_args;
                va_start(rask_args, classSelf);
                L_bar = va_arg(rask_args, CRASK_OBJECT);
                L_baz = va_arg(rask_args, CRASK_OBJECT);
                va_end(rask_args);
                CRASK_OBJECT self = crask_createInstance(C_A);
                return self;
            }
            """
        And generated C code should contain:
            """
            crask_addClassMethodToClass(&CT_A_foo_bar_baz, "foo:bar,baz", C_A);
            """
        And generated C code should compile
    @done
    Scenario: Constructor name based on sorted argument names
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
            CRASK_OBJECT CT_A_bla_a_b_c_d(CRASK_OBJECT classSelf, ...)
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
            crask_addClassMethodToClass(&CT_A_bla_a_b_c_d, "bla:a,b,c,d", C_A);
            """
        And generated C code should compile
