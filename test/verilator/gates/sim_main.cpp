/* Standard Gates Verilator C TB.
 *
 * Author: Igor Lesik 2020-2023
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
    top.in3 = random(rand_engine);
}

static bool check_outputs(const VTbTop& top)
{
    if (top.out_inv != ~top.in1) return false;

    if (top.out_and2 != (top.in1 & top.in2)) {
        printf("And2: %" PRIx64 " != %" PRIx64 "\n", top.out_and2, (top.in1 & top.in2));
        return false;
    }

    if (top.out_nand2 != ~(top.in1 & top.in2)) {
        printf("Nand2: %" PRIx64 " != %" PRIx64 "\n", top.out_nand2, ~(top.in1 & top.in2));
        return false;
    }

    if (top.out_nor2 != ~(top.in1 | top.in2)) {
        printf("Nor2: %" PRIx64 " != %" PRIx64 "\n", top.out_nor2, ~(top.in1 | top.in2));
        return false;
    }

    if (uint64_t mux2 = (top.in3 & 0b1)? top.in2 : top.in1; top.out_mux2 != mux2) {
        return false;
    }

    if (top.out_maj3 != ((top.in1 & top.in2) | (top.in1 & top.in3) | (top.in2 & top.in3))) {
        printf("Maj3: %" PRIx64 " != %" PRIx64 "\n", top.out_maj3,
        (top.in1 & top.in2) | (top.in1 & top.in3) | (top.in2 & top.in3));
        return false;
    }

    return true;
}

int main(int argc, char* argv[])
{
    printf("\n\nTest Basic Gates\n");

    Verilated::commandArgs(argc, argv);

    // Top TB module instantiation
    VTbTop top;

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
