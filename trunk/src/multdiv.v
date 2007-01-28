// multdiv.v
// David_Harris@hmc.edu 1/2/07
//
// An ALU-based multiplier and divider
// handling signed and unsigned operands
//
// Apply inputs and assert start for one cycle.
// Outputs are in prodh and prodl when run becomes low for a cycle
//  Mult: {PRODH, PRODL} = X * Y
//  Div:  PRODH = X % Y ; PRODL = X/Y
//
// The unit has a 2N-bit product register, an N-bit Y register.
// Initially, Y is loaded in the Y register, X is loaded in PRODL,
// and PRODH is cleared.  The unit also has an N-bit ALU and an
// Y mux.  On each cycle, the unit chooses {2Y, Y, 0, -Y, -2Y}, adds
// it to a shifted PRODH, and puts the result back in PRODH.
//
// Keep two more significant bits for PRODH.  One is because 2Y may be
// N+1 bits.  The second is to gracefully handle the sign.
// 
// The multiplier uses Radix 4 Booth's algorithm to handle signed and unsigned
// operands.  It chooses the X multiple based on the 3 lsbs of PRODL.
// After each step, it right-shifts by 2.  At the end, 
//
// The divider left-shifts the two registers by 1 on each cycle.  It 
// subtracts Y from PRODH.  If the result is positive, it is kept and
// the quotient bit is set to 1; otherwise the result is discarded.
//
// Signed division is a tricky case.  To handle it, X and Y are
// made positive, then the sign of the quotient and remainder are adjusted
// at the end:
//
//  Negate quotient if signs of divisor (X) and dividend (Y) disagree 
//  Set sign of remainder so that it agrees with dividend 
//  Examples: 
//  13 / 5 = 2 with remainder of 3 
//  (-13) / 5 = -2 with remainder of 3 
//  13 / (-5) = -2 with remainder of -3 
//  (-13) / (-5) = 2 with remainder of -3 


/////////////////////////////////////////////////////////////////////////////////
// Module: multdiv
// 
// This module is the top level for the multiply/divide unit.
// It contains a controller and datapath to perform signed and
// unsigned multiplication and division (mult when multdivb = 1).
/////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns / 1 ps

module multdiv(input         clk,
               input         reset,
               input         start,
               input         muldivb,
               input         signedop,
               input  [31:0] x,
               input  [31:0] y,
               output [31:0] prodh,
               output [31:0] prodl,
               output        run,
               output        dividebyzero);

  wire done, init, muldivbsaved, signedopsaved;
  wire qi, srchinv;
  wire yzero;
  wire [1:0] prodhsel, prodlsel;
  wire [1:0] srchsel;
  wire [1:0] prodhextra;
  wire [2:0] ysel;
  wire [31:0] ysaved, prodlsh, nextprodl;
  wire [33:0] srch1, srch, prodhsh, nextprodh, yy, srchplusyy;

  // control logic
  mdcontroller mdcont(clk, reset, start, run, done, init, muldivb, signedop, 
                      cout, prodl[1:0], x[31], y[31], ysaved[31], srch1[31], srchplusyy[33], yzero, 
                      ysel, srchsel, srchinv, prodhsel, prodlsel, qi, dividebyzero, muldivbsaved, signedopsaved);

  // Y register and Booth mux
  flopenr        yreg(clk, reset, start, y, ysaved);
  boothsel       ybooth(ysaved, ysel, signedopsaved, yy, cin);
  zerodetect     yzdetect(ysaved, yzero);

  // PRODH
  // keep one extra bit in high part to accomdate 2x Booth multiples and another bit to keep sign
  shl1r2   #(34) prodhshlr(muldivbsaved, {prodhextra, prodh}, {2{prodhextra[1]}}, prodl[31], prodhsh);
  mux3     #(34) srchmux(prodhsh, {prodhextra, prodh}, {2'b0, prodl}, srchsel, srch1);  // only necessary for signed division
  xor2     #(34) srchxor(srch1, {34{srchinv}}, srch); // only necessary for signed division
  adderc   #(34) addh(srch, yy, cin, srchplusyy, cout);
  mux3     #(34) prodhmux(prodhsh, srchplusyy, {prodhextra, prodh}, prodhsel, nextprodh); // d2 for signed division only
  flopenr  #(34) prodhreg(clk, init, run, nextprodh, {prodhextra, prodh});

  // PRODL
  shl1r2         prodlshlr(muldivbsaved, prodl, prodh[1:0], qi, prodlsh);
  mux4           prodlmux(prodlsh, srchplusyy[31:0], prodl, x, prodlsel, nextprodl); // d1 and d2 for signed division only
  flopenr        prodlreg(clk, reset, run, nextprodl, prodl); // probably doesnt' need reset
