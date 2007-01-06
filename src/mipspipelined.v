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
            output [3:0]  byteenM,
            output [31:0] aluoutM, writedataM,
            input  [31:0] readdataM,
            input         instrackF, dataackM);

  wire [5:0]  opD, functD;
  wire [4:0]  rsD, rtD, rdD;
  wire        regdstE, alusrcE, 
              unsignedD, rdsrcD, pcsrcFD, linkD, linkE, luiE,
              memtoregE, memtoregM, memtoregW, regwriteE, regwriteM, regwriteW,
              aeqzD, aeqbD, agtzD, altzD;
  wire [2:0]  alushcontrolE;
  wire [1:0]  pcbranchsrcD, aluoutsrcE;
  wire        flushE;
  wire [31:0] cop0readD, writedataW;
  wire [4:0]  writeregW;
  wire        re, swc, isc;

  controller c(clk, reset, opD, functD, rsD, rtD, flushE, aeqzD, aeqbD, agtzD, 
               altzD, memtoregE, memtoregM, memtoregW, memwriteM, byteenM, 
               branchD,
               alusrcE, unsignedD, unsignedE, regdstE, regwriteE, regwriteM, 
               regwriteW, jumpD, aluoutsrcE, alushcontrolE, linkD, linkE, luiE,
               rdsrcD, pcsrcFD, pcbranchsrcD, cop0writeW);
  datapath dp(clk, reset, memtoregE, memtoregM, memtoregW, branchD, 
              unsignedD, unsignedE, alusrcE, regdstE, regwriteE, regwriteM, 
              regwriteW, jumpD, aluoutsrcE, linkD, linkE, luiE,
              rdsrcD, pcsrcFD, pcbranchsrcD, alushcontrolE, cop0readD,
              pcF, instrF,
              aluoutM, writedataM, readdataM, instrackF, dataackM,
              opD, functD, rsD, rtD, rdD, aeqzD, aeqbD, agtzD, altzD, 
              flushE, 
              writedataW, writeregW);

  // cop0 fields: cop0readD, cop0writeW, writedataW, writeregW, rdD
  coprocessor0 cop0(clk, reset, cop0writeW, rdD, writeregW, writedataW, 
                    cop0readD, re, swc, isc);
endmodule

module controller(input        clk, reset,
                  input  [5:0] opD, functD,
                  input  [4:0] rsD, rtD,
                  input        flushE,
                  input        aeqzD, aeqbD, agtzD, altzD,
                  output       memtoregE, memtoregM, memtoregW, memwriteM,
                  output [3:0] byteenM,
                  output       branchD, alusrcE, unsignedD, unsignedE,
                  output       regdstE, regwriteE, regwriteM, regwriteW,
                  output       jumpD, 
                  output [1:0] aluoutsrcE, 
                  output [2:0] alushcontrolE, 
                  output       linkD, linkE, luiE,
                  output       rdsrcD, pcsrcFD, 
                  output [1:0] pcbranchsrcD,
                  output       cop0writeW);

  wire       memtoregD, memwriteD, alusrcD, mainregwrite, luiD,
             regdstD, regwriteD, maindecuseshifterD, maindecregdstD, 
             useshifterD, cop0readD, cop0writeD, rfeD; 
  reg  [1:0] aluoutsrcD;
  wire       ltD, gtD, eqD, brsrcD;
  wire [2:0] alushcontmaindecD, alushcontrolD;
  wire       memwriteE;
  wire       cop0writeE, cop0writeM;

  assign #1 regwriteD = mainregwrite | linkD | cop0readD;
  assign #1 regdstD = maindecregdstD | cop0writeD;

  // TODO: byte enable stuff
  assign #1 byteenM = 4'b1111;

  maindec md(opD, memtoregD, memwriteD,
             alusrcD, maindecregdstD, mainregwrite, unsignedD, luiD,
             maindecuseshifterD, alushcontmaindecD);

  alushdec  ad(functD, maindecuseshifterD, alushcontmaindecD, useshifterD,
             alushcontrolD);

  branchdec bd(opD, rtD, functD, jumpD, branchD, ltD, gtD, eqD, brsrcD, linkD);

  branchcontroller  bc(jumpD, branchD, linkD, aeqzD, aeqbD, agtzD, altzD, 
                       ltD, gtD, eqD, brsrcD, rdsrcD, pcsrcFD, pcbranchsrcD);
  
  cop0dec c0dec(opD, rsD, functD, cop0readD, cop0writeD, rfeD); 

  // Chooses which component is selected as aluout
  always @ ( * )
    if(linkD)
      aluoutsrcD <= 2'b10; // PC+8
    else if (cop0readD)
      aluoutsrcD <= 2'b11; // cop0 read
    else if (useshifterD)
      aluoutsrcD <= 2'b01; // shifter
    else
      aluoutsrcD <= 2'b00; // alu

  // pipeline registers
  floprc #(13) regE(clk, reset, flushE,
                  {memtoregD, memwriteD, alusrcD, regdstD, regwriteD, 
                  aluoutsrcD, alushcontrolD, unsignedD, luiD, cop0writeD}, 
                  {memtoregE, memwriteE, alusrcE, regdstE, regwriteE,  
                  aluoutsrcE, alushcontrolE, unsignedE, luiE, cop0writeE});
  flopr #(4) regM(clk, reset, 
                  {memtoregE, memwriteE, regwriteE, cop0writeE},
                  {memtoregM, memwriteM, regwriteM, cop0writeM});
  flopr #(3) regW(clk, reset, 
                  {memtoregM, regwriteM, cop0writeM},
                  {memtoregW, regwriteW, cop0writeW});
