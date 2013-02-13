Feature: Class instantiation

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
                    nil
                }
            }
            """
        When I translate "classInstantiation.rask" to C into "classInstantiation.c"
        Then file "classInstantiation.c" should contain:
            """
            CRASK_OBJECT M_B_m(CRASK_OBJECT self, ...) {
                CRASK_OBJECT L_instance;
                L_instance = crask_getMethodImplForObject("new", crask_getClassObject(C_A))(crask_getClassObject(C_A));
                return L_instance;
            }
            """
        And file "classInstantiation.c" should compile
