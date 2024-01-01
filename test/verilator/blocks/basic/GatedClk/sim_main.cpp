#include "VTbTop.h"
#include "helper/verilator_tick.h"


static void set_inputs(VTbTop& top, unsigned int i)
{
    top.enable = ((i / 10) % 2) & 1;
}


static bool check_outputs(const VTbTop& top, unsigned int i)
{
    //printf("i:%u en:%u clk:%u gclkL:%u gclkH:%u\n",
    //    i, top.enable, top.clk, top.gclk_lo, top.gclk_hi);
    if (top.enable) {
        if (top.gclk_lo != 1 || top.gclk_hi != 1)
            return false;
    }
    else {
        if (top.gclk_lo != 0 || top.gclk_hi != 1)
            return false;
    }
    return true;
}


int main(int argc, char* argv[])
{
    printf("\n\nTest GatedClk\n");

    Verilated::commandArgs(argc, argv);

    // Top TB module instantiation
    VTbTop top;

    Tick tick(top);

    for (unsigned int i = 0; i < 100; i++)
    {
        set_inputs(top, i);
        tick();

        if (!check_outputs(top, i))
        {
            printf("Fail\n");
            return 1;
        }
    }

    return 0;
}
