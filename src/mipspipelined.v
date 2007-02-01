//------------------------------------------------
// mipspipelined.v
//
// Authors
// David Harris David_Harris at hmc dot edu 3 November 2005
// Carl Nygaard carlpny at gmail dot com 2007
// Thomas W. Barr tbarr at cs dot hmc dot edu 2007
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
            input  [7:0]  interrupts,
            output        memwriteM,
            output [3:0]  byteenM,
            output [31:0] aluoutM, writedataM,
            input  [31:0] readdataM,
            input         instrackF, dataackM);

  wire [5:0]  opD, functD;
  wire [4:0]  rsD, rtD, rdE;
  wire        regdstE, alusrcE, 
              unsignedD, loadsignedM, rdsrcD, linkD, luiE,
              overflowableE, overflowE,
              memtoregE, memtoregM, memtoregW, regwriteE, regwriteM, regwriteW,
              byteM, hardwordM,
              aeqzD, aeqbD, agtzD, altzD, mdrunE, branchD, jumpregD,
              bdsF, bdsD, bdsE, bdsM,
              syscallE, breakE, riE, fpu,
              adesableE, adelableE, adelthrownE, misaligned;
  wire [2:0]  alushcontrolE;
  wire [1:0]  pcbranchsrcD, aluoutsrcE, pcsrcFD, excstage;
  wire        flushE, flushM;
  wire [31:0] cop0readdataE, writedataW;
  wire [31:0] pcD, pcE, pcM, pcW;
  wire [4:0]  writeregW;
  wire [1:0]  specialregsrcE, hilodisableE;
  wire        hiloaccessD, mdstartE, hilosrcE;
  // Globals
  wire        re, swc, isc, exception;

  controller c(clk, reset, exception, opD, functD, rsD, rtD, flushE, flushM,
               aeqzD, aeqbD, agtzD, altzD, mdrunE,
               memtoregE, memtoregM, memtoregW, memwriteM, 
               byteM, halfwordM, branchD,
               alusrcE, unsignedD, loadsignedM,
               regdstE, regwriteE, regwriteM, 
               regwriteW, jumpD, jumpregD, overflowableE,
               aluoutsrcE, alushcontrolE, linkD, luiE,
               rdsrcD, pcsrcFD, pcbranchsrcD, cop0writeW, 
               bdsF, bdsD, bdsE, bdsM,
               syscallE, breakE, riE, fpuE,
               adesableE, adelableE, halfwordE, rfeE,
               specialregsrcE, hilodisableE,
               hiloaccessD, mdstartE, hilosrcE);
  datapath dp(clk, reset, memtoregE, memtoregM, memtoregW, byteM, halfwordM,
              branchD, jumpregD,
              unsignedD, loadsignedM, alusrcE, regdstE, regwriteE, 
              regwriteM, regwriteW, jumpD, aluoutsrcE, linkD, luiE,
              rdsrcD, 
              specialregsrcE, hilodisableE, hiloaccessD, mdstartE, hilosrcE,
              pcsrcFD, pcbranchsrcD, alushcontrolE, cop0readdataE,
              pcF, pcD, pcE, pcM, pcW, instrF,
              aluoutM, writedataM, readdataM, instrackF, dataackM, 
              exception, excstage,
              opD, functD, rsD, rtD, rdE, aeqzD, aeqbD, agtzD, altzD, 
              flushE, flushM, overflowE,
              writedataW, writeregW, byteenM, misalignedh, misalignedw, 
              adelthrownE, mdrunE);

  coprocessor0 cop0(clk, reset, cop0writeW, rdE, writeregW, writedataW, 
                    overflowableE, overflowE, pcF, pcD, pcE, pcM, pcW,
                    bdsF, bdsD, bdsE, bdsM,
                    syscallE, breakE, riE, fpuE,
                    adesableE, adelableE, adelthrownE, misalignedh, misalignedw,
                    halfwordE, rfeE, interrupts, 
                    cop0readdataE, re, swc, isc, exception, excstage
                    );
endmodule

