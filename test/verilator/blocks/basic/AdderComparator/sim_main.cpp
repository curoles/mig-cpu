#include "VTbTop.h"
#include "helper/verilator_tick.h"

#include <random>

constexpr uint64_t MASK = (1LU << 50) - 1;

static void set_inputs(VTbTop& top)
{
    static std::default_random_engine rand_engine;
    static std::uniform_int_distribution<uint64_t> random;

    uint64_t a = random(rand_engine) & MASK;
    uint64_t b = random(rand_engine) & MASK;
    uint64_t c = (a + b + (a & 1)) & MASK;

    top.a = a;
    top.b = b;
    top.c = c;
}


static bool check_outputs(const VTbTop& top)
{
    uint8_t expected_eq = ((top.a + top.b) & MASK) == top.c;
    //printf("a:%016" PRIx64 " + b:%016" PRIx64  " ==? c:%016" PRIx64", eq=%u vs expected_eq=%u\n",
    //    top.a, top.b, top.c, top.eq, expected_eq);
    if (top.eq != expected_eq) {
        return false;
    }
    return true;
}


int main(int argc, char* argv[])
{
    printf("\n\nTest AdderComparator\n");

    Verilated::commandArgs(argc, argv);

    // Top TB module instantiation
    VTbTop top;

    Tick tick(top);

    for (unsigned int i = 0; i < 1000; i++)
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
