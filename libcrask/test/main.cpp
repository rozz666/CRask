#include <gmock/gmock.h>
#include <ctime>

int main(int argc, char **argv) {
    testing::InitGoogleMock(&argc, argv);
    return RUN_ALL_TESTS();
}