Feature: Class instantiation
    @done
    Scenario: Class instantiation with no arguments
        Given source code:
            """
            class A {
                ctor new {
                }
            }
            
            class B {
                def m {
                    instance = A.new
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
            CRASK_OBJECT M_B_m(CRASK_OBJECT self, ...) {
                CRASK_OBJECT L_instance;
                L_instance = crask_getMethodImplForObject("new", crask_getClassObject(C_A))(crask_getClassObject(C_A));
                crask_release(L_instance);
                return CRASK_NIL;
            }
            """
        And generated C code should compile
