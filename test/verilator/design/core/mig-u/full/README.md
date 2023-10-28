# Testing Mig-u CPU RTL/Verilog

## RISV-V toolchain

Use the official RISC-V [toolchain project](https://github.com/riscv-collab/riscv-gnu-toolchain).
Build and install only [Newlib](https://github.com/riscv-collab/riscv-gnu-toolchain#installation-newlib).

Example:

```
cd ~
mkdir tools
cd tools
git clone https://github.com/riscv/riscv-gnu-toolchain
mkdir riscv
export PATH=$PATH:/home/$USER/tools/riscv/bin
cd riscv-gnu-toolchain/
./configure --prefix=/home/$USER/tools/riscv
make -j

which riscv64-unknown-elf-gcc
/home/<user>/tools/riscv/bin/riscv64-unknown-elf-gcc
```

Note the size: `du -sh ~/tools/riscv-gnu-toolchain/ 8.2G`

To enable full chip tests that build test programs,
provide path to the RISC-V toolchain, for example:

```
build$ cmake -DRISCV=/home/$USER/tools/riscv ../mig-cpu/
```