endmodule

/////////////////////////////////////////////////////////////////////////////////
// Module: mdcontroller
// 
// This module contains a counter to cycle through the steps for
// multiplication or division.  Based on the cycle and the data,
// it generates select signals for the multiplexers.  Most of
// the complexity is due to the signed division, which must 
// conditionally take the two's complement of the inputs and outputs.
/////////////////////////////////////////////////////////////////////////////////

module mdcontroller(input            clk,
                    input            reset,
                    input            start,
                    output           run,
                    output reg       done,
                    output           init,
                    input            muldivb,
                    input            signedop,
                    input            cout,
                    input  [1:0]     x,
                    input            xsign,
                    input            ysign,
                    input            ysavedsign,
                    input            srchsign,
                    input            addsign,
                    input            yzero,
                    output reg [2:0] ysel,
                    output reg [1:0] srchsel,
                    output reg       srchinv,
                    output reg [1:0] prodhsel,
                    output reg [1:0] prodlsel,
                    output           qi,
                    output           dividebyzero,
                    output           muldivbsaved, signedopsaved);

  wire [5:0] nextcount, count;
  wire       nccout, oldrun;
  wire       oldx, muldivbreg, signedopreg;
  reg [1:0] x2;
  wire       signsdisagree;

  // count and run registers
  flopenr #(6) countreg(clk, init, run, nextcount, count);
  flopr #(1)   runreg(clk, reset, run, oldrun);

  // remember whether we are multiplying or dividing and whether we are using
  // a signed op, the value must also be available while start is high
  flopen #(2) controlreg(clk, start, {muldivb, signedop}, {muldivbreg, signedopreg});

  assign {muldivbsaved, signedopsaved} = start ? {muldivb, signedop}
                                               : {muldivbreg, signedopreg};

  // combinational logic for run and count
  assign init = reset | start;
  assign run = start | (oldrun & ~done);
  inc #(6) nc(count, nextcount, nccout);

  // hang onto sign for result of signed division
  flopen #(1) signdisagreereg(clk, start, xsign ^ ysign, signsdisagree);

  // determine quotient digit
  assign qi = ~addsign; // sign of result for division

  // check for division by zero
  assign dividebyzero = yzero & ~muldivbsaved;

  // keep previous x msb for Booth encoding
  flopr #(1) xoldreg(clk, init, x[1], oldx);

  // mux select logic
  always @(*) begin
    ///////////////////////////////////////////////////////
    // default values
    ///////////////////////////////////////////////////////
    srchsel = 0; // default: take srch from shifted PRODH
    srchinv = 0;
    prodhsel = 0; // default: take shifted result
    prodlsel = 0; // default: take shifted result
    ysel = 4; // select 0 by default from Booth mux
    done = 0;

    ///////////////////////////////////////////////////////
    // multiplication
    ///////////////////////////////////////////////////////
    if (muldivbsaved) begin 
      prodhsel = 1; // take adder result
      x2 = x;
      if (count == 16) x2 = signedopsaved ? {2{oldx}} : 2'b0;  // zero or sign extend final two bits
      if (count == 17) done = 1;
      case ({x2, oldx}) // Booth encode for multiplication
        3'b000: ysel = 4; // select 0
        3'b001: ysel = 0; // select Y
        3'b010: ysel = 0; // select Y
        3'b011: ysel = 1; // select 2Y
        3'b100: ysel = 3; // select -2Y
        3'b101: ysel = 2; // select -Y
        3'b110: ysel = 2; // select -Y
        3'b111: ysel = 4; // select 0
      endcase
    end

    ///////////////////////////////////////////////////////
    // unsigned division
    ///////////////////////////////////////////////////////
    else if (~signedopsaved) begin  
      ysel = 2; // select -Y
      if (qi) prodhsel = 1; // if quotient digit is true, take ALU result
      if (count == 32) done = 1; // cycle 32: finished with unsigned division
    end
    
    ///////////////////////////////////////////////////////
    // signed division
    ///////////////////////////////////////////////////////
    else if (signedopsaved) begin 
      if (count == 'd0) begin // cycle 0: ensure X is positive
        srchsel = 2; // select PRODL, containing X
        prodhsel = 2; // freeze PRODH register
        prodlsel = 1; // write ALU result with corrected X to PRODL register
        if (srchsign) begin  // if sign is negative, take two's complement of X
          srchinv = 1;
          ysel = 6;
        end 
      end else if (count == 'd33) begin // cycle 33: set sign of quotient
        srchsel = 2; // select PRODL, containing quotient
        srchinv = signsdisagree; // negate quotient if source signs differ
        prodhsel = 2; // freeze PRODH register
        prodlsel = 1; // write ALU result with corrected quotient to PRODL register
        if (signsdisagree) begin  // if signs disagree, take two's complement of quotient
          srchinv = 1;
          ysel = 6;
        end 
      end else if (count == 'd34) begin // cycle 34: set sign of remainder
        srchsel = 1; // select PRODH, containing remainder
        srchinv = ysavedsign;
        prodhsel = 1; // put corrected remainder in PRODH
        prodlsel = 2; // freeze PRODL register
        if (ysavedsign) begin  // if sign y is negative, take two's complement of remainder
          srchinv = 1;
          ysel = 6;
        end 
      end else if (count == 'd35) begin // cycle 35: finished with signed division
        done = 1;
      end else begin // normal signed division cycle
        if (qi) prodhsel = 1; // if quotient digit is true, take ALU result
        if (ysavedsign) ysel = 0; // Choose Y if it is negative
        else ysel = 2; // else choose -Y
      end
    end

    ///////////////////////////////////////////////////////
    // start cycle
    ///////////////////////////////////////////////////////
    if (start) prodlsel = 3; // always load X into PRODL on start cycle
  end
endmodule

/////////////////////////////////////////////////////////////////////////////////
// Module: shl1r2
// 
// Shift left by 1 (for divide) or right by 2 (for mult).
/////////////////////////////////////////////////////////////////////////////////

module shl1r2 #(parameter WIDTH = 32)
               (input             dir,
               input  [WIDTH-1:0] a,
               input  [1:0]       inl,
               input              inr,
               output [WIDTH-1:0] y);

  // if dir == 0, shift left by 1.  Else shift right by 2
  mux2 #(WIDTH) shmux({a[WIDTH-2:0], inr}, {inl, a[WIDTH-1:2]}, dir, y);
endmodule

/////////////////////////////////////////////////////////////////////////////////
// Module: boothsel
// 
// Select the appropriate second source operand based on boothsel:
//  0: Y
//  1: 2Y
//  2: -Y
//  3: -2Y
//  4: 0
//  6: 1
// The output is sign-extended to 34 bits.
/////////////////////////////////////////////////////////////////////////////////

module boothsel(input  [31:0] a,
                input  [2:0]  boothsel,
                input         signedopsaved,
                output [33:0] y,
                output        cin);

  wire [33:0] yp2, yp1, ym1, ym2, yb;

  assign yp2 = {a[31] & signedopsaved, a, 1'b0};
  assign yp1 = {{2{a[31] & signedopsaved}}, a};
  assign ym1 = ~yp1;
  assign ym2 = ~yp2;

  assign cin = boothsel[1]; // carry for 2's comp if y negated

  mux4 #(34) boothmux(yp1, yp2, ym1, ym2, boothsel[1:0], yb);
  and2 #(34) boothzero(yb, ~{34{boothsel[2]}}, y);
endmodule

