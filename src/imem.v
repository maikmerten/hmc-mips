//------------------------------------------------
// imem.v
// David_Harris@hmc.edu 23 October 2005
// Instruction memory used by MIPS processors
//------------------------------------------------

`timescale 1 ns / 1 ps

module imem(input  [10:0]  a,
            output [31:0] rd);

  // 0x200 = 2^10 = 124
  reg  [31:0] RAM[1023:0];

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
    end

  assign rd = RAM[a]; // word aligned
endmodule

