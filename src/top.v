//------------------------------------------------
// top.v
// David_Harris@hmc.edu 9 November 2005
// Top level system including MIPS and memories
//------------------------------------------------

`timescale 1 ns / 1 ps

module top(input         ph1, ph2, reset,
           input  [7:0]        interrupts,
           output [31:0] writedata, dataadr, 
           output        memwrite);


  wire [31:0] pc, instr, readdata;
  wire instrack, dataack;
  wire [3:0] byteen;
  wire memtoregM, swc;
  
  wire [26:0] memadr;
  wire [31:0] memdata;
  wire [3:0] membyteen;
  wire memrwb;
  wire memen;
  wire memdone;
  
  // instantiate processor and memories
  mips mips(ph1, ph2, reset, pc, instr, interrupts, memwrite, memtoregM, swc, byteen, dataadr, writedata, 
            readdata, instrack, dataack);
  extmem imem(ph1, ph2, pc[12:2], instr, 4'b1, 1'b1, 1'b1, instrack);
  cacheideal dcache(ph1, ph2, memwrite, dataadr, writedata, byteen, readdata, dataack);

/*
  cachecontroller cc(ph1, ph2, reset, pc[31:2], instr, 1'b1, instrack,
                     dataadr[31:2], writedata, byteen, readdata,
                     memwrite, reM, dataack,
                     swc,
                     memadr,memdata,membyteen,
                     memrwb,memen,memdone);
                     
  mainmem mem(ph1, ph2, reset, memadr, memdata, membyteen,
                 memrwb, memen, memdone);
                 */
endmodule

// this is an ideal cache right now
module cacheideal(input         ph1, ph2, writeenable,
             input  [31:0] a, writedata, // TODO: Remove lower two bits of a
             input  [3:0]  byteen,
             output [31:0] readdata,
             output reg    ack);

  reg  [31:0] RAM[1023:0]; 
//  reg  [31:0] RAM[31:0]; // Don't make this much bigger or SynplifyPro
                          // will hate you (and won't halt)
  reg fakedelay1, fakedelay2;

  assign readdata = RAM[a[31:2]]; // word aligned

  // Assume ideal memory

  // Assume big endien
  always @(posedge ph1) //just changed from clk . . . hope it works
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
