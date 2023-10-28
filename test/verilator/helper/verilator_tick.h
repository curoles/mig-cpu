/**
 * @brief  Verilator time simulation helpers.
 * @author Igor Lesik 2020
 *
 */
#pragma once

#include "VTbTop.h"
#include "verilated.h"

void sim_change_clk(VTbTop& top);

uint64_t sim_time();
 
static inline void sim_tick(VTbTop& top)
{
    sim_change_clk(top);
    sim_change_clk(top);
}

struct Tick
{
    VTbTop& tb_;

    Tick(VTbTop& top):tb_(top){}

    void tick() {sim_tick(tb_);}

    void operator()(){tick();}
};

template<typename T, unsigned int N>
void print_binary(T n) {
    for (T i = (T)1 << (N - 1); i > 0; i = i >> 1)
        (n & i)? putchar('1'): putchar('0');
}

static inline void print_bin32(uint32_t n) {
    print_binary<uint32_t, 32>(n);
}