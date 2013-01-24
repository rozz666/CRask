@wip
Feature: Local variables

    @wip
    Scenario: Creating a new local variable by assignment
        Given a file named "local.rask" with:
            """
            aVariable = nil
            """
        When I translate "local.rask" to C into "local.c"
        Then file "local.c" should contain:
            """
            int main() {
                CRASK_OBJECT local_aVariable;
                local_aVariable = CRASK_NIL;
            }
            """
        And file "local.c" should compile

    @wip
    Scenario: Creating a local variable in a method
        Given a file named "local_in_method.rask" with:
            """
            class C {
                def m {
                    a = nil
                }
            }
            """
        When I translate "local_in_method.rask" to C into "local_in_method.c"
        Then file "local_in_method.c" should contain:
            """
            CRASK_OBJECT class_C_method_m(CRASK_OBJECT self, ...) {
                CRASK_OBJECT local_a;
                local_a = CRASK_NIL;
                return CRASK_NIL;
            }
            """
        And file "local_in_method.c" should compile
