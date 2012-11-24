Feature: Empty source

    Scenario: Empty input
        Given an empty file named "empty.rask"
        When I translate "empty.rask" to C into "empty.c"
        Then file "empty.c" should contain:
            """
            #include <crask.h>
            int main() {
            }
            
            """
        And file "empty.c" should compile