endmodule

module maindec(input  [5:0] op,
               output       memtoreg, memwrite,
               output       alusrc,
               output       regdst, regwrite, 
               output       unsignedD, lui, useshift,
               output [2:0] alushcontrol);

  reg [10:0] controls;
  
  assign {regwrite, /* regwrite is also enabled by branchdec and cop0dec */
          regdst,   /* regdst is also enabled by cop0dec */ 
          alusrc,
          memwrite,
          memtoreg, useshift, alushcontrol /* 3 bits */,
          unsignedD, lui} = controls;

  always @ ( * )
    case(op)
      6'b000000: controls <= 11'b11000010100; //R-type
      6'b000001: controls <= 11'b01000010100; //Opcode 1 (branches)
      6'b100011: controls <= 11'b10101001000; //LW
      6'b101011: controls <= 11'b00110001000; //SW
      6'b001000: controls <= 11'b10100001000; //ADDI (treated same as ADDIU)
      6'b001001: controls <= 11'b10100001000; //ADDIU
      6'b001010: controls <= 11'b10100011100; //SLTI
      6'b001011: controls <= 11'b10100001100; //SLTIU (imm _IS_ sign extended)
      6'b001100: controls <= 11'b10100000010; //ANDI
      6'b001101: controls <= 11'b10100000110; //ORI
      6'b001110: controls <= 11'b10100010010; //XORI
      6'b001111: controls <= 11'b10100101011; //LUI
      6'b000010: controls <= 11'b00000001000; //J
      6'b000011: controls <= 11'b11000001000; //JAL
      6'b000100: controls <= 11'b00000011000; //BEQ
      6'b000101: controls <= 11'b00000011000; //BNE
      6'b000110: controls <= 11'b00000011000; //BLEZ
      6'b000111: controls <= 11'b00000011000; //BGTZ
      6'b010000: controls <= 11'b00000001000; //MFC0, MTC0, RFE
      default:   
        begin
          controls <= 11'bxxxxxxxxxxx;  //???
          $stop;
        end
    endcase

endmodule

// ALU and Shifter decoders
module alushdec(input      [5:0] funct,
                input            maindecuseshifter, 
                input      [2:0] alushmaincontrol,
                output           useshifter, /* True when using shifts */
                output     [2:0] alushcontrol);

  reg [3:0] functcontrol;

  // The pattern 0101 indicates that we have an R-type and should use the 
  // funct code (0101 is also the nor command, of which there is no immediate
  // equivalent; hence 0101 is available)
  assign #1 {useshifter, alushcontrol} = 
    (({maindecuseshifter, alushmaincontrol} == 4'b0101) 
      ? functcontrol 
      : {maindecuseshifter, alushmaincontrol});

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
          // The lower 3 bits are: {constant, left, rightassociative}
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
                 output       lt, gt, eq, src,
                 output       link);

  reg [6:0] controls;

  assign #1 {jump, branch, lt, gt, eq, src, link} = controls;

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
          5'b00000: controls <= 7'b0110000;   // BLTZ
          5'b00001: controls <= 7'b0101100;   // BGEZ
          5'b10000: controls <= 7'b0110001;   // BLTZAL
          5'b10001: controls <= 7'b0101101;   // BGEZAL
          default:  controls <= 7'bxxxxxxx;   // Error, unsupported instruction
        endcase
      6'b000100: controls <= 7'b0100110;      // BEQ
      6'b000101: controls <= 7'b0111010;      // BNE
      6'b000110: controls <= 7'b0110100;      // BLEZ
      6'b000111: controls <= 7'b0101000;      // BGTZ
      default:   controls <= 7'b0000000;      // All others, no branching
    endcase
