Feature: Class instantiation

    Scenario: Class instantiation with no arguments
        Given a file named "classInstantiation.rask" with:
            """
            [SomeClass new]
            """
        When I translate "classInstantiation.rask" to C into "classInstantiation.c"
        Then file "classInstantiation.c" should contain:
            """
            int main() {
                crask_sendMessageToClass(crask_getMethod("new"), crask_getClass("SomeClass"));
            }
            
            """
        And file "classInstantiation.c" should compile
