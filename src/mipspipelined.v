//------------------------------------------------
// mipspipelined.v
// David_Harris@hmc.edu 3 November 2005
// Pipelined MIPS processor
//------------------------------------------------

// files needed for simulation:
//  mipsttest.v
//  top.v
//  imem.v
//  mipspipelined.v

// pipelined MIPS processor
module mips(input         clk, reset,
            output [31:0] pcF,
            input  [31:0] instrF,
            output        memwriteM,
            output [31:0] aluoutM, writedataM,
            input  [31:0] readdataM);

  wire [5:0]  opD, functD;
  wire        regdstE, alusrcE, 
              pcsrcD, unsignedD,
              memtoregE, memtoregM, memtoregW, regwriteE, regwriteM, regwriteW;
  wire [3:0]  alucontrolE;
  wire        flushE, equalD;

  controller c(clk, reset, opD, functD, flushE, equalD,
               memtoregE, memtoregM, memtoregW, memwriteM, pcsrcD, branchD,
               alusrcE, unsignedD, unsignedE, regdstE, regwriteE, regwriteM, 
               regwriteW, jumpD, alucontrolE);
  datapath dp(clk, reset, memtoregE, memtoregM, memtoregW, pcsrcD, branchD, 
              unsignedD, unsignedE, alusrcE, regdstE, regwriteE, regwriteM, 
              regwriteW, jumpD, alucontrolE,
              equalD, pcF, instrF,
              aluoutM, writedataM, readdataM,
              opD, functD, flushE);
endmodule

module controller(input        clk, reset,
                  input  [5:0] opD, functD,
                  input        flushE, equalD,
                  output       memtoregE, memtoregM, memtoregW, memwriteM,
                  output       pcsrcD, branchD, alusrcE, unsignedD, unsignedE,
                  output       regdstE, regwriteE, regwriteM, regwriteW,
                  output       jumpD,
                  output [3:0] alucontrolE);

  wire       memtoregD, memwriteD, alusrcD,
             regdstD, regwriteD;
  wire [3:0] alucontmaindec, alucontrolD;
  wire       memwriteE;

  maindec md(opD, memtoregD, memwriteD, branchD,
             alusrcD, regdstD, regwriteD, unsignedD,
             jumpD,
             alucontmaindec);

  aludec  ad(functD, alucontmaindec, alucontrolD);



  assign pcsrcD = branchD & equalD;

  // pipeline registers
  floprc #(10) regE(clk, reset, flushE,
                  {memtoregD, memwriteD, alusrcD, regdstD, regwriteD, 
                  alucontrolD, unsignedD}, 
                  {memtoregE, memwriteE, alusrcE, regdstE, regwriteE,  
                  alucontrolE, unsignedE});
  flopr #(3) regM(clk, reset, 
                  {memtoregE, memwriteE, regwriteE},
                  {memtoregM, memwriteM, regwriteM});
  flopr #(2) regW(clk, reset, 
                  {memtoregM, regwriteM},
                  {memtoregW, regwriteW});
endmodule

module maindec(input  [5:0] op,
               output       memtoreg, memwrite,
               output       branch, alusrc,
               output       regdst, regwrite, 
               output       unsignedD, jump,
               output [3:0] alucontrol);

  reg [11:0] controls;

  assign {regwrite, regdst, alusrc,
          branch, memwrite,
          memtoreg, jump, alucontrol /* 4 bits */,
          unsignedD} = controls;

  always @ ( * )
    case(op)
      6'b000000: controls <= 12'b110000001100; //Rtyp
      6'b100011: controls <= 12'b101001000100; //LW
      6'b101011: controls <= 12'b001010000100; //SW
      6'b000100: controls <= 12'b000100010100; //BEQ
      6'b001000: controls <= 12'b101000000100; //ADDI (treat same as ADDIU)
      6'b001001: controls <= 12'b101000000100; //ADDIU
      6'b001010: controls <= 12'b101000010110; //SLTI
      6'b001011: controls <= 12'b101000001110; //SLTIU (imm _IS_ sign extended)
      6'b001100: controls <= 12'b101000000001; //ANDI
      6'b001101: controls <= 12'b101000000011; //ORI
      6'b001110: controls <= 12'b101000001001; //XORI
      6'b001111: controls <= 12'b101000011101; //LUI
      6'b000010: controls <= 12'b000000100100; //J
      default:   controls <= 12'bxxxxxxxxxxxx; //???
    endcase
