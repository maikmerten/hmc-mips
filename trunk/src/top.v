//------------------------------------------------
// top.v
// David_Harris@hmc.edu 9 November 2005
// Top level system including MIPS and memories
//------------------------------------------------

`timescale 1 ns / 1 ps

module top(input         clk, reset, 
           output [31:0] writedata, dataadr, 
           output        memwrite);

  wire [31:0] pc, instr, readdata;
  wire instrack, dataack;
  wire [3:0] byteen;
  
  // instantiate processor and memories
  mips mips(clk, reset, pc, instr, memwrite, byteen, dataadr, writedata, 
            readdata, instrack, dataack);
  imem imem(pc[12:2], instr); assign instrack = 1; // TODO: make imem a cache
  cache dcache(clk, memwrite, dataadr, writedata, byteen, readdata, dataack);

endmodule

// this is an ideal cache right now
module cache(input         clk, writeenable,
             input  [31:0] a, writedata, // TODO: Remove lower two bits of a
             input  [3:0]  byteen,
             output [31:0] readdata,
             output reg    ack);

  reg  [31:0] RAM[1023:0];
  reg fakedelay1, fakedelay2;

  assign readdata = RAM[a[31:2]]; // word aligned

  // Assume ideal memory

  // Assume big endien
  always @(posedge clk)
    begin
      fakedelay1 <= writeenable;
      fakedelay2 <= fakedelay1;
      ack <= fakedelay2;
      if (writeenable)
        begin
          if(byteen[0])
            RAM[a[31:2]][7:0] <= writedata[7:0];
          if(byteen[1])
            RAM[a[31:2]][15:8] <= writedata[15:8];
          if(byteen[2])
            RAM[a[31:2]][23:16] <= writedata[23:16];
          if(byteen[3])
            RAM[a[31:2]][31:24] <= writedata[31:24];
        end
    end

          
endmodule

// imem may be created with CoreGen for Xilinx synthesis
// or loaded from imem.v for simulation
