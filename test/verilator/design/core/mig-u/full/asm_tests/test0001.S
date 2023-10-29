/*
* https://luplab.gitlab.io/rvcodecjs/
* nop is addi x0, x0, 0, enc=0x00000013, RV32I
*
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
