Feature: Empty source

    @done
    Scenario: Empty input
        Given source code:
        """
        """
        When I translate it to C
        Then generated C code should contain:
            """
            #include <crask.h>
            """
        And generated C code should contain:
            """
            int main() {
            }
            
            """
        And generated C code should compile