endmodule

module aludec(input      [5:0] funct,
              input      [3:0] alumaincontrol,
              output     [3:0] alucontrol);


  reg [3:0] functcontrol;

  // The pattern 0110 indicates that we should use the funct code
  assign #1 alucontrol = (alumaincontrol == 4'b0110 ? 
                           functcontrol : alumaincontrol);

  always @ ( * )
      case(funct)
          6'b100000: functcontrol <= 4'b0010; // ADD (same as ADDU)
          6'b100001: functcontrol <= 4'b0010; // ADDU
          6'b100010: functcontrol <= 4'b1010; // SUB (same as SUBU)
          6'b100011: functcontrol <= 4'b1010; // SUBU
          6'b100100: functcontrol <= 4'b0000; // AND
          6'b100101: functcontrol <= 4'b0001; // OR
          6'b100110: functcontrol <= 4'b0100; // XOR
          6'b100111: functcontrol <= 4'b0101; // NOR
          6'b101010: functcontrol <= 4'b1011; // SLT
          6'b101011: functcontrol <= 4'b1111; // SLTU
          default:   functcontrol <= 4'bxxxx; // ???
      endcase
endmodule

module datapath(input         clk, reset,
                input         memtoregE, memtoregM, memtoregW, 
                input         pcsrcD, branchD, unsignedD, unsignedE,
                input         alusrcE, regdstE,
                input         regwriteE, regwriteM, regwriteW, 
                input         jumpD,
                input  [3:0]  alucontrolE,
                output        equalD,
                output [31:0] pcF,
                input  [31:0] instrF,
                output [31:0] aluoutM, writedataM,
                input  [31:0] readdataM,
                output [5:0]  opD, functD,
                output        flushE);

  wire        forwardaD, forwardbD;
  wire [1:0]  forwardaE, forwardbE;
  wire        stallF;
  wire [4:0]  rsD, rtD, rdD, rsE, rtE, rdE;
  wire [4:0]  writeregE, writeregM, writeregW;
  wire        flushD;
  wire [31:0] pcnextFD, pcnextbrFD, pcplus4F, pcbranchD;
  wire [31:0] signimmD, signimmE, signimmshD;
  wire [31:0] srcaD, srca2D, srcaE, srca2E;
  wire [31:0] srcbD, srcb2D, srcbE, srcb2E, srcb3E;
  wire [31:0] pcplus4D, instrD;
  wire [31:0] aluoutE, aluoutW;
  wire [31:0] readdataW, resultW;

  // hazard detection
  hazard    h(rsD, rtD, rsE, rtE, writeregE, writeregM, writeregW, 
              regwriteE, regwriteM, regwriteW, 
              memtoregE, memtoregM, branchD,
              forwardaD, forwardbD, forwardaE, forwardbE,
              stallF, stallD, flushE);

  // next PC logic (operates in fetch and decode)
  mux2 #(32)  pcbrmux(pcplus4F, pcbranchD, pcsrcD, pcnextbrFD);
  mux2 #(32)  pcmux(pcnextbrFD,{pcplus4D[31:28], instrD[25:0], 2'b00}, 
                    jumpD, pcnextFD);

  // register file (operates in decode and writeback)
  regfile     rf(clk, regwriteW, rsD, rtD, writeregW,
                 resultW, srcaD, srcbD);

  // Fetch stage logic
  flopenr #(32) pcreg(clk, reset, ~stallF, pcnextFD, pcF);
  adder       pcadd1(pcF, 32'b100, pcplus4F);

  // Decode stage 
  flopenr #(32) r1D(clk, reset, ~stallD, pcplus4F, pcplus4D);
  flopenrc #(32) r2D(clk, reset, ~stallD, flushD, instrF, instrD);
  signext     se(instrD[15:0], ~unsignedD, signimmD);
  sl2         immsh(signimmD, signimmshD);
  adder       pcadd2(pcplus4D, signimmshD, pcbranchD);
  mux2 #(32)  forwardadmux(srcaD, aluoutM, forwardaD, srca2D);
  mux2 #(32)  forwardbdmux(srcbD, aluoutM, forwardbD, srcb2D);
  eqcmp       comp(srca2D, srcb2D, equalD);

  // Instruction breakdown
  assign opD = instrD[31:26];
  assign functD = instrD[5:0];
  assign rsD = instrD[25:21];
  assign rtD = instrD[20:16];
  assign rdD = instrD[15:11];

  assign flushD = pcsrcD | jumpD;

  // Execute stage 
  floprc #(32) r1E(clk, reset, flushE, srcaD, srcaE);
  floprc #(32) r2E(clk, reset, flushE, srcbD, srcbE);
  floprc #(32) r3E(clk, reset, flushE, signimmD, signimmE);
  floprc #(5)  r4E(clk, reset, flushE, rsD, rsE);
  floprc #(5)  r5E(clk, reset, flushE, rtD, rtE);
  floprc #(5)  r6E(clk, reset, flushE, rdD, rdE);
  mux3 #(32)  forwardaemux(srcaE, resultW, aluoutM, forwardaE, srca2E);
  mux3 #(32)  forwardbemux(srcbE, resultW, aluoutM, forwardbE, srcb2E);
  mux2 #(32)  srcbmux(srcb2E, signimmE, alusrcE, srcb3E);
  alu         alu(srca2E, srcb3E, alucontrolE, aluoutE);
  mux2 #(5)   wrmux(rtE, rdE, regdstE, writeregE);

  // Memory stage
  flopr #(32) r1M(clk, reset, srcb2E, writedataM);
  flopr #(32) r2M(clk, reset, aluoutE, aluoutM);
  flopr #(5)  r3M(clk, reset, writeregE, writeregM);

  // Writeback stage
  flopr #(32) r1W(clk, reset, aluoutM, aluoutW);
  flopr #(32) r2W(clk, reset, readdataM, readdataW);
  flopr #(5)  r3W(clk, reset, writeregM, writeregW);
  mux2 #(32)  resmux(aluoutW, readdataW, memtoregW, resultW);

endmodule

module hazard(input  [4:0] rsD, rtD, rsE, rtE, 
              input  [4:0] writeregE, writeregM, writeregW,
              input        regwriteE, regwriteM, regwriteW,
              input        memtoregE, memtoregM, branchD,
              output           forwardaD, forwardbD,
              output reg [1:0] forwardaE, forwardbE,
              output       stallF, stallD, flushE);

  wire lwstallD, branchstallD;

  // forwarding sources to D stage (branch equality)
  assign forwardaD = (rsD !=0 & rsD == writeregM & regwriteM);
  assign forwardbD = (rtD !=0 & rtD == writeregM & regwriteM);

  // forwarding sources to E stage (ALU)
  always @( * )
    begin
      forwardaE = 2'b00; forwardbE = 2'b00;
      if (rsE != 0)
        if (rsE == writeregM & regwriteM) forwardaE = 2'b10;
        else if (rsE == writeregW & regwriteW) forwardaE = 2'b01;
      if (rtE != 0)
        if (rtE == writeregM & regwriteM) forwardbE = 2'b10;
        else if (rtE == writeregW & regwriteW) forwardbE = 2'b01;
    end

  // stalls  
  assign #1 lwstallD = memtoregE & (rtE == rsD | rtE == rtD);
  assign #1 branchstallD = branchD & 
             (regwriteE & (writeregE == rsD | writeregE == rtD) |
              memtoregM & (writeregM == rsD | writeregM == rtD));

  assign #1 stallD = lwstallD | branchstallD;
  assign #1 stallF = stallD; // stalling D stalls all previous stages
  assign #1 flushE = stallD; // stalling D flushes next stage

  // *** not necessary to stall D stage on store if source comes from load;
  // *** instead, another bypass network could be added from W to M
endmodule

module alu(input      [31:0] a, b, 
           input      [3:0]  alucont, 
           output reg [31:0] result);

  wire [31:0] b2, sum, aorb;

  wire sltSigned, sltUnsigned;

  assign #1 b2 = alucont[3] ? ~b:b; 
  assign #1 sum = a + b2 + alucont[3];
  assign #1 sltSigned = sum[31];
  // a < b is an unsigned comparrison
  assign #1 sltUnsigned = a < b;
  assign #1 aorb = a | b;

  always@( * )
    case(alucont[2:0])
      3'b000: result <= #1 a & b;     // and
      3'b001: result <= #1 aorb;      // or
      3'b010: result <= #1 sum;       // add, sub
      3'b011: result <= #1 sltSigned; // slt signed
      3'b100: result <= #1 a ^ b;     // xor
      3'b101: result <= #1 ~aorb;     // nor
      // 0110 is reserved for main decoder (it indicates to choose alucont based
      // on the funct), but 1110 is used for LUI
      3'b110: result <= #1 {b[15:0], 16'b0}; // lu (load upper)
      3'b111: result <= #1 sltUnsigned; // slt unsigned
    endcase