module controller(input        clk, reset, exception,
                  input  [5:0] opD, functD,
                  input  [4:0] rsD, rtD,
                  input        flushE, flushM,
                  input        aeqzD, aeqbD, agtzD, altzD, mdrunE,
                  output       memtoregE, memtoregM, memtoregW, memwriteM,
                  output       byteM, halfwordM,
                  output       branchD, alusrcE, unsignedD, 
                  output       loadsignedM,
                  output       regdstE, regwriteE, regwriteM, regwriteW,
                  output       jumpD, jumpregD, overflowableE,
                  output [1:0] aluoutsrcE, 
                  output [2:0] alushcontrolE, 
                  output       linkD, luiE,
                  output       rdsrcD, 
                  output [1:0] pcsrcFD, pcbranchsrcD,
                  output       cop0writeW, bdsF, bdsD, bdsE, bdsM,
                  output       syscallE, breakE, riE, fpuE,
                  output       adesableE, adelableE, halfwordE, rfeE,
                  output [1:0] specialregsrcE, hilodisableE,
                  output       hiloaccessD, mdstartE, hilosrcE);

  wire       memtoregD, memwriteD, alusrcD, mainregwrite, luiD,
             regdstD, regwriteD, maindecuseshifterD, maindecregdstD, 
             alushdecoverflowableD, maindecoverflowableD, overflowableD,
             useshifterD, cop0readD, cop0writeD, rfeD,
             loadsignedD, loadsignedE,
	           syscallD, breakD, riD, fpuD,
             adesableD, adelableD, adelthrownD,
             mdstartD, hilosrcD,
             hiloreadD, hiloselD;
  wire       byteD, halfwordD, byteE;
  reg  [1:0] aluoutsrcD, specialregsrcD;
  wire [1:0] hilodisablealushD, hilodisablealushE;
  wire       ltD, gtD, eqD, brsrcD;
  wire [2:0] alushcontmaindecD, alushcontrolD;
  wire       memwriteE;
  wire       cop0writeE, cop0writeM;

  assign #1 regwriteD = mainregwrite | linkD | cop0readD;
  assign #1 regdstD = maindecregdstD | cop0writeD;
  assign #1 overflowableD = maindecoverflowableD | alushdecoverflowableD;
  assign #1 bdsF = branchD | jumpD;
  // The instruction in register D needs to access/change HI or LO
  assign #1 hiloaccessD = mdstartD | hiloreadD;

  maindec md(opD, memtoregD, memwriteD, byteD, halfwordD, loadsignedD,
             alusrcD, maindecregdstD, mainregwrite, unsignedD, luiD,
             maindecuseshifterD, maindecoverflowableD, alushcontmaindecD,
             riD, fpuD, adesableD, adelableD);

  alushdec  ad(functD, maindecuseshifterD, alushcontmaindecD, useshifterD,
               alushcontrolD, alushdecoverflowableD, syscallD, breakD,
               mdstartD, hilosrcD, hiloreadD, hiloselD, 
               hilodisablealushD);

  branchdec bd(opD, rtD, functD, jumpD, branchD, ltD, gtD, eqD, brsrcD, linkD);

  branchcontroller  bc(reset, exception, jumpD, branchD, linkD, aeqzD, aeqbD, 
                       agtzD, altzD, 
                       ltD, gtD, eqD, brsrcD, rdsrcD, pcsrcFD, pcbranchsrcD,
                       jumpregD);
  
  cop0dec c0dec(opD, rsD, functD, cop0readD, cop0writeD, rfeD); 

  // Chooses which component is selected as aluout
  always @ ( * )
    if(linkD)
      aluoutsrcD <= 2'b10; // PC+8
    else if (cop0readD | hiloreadD)
      aluoutsrcD <= 2'b11; // special register
    else if (useshifterD)
      aluoutsrcD <= 2'b01; // shifter
    else
      aluoutsrcD <= 2'b00; // alu


  // Chooses which special register is used
  always @ ( * ) 
    if(hiloreadD)
      if(hiloselD)
        // Use LO
        specialregsrcD <= 2'b10;
      else
        // Use HI
        specialregsrcD <= 2'b01;
    else // implied if cop0readD
      // Read from coprocessor0
      specialregsrcD <= 2'b00;

  // Choose which HI or LO register(s) should be written to
  hilocontrol hiloc(mdrunE, hilodisablealushE, hilodisableE);


  // pipeline registers
  floprc #(1) regD(clk, reset, flushE, {bdsF}, {bdsD});
  floprc #(32) regE(clk, reset, flushE,
                  {memtoregD, memwriteD, alusrcD, regdstD, regwriteD, 
                  aluoutsrcD, alushcontrolD, loadsignedD, luiD, cop0writeD,
                  byteD, halfwordD, overflowableD, bdsD,
		              syscallD, breakD, riD, fpuD,
		              adesableD, adelableD, adelthrownD,
                  mdstartD, hilosrcD, hiloselD, hilodisablealushD, 
                  specialregsrcD, rfeD}, 
                  {memtoregE, memwriteE, alusrcE, regdstE, regwriteE,  
                  aluoutsrcE, alushcontrolE, loadsignedE, luiE, cop0writeE,
                  byteE, halfwordE, overflowableE, bdsE,
		              syscallE, breakE, riE, fpuE,
		              adesableE, adelableE, adelthrownE,
                  mdstartE, hilosrcE, hiloselE, hilodisablealushE, 
                  specialregsrcE, rfeE});
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
               output       riD, fpuD,
               output       adesableD, adelableD);

  reg [18:0] controls;
 
  assign {regwrite, /* regwrite is also enabled by branchdec and cop0dec */
          regdst,   /* regdst is also enabled by cop0dec */ 
          overflowable, /* overflowable is also enabled by alushdec */
          alusrc,
          memwrite,
          memtoreg, byte, halfword, loadsignedD,
          useshift, alushcontrol /* 3 bits */,
          unsignedD, lui, adesableD, adelableD, fpuD, riD} = controls;

  always @ ( * )
    case(op)
      6'b000000: controls <= 19'b1100000000101000000; //R-type
      6'b000001: controls <= 19'b0100000000101000000; //Opcode 1 (branches)
      6'b100000: controls <= 19'b1001011010010000000; //LB (assume big endian)
      6'b100001: controls <= 19'b1001010110010000100; //LH
      6'b100011: controls <= 19'b1001010010010000100; //LW
      6'b100100: controls <= 19'b1001011000010100000; //LBU
      6'b100101: controls <= 19'b1001010100010100000; //LHU
      6'b101000: controls <= 19'b0001101000010000000; //SB
      6'b101001: controls <= 19'b0001100100010001000; //SH
      6'b101011: controls <= 19'b0001100000010001000; //SW
      6'b001000: controls <= 19'b1011000000010000000; //ADDI
      6'b001001: controls <= 19'b1001000000010000000; //ADDIU
      6'b001010: controls <= 19'b1001000000111000000; //SLTI
      6'b001011: controls <= 19'b1001000000011000000; //SLTIU 
      6'b001100: controls <= 19'b1001000000000100000; //ANDI
      6'b001101: controls <= 19'b1001000000001100000; //ORI
      6'b001110: controls <= 19'b1001000000100100000; //XORI
      6'b001111: controls <= 19'b1001000001010110000; //LUI
      6'b000010: controls <= 19'b0000000000010000000; //J
      6'b000011: controls <= 19'b1100000000010000000; //JAL
      6'b000100: controls <= 19'b0000000000110000000; //BEQ
      6'b000101: controls <= 19'b0000000000110000000; //BNE
      6'b000110: controls <= 19'b0000000000110000000; //BLEZ
      6'b000111: controls <= 19'b0000000000110000000; //BGTZ
      6'b010000: controls <= 19'b0000000000010000000; //MFC0, MTC0, RFE
      6'b010001: controls <= 19'b0000000000000000010; //fpu
      default:   
        begin
          controls <= 19'bxxxxxxxxxxxxxxxxxx1;  //???
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
                output           overflowable, syscallD, breakD, 
                                 mdstart, hilosrc, hiloread, hilosel,
                output     [1:0] hilodisable);

  reg [12:0] functcontrol;
  wire usefunct;

  // The pattern 0101 indicates that we have an R-type and should use the 
  // funct code (0101 is also the nor command, of which there is no immediate
  // equivalent; hence 0101 is available)
  assign #1 usefunct = ({maindecuseshifter, alushmaincontrol} == 4'b0101);
  assign #1 {overflowable, syscallD, breakD, hiloread, hilosel, hilodisable,
    mdstart, hilosrc, useshifter, alushcontrol} = 
    (usefunct ? functcontrol : {9'b0, maindecuseshifter, alushmaincontrol});

  always @ ( * )
      case(funct)
          // ALU Ops
          6'b100000: functcontrol <= 13'b1000000000010; // ADD 
          6'b100001: functcontrol <= 13'b0000000000010; // ADDU
          6'b100010: functcontrol <= 13'b1000000000110; // SUB 
          6'b100011: functcontrol <= 13'b0000000000110; // SUBU
          6'b100100: functcontrol <= 13'b0000000000000; // AND
          6'b100101: functcontrol <= 13'b0000000000001; // OR
          6'b100110: functcontrol <= 13'b0000000000100; // XOR
          6'b100111: functcontrol <= 13'b0000000000101; // NOR
          6'b101010: functcontrol <= 13'b0000000000111; // SLT
          6'b101011: functcontrol <= 13'b0000000000011; // SLTU
                                                 
          // Shift Ops                           
          // The lower 3 bits are: {coonstant, left, rightassociative}
          6'b000000: functcontrol <= 13'b0000000001110; // SLL
          6'b000010: functcontrol <= 13'b0000000001100; // SRL
          6'b000011: functcontrol <= 13'b0000000001101; // SRA
          6'b000100: functcontrol <= 13'b0000000001010; // SLLV
          6'b000110: functcontrol <= 13'b0000000001000; // SRLV
          6'b000111: functcontrol <= 13'b0000000001001; // SRAV
                                                 
          // Branch Ops (These are all don't cares)
                                                 
          // Mult/div/HI/LO Ops                  
          // The lower 3 bits are {dont care, signedop, muldivb}
                                                 
          6'b010000: functcontrol <= 13'b0001000000000; // MFHI
          6'b010001: functcontrol <= 13'b0000010010000; // MTHI
          6'b010010: functcontrol <= 13'b0001100000000; // MFLO
          6'b010011: functcontrol <= 13'b0000001010000; // MTLO
                                                 
          6'b011000: functcontrol <= 13'b0000000100011; // MULT
          6'b011001: functcontrol <= 13'b0000000100001; // MULTU
          6'b011010: functcontrol <= 13'b0000000100010; // DIV
          6'b011011: functcontrol <= 13'b0000000100000; // DIVU
                                               
          // Exceptions                        
          6'b001100: functcontrol <= 13'b0100000000000; // SYSCALL
          6'b001101: functcontrol <= 13'b0010000000000; // BREAK
                                                 
          default:   functcontrol <= 13'b0000000000xxx; // ???
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

module hilocontrol(input        mdrunE,
                   input  [1:0] hilodisablealushE,
                   output [1:0] hilodisableE);

  assign hilodisableE = mdrunE ? 2'b00 : hilodisablealushE;

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
                input         branchD, jumpregD, unsignedD, loadsignedM,
                input         alusrcE, regdstE,
                input         regwriteE, regwriteM, regwriteW, 
                input         jumpD, 
                input  [1:0]  aluoutsrcE, 
                input         linkD, luiE,
                input         rdsrcD, 
                input  [1:0]  specialregsrcE, hilodisableE,
                input         hiloaccessD, mdstartE, hilosrcE,
                input  [1:0]  pcsrcFD, pcbranchsrcD,
                input  [2:0]  alushcontrolE,
                input  [31:0] cop0readdataE,
                output [31:0] pcF, pcD, pcE, pcM, pcW,
                input  [31:0] instrF,
                output [31:0] aluoutM, writedata2M,
                input  [31:0] readdataM, 
                input         instrackF, dataackM, exception,
                input  [1:0]  excstage,
                output [5:0]  opD, functD,
                output [4:0]  rsD, rtD, rdE,
                output        aeqzD, aeqbD, agtzD, altzD,
                output        flushE, flushM, overflowE,
                output [31:0] writedataW,
                output [4:0]  writeregW,
                output [3:0]  byteenM,
                output        misalignedh, misalignedw, adelthrownE, mdrunE);

  parameter RESETVECTORUNCACHED = 32'hbfc00000;
  parameter EXCEPTIONVECTORUNCACHED = 32'hbfc00100;
  // Curretly, cached exceptions are not supported
  parameter EXCEPTIONVECTORCACHED = 32'h9fc00100;  // TODO: Double-check value

  wire        forwardaD, forwardbD;
  wire [1:0]  forwardaE, forwardbE;
  wire        stallF, flushD;
  wire [4:0]  rd2D, rsE, rtE, rdD;
  wire [4:0]  writeregE, writeregM;
  wire [31:0] writedataM;
  wire [7:0]  rbyteM;
  wire [15:0] rhalfwordM;
  wire [31:0] rbyteextM, rhalfwordextM, readdata2M;
  wire [3:0]  bytebyteenM, halfwordbyteenM;
  wire [31:0] pcnextFD, pcnextbrFD, pcplus4F, pcplus4D;
  wire [31:0] signimmD, signimmE;
  wire [31:0] srcaD, srca2D, srcaE, srca2E;
  wire [31:0] srcbD, srcb2D, srcbE, srcb2E, srcb3E;
  wire [31:0] hiE, loE, specialregE;
  wire [31:0] pcplus8D, pcplus8E, instrD, branchtargetD;
  wire [31:0] aluresultE, shiftresultE;
  wire [31:0] aluoutE, aluoutW;
  wire [31:0] readdataW, resultW;
  wire        adelthrownF, adelthrownD;

  // hazard detection
  hazard    h(rsD, rtD, rsE, rtE, writeregE, writeregM, writeregW, 
              regwriteE, regwriteM, regwriteW, 
              memtoregE, memtoregM, branchD, jumpregD,
              instrackF, dataackM, exception, hiloaccessD, mdrunE, excstage,
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
  // misaligned fetch logic
  assign     adelthrownF = pcF[0] | pcF[1];

  // Decode stage 
  flopenr #(32) r1D(clk, reset, ~stallD, pcF, pcD);
  flopenrc #(32) r2D(clk, reset, ~stallD, flushD, instrF, instrD);
  flopenrc #(1) r3D(clk, reset, ~stallD, flushD, adelthrownF, adelthrownD);
  flopenr #(32) r4D(clk, reset, ~stallD, pcplus4F, pcplus4D);
  signext #(16,32) se(instrD[15:0], ~unsignedD, signimmD);
  mux2 #(32)  forwardadmux(srcaD, aluoutM, forwardaD, srca2D);
  mux2 #(32)  forwardbdmux(srcbD, aluoutM, forwardbD, srcb2D);
  eqcmp       comp(srca2D, srcb2D, equalD);
  // TODO: consider moving link adder to the Execute stage
  adder       pcadd2(pcD, 32'b1000, pcplus8D);
  // PCSpin uses pcD, gcc/assembler use pcplus4D, we'll stick with pcplus4D
  adder btadd(pcplus4D, {signimmD[29:0], 2'b00}, branchtargetD);
  eqcmp aeqbcmp(srca2D, srcb2D, aeqbD);
  eqzerocmp aeqzcmp(srca2D, aeqzD);
  gtzerocmp agtzcmp(srca2D, agtzD);
  ltzerocmp altzcmp(srca2D, altzD);
  mux3 #(32)  pcbranchmux(branchtargetD, {pcplus4D[31:28], instrD[25:0], 2'b00},
                          srca2D, pcbranchsrcD, pcnextbrFD);
  mux2 #(5)   rdmux(rdD, 5'b11111, rdsrcD, rd2D);

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
  floprc #(32) r9E(clk, reset, flushE, pcD, pcE);
  floprc #(1)  r10E(clk, reset, flushE, adelthrownD, adelthrownE);
  
  mux3 #(32)  forwardaemux(srcaE, resultW, aluoutM, forwardaE, srca2E);
  mux3 #(32)  forwardbemux(srcbE, resultW, aluoutM, forwardbE, srcb2E);
  mux2 #(32)  srcbmux(srcb2E, signimmE, alusrcE, srcb3E);
  alu         alu(srca2E, srcb3E, alushcontrolE, aluresultE, overflowE);
  shifter     shifter(srca2E, srcb3E, alushcontrolE, luiE, signimmE[10:6],
                      shiftresultE);
  mux2 #(5)   wrmux(rtE, rdE, regdstE, writeregE);
  assign misalignedw = aluoutE[1] | aluoutE[0];
  assign misalignedh = aluoutE[0];
  mdunit md(clk, reset,
            srca2E, srcb3E, alushcontrolE, mdstartE, hilosrcE, hilodisableE,
            hiE, loE, mdrunE);
  mux3 #(32)  specialregmux(cop0readdataE, hiE, loE, specialregsrcE, 
                            specialregE);
  mux4 #(32)  aluoutmux(aluresultE, shiftresultE, pcplus8E, specialregE, 
                        aluoutsrcE, aluoutE);

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
                    input             syscallE, breakE, riE, fpuE,
                    input             adesableE, adelableE, adelthrownE, 
                    input             misalignedh, misalignedw, halfwordE, rfeE,
                    input      [7:0]  interrupts,
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


  exceptionunit excu(clk, reset, overflowableE, overflowE, 
                     bdsF, bdsD, bdsE, bdsM,
                     syscallE, breakE, riE, fpuE,
                     adesableE, adelableE, adelthrownE, misalignedh, misalignedw,
                     halfwordE, iec, interrupts, im,
                     exception, branchdelay, exccode, 
                     excstage);
  epcunit       epcu(clk, exception, branchdelay, excstage, pcF, pcD, pcE, pcM,
                     pcW, epc);
  statusregunit sr(clk, reset, cop0writeW & (writeaddress == 5'b01100), exception, 
                   writecop0W, rfeE, statusreg, re, im, swc, isc, iec);
  causeregunit  cr(clk, branchdelay, interrupts, exccode, 
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
                     input            syscallE, breakE, riE, fpuE,
                     input            adesableE, adelableE, adelthrownE, 
                     input            misalignedh, misalignedw, halfwordE,
                     input            iec, //SR(IEc)
                     input [7:0]      interrupts, im, //interrupt inputs, SR(IM)
                     output reg       exception, branchdelay,
                     output reg [4:0] exccode, 
                     output reg [1:0] excstage);

  // TODO: worry about undesired startup exceptions

  // excstage is the stage exception occured in
  // 0 = Fetch, 1 = Decode, 2 = Execute, 3 = Memory
  // (assume writeback does not have exceptions)

  always @ ( * ) // Using posedge clk would add extra clock sycle and likely 
                 // offset everything by one, rendering some of the
                 // subsequent logic incorrect.
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
      
      if(syscallE) begin
        exception = 1;
        exccode = 8;       // Syscall
        excstage = 2;       // Stage E
        branchdelay = bdsE;
      end
      
      if(breakE) begin
        exception = 1;
        exccode = 9;       // Break
        excstage = 2;       // Stage E
        branchdelay = bdsE;
      end
      
      if(riE) begin
        exception = 1;
        exccode = 10;       // RI (reserved instruction)
        excstage = 2;       // Stage E
        branchdelay = bdsE;
      end
      
      if(fpuE) begin
        exception = 1;
        exccode = 11;       // CpU - Coprocessor unavailable
        excstage = 2;       // Stage E
        branchdelay = bdsE;
      end
      
      if((adelableE & (!halfwordE & (misalignedh | misalignedw) | misalignedh)) | adelthrownE) begin
        //$display("adel:%d, hwE:%d, malh:$d, malw:$d", adelableE, halfwordE, misalignedh, misalignedw);
        exception = 1;
        exccode = 4;       // ADeL
        excstage = 2;       // Stage E
        branchdelay = bdsE;
      end
      
      if(adesableE & (!halfwordE & (misalignedh | misalignedw) | misalignedh)) begin
        //$display("ades:%d, hwE:%d, malh:$d, malw:$d", adesableE, halfwordE, misalignedh, misalignedw);
        exception = 1;
        exccode = 5;       // ADeS
        excstage = 2;       // Stage E
        branchdelay = bdsE;
      end
      
      if(iec & ( |(im & interrupts))) begin
        $display("interupt");
        exception = 1;
        exccode = 1;       // Interrupt
        excstage = 2;       // Stage E
        branchdelay = bdsE;
      end
      
    end
endmodule

module statusregunit(input             clk, reset, writeenable, exception, 
                     input      [31:0] writedata, 
                     input             rfeE,
                     output reg [31:0] statusreg,
                     output            re, 
                     output     [7:0]  im,
                     output            swc, isc, iec);

  wire cu1, bev, ts, pe, cm, pz, kuo, ieo, kup, iep, kuc;

  assign cu1 = 0; // No floating point unit
  assign pe = 0;  // No parity checking
  assign cm = 0;  // Isolated cache feature, not yet implemented
  assign pz = 0;  // Archaic parity feature, not implemented

  assign re  = statusreg[25];  // reverse endianness
  assign bev = statusreg[22];  // not currently implemented
  assign ts  = statusreg[21];  // TLB not implemented
  assign {swc, isc, im} = statusreg[17:7];
  
  assign iec = statusreg[0];

  assign {kuo, ieo, kup, iep, kuc} = 5'b0; // No user vs kernel mode

  //always @ ( posedge clk )
   // statusreg = 0;

  always @ ( posedge clk )
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
        statusreg[5:1] = {kuo, ieo, kup, iep, kuc};
      end
      if(reset | rfeE) begin
        statusreg[0] = 1; // iec
      end else if(exception) begin
        // if we're handling an exception, ignore interrupts.
        statusreg[0] = 0; // iec
      end
    end
endmodule

module causeregunit(input             clk, branchdelay,
                    input      [7:0]  interrupts,
                    input      [4:0]  exccode,
                    input             writeenable,
                    output reg [31:0] causereg);

  always @ ( posedge clk )
    if(writeenable) begin
      causereg[31] = branchdelay;
      causereg[30] = 0;
      causereg[29:28] = 0; // Coprocessor error -- not sure what's good for
      causereg[27:16] = 0;
      causereg[15:8] = interrupts;
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
              input            memtoregE, memtoregM, branchD, jumpregD,
              input            instrackF, dataackM, exception,
              input            hiloaccessD, mdrunE,
              input  [1:0]     excstage, // TODO (Thomas): Remove and make 
                                         //   everything execution stage
                                         //   (simplify this excstage mess)
              output           forwardaD, forwardbD,
              output reg [1:0] forwardaE, forwardbE,
              output           stallF, stallD, flushD, flushE, flushM);

  wire lwstallD, branchstallD, instrmissF, datamissM, multdivDE;

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

  // Accessing HI and LO cannot happen during a multiply
  assign #1 multdivDE = hiloaccessD & mdrunE;

  // This assumes we are reading an instruction every cycle
  assign #1 instrmissF = ~instrackF;

  // This could be made slightly better since jumpreg only uses one register
  // output.
  assign #1 branchstallD = (branchD | jumpregD) & 
             (regwriteE & ((writeregE == rsD) | 
                          (writeregE == rtD)) |
              memtoregM & ((writeregM == rsD) | 
                          (writeregM == rtD)));

  assign #1 stallD = lwstallD | branchstallD | datamissM | multdivDE;
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
                        output reg  [1:0] pcbranchsrc,
                        output reg        jumpreg);

  always @ ( * )
    begin
      pcsrc = 2'b10; // Default to PC+4
      rdsrc = 1'b0;
      pcbranchsrc = 2'b00; // This is really a don't care
      jumpreg = 1'b0;
      if(reset) begin
        pcsrc = 2'b00;
      end else if (exception) begin
        pcsrc = 2'b01;
      end else if (jump) begin // Jump
        pcsrc = 2'b11;
        if(src) begin  // Jump using register 
          pcbranchsrc = 2'b10;
          jumpreg = 1'b1;
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

module mdunit(input         clk, reset,
              input  [31:0] srca, srcb,
              input  [2:0]  alushcontrol,
              input         mdstart, hilosrc, 
              input  [1:0]  hilodisable,
              output [31:0] hi, lo,
              output        mdrun);

  wire [31:0] prodh, prodl, hinext, lonext;
  wire        dividebyzero; // MIPS does not support divide by zero exceptions

  multdiv multdiv(clk, reset, mdstart, alushcontrol[0], alushcontrol[1],
                  srca, srcb, prodh, prodl, mdrun, dividebyzero);
  mux2 #(32) losrcmux(prodl, srca, hilosrc, lonext);
  mux2 #(32) hisrcmux(prodh, srca, hilosrc, hinext);

  // The HI and LO registers:
  // These don't really need the reset
  flopenr #(32) loreg(clk, reset, ~hilodisable[0], lonext, lo);
  flopenr #(32) hireg(clk, reset, ~hilodisable[1], hinext, hi);
    
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
