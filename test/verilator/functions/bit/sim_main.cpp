#include "VTbTop.h"
#include "helper/verilator_tick.h"

//#include <random>
//#include <bit>

static void set_inputs(VTbTop& top)
{
#if 0
    static std::default_random_engine rand_engine;
    static std::uniform_int_distribution<uint64_t> random;

    uint64_t input = random(rand_engine) % 32;

    top.in = 1 << input;
    top.en = 1;
#endif
}


static bool check_outputs(const VTbTop& top)
{
#if 0
    uint64_t input = top.in & 0xffff'ffff;
    uint64_t expected = __builtin_ctz(input); // std::countr_zero(input);
    //printf("Encoded in:%" PRIx64 " out:%" PRIx16  " expected:%" PRIx64"\n",
    //    input, top.out, expected);
    if (top.out != expected) {
        printf("Encoded in:%" PRIx64 " out:%" PRIx16  " expected:%" PRIx64"\n",
            input, top.out, expected);
        return false;
    }
#endif
    return true;
}


int main(int argc, char* argv[])
{
    printf("\n\nTest Bit Functions\n");

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