endmodule

module regfile(input         clk, 
               input         we3, 
               input  [4:0]  ra1, ra2, wa3, 
               input  [31:0] wd3, 
               output [31:0] rd1, rd2);

  reg [31:0] rf[31:0];

  // three ported register file
  // read two ports combinationally
  // write third port on falling edge of clock
  // register 0 hardwired to 0

  always @(negedge clk)
    if (we3) rf[wa3] <= wd3;

  assign #1 rd1 = (ra1 != 0) ? rf[ra1] : 0;
  assign #1 rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule

module adder(input  [31:0] a, b,
             output [31:0] y);

  assign #1 y = a + b;
endmodule

module eqcmp(input [31:0] a, b,
             output        eq);

  assign #1 eq = (a == b);
endmodule

module sl2(input  [31:0] a,
           output [31:0] y);

  // shift left by 2
  assign #1 y = {a[29:0], 2'b00};
endmodule

// When disabled, signext acts as a zero extender
module signext(input  [15:0] a,
               input  enable,
               output [31:0] y);
               
  wire extension;
  
  assign #1 extension = (enable ? a[15] : 0);
  assign #1 y = {{16{extension}}, a};
endmodule

module flopr #(parameter WIDTH = 8)
              (input                  clk, reset,
               input      [WIDTH-1:0] d, 
               output reg [WIDTH-1:0] q);

  always @(posedge clk, posedge reset)
    if (reset) q <= #1 0;
    else       q <= #1 d;
