/*
* https://luplab.gitlab.io/rvcodecjs/
* nop is addi x0, x0, 0, enc=0x00000013, RV32I
* c.nop is 16-bits compressed insn from RV32C enc=0x10001
*/

.text
.align  4

.global _start

_start:
    nop
    nop
    nop
    nop

.align  4
.global _exit
.type   _exit, %function

_exit:
    nop
    nop
    nop
    nop
