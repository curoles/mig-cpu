#include "VTbTop.h"
#include "helper/verilator_tick.h"

enum InsnType {
    TYPE_UNDEF,
    TYPE_R,
    TYPE_I,
    TYPE_S,
    TYPE_B,
    TYPE_U,
    TYPE_J
};

struct InsnTest {
    uint32_t insn;
    const char* desc;
    InsnType type;
    uint32_t rd, rs1, rs2;
};

//https://luplab.gitlab.io/rvcodecjs
static InsnTest insn_tests[] = {
    {.insn = 0x003100b3, .desc = "add x1, x2, x3", .type = TYPE_R, .rd = 1, .rs1 = 2, .rs2 = 3},
};

static constexpr
uint32_t number_of_tests = sizeof(insn_tests) / sizeof(insn_tests[0]);

static void set_inputs(VTbTop& top, unsigned int i)
{
    uint32_t test_id = i % number_of_tests;
    InsnTest& test = insn_tests[test_id];

    top.insn = test.insn;
    top.test_id = test_id;
}

union InsnInfo {
    uint64_t val;
    struct __attribute__((packed)) {
        uint32_t itype : 3;
        uint32_t imm : 16;
        uint32_t funct7 : 7;
        uint32_t funct3 : 3;
        uint32_t rs2 : 5;
        uint32_t rs1 : 5;
        uint32_t rd : 5;
        uint32_t opcode : 7;
    };
};

static bool check_outputs(const VTbTop& top)
{
    InsnInfo info = {.val = top.decoded_info};

    uint32_t insn = top.insn;
    uint32_t test_id = top.test_id;
    InsnTest& test = insn_tests[test_id];

    printf("Test ID:%" PRIu32 " hex:%08" PRIx32
        " op:%02x type:%u rd:%u rs1:%u rs2:%u desc:%s\n",
        test_id, insn,
        info.opcode, info.itype, info.rd, info.rs1, info.rs2,
        test.desc);

    if (info.itype != test.type) {
        return false;
    }

    if (info.rd != test.rd || info.rs1 != test.rs1 || info.rs2 != test.rs2) {
        return false;
    }

    return true;
}


int main(int argc, char* argv[])
{
    printf("\n\nTest RISC-V Instruction Decoder\n");

    Verilated::commandArgs(argc, argv);

    // Top TB module instantiation
    VTbTop top;

    Tick tick(top);

    for (unsigned int i = 0; i < number_of_tests; i++)
    {
        set_inputs(top, i);
        tick();

        if (!check_outputs(top))
        {
            printf("Fail\n");
            return 1;
        }
    }

    return 0;
}
