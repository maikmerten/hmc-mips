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

`timescale 1 ns / 1 ps

// pipelined MIPS processor
module mips(input         clk, reset,
            output [31:0] pcF,
            input  [31:0] instrF,
            output        memwriteM,
            output [31:0] aluoutM, writedataM,
            input  [31:0] readdataM);

  wire [5:0]  opD, functD;
  wire [4:0]  rtD;
  wire        regdstE, alusrcE, 
              unsignedD, linkD, linkE, 
              memtoregE, memtoregM, memtoregW, regwriteE, regwriteM, regwriteW,
              aluoutsrcE;
  wire [2:0]  alushcontrolE;
  wire [3:0]  branchcontD;
  wire        flushE;

  controller c(clk, reset, opD, functD, rtD, flushE, 
               memtoregE, memtoregM, memtoregW, memwriteM, branchD,
               alusrcE, unsignedD, unsignedE, regdstE, regwriteE, regwriteM, 
               regwriteW, jumpD, aluoutsrcE, alushcontrolE, linkD, linkE, 
               branchcontD);
  datapath dp(clk, reset, memtoregE, memtoregM, memtoregW, branchD, 
              unsignedD, unsignedE, alusrcE, regdstE, regwriteE, regwriteM, 
              regwriteW, jumpD, aluoutsrcE, linkD, linkE,
              branchcontD, alushcontrolE,
              pcF, instrF,
              aluoutM, writedataM, readdataM,
              opD, functD, rtD, flushE);
endmodule

module controller(input        clk, reset,
                  input  [5:0] opD, functD,
                  input  [4:0] rtD,
                  input        flushE,
                  output       memtoregE, memtoregM, memtoregW, memwriteM,
                  output       branchD, alusrcE, unsignedD, unsignedE,
                  output       regdstE, regwriteE, regwriteM, regwriteW,
                  output       jumpD, aluoutsrcE, 
                  output [2:0] alushcontrolE, 
                  output       linkD, linkE,
                  output [3:0] branchcontD);

  wire       memtoregD, memwriteD, alusrcD,
             regdstD, regwriteD, alushmainoutsrcD, aluoutsrcD;
  wire [2:0] alushcontmaindecD, alushcontrolD;
  wire       memwriteE;

  maindec md(opD, memtoregD, memwriteD,
             alusrcD, regdstD, regwriteD, unsignedD,
             alushmainoutsrcD, alushcontmaindecD);

  alushdec  ad(functD, alushmainoutsrcD, alushcontmaindecD, aluoutsrcD,
             alushcontrolD);

  branchdec bd(opD, rtD, functD, jumpD, branchD, branchcontD, linkD);

  // pipeline registers
  floprc #(11) regE(clk, reset, flushE,
                  {memtoregD, memwriteD, alusrcD, regdstD, regwriteD, 
                  aluoutsrcD, alushcontrolD, unsignedD, linkD}, 
                  {memtoregE, memwriteE, alusrcE, regdstE, regwriteE,  
                  aluoutsrcE, alushcontrolE, unsignedE, linkE});
  flopr #(3) regM(clk, reset, 
                  {memtoregE, memwriteE, regwriteE},
                  {memtoregM, memwriteM, regwriteM});
  flopr #(2) regW(clk, reset, 
                  {memtoregM, regwriteM},
                  {memtoregW, regwriteW});
endmodule

module maindec(input  [5:0] op,
               output       memtoreg, memwrite,
               output       alusrc,
               output       regdst, regwrite, 
               output       unsignedD, aluoutsrc,
               output [2:0] alushcontrol);

  reg [9:0] controls;
  
  assign {regwrite, regdst, alusrc,
          memwrite,
          memtoreg, aluoutsrc, alushcontrol /* 3 bits */,
          unsignedD} = controls;

  always @ ( * )
    case(op)
      6'b000000: controls <= 12'b1100001010; //R-type
      6'b000001: controls <= 12'b1100001010; //Opcode 1 (branches)
      6'b100011: controls <= 12'b1010100100; //LW
      6'b101011: controls <= 12'b0011000100; //SW
      6'b001000: controls <= 12'b1010000100; //ADDI (treated same as ADDIU)
      6'b001001: controls <= 12'b1010000100; //ADDIU
      6'b001010: controls <= 12'b1010001110; //SLTI
      6'b001011: controls <= 12'b1010000110; //SLTIU (imm _IS_ sign extended)
      6'b001100: controls <= 12'b1010000001; //ANDI
      6'b001101: controls <= 12'b1010000011; //ORI
      6'b001110: controls <= 12'b1010001001; //XORI
      6'b001111: controls <= 12'b1010011111; //LUI
      6'b000010: controls <= 12'b0000000100; //J
      6'b000011: controls <= 12'b0000000100; //JAL
      6'b000100: controls <= 12'b0000001100; //BEQ
      6'b000101: controls <= 12'b0000001100; //BNE
      6'b000110: controls <= 12'b0000001100; //BLEZ
      6'b000111: controls <= 12'b0000001100; //BGTZ
      default:   controls <= 12'bxxxxxxxxxx; //???
    endcase

endmodule

// ALU and Shifter decoders
module alushdec(input      [5:0] funct,
                input            alushmainoutsrc, 
                input      [2:0] alushmaincontrol,
                output           aluoutsrc, /* True when using shifts */
                output     [2:0] alushcontrol);

  reg [3:0] functcontrol;

  // The pattern 0101 indicates that we have an R-type and should use the 
  // funct code (0101 is also the nor command, of which there is no immediate
  // equivalent; hence 0101 is available)
  assign #1 {aluoutsrc, alushcontrol} = 
    (({alushmainoutsrc, alushmaincontrol} == 4'b0101) 
      ? functcontrol 
      : {alushmainoutsrc, alushmaincontrol});

  always @ ( * )
      case(funct)
          // ALU Ops
          6'b100000: functcontrol <= 4'b0010; // ADD (same as ADDU)
          6'b100001: functcontrol <= 4'b0010; // ADDU
          6'b100010: functcontrol <= 4'b0110; // SUB (same as SUBU)
          6'b100011: functcontrol <= 4'b0110; // SUBU
          6'b100100: functcontrol <= 4'b0000; // AND
          6'b100101: functcontrol <= 4'b0001; // OR
          6'b100110: functcontrol <= 4'b0100; // XOR
          6'b100111: functcontrol <= 4'b0101; // NOR
          6'b101010: functcontrol <= 4'b0111; // SLT
          6'b101011: functcontrol <= 4'b0011; // SLTU

          // Shift Ops
          // 4'b1111 is a special case used directly by microcontroller for LUI
          //
          // The lower 3 bits are: {constant, left, associative}
          6'b000000: functcontrol <= 4'b1110; // SLL
          6'b000010: functcontrol <= 4'b1100; // SRL
          6'b000011: functcontrol <= 4'b1101; // SRA
          6'b000100: functcontrol <= 4'b1010; // SLLV
          6'b000110: functcontrol <= 4'b1000; // SRLV
          6'b000111: functcontrol <= 4'b1001; // SRAV

          // Branch Ops (These are all don't cares)

          default:   functcontrol <= 4'bxxxx; // ???
      endcase
endmodule

// Branch decoder
module branchdec(input  [5:0] op,
                 input  [4:0] rt,
                 input  [5:0] funct,
                 output       jump,
                 output       branch,
                 output [3:0] branchcont,  // {lt, gt, eq, src};
                 output       link);

  reg [6:0] controls;

  assign #1 {jump, branch, branchcont, link} = controls;

  always @ ( * )
    case(op)
      6'b000010: controls <= 7'b1011100;      // J
      6'b000011: controls <= 7'b1011101;      // JAL
      6'b000000: // R-type
        case(funct)
          6'b001000: controls <= 7'b1011110;  // JR
          6'b001001: controls <= 7'b1011111;  // JALR
          default:   controls <= 7'b0000000;  // Another R-type, no branching
        endcase
      6'b000001: // Opcode 1
        case(rt)
          6'b000000: controls <= 7'b0110000;  // BLTZ
          6'b000001: controls <= 7'b0101100;  // BGEZ
          6'b100000: controls <= 7'b0110001;  // BLTZAL
          6'b100001: controls <= 7'b0101101;  // BGEZAL
          default:   controls <= 7'bxxxxxxx;  // Error, unsupported instruction
        endcase
      6'b000100: controls <= 7'b0100110;      // BEQ
      6'b000101: controls <= 7'b0111010;      // BNE
      6'b000110: controls <= 7'b0110100;      // BLEZ
      6'b000111: controls <= 7'b0101000;      // BGTZ
      default:   controls <= 7'b0000000;      // All others, no branching
    endcase
endmodule

module datapath(input         clk, reset,
                input         memtoregE, memtoregM, memtoregW, 
                input         branchD, unsignedD, unsignedE,
                input         alusrcE, regdstE,
                input         regwriteE, regwriteM, regwriteW, 
                input         jumpD, aluoutsrcE, linkD, linkE,
                input  [3:0]  branchcontD,
                input  [2:0]  alushcontrolE,
                output [31:0] pcF,
                input  [31:0] instrF,
                output [31:0] aluoutM, writedataM,
                input  [31:0] readdataM,
                output [5:0]  opD, functD,
                output [4:0]  rtD,
                output        flushE);

  wire        forwardaD, forwardbD;
  wire [1:0]  forwardaE, forwardbE;
  wire        stallF;
  wire [4:0]  rsD, rdD, rd2D, rsE, rtE, rdE;
  wire [4:0]  writeregE, writeregM, writeregW;
  wire [31:0] pcnextFD, pcnextbrFD, pcplus4F, pcbranchD;
  wire [31:0] signimmD, signimmE;
  wire [31:0] srcaD, srca2D, srcaE, srca2E;
  wire [31:0] srcbD, srcb2D, srcbE, srcb2E, srcb3E;
  wire [31:0] pcD, pcplus4D, pcplus8D, pcplus8E, instrD;
  wire [31:0] aluresultE, shiftresultE, alushresultE;
  wire [31:0] aluoutE, aluoutW;
  wire [31:0] readdataW, resultW;
  wire        pcsrcD, rdsrcD;


  // hazard detection
  hazard    h(rsD, rtD, rsE, rtE, writeregE, writeregM, writeregW, 
              regwriteE, regwriteM, regwriteW, 
              memtoregE, memtoregM, branchD,
              forwardaD, forwardbD, forwardaE, forwardbE,
              stallF, stallD, flushE);

  // next PC logic (operates in fetch and decode)
  mux2 #(32)  pcmux(pcplus4F, pcnextbrFD, pcsrcD, pcnextFD);

  // register file (operates in decode and writeback)
  regfile     rf(clk, regwriteW, rsD, rtD, writeregW,
                 resultW, srcaD, srcbD);

  // Fetch stage logic
  flopenr #(32) pcreg(clk, reset, ~stallF, pcnextFD, pcF);
  adder       pcadd1(pcF, 32'b100, pcplus4F);

  // Decode stage 
  flopenr #(32) r1D(clk, reset, ~stallD, pcplus4F, pcplus4D);
  flopenr #(32) r3D(clk, reset, ~stallD, pcF, pcD);
  flopenr #(32) r2D(clk, reset, ~stallD, instrF, instrD);
  signext     se(instrD[15:0], ~unsignedD, signimmD);
  mux2 #(32)  forwardadmux(srcaD, aluoutM, forwardaD, srca2D);
  mux2 #(32)  forwardbdmux(srcbD, aluoutM, forwardbD, srcb2D);
  eqcmp       comp(srca2D, srcb2D, equalD);
  adder       pcadd2(pcplus4D, 32'b100, pcplus8D);
  branchunit  bu(pcD, pcplus4D, srca2D, srcb2D, instrD[25:0], jumpD, branchD,
                 linkD, branchcontD, rdsrcD, pcsrcD, pcnextbrFD);
  mux2 #(5)  rdmux(rdD, 5'b11111, rdsrcD, rd2D);

  // Instruction breakdown
  assign opD = instrD[31:26];
  assign functD = instrD[5:0];
  assign rsD = instrD[25:21];
  assign rtD = instrD[20:16];
  assign rdD = instrD[15:11];

  // Execute stage 
  floprc #(32) r1E(clk, reset, flushE, srcaD, srcaE);
  floprc #(32) r2E(clk, reset, flushE, srcbD, srcbE);
  floprc #(32) r3E(clk, reset, flushE, signimmD, signimmE);
  floprc #(32) r7E(clk, reset, flushE, pcplus8D, pcplus8E);
  floprc #(5)  r4E(clk, reset, flushE, rsD, rsE);
  floprc #(5)  r5E(clk, reset, flushE, rtD, rtE);
  floprc #(5)  r6E(clk, reset, flushE, rd2D, rdE);
  mux3 #(32)  forwardaemux(srcaE, resultW, aluoutM, forwardaE, srca2E);
  mux3 #(32)  forwardbemux(srcbE, resultW, aluoutM, forwardbE, srcb2E);
  mux2 #(32)  srcbmux(srcb2E, signimmE, alusrcE, srcb3E);

  alu         alu(srca2E, srcb3E, alushcontrolE, aluresultE);
  shifter     shifter(srca2E, srcb3E, alushcontrolE, signimmE[10:6],
                      shiftresultE);
  mux2 #(32)  alushmux(aluresultE, shiftresultE, aluoutsrcE, alushresultE);
  mux2 #(32)  alulinkmux(alushresultE, pcplus8E, linkE, aluoutE);

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
  // TODO: Don't stall for $0
  assign #1 branchstallD = branchD & 
             (regwriteE & (writeregE == rsD | writeregE == rtD) |
              memtoregM & (writeregM == rsD | writeregM == rtD));

  assign #1 stallD = lwstallD | branchstallD;
  assign #1 stallF = stallD; // stalling D stalls all previous stages
  assign #1 flushE = stallD; // stalling D flushes next stage

  // *** not necessary to stall D stage on store if source comes from load;
  // *** instead, another bypass network could be added from W to M
endmodule

module branchunit(input      [31:0] pc, 
                  input      [31:0] pcplusfour, 
                  input      [31:0] a, b,
                  input      [25:0] jumpimm, 
                  input             jump, branch, link,
                  input      [3:0]  branchcont,
                  output reg        rdsrc, /* when true, rd becomes 5'b11111 */
                  output reg        pcsrc, /* makes pcbranch the next instr. */
                  output reg [31:0] pcbranch);

  wire aeqz, aeqb, agtz, altz;
  wire lt, gt, eq, src;
  wire ltsat, gtsat, eqsat;
  wire [31:0] branchtarget;

  assign #1 {aeqz, aeqb, agtz, altz} = {a == 0, a == b, 
                                        ~a[31] & (a[30:0] !== 0), a[31]};

  assign #1 {lt, gt, eq, src} = branchcont;

  // Use PC not PC+4
  adder btadd(pc, {{14{jumpimm[15]}}, jumpimm[15:0], 2'b00}, branchtarget);

  always @ ( * )
    begin
      pcsrc = 1'b0;
      rdsrc = 1'b0;
      pcbranch = 32'hxxxxxxxx;
      if(jump) begin // Jump
        pcsrc = 1'b1;
        if(src) begin  // Jump using register
          pcbranch = a;
        end else begin // Jump using immediate
          pcbranch = {pc[31:27], jumpimm, 2'b00}; 
          rdsrc = link;
        end
      end else if(branch) begin // Branch
        // All linking branches link to register 31
        rdsrc = link;
        if(src) begin // Compare a and b
          if((eq & aeqb) | (~eq & ~aeqb)) begin
            pcsrc = 1'b1;
            pcbranch = branchtarget;
          end
        end else begin  // Compare a to zero
          if((~eq | aeqz) & (~gt | agtz) & (~lt | altz)) begin
            pcsrc = 1'b1;
            pcbranch = branchtarget;
          end else begin
            pcbranch = 32'hxxxxxxxx;
          end
        end
      end
    end
endmodule
           
module alu(input      [31:0] a, b, 
           input      [2:0]  control, 
           output reg [31:0] aluresult);

  wire [31:0] b2, sum, aorb;
  wire sltSigned, sltUnsigned;

  assign #1 b2 = control[2] ? ~b:b; 
  assign #1 sum = a + b2 + control[2];
  assign #1 sltSigned = sum[31];
  // a < b is an unsigned comparrison
  assign #1 sltUnsigned = a < b;
  assign #1 aorb = a | b;

  // ALU Unit
  always@( * )
    case(control[2:0])
      3'b000: aluresult <= #1 a & b;      // and
      3'b001: aluresult <= #1 aorb;       // or
      3'b010: aluresult <= #1 sum;        // add
      3'b110: aluresult <= #1 sum;        // sub
      3'b111: aluresult <= #1 sltSigned;  // slt signed
      3'b011: aluresult <= #1 sltUnsigned;// slt unsigned
      3'b100: aluresult <= #1 a ^ b;      // xor
      3'b101: aluresult <= #1 ~aorb;      // nor
      default: aluresult <= #1 32'hxxxxxxxx; 
    endcase
endmodule

module shifter(input signed [31:0] a, b,
               input        [2:0] control,
               input        [4:0] constshift,
               output       [31:0] shiftresult);

  wire lui, constant, left, associative, extensionval;
  wire [4:0] shiftamount;

  // We need to handle the special case where control = 4'b1111, this is the LUI
  // instruction (it is a left shift by 5'b10000)

  assign #1 lui = (control == 3'b111);
  assign #1 {constant, left, associative} = 
    {control[2:1], (lui ? 1'b0 : control[0])};
  assign #1 shiftamount = (constant
                            ? (lui ? 5'b10000 : constshift)
                            : a[4:0]);
  
  assign #1 extensionval = associative & b[31];
  
  assign shiftresult = (left ? (b << shiftamount) 
                             : associative ? (b >>> shiftamount)
                                           : (b >> shiftamount));

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

