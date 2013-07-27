Feature: Method call
    @wip
    Scenario: Method call with no arguments
        Given method body:
            """
            object = nil
            object.aMethod
            """
        When I translate it to C
        Then generated C code should contain:
            """
            crask_release(crask_getMethodImplForObject("aMethod", L_object)(L_object));
            """
        And generated C code should compile
