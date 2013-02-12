Feature: Class definitions
    @done
    Scenario: Empty class definitions
        Given source code:
            """
            class SomeClass {
            }
            class AnotherClass {
            }
            """
        When I translate it to C
        Then generated C code should contain lines:
            """
            CRASK_CLASS C_SomeClass;
            C_SomeClass = crask_registerClass("SomeClass");
            CRASK_CLASS C_AnotherClass;
            C_AnotherClass = crask_registerClass("AnotherClass");
            """
        And generated C code should compile
