# Introduction #

GCC supports the MIPS1 CPU. We hope to be able to use it to compile ANSI C code that will run on our CPU.

# Challenges #

  * GCC emits code that either targets the FPU, or never attempts to use it, calling libraries instead. I'm not sure if it generates the software FPU that handles unimplemented FPU calls.

  * GCC uses the patented instructions, which we do not. We will have to work around that.

  * Our CPU doesn't use an MMU.