//------------------------------------------------
// mipspipelined.v
//
// Authors
// David Harris David_Harris at hmc dot edu 3 November 2005
// Carl Nygaard carlpny at gmail dot com 2007
// Thomas Barr tbarr at hmc do edu 2007
// Matt Totino mtotino at hmc.edu 2007
// Nathaniel Pinckney npinckney at gmail dot com
//
// Pipelined MIPS processor
//------------------------------------------------

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
              unsignedD, loadsignedM, rdsrcD, linkD, linkE, luiE,
              overflowableE, overflowE,
              memtoregE, memtoregM, memtoregW, regwriteE, regwriteM, regwriteW,
              byteM, hardwordM,
              aeqzD, aeqbD, agtzD, altzD,
              bdsF, bdsD, bdsE, bdsM,
              syscallE, breakE, riI, fpu,
              adesableE, adelableE, adesthrownE, misaligned;
  wire [2:0]  alushcontrolE;
  wire [1:0]  pcbranchsrcD, aluoutsrcE, pcsrcFD, excstage;
  wire        flushE, flushM;
  wire [31:0] cop0readD, writedataW;
  wire [31:0] pcD, pcE, pcM, pcW;
  wire [4:0]  writeregW;

  // Globals
  wire        re, swc, isc, exception;

  controller c(clk, reset, exception, opD, functD, rsD, rtD, flushE, flushM,
               aeqzD, aeqbD, agtzD, altzD, 
               memtoregE, memtoregM, memtoregW, memwriteM, 
               byteM, halfwordM, branchD,
               alusrcE, unsignedD, loadsignedM,
               regdstE, regwriteE, regwriteM, 
               regwriteW, jumpD, overflowableE,
               aluoutsrcE, alushcontrolE, linkD, linkE, luiE,
               rdsrcD, pcsrcFD, pcbranchsrcD, cop0writeW, 
               bdsF, bdsD, bdsE, bdsM,
               syscallE, breakE, riI, fpuE,
               adesableE, adelableE, adesthrownE);
  datapath dp(clk, reset, memtoregE, memtoregM, memtoregW, byteM, halfwordM,
              branchD, 
              unsignedD, loadsignedM, alusrcE, regdstE, regwriteE, 
              regwriteM, regwriteW, jumpD, aluoutsrcE, linkD, linkE, luiE,
              rdsrcD, pcsrcFD, pcbranchsrcD, alushcontrolE, cop0readD,
              pcF, pcD, pcE, pcM, pcW, instrF,
              aluoutM, writedataM, readdataM, instrackF, dataackM, 
              exception, excstage,
              opD, functD, rsD, rtD, rdD, aeqzD, aeqbD, agtzD, altzD, 
              flushE, flushM, overflowE,
              writedataW, writeregW, byteenM, misaligned);

  coprocessor0 cop0(clk, reset, cop0writeW, rdD, writeregW, writedataW, 
                    overflowableE, overflowE, pcF, pcD, pcE, pcM, pcW,
                    bdsF, bdsD, bdsE, bdsM,
                    syscallE, breakE, riI, fpuE,
                    adesableE, adelableE, adesthrownE, misaligned, 
                    cop0readD, re, swc, isc, exception, excstage
                    );
endmodule

