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
                CRASK_OBJECT local_aVariable = CRASK_NIL;
            }
            
            """

