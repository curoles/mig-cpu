

#include "VTbTop.h"
#include "helper/verilator_tick.h"

#include <random>


static void set_inputs(VTbTop& top)
{
    static std::default_random_engine rand_engine;
    static std::uniform_int_distribution<uint64_t> random;

    uint64_t input = random(rand_engine);

    top.in = input & 0xf;
    top.en = 1;
}


static bool check_outputs(const VTbTop& top)
{
    uint64_t input = top.in & 0xf;
    uint64_t expected = 1 << input;
    //printf("Decoded in:%" PRIx64 " out:%" PRIx16  " expected:%" PRIx64"\n",
    //    input, top.out, expected);
    if (top.out != expected) {
        return false;
    }
    return true;
}


int main(int argc, char* argv[])
{
    printf("\n\nTest Decoder\n");

    Verilated::commandArgs(argc, argv);

    // Top TB module instantiation
    VTbTop top;

    Tick tick(top);

    for (unsigned int i = 0; i < 100; i++)
    {
        set_inputs(top);
        tick();

        if (!check_outputs(top))
        {
            printf("Fail\n");
            return 1;
        }
    }

    return 0;
}