module controller(input        clk, reset, exception,
                  input  [5:0] opD, functD,
                  input  [4:0] rsD, rtD,
                  input        flushE, flushM,
                  input        aeqzD, aeqbD, agtzD, altzD,
                  output       memtoregE, memtoregM, memtoregW, memwriteM,
                  output       byteM, halfwordM,
                  output       branchD, alusrcE, unsignedD, 
                  output       loadsignedM,
                  output       regdstE, regwriteE, regwriteM, regwriteW,
                  output       jumpD, overflowableE,
                  output [1:0] aluoutsrcE, 
                  output [2:0] alushcontrolE, 
                  output       linkD, linkE, luiE,
                  output       rdsrcD, 
                  output [1:0] pcsrcFD, pcbranchsrcD,
                  output       cop0writeW, bdsF, bdsD, bdsE, bdsM,
                  output       syscallE, breakE, riI, fpuE,
                  output       adesableE, adelableE, adesthrownE);

  wire       memtoregD, memwriteD, alusrcD, mainregwrite, luiD,
             regdstD, regwriteD, maindecuseshifterD, maindecregdstD, 
             alushdecoverflowableD, maindecoverflowableD, overflowableD,
             useshifterD, cop0readD, cop0writeD, rfeD,
             loadsignedD, loadsignedE,
	           syscallD, breakD, riD, fpuD,
             adesableD, adelableD, adesthrownD;
  wire       byteD, halfwordD, byteE, halfwordE;
  reg  [1:0] aluoutsrcD;
  wire       ltD, gtD, eqD, brsrcD;
  wire [2:0] alushcontmaindecD, alushcontrolD;
  wire       memwriteE;
  wire       cop0writeE, cop0writeM;

  assign #1 regwriteD = mainregwrite | linkD | cop0readD;
  assign #1 regdstD = maindecregdstD | cop0writeD;
  assign #1 overflowableD = maindecoverflowableD | alushdecoverflowableD;
  assign #1 bdsF = branchD | jumpD;

  maindec md(opD, memtoregD, memwriteD, byteD, halfwordD, loadsignedD,
             alusrcD, maindecregdstD, mainregwrite, unsignedD, luiD,
             maindecuseshifterD, maindecoverflowableD, alushcontmaindecD,
             syscallD, breakD, riD, fpuD, adesableD, adelableD);

  alushdec  ad(functD, maindecuseshifterD, alushcontmaindecD, useshifterD,
             alushcontrolD, alushdecoverflowableD);

  branchdec bd(opD, rtD, functD, jumpD, branchD, ltD, gtD, eqD, brsrcD, linkD);

  branchcontroller  bc(reset, exception, jumpD, branchD, linkD, aeqzD, aeqbD, 
                       agtzD, altzD, 
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
  floprc #(1) regD(clk, reset, flushE, {bdsF}, {bdsD});
  floprc #(24) regE(clk, reset, flushE,
                  {memtoregD, memwriteD, alusrcD, regdstD, regwriteD, 
                  aluoutsrcD, alushcontrolD, loadsignedD, luiD, cop0writeD,
                  byteD, halfwordD, overflowableD, bdsD,
		              syscallD, breakD, riD, fpuD,
		              adesableD, adelableD, adesthrownD}, 
                  {memtoregE, memwriteE, alusrcE, regdstE, regwriteE,  
                  aluoutsrcE, alushcontrolE, loadsignedE, luiE, cop0writeE,
                  byteE, halfwordE, overflowableE, bdsE,
		              syscallE, breakE, riE, fpuE,
		              adesableE, adelableE, adesthrownE});
  floprc #(8) regM(clk, reset, flushM,
                  {memtoregE, memwriteE, regwriteE, cop0writeE, loadsignedE,
                  byteE, halfwordE, bdsE},
                  {memtoregM, memwriteM, regwriteM, cop0writeM, loadsignedM,
                  byteM, halfwordM, bdsM});
  flopr #(3) regW(clk, reset, 
                  {memtoregM, regwriteM, cop0writeM},
                  {memtoregW, regwriteW, cop0writeW});
endmodule

module maindec(input  [5:0] op,
               output       memtoreg, memwrite, byte, halfword, loadsignedD,
               output       alusrc,
               output       regdst, regwrite, 
               output       unsignedD, lui, useshift, overflowable,
               output [2:0] alushcontrol,
               output       syscallD, breakD, riD, fpuD,
               output       adesableD, adelableD);

  reg [14:0] controls;
 
  assign {regwrite, /* regwrite is also enabled by branchdec and cop0dec */
          regdst,   /* regdst is also enabled by cop0dec */ 
          overflowable, /* overflowable is also enabled by alushdec */
          alusrc,
          memwrite,
          memtoreg, byte, halfword, loadsignedD,
          useshift, alushcontrol /* 3 bits */,
          unsignedD, lui} = controls;

  // we're just wiring it together for now.	  
  assign { syscallD, breakD, riD, fpuD, adesableD, adelableD } = 6'b000000;

  always @ ( * )
    case(op)
      6'b000000: controls <= 15'b110000000010100; //R-type
      6'b000001: controls <= 15'b010000000010100; //Opcode 1 (branches)
      6'b100000: controls <= 15'b100101101001000; //LB (assume big endian)
      6'b100001: controls <= 15'b100101011001000; //LH
      6'b100011: controls <= 15'b100101001001000; //LW
      6'b100100: controls <= 15'b100101100001010; //LBU
      6'b100101: controls <= 15'b100101010001010; //LHU
      6'b101000: controls <= 15'b000110100001000; //SB
      6'b101001: controls <= 15'b000110010001000; //SH
      6'b101011: controls <= 15'b000110000001000; //SW
      6'b001000: controls <= 15'b101100000001000; //ADDI (treated as ADDIU)
      6'b001001: controls <= 15'b100100000001000; //ADDIU
      6'b001010: controls <= 15'b100100000011100; //SLTI
      6'b001011: controls <= 15'b100100000001100; //SLTIU 
      6'b001100: controls <= 15'b100100000000010; //ANDI
      6'b001101: controls <= 15'b100100000000110; //ORI
      6'b001110: controls <= 15'b100100000010010; //XORI
      6'b001111: controls <= 15'b100100000101011; //LUI
      6'b000010: controls <= 15'b000000000001000; //J
      6'b000011: controls <= 15'b110000000001000; //JAL
      6'b000100: controls <= 15'b000000000011000; //BEQ
      6'b000101: controls <= 15'b000000000011000; //BNE
      6'b000110: controls <= 15'b000000000011000; //BLEZ
      6'b000111: controls <= 15'b000000000011000; //BGTZ
      6'b010000: controls <= 15'b000000000001000; //MFC0, MTC0, RFE
      default:   
        begin
          // TODO: unknown opcodes should throw an exception
          controls <= 15'bxxxxxxxxxxxxxxx;  //???
          //$stop;
        end
    endcase

