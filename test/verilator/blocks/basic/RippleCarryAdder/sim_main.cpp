/* Ripple Carry Adder C TB.
 *
 * Author: Igor Lesik 2020
 *
 */
#include <cassert>
#include <cstdio>
#include <cstdint>
#include <limits>
#include <random>

#include "VTbTop.h"
#include "helper/verilator_tick.h"

static void set_inputs(VTbTop& top)
{
    static std::default_random_engine rand_engine;
    static std::uniform_int_distribution<uint64_t> random;

    top.in1 = random(rand_engine);
    top.in2 = random(rand_engine);
}

static bool check_outputs(const VTbTop& top)
{
    uint64_t sum = top.in1 + top.in2;

    //printf("HW %" PRIx64 " vs correct %" PRIx64 "\n", top.sum, sum);

    if (top.sum != sum) {
        printf("HW %" PRIx64 " vs correct %" PRIx64 "\n", top.sum, sum);
        return false;
    }

    if (top.sum_aoi != sum) {
        printf("HW %" PRIx64 " vs correct %" PRIx64 "\n", top.sum_aoi, sum);
        return false;
    }

    return true;
}

int main(int argc, char* argv[])
{
    printf("\n\nTest Ripple Carry Adder\n");

    Verilated::commandArgs(argc, argv);

    // Top TB module instantiation
    VTbTop top;

    top.ci = 0;

    Tick tick(top);

    for (unsigned int i = 0; i < 100; ++i)
    {
        set_inputs(top);
        tick();
        if (!check_outputs(top)) {
            printf("\n\nFAIL i:%u\n", i);
            return 1;
        }
    }

    printf("\n\nSUCCESS\n");

    return 0;
}
