Feature: Local variables
    @done
    Scenario: Creating new local variables by nil assignment
        Given source code:
            """
            class A {
                def m {
                    foo = nil
                    bar = nil
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
            CRASK_OBJECT M_A_m(CRASK_OBJECT self, ...) {
                CRASK_OBJECT L_foo, L_bar;
                L_foo = CRASK_NIL;
                crask_retain(L_foo);
                L_bar = CRASK_NIL;
                crask_retain(L_bar);
                crask_release(L_bar);
                crask_release(L_foo);
                return CRASK_NIL;
            }
            """
        And generated C code should compile
    @done
    Scenario: Repeated assignment 
        Given source code:
            """
            class A {
                def m {
                    foo = nil
                    foo = nil
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
            CRASK_OBJECT M_A_m(CRASK_OBJECT self, ...) {
                CRASK_OBJECT L_foo;
                L_foo = CRASK_NIL;
                crask_retain(L_foo);
                crask_release(L_foo);
                L_foo = CRASK_NIL;
                crask_retain(L_foo);
                crask_release(L_foo);
                return CRASK_NIL;
            }
            """
        And generated C code should compile
    @done
    Scenario: Assignment from arguments
        Given source code:
            """
            class A {
                def m(arg) {
                    foo = arg
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
                crask_retain(L_arg);
                L_foo = L_arg;
                crask_retain(L_foo);
                crask_release(L_foo);
                crask_release(L_arg);
                return CRASK_NIL;
            }
            """
        And generated C code should compile
    @done
    Scenario: Repeated assignment from arguments
        Given source code:
            """
            class A {
                def m(arg1, arg2) {
                    foo = arg1
                    foo = arg2
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
                CRASK_OBJECT L_arg1, L_arg2, L_foo;
            """
        And generated C code should contain:
            """
                crask_retain(L_arg1);
                crask_retain(L_arg2);
                L_foo = L_arg1;
                crask_retain(L_foo);
                crask_release(L_foo);
                L_foo = L_arg2;
                crask_retain(L_foo);
                crask_release(L_foo);
                crask_release(L_arg2);
                crask_release(L_arg1);
                return CRASK_NIL;
            }
            """
        And generated C code should compile
    @done
    Scenario: Argument assignment
        Given source code:
            """
            class A {
                def m(arg) {
                    arg = nil
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
                crask_retain(L_arg);
                crask_release(L_arg);
                L_arg = CRASK_NIL;
                crask_retain(L_arg);
                crask_release(L_arg);
                return CRASK_NIL;
            """
    