endmodule

// ALU and Shifter decoders
module alushdec(input      [5:0] funct,
                input            maindecuseshifter, 
                input      [2:0] alushmaincontrol,
                output           useshifter, /* True when using shifts */
                output     [2:0] alushcontrol,
                output           overflowable);

  reg [3:0] functcontrol;
  wire usefunct;

  // The pattern 0101 indicates that we have an R-type and should use the 
  // funct code (0101 is also the nor command, of which there is no immediate
  // equivalent; hence 0101 is available)
  assign #1 usefunct = ({maindecuseshifter, alushmaincontrol} == 4'b0101);
  assign #1 {useshifter, alushcontrol} = 
    (usefunct ? functcontrol : {maindecuseshifter, alushmaincontrol});

  assign #1 overflowable = (usefunct &   (funct == 6'b100000)   // ADD
                                       | (funct == 6'b100010)); // SUB
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

  // TODO: move signals like this to the main decoder            
  wire opcode16 = (op == 6'b010000);

  assign #1 cop0read = (opcode16 & (rs == 5'b00000));                    // MFC0
  assign #1 cop0write = (opcode16 & (rs == 5'b00100));                   // MTC0
  assign #1 rfe = (opcode16 & (rs == 5'b10000) & (funct == 6'b010000));  // RFE

endmodule

module datapath(input         clk, reset,
                input         memtoregE, memtoregM, memtoregW, byteM, halfwordM,
                input         branchD, unsignedD, loadsignedM,
                input         alusrcE, regdstE,
                input         regwriteE, regwriteM, regwriteW, 
                input         jumpD, 
                input  [1:0]  aluoutsrcE, 
                input         linkD, linkE, luiE,
                input         rdsrcD, 
                input  [1:0]  pcsrcFD, pcbranchsrcD,
                input  [2:0]  alushcontrolE,
                input  [31:0] cop0readD,
                output [31:0] pcF, pcD, pcE, pcM, pcW,
                input  [31:0] instrF,
                output [31:0] aluoutM, writedata2M,
                input  [31:0] readdataM, 
                input         instrackF, dataackM, exception,
                input  [1:0]  excstage,
                output [5:0]  opD, functD,
                output [4:0]  rsD, rtD, rdD,
                output        aeqzD, aeqbD, agtzD, altzD,
                output        flushE, flushM, overflowE,
                output [31:0] writedataW,
                output [4:0]  writeregW,
                output [3:0]  byteenM,
                output        misaligned);

  parameter RESETVECTORUNCACHED = 32'hbfc00000;
  parameter EXCEPTIONVECTORUNCACHED = 32'hbfc00100;
  // Curretly, cached exceptions are not supported
  parameter EXCEPTIONVECTORCACHED = 32'h9fc00100;  // TODO: Double-check value

  wire        forwardaD, forwardbD;
  wire [1:0]  forwardaE, forwardbE;
  wire        stallF, flushD;
  wire [4:0]  rd2D, rsE, rtE, rdE;
  wire [4:0]  writeregE, writeregM;
  wire [31:0] writedataM;
  wire [7:0]  rbyteM;
  wire [15:0] rhalfwordM;
  wire [31:0] rbyteextM, rhalfwordextM, readdata2M;
  wire [3:0]  bytebyteenM, halfwordbyteenM;
  wire [31:0] pcnextFD, pcnextbrFD, pcplus4F;
  wire [31:0] signimmD, signimmE;
  wire [31:0] srcaD, srca2D, srcaE, srca2E;
  wire [31:0] srcbD, srcb2D, srcbE, srcb2E, srcb3E;
  wire [31:0] pcplus8D, pcplus8E, instrD, branchtargetD;
  wire [31:0] aluresultE, shiftresultE, cop0readE;
  wire [31:0] aluoutE, aluoutW;
  wire [31:0] readdataW, resultW;


  // hazard detection
  hazard    h(rsD, rtD, rsE, rtE, writeregE, writeregM, writeregW, 
              regwriteE, regwriteM, regwriteW, 
              memtoregE, memtoregM, branchD,
              instrackF, dataackM, exception, excstage,
              forwardaD, forwardbD, forwardaE, forwardbE,
              stallF, stallD, flushD, flushE, flushM);

  // next PC logic (operates in fetch and decode)
  mux4 #(32)  pcmux(RESETVECTORUNCACHED, EXCEPTIONVECTORUNCACHED,
                    pcplus4F, pcnextbrFD, pcsrcFD, pcnextFD); 

  // register file (operates in decode and writeback)
  regfile     rf(clk, regwriteW, rsD, rtD, writeregW,
                 resultW, srcaD, srcbD);

  // Fetch stage logic
  flopenr #(32) pcreg(clk, reset, ~stallF, pcnextFD, pcF);
  adder       pcadd1(pcF, 32'b100, pcplus4F);

  // Decode stage 
  flopenr #(32) r3D(clk, reset, ~stallD, pcF, pcD);
  flopenrc #(32) r2D(clk, reset, ~stallD, flushD, instrF, instrD);
  signext #(16,32) se(instrD[15:0], ~unsignedD, signimmD);
  mux2 #(32)  forwardadmux(srcaD, aluoutM, forwardaD, srca2D);
  mux2 #(32)  forwardbdmux(srcbD, aluoutM, forwardbD, srcb2D);
  eqcmp       comp(srca2D, srcb2D, equalD);
  adder       pcadd2(pcD, 32'b1000, pcplus8D);
  adder btadd(pcD, {signimmD[29:0], 2'b00}, branchtargetD);
  // TODO: Make these into individual modules
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
  floprc #(32) r9E(clk, reset, flushE, pcD, pcE);
  mux3 #(32)  forwardaemux(srcaE, resultW, aluoutM, forwardaE, srca2E);
  mux3 #(32)  forwardbemux(srcbE, resultW, aluoutM, forwardbE, srcb2E);
  mux2 #(32)  srcbmux(srcb2E, signimmE, alusrcE, srcb3E);
  alu         alu(srca2E, srcb3E, alushcontrolE, aluresultE, overflowE);
  shifter     shifter(srca2E, srcb3E, alushcontrolE, luiE, signimmE[10:6],
                      shiftresultE);
  mux4 #(32)  aluoutmux(aluresultE, shiftresultE, pcplus8E, cop0readE, 
                        aluoutsrcE, aluoutE);

  mux2 #(5)   wrmux(rtE, rdE, regdstE, writeregE);
  assign misaligned = aluoutE[1] | aluoutE[0];

  // Memory stage
  floprc #(32) r1M(clk, reset, flushM, srcb2E, writedataM);
  floprc #(32) r2M(clk, reset, flushM, aluoutE, aluoutM);
  floprc #(5)  r3M(clk, reset, flushM, writeregE, writeregM);
  floprc #(32)  r4M(clk, reset, flushM, pcE, pcM);
  mux3 #(32) wdatamux(writedataM, {writedataM[15:0], writedataM[15:0]}, 
                      {writedataM[7:0], writedataM[7:0], writedataM[7:0], 
                       writedataM[7:0]}, 
                      {byteM, halfwordM}, writedata2M);
  // Byte encoding logic for store operations
  dec2 bytebyteendec(aluoutM[1:0], bytebyteenM);
  mux2 #(4) halfwbyteendec(4'b0011, 4'b1100, aluoutM[1], halfwordbyteenM);
  mux3 #(4) byteenmux(4'b1111, halfwordbyteenM, bytebyteenM, 
                      {byteM, halfwordM}, byteenM);
  // Load conversionts
  mux4 #(8) rbytemux(readdataM[7:0], readdataM[15:8], readdataM[23:16], 
                        readdataM[31:24], aluoutM[1:0], rbyteM);
  mux2 #(16) rhalfwordmux(readdataM[15:0], readdataM[31:16], aluoutM[1],
                          rhalfwordM);
  signext #(8, 32) rbytesignext(rbyteM, loadsignedM, rbyteextM);
  signext #(16, 32) rhalfwsignext(rhalfwordM, loadsignedM, rhalfwordextM);
  mux3 #(32) readmux(readdataM, rhalfwordextM, rbyteextM, {byteM, halfwordM},
                     readdata2M);

  // Writeback stage
  flopr #(32) r1W(clk, reset, aluoutM, aluoutW);
  flopr #(32) r2W(clk, reset, readdata2M, readdataW);
  flopr #(5)  r3W(clk, reset, writeregM, writeregW);
  flopr #(32) r4W(clk, reset, writedataM, writedataW);
  flopr #(32) r5W(clk, reset, pcM, pcW);
  mux2 #(32)  resmux(aluoutW, readdataW, memtoregW, resultW);

