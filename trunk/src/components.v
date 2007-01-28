//------------------------------------------------
// components.v
//
// Authors
// David Harris David_Harris at hmc dot edu 3 November 2005
// Carl Nygaard carlpny at gmail dot com 2007
// Thomas W. Barr tbarr at cs dot hmc dot edu 2007
// Matt Totino mtotino at hmc.edu 2007
// Nathaniel Pinckney npinckney at gmail dot com
//
// Pipelined MIPS processor spare parts
//------------------------------------------------

`timescale 1 ns / 1 ps


module adder(input  [31:0] a, b,
             output [31:0] y);

  assign #1 y = a + b;
endmodule

// Adder with carry in and out
module adderc #(parameter WIDTH = 32)
             (input  [WIDTH-1:0] a, b,
              input              cin,
              output [WIDTH-1:0] y,
              output             cout);
 
  assign #1 {cout, y} = a + b + cin;
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

module flopen #(parameter WIDTH = 32)
               (input                  clk,
                input                  en,
                input      [WIDTH-1:0] d, 
                output reg [WIDTH-1:0] q);
 
  always @(posedge clk)
    if (en)    #1 q <= d;
endmodule

module flopenr #(parameter WIDTH = 32)
                (input                  clk, reset,
                 input                  en,
                 input      [WIDTH-1:0] d, 
                 output reg [WIDTH-1:0] q);
 
  always @(posedge clk, posedge reset)
    if      (reset) q <= #1 0;
    else if (en)    q <= #1 d;
endmodule

module flopenrc #(parameter WIDTH = 32)
                 (input                  clk, reset,
                  input                  en, clear,
                  input      [WIDTH-1:0] d, 
                  output reg [WIDTH-1:0] q);
 
  always @(posedge clk, posedge reset)
    if      (reset) q <= #1 0;
    else if (clear) q <= #1 0;
    else if (en)    q <= #1 d;
endmodule

module mux2 #(parameter WIDTH = 32)
             (input  [WIDTH-1:0] d0, d1, 
              input              s, 
              output [WIDTH-1:0] y);

  assign #1 y = s ? d1 : d0; 
endmodule

module mux3 #(parameter WIDTH = 32)
             (input  [WIDTH-1:0] d0, d1, d2,
              input  [1:0]       s, 
              output [WIDTH-1:0] y);

  assign #1 y = s[1] ? d2 : (s[0] ? d1 : d0); 
endmodule

module mux4 #(parameter WIDTH = 32)
             (input  [WIDTH-1:0] d0, d1, d2, d3,
              input  [1:0]       s, 
              output [WIDTH-1:0] y);

  assign #1 y = s[1] ? (s[0] ? d3 : d2)
                     : (s[0] ? d1 : d0); 
endmodule

module mux5 #(parameter WIDTH = 32)
             (input  [WIDTH-1:0] d0, d1, d2, d3, d4,
             input   [2:0]  s,
                output  [WIDTH-1:0] y);

  // 101 = d4; 100 = d3; 010 = d2; 001 = d1; 000 = d0

  assign #1 y = s[2] ? (s[0] ? d4 : d3)
                     : (s[1] ? d2 : (s[0] ? d1 : d0));
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
module and2 #(parameter WIDTH = 32)
             (input  [WIDTH-1:0] a, b,
              output [WIDTH-1:0] y);

  assign #1 y = a & b;
endmodule

module xor2 #(parameter WIDTH = 32)
             (input  [WIDTH-1:0] a, b,
              output [WIDTH-1:0] y);

  assign #1 y = a ^ b;
endmodule

module inc #(parameter WIDTH = 32)
            (input  [WIDTH-1:0] a,
             output [WIDTH-1:0] y,
             output             cout);
 
  assign #1 {cout, y} = a + 1'b1;
endmodule

module zerodetect #(parameter WIDTH = 32)
             (input  [WIDTH-1:0] a,
              output             y);
 
  assign #1 y = ~|a;
endmodule

