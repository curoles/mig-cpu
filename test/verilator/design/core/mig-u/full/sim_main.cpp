/* MigU CPU C TB.
 *
 * Author: Igor Lesik 2020-2023
 *
 */
#include <cassert>
#include <cstdio>
#include <cstdint>
#include <limits>
#include <random>

//#include "svdpi.h"

#include "VTbTop.h"
//#include "VTbTop_TbTop.h"
//#include "VTbTop__Dpi.h"
#include "helper/verilator_tick.h"

static uint32_t getPC(const VTbTop& top)
{
    svSetScope(svGetScopeFromName("TOP.TbTop._cpu"));
    return top.public_get_PC();
}

int main(int argc, char* argv[])
{
    printf("\n\nTest MigU CPU\n");

    Verilated::commandArgs(argc, argv);

    // Top TB module instantiation
    VTbTop top;

    Tick tick(top);

    top.rst = 1;
    top.rst_addr = 16;
    for (unsigned int i = 0; i < 5; ++i) {
        tick();
    }
    top.rst = 0;

    printf("Running. Press Ctrl-C to stop.\n");
    for (unsigned int i = 0;
        i < 10 and !Verilated::gotFinish();
        ++i)
    {
        tick();
        //printf("PC:%x\n", getPC(top));
    }

    //printf("Running. Press Ctrl-C to stop.\n");
    //while (!Verilated::gotFinish()) {
    //    //top->eval();
    //    tick();
    //}

    printf("\n\nSUCCESS\n");

    return 0;
}
