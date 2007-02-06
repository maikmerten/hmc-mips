//------------------------------------------------
// fpgabench.v
// tbarr at cs.hmc.edu 5 Feb 2007
// Testbench for MIPS processor on FPGA
//------------------------------------------------

`timescale 1 ns / 1 ps

// this model simulates the hardware external to the FPGA,
// and the user.

// LEDs [3:0] = {running, succeeded, failed (if not succeeded), power}

module fpgabench;

  reg         clk;
  reg         reset;

  reg [7:0] interrupts;
  
  wire [31:0] writedata, dataadr;
  wire memwrite;
  wire [3:0] outputleds;

  // instantiate device to be tested
  fpga dut(clk, reset, outputleds);
  
  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end
    
  initial
    begin
      reset <= 1; #15; reset <= 0;
    end
      
endmodule
