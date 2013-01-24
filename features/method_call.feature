Feature: Method call

    Scenario: Method call with no arguments
        Given a file named "methodCall.rask" with:
            """
            object = nil
            [object aMethod]
            """
        When I translate "methodCall.rask" to C into "methodCall.c"
        Then file "methodCall.c" should contain:
            """
            int main() {
                CRASK_OBJECT local_object = CRASK_NIL
                crask_sendMessageToObject(crask_getMethod("aMethod"), object);
            }
            
            """
        And file "methodCall.c" should compile
