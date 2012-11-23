@wip
Feature: Class definitions

    @wip
    Scenario: An empty class definition
        Given a file named "someClass.rask" with:
            """
            class SomeClass {
            }
            """
        When I translate "someClass.rask" to C into "someClass.c"
        Then file "someClass.c" should contain:
            """
            int main() {
                CRASK_CLASS class_SomeClass = crask_registerClass("SomeClass");
            }
            
            """

    @wip
    Scenario: A class with methods
        Given a file named "classWithMethods.rask" with:
            """
            class ClassWithMethods {
                def foo
                end
                def bar
                end
            }
            """
        When I translate "classWithMethods.rask" to C into "classWithMethods.c"
        Then file "classWithMethods.c" should contain:
            """
            CRASK_OBJECT class_ClassWithMethods_method_foo() {
            }
            CRASK_OBJECT class_ClassWithMethods_method_bar() {
            }
            int main() {
                CRASK_CLASS class_ClassWithMethods = crask_registerClass("ClassWithMethods");
                crask_addMethodToClass(&class_ClassWithMethods_method_foo, "foo", class_ClassWithMethods);
                crask_addMethodToClass(&class_ClassWithMethods_method_bar, "bar", class_ClassWithMethods);
            }
            
            """

