//------------------------------------------------
// imem.v
// David_Harris@hmc.edu 23 October 2005
// Instruction memory used by MIPS processors
//------------------------------------------------

`timescale 1 ns / 1 ps

                 
//module imem(input  [10:0]  a,
//            output [31:0] rd);
module extmem(input ph1, ph2,
               input [10:0] adr,
               inout [31:0] data,
               input [3:0] byteen,
               input rwb, en,
               output done);

  // 0x200 = 2^10 = 1024
  reg  [31:0] RAM[1023:0];
  //  reg  [31:0] RAM[63:0];  // USE THIS FOR SYNTHESIS
  wire [1:0] state;
  reg [1:0] nextstate;
  
  initial
    begin
      // TODO: Zero out memory each time
      $readmemh("testing/test_000.dat",RAM);
      #1000;
      $readmemh("testing/test_001.dat",RAM);
      #1000;
      $readmemh("testing/test_002.dat",RAM);
      #1000;
      $readmemh("testing/test_003.dat",RAM);
      #1000;
      $readmemh("testing/test_004.dat",RAM);
      #1000;
      $readmemh("testing/test_005.dat",RAM);
      #1000;
      $readmemh("testing/test_006.dat",RAM);
      #1000;
      $readmemh("testing/test_007.dat",RAM);
      #1000;
      $readmemh("testing/test_008.dat",RAM);
      #1000;
      $readmemh("testing/test_009.dat",RAM);
      #1000;
      $readmemh("testing/test_010.dat",RAM);
      #1000;
      $readmemh("testing/test_011.dat",RAM);
      #1000;
      $readmemh("testing/test_012.dat",RAM);
      #5000;
      $readmemh("testing/test_013.dat",RAM);
      #1000;
      $readmemh("testing/test_014.dat",RAM);
      #1000;
      $readmemh("testing/test_015.dat",RAM);
      #1000;
      $readmemh("testing/test_016.dat",RAM);
      #5000;
    end
    
    assign data = (rwb) ? RAM[adr] : 32'bz;
    //assign done = state[1];
    assign done = 1'b1;
    
    flopr #(2) fstate(ph1, ph2,reset,nextstate,state);

    always @(*)
    case(state)
        2'b00: if(en) nextstate <= 2'b01;
               else nextstate <= 2'b00;
        2'b01: if(en) nextstate <= 2'b10;
               else nextstate <= 2'b00;
        default: nextstate <= 2'b00;
    endcase
    
    always @(posedge ph1)
      if(~rwb) RAM[adr] <= data;
endmodule