endmodule

module coprocessor0(input             clk, reset,
                    input             cop0writeW, 
                    input      [4:0]  readaddress, writeaddress,
                    input      [31:0] writecop0W,
                    input             overflowableE, overflowE,
                    input      [31:0] pcF, pcD, pcE, pcM, pcW,
                    input             bdsF, bdsD, bdsE, bdsM,
                    input             syscallE, breakE, riI, fpuE,
                    input             adesableE, adelableE, adesthrownE, misaligned,  
                    output reg [31:0] readvalue,
                    output            re,   // reverse endianess
                                      swc,  // swap caches
                                      isc,  // isolate cache
                                      exception,
                    output     [1:0]  excstage
                    );

  wire [31:0] statusreg, causereg, epc;
  wire [7:0]  im;    // Interupt mask
  wire [4:0]  exccode;
  wire        branchdelay; 

  // To become inputs some time:
  wire [7:0]  pendinginterupts;
  assign #1 pendinginterupts = 0;


  exceptionunit excu(clk, reset, overflowableE, overflowE, 
                     bdsF, bdsD, bdsE, bdsM,
                     syscallE, breakE, riI, fpuE,
                     adesableE, adelableE, adesthrownE, misaligned,
                     exception, branchdelay, exccode, 
                     excstage);
  epcunit       epcu(clk, exception, branchdelay, excstage, pcF, pcD, pcE, pcM,
                     pcW, epc);
  statusregunit sr(clk, reset, cop0writeW & (writeaddress == 5'b01100), 
                   writecop0W, statusreg, re, im, swc, isc);
  causeregunit  cr(clk, branchdelay, pendinginterupts, exccode, 
                   exception, /* write enable determined by exception */
                   causereg);
   
  // All cop0 registers can be read
  always @ ( * )
    case(readaddress)
      5'b01100: readvalue <= statusreg;
      5'b01101: readvalue <= causereg;
      5'b01110: readvalue <= epc;
      default:  readvalue <= 32'hxxxxxxxx;
    endcase
endmodule 

module exceptionunit(input            clk, reset,
                     input            overflowableE, overflowE,
                     input            bdsF, bdsD, bdsE, bdsM,
                     input            syscallE, breakE, riI, fpuE,
                     input            adesableE, adelableE, adesthrownE, misaligned,
                     output reg       exception, branchdelay,
                     output reg [4:0] exccode, 
                     output reg [1:0] excstage);

  // TODO: worry about undesired startup exceptions

  // excstage is the stage exception occured in
  // 0 = Fetch, 1 = Decode, 2 = Execute, 3 = Memory
  // (assume writeback does not have exceptions)

  always @ ( * ) // Using posedge clk would add extra clock sycle and likely 
                 // offset everything by one, rendering some of the
                 // subsequent logic incorrect.  Check me on this though.
    begin
      exception = 0;
      branchdelay = 0;
      // This if-tree emphasizes the priority of exceptions.
      if(overflowableE & overflowE) begin
        exception = 1;
        exccode = 12;       // Overflow
        excstage = 2;       // Stage E
        branchdelay = bdsE;
      end
    end
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
        // bit 28 (cu0) will not have effect since we only run in kernel mode
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

module causeregunit(input             clk, branchdelay,
                    input      [7:0]  pendinginterupts,
                    input      [4:0]  exccode,
                    input             writeenable,
                    output reg [31:0] causereg);

  always @ ( posedge clk )
    if(writeenable) begin
      causereg[31] = branchdelay;
      causereg[30] = 0;
      causereg[29:28] = 0; // Coprocessor error -- not sure what's good for
      causereg[27:16] = 0;
      causereg[15:8] = pendinginterupts;
      causereg[7] = 0;
      causereg[6:2] = exccode;
      causereg[1:0] = 0;
    end
endmodule

module epcunit(input             clk, exception, branchdelay,
               input      [1:0]  excstage,
               input      [31:0] pcF, pcD, pcE, pcM, pcW,
               output reg [31:0] epc);

  always @ ( posedge clk )
      if(exception)
        case(excstage)
          2'b00: epc <= (branchdelay ? pcD : pcF);
          2'b01: epc <= (branchdelay ? pcE : pcD);
          2'b10: epc <= (branchdelay ? pcM : pcE);
          2'b11: epc <= (branchdelay ? pcW : pcM);
        endcase
endmodule



module hazard(input  [4:0]     rsD, rtD, rsE, rtE, 
              input  [4:0]     writeregE, writeregM, writeregW,
              input            regwriteE, regwriteM, regwriteW,
              input            memtoregE, memtoregM, branchD, 
              input            instrackF, dataackM, exception,
              input  [1:0]     excstage,
              output           forwardaD, forwardbD,
              output reg [1:0] forwardaE, forwardbE,
              output           stallF, stallD, flushD, flushE, flushM);

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

  assign #1 flushD =   instrmissF  // Flush decoder if the instruction is not 
                                   // yet available to enter the decode stage
                     | exception;  // All exceptions invalidate the decod stage

  assign #1 flushE =   stallD // stalling D flushes next stage
                     | (exception & excstage != 2'b00); // flush decoder on all 
                                                        // exceptions but those
                                                        // in the fetch stage
  // flush memory stage when we need to throw out an ALU computation, such as
  // when there is an arithmetic overflow
  assign #1 flushM = (exception & (excstage == 2'b10 | excstage == 2'b11)); 

  // *** not necessary to stall D stage on store if source comes from load;
  // *** instead, another bypass network could be added from W to M
endmodule

module branchcontroller(input             reset, exception, jump, branch, link,
                        input             aeqz, aeqb, agtz, altz,
                        input             lt, gt, eq, src,
                        output reg        rdsrc, 
                        output reg  [1:0] pcsrc,
                        output reg  [1:0] pcbranchsrc);

  always @ ( * )
    begin
      pcsrc = 2'b10; // Default to PC+4
      rdsrc = 1'b0;
      pcbranchsrc = 2'b00; // This is really a don't care
      if(reset) begin
        pcsrc = 2'b00;
      end else if (exception) begin
        pcsrc = 2'b01;
      end else if (jump) begin // Jump
        pcsrc = 2'b11;
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
            pcsrc = 2'b11;
          end
        end else begin  // Compare a to zero
          if((~eq & ~lt & ~gt) | (eq & aeqz) | (gt & agtz) | (lt & altz)) begin
            pcsrc = 2'b11;
          end
        end
      end
    end
endmodule
           
module alu(input      [31:0] a, b, 
           input      [2:0]  control, 
           output reg [31:0] aluresult,
           output            overflow);

  wire [31:0] b2, sum, aorb;
  wire sltSigned, sltUnsigned;

  assign #1 b2 = control[2] ? ~b:b; 
  assign #1 sum = a + b2 + control[2];
  assign #1 sltSigned = sum[31];
  // a < b is an unsigned comparrison
  assign #1 sltUnsigned = a < b;
  assign #1 aorb = a | b;

  // Overflow assumes add or sub command (cop0 checks whether overflow matters)
  assign #1 overflow = (a[31] == b2[31] & a[31] != sum[31]);

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
module signext #(parameter INPUT = 16, OUTPUT = 32)
               (input  [INPUT-1:0] a,
               input  enable,
               output [OUTPUT-1:0] y);
               
  wire extension;
  
  assign #1 extension = (enable ? a[INPUT-1] : 0);
  assign #1 y = {{OUTPUT-INPUT{extension}}, a};
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

// Basic one hot decoders, eg b10 -> b0100
module dec2 (input  [1:0] x,
             output [3:0] y);

  assign #1 y = (x[0] ? (x[1] ? 4'b1000 : 4'b0010)
                      : (x[1] ? 4'b0100 : 4'b0001));
endmodule

module dec1 (input        x,
             output [1:0] y);

  assign #1 y = (x ? 2'b01 : 2'b10);
endmodule
