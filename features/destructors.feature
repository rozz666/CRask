Feature: Class destructors
    @done
    Scenario: Default destructor
        Given source code:
            """
            class Foo {
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
            void DT_Foo(CRASK_OBJECT self) {
            }
            """
        And generated C code should contain:
            """
            crask_addDestructorToClass(&DT_Foo, C_Foo);
            """
        And generated C code should compile
    @done
    Scenario: A class with destructor
        Given source code:
            """
            class ClassWithDtor {
                dtor {
                }
            }
            """
        When I translate it to C
        Then generated C code should contain:
            """
            void DT_ClassWithDtor(CRASK_OBJECT self) {
            }
            """
        And generated C code should contain:
            """
            crask_addDestructorToClass(&DT_ClassWithDtor, C_ClassWithDtor);
            """
        And generated C code should compile
