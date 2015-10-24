# Introduction #

The hmc-MIPS CPU requires implementation of eight exceptions. These must be implemented, and tested, before 27 January.


# Exceptions to implement #

  * 0 - Interrupt - Implemented, partially tested.
  * 4 - AdEL (thrown on misaligned doubleword, word or halfword load) - Implemented, tested. (misaligned fetch not implemented)
  * 5 - AdES (thrown on misaligned doubleword, word or halfword store) - Implemented, tested.
  * 8 - Syscall - Implemented, tested.
  * 9 - Breakpoint - Implemented, tested.
  * 10 - RI (invalid opcode) - Implemented, tested.
  * 11 - CpU - thrown on attempt to use CP1-3 (FPU) - Implemented, tested.
  * 12 - Ov - Arithmetic overflow - Implemented, tested.

# Exceptions that will remain unimplemented #
  * 6 - IBE - Instruction Bus Error
  * 7 - DBE - Data Bus Error

Since the hmc-mips CPU won't have an error-checking bus, these exceptions will never be fired, and thus, will not be implemented.

# Details #
The framework for exception handling is already present. Ov checks to see if the ALU is overflowing and that the bubbled-through overflowableE is high. The actual exception occurs when the offending instruction is in the execute stage. To simplify the design of the processor, this will necessarily be true for all exceptions (that it will be thrown when the offending instruction is in the execute stage).

Syscall, Breakpoint, RI and CpU all can be detected when we decode, so we'll add a line for each in controls. These lines get bubbled down the pipeline until they reach the decode stage, where they're routed to the exception handler as is. The processing is identical to Ov from that point. Only exccode changes.

Interrupts are handled entirely within the exception handler. We see that an interrupt happened, and proceed just as if we'd gotten an exception line signal from the execution unit.

AdES is only applicable on store doubleword, word or halfword. In decode, we'll have another control line (bubbled down the pipeline) for adesable, if we're dealing with that type of instruction. We'll route this signal, along with aluoutE[0](0.md) AND aluoutE[1](1.md) to the exception unit, where we detect the exception, and process accordingly.

Finally, AdEL can be thrown from memwrites of dwords, words and halfwords. We set a similar adelable control, and handle identically to adesable (we check our location with aluoutE[0](0.md) AND aluoutE[1](1.md), I believe). We also need to check that we're I-fetching from a valid address. In the fetch stage, we'll check to see if we're aligned, and if not, we set a adesifetchthrown line, which we route into the exception handler at the execute stage.

In terms of physical implementation, by only handling excepting instructions at the execute stage, we vastly simplify the layout, because the exception unit only has to interface with the execute stage.

# Excepting instructions #
Four of the eight exceptions are caused by specific instructions, and therefore are caught in the decode stage (though not thrown until the execute stage).

  * syscall code: {6'b00000 code 6'b001100}
  * break code: {6'b000000 code 6'b001110}
  * any FPU operation
  * any other, unimplemented instruction

# `rfe` - Return from exception #
The `rfe` instruction must reenable interrupt handling. It must do nothing else.

# Unimplemented memory #
Professor Harris suggested that we might consider implementing an unimplemented memory exception if software made an attempt to access memory that was not physically attached to the machine. Since all commercial MIPS implementations (to my knowledge) use the TLB, and therefore support virtual memory, any implementation of this would have to be non-standard. It would be possible to emit the TLB miss exception when an attempt to access unimplemented memory was made, however this would not be a per-spec use of that exception, and would likely end up being confusing. Since no compiler would recognize the non-standard use of the exception, I see no overwhelming benefit in implementing this feature at this time, though any comments would be welcome.