endmodule

module floprc #(parameter WIDTH = 8)
              (input                  clk, reset, clear,
               input      [WIDTH-1:0] d, 
               output reg [WIDTH-1:0] q);

  always @(posedge clk, posedge reset)
    if (reset)      q <= #1 0;
    else if (clear) q <= #1 0;
    else            q <= #1 d;
endmodule

module flopenr #(parameter WIDTH = 8)
                (input                  clk, reset,
                 input                  en,
                 input      [WIDTH-1:0] d, 
                 output reg [WIDTH-1:0] q);
 
  always @(posedge clk, posedge reset)
    if      (reset) q <= #1 0;
    else if (en)    q <= #1 d;
endmodule

module flopenrc #(parameter WIDTH = 8)
                 (input                  clk, reset,
                  input                  en, clear,
                  input      [WIDTH-1:0] d, 
                  output reg [WIDTH-1:0] q);
 
  always @(posedge clk, posedge reset)
    if      (reset) q <= #1 0;
    else if (clear) q <= #1 0;
    else if (en)    q <= #1 d;
endmodule

module mux2 #(parameter WIDTH = 8)
             (input  [WIDTH-1:0] d0, d1, 
              input              s, 
              output [WIDTH-1:0] y);

  assign #1 y = s ? d1 : d0; 
endmodule

module mux3 #(parameter WIDTH = 8)
             (input  [WIDTH-1:0] d0, d1, d2,
              input  [1:0]       s, 
              output [WIDTH-1:0] y);

  assign #1 y = s[1] ? d2 : (s[0] ? d1 : d0); 
endmodule