endmodule

module cop0dec(input [5:0] op,
               input [4:0] rs,
               input [5:0] funct,
               output      cop0read, cop0write, rfe);

  wire opcode16 = (op == 6'b010000);

  assign #1 cop0read = (opcode16 & (rs == 5'b00000));                    // MFC0
  assign #1 cop0write = (opcode16 & (rs == 5'b00100));                   // MTC0
  assign #1 rfe = (opcode16 & (rs == 5'b10000) & (funct == 6'b010000));  // RFE

endmodule

module datapath(input         clk, reset,
                input         memtoregE, memtoregM, memtoregW, 
                input         branchD, unsignedD, unsignedE,
                input         alusrcE, regdstE,
                input         regwriteE, regwriteM, regwriteW, 
                input         jumpD, 
                input  [1:0]  aluoutsrcE, 
                input         linkD, linkE, luiE,
                input         rdsrcD, pcsrcFD, 
                input  [1:0]  pcbranchsrcD,
                input  [2:0]  alushcontrolE,
                input  [31:0] cop0readD,
                output [31:0] pcF,
                input  [31:0] instrF,
                output [31:0] aluoutM, writedataM,
                input  [31:0] readdataM, 
                input         instrackF, dataackM,
                output [5:0]  opD, functD,
                output [4:0]  rsD, rtD, rdD,
                output        aeqzD, aeqbD, agtzD, altzD,
                output        flushE,
                output [31:0] writedataW,
                output [4:0]  writeregW);

  wire        forwardaD, forwardbD;
  wire [1:0]  forwardaE, forwardbE;
  wire        stallF, flushD;
  wire [4:0]  rd2D, rsE, rtE, rdE;
  wire [4:0]  writeregE, writeregM;
  wire [31:0] pcnextFD, pcnextbrFD, pcplus4F;
  wire [31:0] signimmD, signimmE;
  wire [31:0] srcaD, srca2D, srcaE, srca2E;
  wire [31:0] srcbD, srcb2D, srcbE, srcb2E, srcb3E;
  wire [31:0] pcD, pcplus4D, pcplus8D, pcplus8E, instrD, branchtargetD;
  wire [31:0] aluresultE, shiftresultE, cop0readE;
  wire [31:0] aluoutE, aluoutW;
  wire [31:0] readdataW, resultW;


  // hazard detection
  hazard    h(rsD, rtD, rsE, rtE, writeregE, writeregM, writeregW, 
              regwriteE, regwriteM, regwriteW, 
              memtoregE, memtoregM, branchD,
              instrackF, dataackM,
              forwardaD, forwardbD, forwardaE, forwardbE,
              stallF, stallD, flushD, flushE);

  // next PC logic (operates in fetch and decode)
  mux2 #(32)  pcmux(pcplus4F, pcnextbrFD, pcsrcFD, pcnextFD);

  // register file (operates in decode and writeback)
  regfile     rf(clk, regwriteW, rsD, rtD, writeregW,
                 resultW, srcaD, srcbD);

  // Fetch stage logic
  flopenr #(32) pcreg(clk, reset, ~stallF, pcnextFD, pcF);
  adder       pcadd1(pcF, 32'b100, pcplus4F);

  // Decode stage 
  flopenr #(32) r1D(clk, reset, ~stallD, pcplus4F, pcplus4D);
  flopenr #(32) r3D(clk, reset, ~stallD, pcF, pcD);
  flopenrc #(32) r2D(clk, reset, ~stallD, flushD, instrF, instrD);
  signext     se(instrD[15:0], ~unsignedD, signimmD);
  mux2 #(32)  forwardadmux(srcaD, aluoutM, forwardaD, srca2D);
  mux2 #(32)  forwardbdmux(srcbD, aluoutM, forwardbD, srcb2D);
  eqcmp       comp(srca2D, srcb2D, equalD);
  adder       pcadd2(pcplus4D, 32'b100, pcplus8D);
  adder btadd(pcD, {{14{instrD[15]}}, instrD[15:0], 2'b00}, branchtargetD);
  assign #1 {aeqzD, aeqbD, agtzD, altzD} = {srca2D == 0, srca2D == srcb2D, 
                                            ~srca2D[31] & (srca2D[30:0] !== 0),
                                            srca2D[31]};
  mux3 #(32)  pcbranchmux(branchtargetD, {pcD[31:28], instrD[25:0], 2'b00}, 
                          srca2D, pcbranchsrcD, pcnextbrFD);
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
  floprc #(5)  r4E(clk, reset, flushE, rsD, rsE);
  floprc #(5)  r5E(clk, reset, flushE, rtD, rtE);
  floprc #(5)  r6E(clk, reset, flushE, rd2D, rdE);
  floprc #(32) r7E(clk, reset, flushE, pcplus8D, pcplus8E);
  floprc #(32) r8E(clk, reset, flushE, cop0readD, cop0readE);
  mux3 #(32)  forwardaemux(srcaE, resultW, aluoutM, forwardaE, srca2E);
  mux3 #(32)  forwardbemux(srcbE, resultW, aluoutM, forwardbE, srcb2E);
  mux2 #(32)  srcbmux(srcb2E, signimmE, alusrcE, srcb3E);

  alu         alu(srca2E, srcb3E, alushcontrolE, aluresultE);
  shifter     shifter(srca2E, srcb3E, alushcontrolE, luiE, signimmE[10:6],
                      shiftresultE);
  mux4 #(32)  aluoutmux(aluresultE, shiftresultE, pcplus8E, cop0readE, 
                        aluoutsrcE, aluoutE);

  mux2 #(5)   wrmux(rtE, rdE, regdstE, writeregE);

  // Memory stage
  flopr #(32) r1M(clk, reset, srcb2E, writedataM);
  flopr #(32) r2M(clk, reset, aluoutE, aluoutM);
  flopr #(5)  r3M(clk, reset, writeregE, writeregM);

  // Writeback stage
  flopr #(32) r1W(clk, reset, aluoutM, aluoutW);
  flopr #(32) r2W(clk, reset, readdataM, readdataW);
  flopr #(5)  r3W(clk, reset, writeregM, writeregW);
  flopr #(32) r4W(clk, reset, writedataM, writedataW);
  mux2 #(32)  resmux(aluoutW, readdataW, memtoregW, resultW);

endmodule

module coprocessor0(input             clk, reset,
                    input             cop0writeW, 
                    input      [4:0]  readaddress, writeaddress,
                    input      [31:0] writecop0W,
                    output reg [31:0] readvalue,
                    output            re,   // reverse endianess
                                      swc,  // swap caches
                                      isc); // isolate cache

  wire [31:0] reg12;
  wire [7:0]  im;    // Interupt mask

  statusregunit sr(clk, reset, cop0writeW & (writeaddress == 5'b01100), 
                   writecop0W, reg12, re, im, swc, isc);

  always @ ( * )
    case(readaddress)
      5'b01100: readvalue <= reg12;
      default:  readvalue <= 32'hxxxxxxxx;
    endcase
endmodule 

module statusregunit(input             clk, reset, writeenable,
                     input      [31:0] writedata,
                     output reg [31:0] statusreg,
                     output            re, 
                     output     [7:0]  im,
                     output            swc, isc);



wire cu1, bev, ts, pe, cm, pz, kuo, ieo, kup, iep, kuc, iec;

assign cu1 = 0; // No floating point unit
assign pe = 0;  // No parity checking
assign cm = 0;  // Isolated cache feature, not yet implemented
assign pz = 0;  // Archaic parity feature, not implemented

assign re  = statusreg[25];  // reverse endianness
assign bev = statusreg[22];  // not currently implemented
assign ts  = statusreg[21];  // TLB not implemented
assign {swc, isc, im} = statusreg[17:7];

assign {kuo, ieo, kup, iep, kuc, iec} = 6'b0; // No user vs kernel mode


always @ ( negedge clk )
  begin
    if(writeenable) begin
      statusreg = writedata;
      statusreg[31:30] = 0;
      statusreg[29]    = cu1;
      // bit 28 (cu0) will not effect the chip since we only run in kernel mode
      statusreg[27:26] = 0;
      // 25 is re
      statusreg[24:23] = 0;
      // 22 and 21 are bev and ts
      statusreg[20] = pe;
      statusreg[19] = cm;
      statusreg[18] = pz;
      // 17 to 8 are swc, isc, and im
      statusreg[7:6] = 0;
      statusreg[5:0] = {kuo, ieo, kup, iep, kuc, iec};
    end
  end
endmodule


module hazard(input  [4:0] rsD, rtD, rsE, rtE, 
              input  [4:0] writeregE, writeregM, writeregW,
              input        regwriteE, regwriteM, regwriteW,
              input        memtoregE, memtoregM, branchD, 
              input        instrackF, dataackM,
              output           forwardaD, forwardbD,
              output reg [1:0] forwardaE, forwardbE,
              output       stallF, stallD, flushD, flushE);

  wire lwstallD, branchstallD, instrmissF, datamissM;

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

  // (This stall was not implemented in R2000)
  assign #1 lwstallD = memtoregE & (rtE == rsD | rtE == rtD);

  // Cache miss delays
  assign #1 datamissM = memtoregM & ~dataackM;

  // This assumes we are reading an instruction every cycle
  assign #1 instrmissF = ~instrackF;

  assign #1 branchstallD = branchD & 
             (regwriteE & ((rsD != 0 & writeregE == rsD) | 
                          (rtD != 0 & writeregE == rtD)) |
              memtoregM & ((rsD != 0 & writeregM == rsD) | 
                          (rtD != 0 & writeregM == rtD)));

  assign #1 stallD = lwstallD | branchstallD | datamissM;
  assign #1 stallF =   stallD      // stalling D stalls all previous stages
                     | instrmissF; // Stall on instruction cache miss

  assign #1 flushD = instrmissF;   // Flush decoder if the instruction is not 
                                   // yet available to enter the decode stage
  assign #1 flushE = stallD; // stalling D flushes next stage

  // *** not necessary to stall D stage on store if source comes from load;
  // *** instead, another bypass network could be added from W to M
endmodule

module branchcontroller(input             jump, branch, link,
                        input             aeqz, aeqb, agtz, altz,
                        input             lt, gt, eq, src,
                        output reg        rdsrc, 
                        output reg        pcsrc,
                        output reg  [1:0] pcbranchsrc);

  always @ ( * )
    begin
      pcsrc = 1'b0;
      rdsrc = 1'b0;
      pcbranchsrc = 2'b00; // This is really a don't care
      if(jump) begin // Jump
        pcsrc = 1'b1;
        if(src) begin  // Jump using register
          pcbranchsrc = 2'b10;
        end else begin // Jump using immediate
          pcbranchsrc = 2'b01;
          rdsrc = link;
        end
      end else if(branch) begin // Branch
        // All linking branches link to register 31
        rdsrc = link;
        pcbranchsrc = 2'b00;
        if(src) begin // Compare a and b
          if((eq & aeqb) | (~eq & ~aeqb)) begin
            pcsrc = 1'b1;
          end
        end else begin  // Compare a to zero
          if((~eq & ~lt & ~gt) | (eq & aeqz) | (gt & agtz) | (lt & altz)) begin
            pcsrc = 1'b1;
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
    endcase
endmodule

module shifter(input signed [31:0] a, b,
               input        [2:0] control,
               input              lui,
               input        [4:0] constshift,
               output       [31:0] shiftresult);

  wire [31:0] leftlogical, rightlogical, rightassociative;
  wire [4:0] shiftamount;

  assign leftlogical      = b << shiftamount;
  assign rightlogical     = b >> shiftamount;
  assign rightassociative = b >>> shiftamount;

  // The control bits are: {constant, left, rightassociative}
 
  mux3 #(5)  shamtmux(a[4:0],     // Variable shift taken from a register
                      constshift, // Shift taken from the immediate value
                      5'b10000,   // LUI always shifts by 16
                      {lui, control[2]}, shiftamount);

  mux3 #(32) shresmux(rightlogical, rightassociative, leftlogical, control[1:0],
                      shiftresult);
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

module mux4 #(parameter WIDTH = 8)
             (input  [WIDTH-1:0] d0, d1, d2, d3,
              input  [1:0]       s, 
              output [WIDTH-1:0] y);

  assign #1 y = s[1] ? (s[0] ? d3 : d2)
                     : (s[0] ? d1 : d0); 
endmodule
