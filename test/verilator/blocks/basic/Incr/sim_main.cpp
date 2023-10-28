/* Fast Incrementor C TB.
 * Author: Igor Lesik 2019-2023
 *
 */
#include <cassert>
#include <cstdio>
#include <cstdint>
#include <limits>

#include "VTbTop.h"
#include "helper/verilator_tick.h"


static bool test_incr4_eq5(VTbTop& top)
{
    printf("%lu: Testing 4+1==5...\n", sim_time());

    top.in = 4;

    sim_tick(top);

    if (top.out9 != 5 or top.cy9 != 0) {
        return false;
    }

    return true;
}

static bool test_incr_all1_eq0(VTbTop& top)
{
    printf("%lu: Testing All1+1==0...\n", sim_time());

    top.in = 0b111'111'111;

    sim_tick(top);

    if (top.out9 != 0 or top.cy9 != 1) {
        return false;
    }

    return true;
}

static bool test_random(VTbTop& top, uint32_t iter_id)
{
    if (0 == (iter_id % 10'000))
        printf("\rTesting random %u", iter_id);

    uint32_t a = std::rand();
    uint32_t a9 = a & 0x1FF;
    uint32_t a16 = a & 0xFFFF;

    top.in = a;

    sim_tick(top);

    bool match9 = (top.out9 == (a9 + 1) and top.cy9 == 0) or
                  (top.out9 == 0 and top.cy9);

    if (!match9) {
        printf("\nError: %u + 1 = %u, carry-out=%u\n", a9, top.out9, top.cy9);
        printf("0x%x + 1 = 0x%x\n", a9, top.out9);
        print_bin32(a9); printf(" <- a\n");
        print_bin32(top.out9); printf(" <- result of a + 1\n");
        return false;
    }

    bool match16 = (top.out16 == (a16 + 1) and top.cy16 == 0) or
                   (top.out16 == 0 and top.cy16);

    if (!match16) {
        printf("\nError: %u + 1 = %u, carry-out=%u\n", a16, top.out16, top.cy16);
        printf("0x%x + 1 = 0x%x\n", a16, top.out16);
        print_bin32(a16); printf(" <- a\n");
        print_bin32(top.out16); printf(" <- result of a + 1\n");
        return false;
    }

    return true;
}

int main(int argc, char* argv[])
{
    printf("\n\nTest Fast Incrementor\n");

    Verilated::commandArgs(argc, argv);

    // Top TB module instantiation
    VTbTop top;

    using TestFunc = bool (*)(VTbTop&);

    TestFunc tests[] = {
        test_incr4_eq5, test_incr_all1_eq0
    };

    for (auto test : tests)
    {
        if (!test(top)) {
            printf("FAIL\n");
            return 1;
        }

        if (Verilated::gotFinish()) {
            printf("SIM ERROR\n");
            return 1;
        }
    }

    static constexpr uint32_t MAX_RANDOM_TESTS = 10'000'001u;

    for (uint32_t i = 0; i < MAX_RANDOM_TESTS and !Verilated::gotFinish(); ++i)
    {
        if (!test_random(top, i)) {
            printf("\nFAIL\n");
            return 1;
        }

    }

    printf("\n\nDone\n");

    return 0;
}
