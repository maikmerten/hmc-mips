//------------------------------------------------
// top.v
// David_Harris@hmc.edu 9 November 2005
// npinckney@hmc.edu 12 February 2007
// Carl Nygaard carlpny at gmail dot com 2007
//
// Top level system including MIPS and memories
//------------------------------------------------
// topmips: this is what should be on-chip

`timescale 1 ns / 1 ps

module top(input         ph1, ph2, reset,
           input  [7:0]        interrupts,
           output [31:0] writedata, dataadr, 
           output        memwrite);


  wire [31:0] memadr;
  wire [31:0] memdata;
  wire [3:0] membyteen;
  wire memrwb;
  wire memen;
  wire memdone;
  
  // These are hooks for testing
  assign memwrite = ~memrwb & memen;
  assign writedata = memdata;
  assign dataadr = memadr;
   
  // instantiate processor and memories
  topmips thechip(ph1, ph2, reset, interrupts, memadr, memdata, membyteen, memrwb, memen, memdone);
  extmem extmem(ph1, ph2, reset, memadr[14:2], memdata, membyteen, memrwb, memen, memdone);

endmodule














/* Verilog for cell 'topmips{sch}' from library 'MIPS' */
/* Created on Mon Apr 09, 2007 23:24:53 */
/* Last revised on Fri Apr 13, 2007 14:25:30 */
/* Written on Fri Apr 13, 2007 16:05:44 by Electric VLSI Design System, version 8.04 */

module muddlib07__and2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_1, net_2;

  tranif1 nmos_0(net_1, net_2, b);
  tranif1 nmos_1(gnd, net_1, a);
  tranif1 nmos_2(gnd, y, net_2);
  tranif0 pmos_0(net_2, vdd, b);
  tranif0 pmos_1(net_2, vdd, a);
  tranif0 pmos_2(y, vdd, net_2);
endmodule   /* muddlib07__and2_1x */

module muddlib07__mux2_c_1x(d0, d1, s, y);
  input d0;
  input d1;
  input s;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_12, net_15, net_3, net_4, net_5, sb;

  tranif1 nmos_0(gnd, net_3, d1);
  tranif1 nmos_1(gnd, net_4, d0);
  tranif1 nmos_2(net_3, net_5, s);
  tranif1 nmos_3(net_4, net_5, sb);
  tranif1 nmos_4(gnd, y, net_5);
  tranif1 nmos_5(gnd, sb, s);
  tranif0 pmos_0(net_5, net_15, sb);
  tranif0 pmos_1(net_15, vdd, d1);
  tranif0 pmos_2(net_5, net_12, s);
  tranif0 pmos_3(net_12, vdd, d0);
  tranif0 pmos_4(y, vdd, net_5);
  tranif0 pmos_5(sb, vdd, s);
endmodule   /* muddlib07__mux2_c_1x */

module muddlib07__buftri_dp_1x(d, en, enb, y);
  input d;
  input en;
  input enb;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_1, net_3, net_6;

  tranif1 nmos_0(gnd, net_3, net_6);
  tranif1 nmos_1(net_3, y, en);
  tranif1 nmos_2(gnd, net_6, d);
  tranif0 pmos_0(y, net_1, enb);
  tranif0 pmos_1(net_1, vdd, net_6);
  tranif0 pmos_2(net_6, vdd, d);
endmodule   /* muddlib07__buftri_dp_1x */

module muddlib07__inv_4x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  tranif1 nmos_0(gnd, y, a);
  tranif0 pmos_0(y, vdd, a);
endmodule   /* muddlib07__inv_4x */

module memsys_final__buftri_zip(en, en_out, enb_out);
  input en;
  output en_out;
  output enb_out;

  supply1 vdd;
  supply0 gnd;
  muddlib07__inv_4x inv_4x_0(.a(en), .y(enb_out));
  muddlib07__inv_4x inv_4x_1(.a(enb_out), .y(en_out));
endmodule   /* memsys_final__buftri_zip */

module memsys_final__buftri_1x_4(d, en, y);
  input [3:0] d;
  input en;
  output [3:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_17, net_18;

  muddlib07__buftri_dp_1x buftri_3_(.d(d[3]), .en(net_17), .enb(net_18), 
      .y(y[3]));
  muddlib07__buftri_dp_1x buftri_2_(.d(d[2]), .en(net_17), .enb(net_18), 
      .y(y[2]));
  muddlib07__buftri_dp_1x buftri_1_(.d(d[1]), .en(net_17), .enb(net_18), 
      .y(y[1]));
  muddlib07__buftri_dp_1x buftri_0_(.d(d[0]), .en(net_17), .enb(net_18), 
      .y(y[0]));
  memsys_final__buftri_zip buftri_z_0(.en(en), .en_out(net_17), 
      .enb_out(net_18));
endmodule   /* memsys_final__buftri_1x_4 */

module muddlib07__buftri_c_1x(d, en, y);
  input d;
  input en;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_1, net_3, net_54, net_6;

  tranif1 nmos_0(gnd, net_3, net_6);
  tranif1 nmos_1(net_3, y, en);
  tranif1 nmos_2(gnd, net_54, en);
  tranif1 nmos_3(gnd, net_6, d);
  tranif0 pmos_0(y, net_1, net_54);
  tranif0 pmos_1(net_1, vdd, net_6);
  tranif0 pmos_2(net_54, vdd, en);
  tranif0 pmos_3(net_6, vdd, d);
endmodule   /* muddlib07__buftri_c_1x */

module memsys_final__blueblock(dmembyteen, dmemen, don, memdone, swcb_dmemrwbb, 
      wbdone, dmemdone, wbbyteen, wben);
  input [3:0] dmembyteen;
  input dmemen;
  input don;
  input memdone;
  input swcb_dmemrwbb;
  input wbdone;
  output dmemdone;
  output [3:0] wbbyteen;
  output wben;

  supply1 vdd;
  supply0 gnd;
  wire dmemdonemem;

  muddlib07__mux2_c_1x dmemdonememmux(.d0(gnd), .d1(memdone), .s(don), 
      .y(dmemdonemem));
  muddlib07__mux2_c_1x dmemdonemux(.d0(dmemdonemem), .d1(wbdone), 
      .s(swcb_dmemrwbb), .y(dmemdone));
  memsys_final__buftri_1x_4 wbbyteend(.d(dmembyteen[3:0]), .en(swcb_dmemrwbb), 
      .y(wbbyteen[3:0]));
  muddlib07__buftri_c_1x wbend(.d(dmemen), .en(swcb_dmemrwbb), .y(wben));
endmodule   /* memsys_final__blueblock */

module memsys_final__cmux2_dp_1x(d0, d1, s, sb, y0, y1);
  input d0;
  input d1;
  input s;
  input sb;
  output y0;
  output y1;

  supply1 vdd;
  supply0 gnd;
  wire net_0, net_1, net_10, net_11, net_12, net_13, net_4, net_5, net_6, net_9;

  tranif1 nmos_0(net_0, net_4, sb);
  tranif1 nmos_1(gnd, net_0, d1);
  tranif1 nmos_2(net_1, net_4, s);
  tranif1 nmos_3(gnd, net_1, d0);
  tranif1 nmos_4(net_5, net_9, s);
  tranif1 nmos_5(gnd, net_5, d1);
  tranif1 nmos_6(net_6, net_9, sb);
  tranif1 nmos_7(gnd, net_6, d0);
  tranif1 nmos_8(gnd, y1, net_4);
  tranif1 nmos_9(gnd, y0, net_9);
  tranif0 pmos_0(net_4, net_12, sb);
  tranif0 pmos_1(net_12, vdd, d0);
  tranif0 pmos_2(net_4, net_13, s);
  tranif0 pmos_3(net_13, vdd, d1);
  tranif0 pmos_4(net_9, net_11, sb);
  tranif0 pmos_5(net_11, vdd, d1);
  tranif0 pmos_6(net_10, vdd, d0);
  tranif0 pmos_7(net_9, net_10, s);
  tranif0 pmos_8(y1, vdd, net_4);
  tranif0 pmos_9(y0, vdd, net_9);
endmodule   /* memsys_final__cmux2_dp_1x */

module memsys_final__cmux2_zip(s, s_out, sb_out);
  input s;
  output s_out;
  output sb_out;

  supply1 vdd;
  supply0 gnd;
  muddlib07__inv_4x inv_4x_0(.a(s), .y(sb_out));
  muddlib07__inv_4x inv_4x_1(.a(sb_out), .y(s_out));
endmodule   /* memsys_final__cmux2_zip */

module memsys_final__cmux2_1x_32(d0, d1, s, y0, y1);
  input [31:0] d0;
  input [31:0] d1;
  input s;
  output [31:0] y0;
  output [31:0] y1;

  supply1 vdd;
  supply0 gnd;
  wire sb, sbb;

  memsys_final__cmux2_dp_1x cmux2_31_(.d0(d0[31]), .d1(d1[31]), .s(sbb), 
      .sb(sb), .y0(y0[31]), .y1(y1[31]));
  memsys_final__cmux2_dp_1x cmux2_30_(.d0(d0[30]), .d1(d1[30]), .s(sbb), 
      .sb(sb), .y0(y0[30]), .y1(y1[30]));
  memsys_final__cmux2_dp_1x cmux2_29_(.d0(d0[29]), .d1(d1[29]), .s(sbb), 
      .sb(sb), .y0(y0[29]), .y1(y1[29]));
  memsys_final__cmux2_dp_1x cmux2_28_(.d0(d0[28]), .d1(d1[28]), .s(sbb), 
      .sb(sb), .y0(y0[28]), .y1(y1[28]));
  memsys_final__cmux2_dp_1x cmux2_27_(.d0(d0[27]), .d1(d1[27]), .s(sbb), 
      .sb(sb), .y0(y0[27]), .y1(y1[27]));
  memsys_final__cmux2_dp_1x cmux2_26_(.d0(d0[26]), .d1(d1[26]), .s(sbb), 
      .sb(sb), .y0(y0[26]), .y1(y1[26]));
  memsys_final__cmux2_dp_1x cmux2_25_(.d0(d0[25]), .d1(d1[25]), .s(sbb), 
      .sb(sb), .y0(y0[25]), .y1(y1[25]));
  memsys_final__cmux2_dp_1x cmux2_24_(.d0(d0[24]), .d1(d1[24]), .s(sbb), 
      .sb(sb), .y0(y0[24]), .y1(y1[24]));
  memsys_final__cmux2_dp_1x cmux2_23_(.d0(d0[23]), .d1(d1[23]), .s(sbb), 
      .sb(sb), .y0(y0[23]), .y1(y1[23]));
  memsys_final__cmux2_dp_1x cmux2_22_(.d0(d0[22]), .d1(d1[22]), .s(sbb), 
      .sb(sb), .y0(y0[22]), .y1(y1[22]));
  memsys_final__cmux2_dp_1x cmux2_21_(.d0(d0[21]), .d1(d1[21]), .s(sbb), 
      .sb(sb), .y0(y0[21]), .y1(y1[21]));
  memsys_final__cmux2_dp_1x cmux2_20_(.d0(d0[20]), .d1(d1[20]), .s(sbb), 
      .sb(sb), .y0(y0[20]), .y1(y1[20]));
  memsys_final__cmux2_dp_1x cmux2_19_(.d0(d0[19]), .d1(d1[19]), .s(sbb), 
      .sb(sb), .y0(y0[19]), .y1(y1[19]));
  memsys_final__cmux2_dp_1x cmux2_18_(.d0(d0[18]), .d1(d1[18]), .s(sbb), 
      .sb(sb), .y0(y0[18]), .y1(y1[18]));
  memsys_final__cmux2_dp_1x cmux2_17_(.d0(d0[17]), .d1(d1[17]), .s(sbb), 
      .sb(sb), .y0(y0[17]), .y1(y1[17]));
  memsys_final__cmux2_dp_1x cmux2_16_(.d0(d0[16]), .d1(d1[16]), .s(sbb), 
      .sb(sb), .y0(y0[16]), .y1(y1[16]));
  memsys_final__cmux2_dp_1x cmux2_15_(.d0(d0[15]), .d1(d1[15]), .s(sbb), 
      .sb(sb), .y0(y0[15]), .y1(y1[15]));
  memsys_final__cmux2_dp_1x cmux2_14_(.d0(d0[14]), .d1(d1[14]), .s(sbb), 
      .sb(sb), .y0(y0[14]), .y1(y1[14]));
  memsys_final__cmux2_dp_1x cmux2_13_(.d0(d0[13]), .d1(d1[13]), .s(sbb), 
      .sb(sb), .y0(y0[13]), .y1(y1[13]));
  memsys_final__cmux2_dp_1x cmux2_12_(.d0(d0[12]), .d1(d1[12]), .s(sbb), 
      .sb(sb), .y0(y0[12]), .y1(y1[12]));
  memsys_final__cmux2_dp_1x cmux2_11_(.d0(d0[11]), .d1(d1[11]), .s(sbb), 
      .sb(sb), .y0(y0[11]), .y1(y1[11]));
  memsys_final__cmux2_dp_1x cmux2_10_(.d0(d0[10]), .d1(d1[10]), .s(sbb), 
      .sb(sb), .y0(y0[10]), .y1(y1[10]));
  memsys_final__cmux2_dp_1x cmux2_9_(.d0(d0[9]), .d1(d1[9]), .s(sbb), .sb(sb), 
      .y0(y0[9]), .y1(y1[9]));
  memsys_final__cmux2_dp_1x cmux2_8_(.d0(d0[8]), .d1(d1[8]), .s(sbb), .sb(sb), 
      .y0(y0[8]), .y1(y1[8]));
  memsys_final__cmux2_dp_1x cmux2_7_(.d0(d0[7]), .d1(d1[7]), .s(sbb), .sb(sb), 
      .y0(y0[7]), .y1(y1[7]));
  memsys_final__cmux2_dp_1x cmux2_6_(.d0(d0[6]), .d1(d1[6]), .s(sbb), .sb(sb), 
      .y0(y0[6]), .y1(y1[6]));
  memsys_final__cmux2_dp_1x cmux2_5_(.d0(d0[5]), .d1(d1[5]), .s(sbb), .sb(sb), 
      .y0(y0[5]), .y1(y1[5]));
  memsys_final__cmux2_dp_1x cmux2_4_(.d0(d0[4]), .d1(d1[4]), .s(sbb), .sb(sb), 
      .y0(y0[4]), .y1(y1[4]));
  memsys_final__cmux2_dp_1x cmux2_3_(.d0(d0[3]), .d1(d1[3]), .s(sbb), .sb(sb), 
      .y0(y0[3]), .y1(y1[3]));
  memsys_final__cmux2_dp_1x cmux2_2_(.d0(d0[2]), .d1(d1[2]), .s(sbb), .sb(sb), 
      .y0(y0[2]), .y1(y1[2]));
  memsys_final__cmux2_dp_1x cmux2_1_(.d0(d0[1]), .d1(d1[1]), .s(sbb), .sb(sb), 
      .y0(y0[1]), .y1(y1[1]));
  memsys_final__cmux2_dp_1x cmux2_0_(.d0(d0[0]), .d1(d1[0]), .s(sbb), .sb(sb), 
      .y0(y0[0]), .y1(y1[0]));
  memsys_final__cmux2_zip cmux2_zi_0(.s(s), .s_out(sbb), .sb_out(sb));
endmodule   /* memsys_final__cmux2_1x_32 */

module memsys_final__cmux2_1x_4(d0, d1, s, y0, y1);
  input [3:0] d0;
  input [3:0] d1;
  input s;
  output [3:0] y0;
  output [3:0] y1;

  supply1 vdd;
  supply0 gnd;
  wire sb, sbb;

  memsys_final__cmux2_dp_1x cmux2_3_(.d0(d0[3]), .d1(d1[3]), .s(sbb), .sb(sb), 
      .y0(y0[3]), .y1(y1[3]));
  memsys_final__cmux2_dp_1x cmux2_2_(.d0(d0[2]), .d1(d1[2]), .s(sbb), .sb(sb), 
      .y0(y0[2]), .y1(y1[2]));
  memsys_final__cmux2_dp_1x cmux2_1_(.d0(d0[1]), .d1(d1[1]), .s(sbb), .sb(sb), 
      .y0(y0[1]), .y1(y1[1]));
  memsys_final__cmux2_dp_1x cmux2_0_(.d0(d0[0]), .d1(d1[0]), .s(sbb), .sb(sb), 
      .y0(y0[0]), .y1(y1[0]));
  memsys_final__cmux2_zip cmux2_zi_0(.s(s), .s_out(sbb), .sb_out(sb));
endmodule   /* memsys_final__cmux2_1x_4 */

module memsys_final__buftri_1x_32(d, en, y);
  input [31:0] d;
  input en;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  wire enb, enbb;

  muddlib07__buftri_dp_1x buftri_31_(.d(d[31]), .en(enbb), .enb(enb), 
      .y(y[31]));
  muddlib07__buftri_dp_1x buftri_30_(.d(d[30]), .en(enbb), .enb(enb), 
      .y(y[30]));
  muddlib07__buftri_dp_1x buftri_29_(.d(d[29]), .en(enbb), .enb(enb), 
      .y(y[29]));
  muddlib07__buftri_dp_1x buftri_28_(.d(d[28]), .en(enbb), .enb(enb), 
      .y(y[28]));
  muddlib07__buftri_dp_1x buftri_27_(.d(d[27]), .en(enbb), .enb(enb), 
      .y(y[27]));
  muddlib07__buftri_dp_1x buftri_26_(.d(d[26]), .en(enbb), .enb(enb), 
      .y(y[26]));
  muddlib07__buftri_dp_1x buftri_25_(.d(d[25]), .en(enbb), .enb(enb), 
      .y(y[25]));
  muddlib07__buftri_dp_1x buftri_24_(.d(d[24]), .en(enbb), .enb(enb), 
      .y(y[24]));
  muddlib07__buftri_dp_1x buftri_23_(.d(d[23]), .en(enbb), .enb(enb), 
      .y(y[23]));
  muddlib07__buftri_dp_1x buftri_22_(.d(d[22]), .en(enbb), .enb(enb), 
      .y(y[22]));
  muddlib07__buftri_dp_1x buftri_21_(.d(d[21]), .en(enbb), .enb(enb), 
      .y(y[21]));
  muddlib07__buftri_dp_1x buftri_20_(.d(d[20]), .en(enbb), .enb(enb), 
      .y(y[20]));
  muddlib07__buftri_dp_1x buftri_19_(.d(d[19]), .en(enbb), .enb(enb), 
      .y(y[19]));
  muddlib07__buftri_dp_1x buftri_18_(.d(d[18]), .en(enbb), .enb(enb), 
      .y(y[18]));
  muddlib07__buftri_dp_1x buftri_17_(.d(d[17]), .en(enbb), .enb(enb), 
      .y(y[17]));
  muddlib07__buftri_dp_1x buftri_16_(.d(d[16]), .en(enbb), .enb(enb), 
      .y(y[16]));
  muddlib07__buftri_dp_1x buftri_15_(.d(d[15]), .en(enbb), .enb(enb), 
      .y(y[15]));
  muddlib07__buftri_dp_1x buftri_14_(.d(d[14]), .en(enbb), .enb(enb), 
      .y(y[14]));
  muddlib07__buftri_dp_1x buftri_13_(.d(d[13]), .en(enbb), .enb(enb), 
      .y(y[13]));
  muddlib07__buftri_dp_1x buftri_12_(.d(d[12]), .en(enbb), .enb(enb), 
      .y(y[12]));
  muddlib07__buftri_dp_1x buftri_11_(.d(d[11]), .en(enbb), .enb(enb), 
      .y(y[11]));
  muddlib07__buftri_dp_1x buftri_10_(.d(d[10]), .en(enbb), .enb(enb), 
      .y(y[10]));
  muddlib07__buftri_dp_1x buftri_9_(.d(d[9]), .en(enbb), .enb(enb), .y(y[9]));
  muddlib07__buftri_dp_1x buftri_8_(.d(d[8]), .en(enbb), .enb(enb), .y(y[8]));
  muddlib07__buftri_dp_1x buftri_7_(.d(d[7]), .en(enbb), .enb(enb), .y(y[7]));
  muddlib07__buftri_dp_1x buftri_6_(.d(d[6]), .en(enbb), .enb(enb), .y(y[6]));
  muddlib07__buftri_dp_1x buftri_5_(.d(d[5]), .en(enbb), .enb(enb), .y(y[5]));
  muddlib07__buftri_dp_1x buftri_4_(.d(d[4]), .en(enbb), .enb(enb), .y(y[4]));
  muddlib07__buftri_dp_1x buftri_3_(.d(d[3]), .en(enbb), .enb(enb), .y(y[3]));
  muddlib07__buftri_dp_1x buftri_2_(.d(d[2]), .en(enbb), .enb(enb), .y(y[2]));
  muddlib07__buftri_dp_1x buftri_1_(.d(d[1]), .en(enbb), .enb(enb), .y(y[1]));
  muddlib07__buftri_dp_1x buftri_0_(.d(d[0]), .en(enbb), .enb(enb), .y(y[0]));
  memsys_final__buftri_zip buftri_z_0(.en(en), .en_out(enbb), .enb_out(enb));
endmodule   /* memsys_final__buftri_1x_32 */

module muddlib07__mux4_dp_1x(d0, d1, d2, d3, s0, s0b, s1, s1b, y);
  input d0;
  input d1;
  input d2;
  input d3;
  input s0;
  input s0b;
  input s1;
  input s1b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_28, net_29, net_30, net_5, net_50, net_51, net_56, net_57, net_58;
  wire net_6, net_68, net_70, net_8;

  tranif1 nmos_0(gnd, net_5, d0);
  tranif1 nmos_1(gnd, net_6, d1);
  tranif1 nmos_3(net_5, net_8, s0b);
  tranif1 nmos_4(net_6, net_8, s0);
  tranif1 nmos_5(net_8, net_50, s1b);
  tranif1 nmos_7(gnd, net_70, d3);
  tranif1 nmos_8(net_68, net_51, s0b);
  tranif1 nmos_9(net_70, net_51, s0);
  tranif1 nmos_10(net_51, net_50, s1);
  tranif1 nmos_11(gnd, net_68, d2);
  tranif1 nmos_12(gnd, y, net_50);
  tranif0 pmos_0(net_50, net_30, s1);
  tranif0 pmos_2(net_30, net_28, s0);
  tranif0 pmos_3(net_28, vdd, d0);
  tranif0 pmos_4(net_30, net_29, s0b);
  tranif0 pmos_5(net_29, vdd, d1);
  tranif0 pmos_7(net_58, net_56, s0);
  tranif0 pmos_8(net_56, vdd, d2);
  tranif0 pmos_9(net_58, net_57, s0b);
  tranif0 pmos_10(net_57, vdd, d3);
  tranif0 pmos_11(net_50, net_58, s1b);
  tranif0 pmos_12(y, vdd, net_50);
endmodule   /* muddlib07__mux4_dp_1x */

module memsys_final__mux4_zip(s, s0_out, s0b_out, s1_out, s1b_out);
  input [1:0] s;
  output s0_out;
  output s0b_out;
  output s1_out;
  output s1b_out;

  supply1 vdd;
  supply0 gnd;
  muddlib07__inv_4x inv_4x_4(.a(s[1]), .y(s1b_out));
  muddlib07__inv_4x inv_4x_5(.a(s[0]), .y(s0b_out));
  muddlib07__inv_4x inv_4x_6(.a(s1b_out), .y(s1_out));
  muddlib07__inv_4x inv_4x_7(.a(s0b_out), .y(s0_out));
endmodule   /* memsys_final__mux4_zip */

module memsys_final__mux4_1x_27(d0, d1, d2, d3, s, y);
  input [26:0] d0;
  input [26:0] d1;
  input [26:0] d2;
  input [26:0] d3;
  input [1:0] s;
  output [26:0] y;

  supply1 vdd;
  supply0 gnd;
  wire s0b, s0bb, s1b, s1bb;

  muddlib07__mux4_dp_1x mux4_26_(.d0(d0[26]), .d1(d1[26]), .d2(d2[26]), 
      .d3(d3[26]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[26]));
  muddlib07__mux4_dp_1x mux4_25_(.d0(d0[25]), .d1(d1[25]), .d2(d2[25]), 
      .d3(d3[25]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[25]));
  muddlib07__mux4_dp_1x mux4_24_(.d0(d0[24]), .d1(d1[24]), .d2(d2[24]), 
      .d3(d3[24]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[24]));
  muddlib07__mux4_dp_1x mux4_23_(.d0(d0[23]), .d1(d1[23]), .d2(d2[23]), 
      .d3(d3[23]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[23]));
  muddlib07__mux4_dp_1x mux4_22_(.d0(d0[22]), .d1(d1[22]), .d2(d2[22]), 
      .d3(d3[22]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[22]));
  muddlib07__mux4_dp_1x mux4_21_(.d0(d0[21]), .d1(d1[21]), .d2(d2[21]), 
      .d3(d3[21]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[21]));
  muddlib07__mux4_dp_1x mux4_20_(.d0(d0[20]), .d1(d1[20]), .d2(d2[20]), 
      .d3(d3[20]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[20]));
  muddlib07__mux4_dp_1x mux4_19_(.d0(d0[19]), .d1(d1[19]), .d2(d2[19]), 
      .d3(d3[19]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[19]));
  muddlib07__mux4_dp_1x mux4_18_(.d0(d0[18]), .d1(d1[18]), .d2(d2[18]), 
      .d3(d3[18]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[18]));
  muddlib07__mux4_dp_1x mux4_17_(.d0(d0[17]), .d1(d1[17]), .d2(d2[17]), 
      .d3(d3[17]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[17]));
  muddlib07__mux4_dp_1x mux4_16_(.d0(d0[16]), .d1(d1[16]), .d2(d2[16]), 
      .d3(d3[16]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[16]));
  muddlib07__mux4_dp_1x mux4_15_(.d0(d0[15]), .d1(d1[15]), .d2(d2[15]), 
      .d3(d3[15]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[15]));
  muddlib07__mux4_dp_1x mux4_14_(.d0(d0[14]), .d1(d1[14]), .d2(d2[14]), 
      .d3(d3[14]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[14]));
  muddlib07__mux4_dp_1x mux4_13_(.d0(d0[13]), .d1(d1[13]), .d2(d2[13]), 
      .d3(d3[13]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[13]));
  muddlib07__mux4_dp_1x mux4_12_(.d0(d0[12]), .d1(d1[12]), .d2(d2[12]), 
      .d3(d3[12]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[12]));
  muddlib07__mux4_dp_1x mux4_11_(.d0(d0[11]), .d1(d1[11]), .d2(d2[11]), 
      .d3(d3[11]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[11]));
  muddlib07__mux4_dp_1x mux4_10_(.d0(d0[10]), .d1(d1[10]), .d2(d2[10]), 
      .d3(d3[10]), .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[10]));
  muddlib07__mux4_dp_1x mux4_9_(.d0(d0[9]), .d1(d1[9]), .d2(d2[9]), .d3(d3[9]), 
      .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[9]));
  muddlib07__mux4_dp_1x mux4_8_(.d0(d0[8]), .d1(d1[8]), .d2(d2[8]), .d3(d3[8]), 
      .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[8]));
  muddlib07__mux4_dp_1x mux4_7_(.d0(d0[7]), .d1(d1[7]), .d2(d2[7]), .d3(d3[7]), 
      .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[7]));
  muddlib07__mux4_dp_1x mux4_6_(.d0(d0[6]), .d1(d1[6]), .d2(d2[6]), .d3(d3[6]), 
      .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[6]));
  muddlib07__mux4_dp_1x mux4_5_(.d0(d0[5]), .d1(d1[5]), .d2(d2[5]), .d3(d3[5]), 
      .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[5]));
  muddlib07__mux4_dp_1x mux4_4_(.d0(d0[4]), .d1(d1[4]), .d2(d2[4]), .d3(d3[4]), 
      .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[4]));
  muddlib07__mux4_dp_1x mux4_3_(.d0(d0[3]), .d1(d1[3]), .d2(d2[3]), .d3(d3[3]), 
      .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[3]));
  muddlib07__mux4_dp_1x mux4_2_(.d0(d0[2]), .d1(d1[2]), .d2(d2[2]), .d3(d3[2]), 
      .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[2]));
  muddlib07__mux4_dp_1x mux4_1_(.d0(d0[1]), .d1(d1[1]), .d2(d2[1]), .d3(d3[1]), 
      .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[1]));
  muddlib07__mux4_dp_1x mux4_0_(.d0(d0[0]), .d1(d1[0]), .d2(d2[0]), .d3(d3[0]), 
      .s0(s0bb), .s0b(s0b), .s1(s1bb), .s1b(s1b), .y(y[0]));
  memsys_final__mux4_zip mux4_zip_1(.s(s[1:0]), .s0_out(s0bb), .s0b_out(s0b), 
      .s1_out(s1bb), .s1b_out(s1b));
endmodule   /* memsys_final__mux4_1x_27 */

module memsys_final__buftri_1x_27(d, en, y);
  input [26:0] d;
  input en;
  output [26:0] y;

  supply1 vdd;
  supply0 gnd;
  wire enb, enbb;

  muddlib07__buftri_dp_1x buftri_26_(.d(d[26]), .en(enbb), .enb(enb), 
      .y(y[26]));
  muddlib07__buftri_dp_1x buftri_25_(.d(d[25]), .en(enbb), .enb(enb), 
      .y(y[25]));
  muddlib07__buftri_dp_1x buftri_24_(.d(d[24]), .en(enbb), .enb(enb), 
      .y(y[24]));
  muddlib07__buftri_dp_1x buftri_23_(.d(d[23]), .en(enbb), .enb(enb), 
      .y(y[23]));
  muddlib07__buftri_dp_1x buftri_22_(.d(d[22]), .en(enbb), .enb(enb), 
      .y(y[22]));
  muddlib07__buftri_dp_1x buftri_21_(.d(d[21]), .en(enbb), .enb(enb), 
      .y(y[21]));
  muddlib07__buftri_dp_1x buftri_20_(.d(d[20]), .en(enbb), .enb(enb), 
      .y(y[20]));
  muddlib07__buftri_dp_1x buftri_19_(.d(d[19]), .en(enbb), .enb(enb), 
      .y(y[19]));
  muddlib07__buftri_dp_1x buftri_18_(.d(d[18]), .en(enbb), .enb(enb), 
      .y(y[18]));
  muddlib07__buftri_dp_1x buftri_17_(.d(d[17]), .en(enbb), .enb(enb), 
      .y(y[17]));
  muddlib07__buftri_dp_1x buftri_16_(.d(d[16]), .en(enbb), .enb(enb), 
      .y(y[16]));
  muddlib07__buftri_dp_1x buftri_15_(.d(d[15]), .en(enbb), .enb(enb), 
      .y(y[15]));
  muddlib07__buftri_dp_1x buftri_14_(.d(d[14]), .en(enbb), .enb(enb), 
      .y(y[14]));
  muddlib07__buftri_dp_1x buftri_13_(.d(d[13]), .en(enbb), .enb(enb), 
      .y(y[13]));
  muddlib07__buftri_dp_1x buftri_12_(.d(d[12]), .en(enbb), .enb(enb), 
      .y(y[12]));
  muddlib07__buftri_dp_1x buftri_11_(.d(d[11]), .en(enbb), .enb(enb), 
      .y(y[11]));
  muddlib07__buftri_dp_1x buftri_10_(.d(d[10]), .en(enbb), .enb(enb), 
      .y(y[10]));
  muddlib07__buftri_dp_1x buftri_9_(.d(d[9]), .en(enbb), .enb(enb), .y(y[9]));
  muddlib07__buftri_dp_1x buftri_8_(.d(d[8]), .en(enbb), .enb(enb), .y(y[8]));
  muddlib07__buftri_dp_1x buftri_7_(.d(d[7]), .en(enbb), .enb(enb), .y(y[7]));
  muddlib07__buftri_dp_1x buftri_6_(.d(d[6]), .en(enbb), .enb(enb), .y(y[6]));
  muddlib07__buftri_dp_1x buftri_5_(.d(d[5]), .en(enbb), .enb(enb), .y(y[5]));
  muddlib07__buftri_dp_1x buftri_4_(.d(d[4]), .en(enbb), .enb(enb), .y(y[4]));
  muddlib07__buftri_dp_1x buftri_3_(.d(d[3]), .en(enbb), .enb(enb), .y(y[3]));
  muddlib07__buftri_dp_1x buftri_2_(.d(d[2]), .en(enbb), .enb(enb), .y(y[2]));
  muddlib07__buftri_dp_1x buftri_1_(.d(d[1]), .en(enbb), .enb(enb), .y(y[1]));
  muddlib07__buftri_dp_1x buftri_0_(.d(d[0]), .en(enbb), .enb(enb), .y(y[0]));
  memsys_final__buftri_zip buftri_z_0(.en(en), .en_out(enbb), .enb_out(enb));
endmodule   /* memsys_final__buftri_1x_27 */

module memsys_final__datapath(adrM, byteenM, dmemrwb_don, enM, imemrwb_ion, 
      memwriteMb, pcF, reF, state, swc, swc_imemrwbb, swc_memwriteM, 
      swcb_dmemrwbb, swcb_memwriteM, wbmemadr, wbmemdata, wbon, writedataM, 
      dadr, dbyteen, ddata, den, drwb, iadr, ibyteen, idata, ien, imemdata, 
      instrF, irwb, memadr, readdataM, wbadr, wbdata, dmemdata, memdata);
  input [29:0] adrM;
  input [3:0] byteenM;
  input dmemrwb_don;
  input enM;
  input imemrwb_ion;
  input memwriteMb;
  input [31:2] pcF;
  input reF;
  input [1:0] state;
  input swc;
  input swc_imemrwbb;
  input swc_memwriteM;
  input swcb_dmemrwbb;
  input swcb_memwriteM;
  input [26:0] wbmemadr;
  input [31:0] wbmemdata;
  input wbon;
  input [31:0] writedataM;
  output [29:0] dadr;
  output [3:0] dbyteen;
  output [31:0] ddata;
  output den;
  output drwb;
  output [29:0] iadr;
  output [3:0] ibyteen;
  output [31:0] idata;
  output ien;
  output [31:0] imemdata;
  output [31:0] instrF;
  output irwb;
  output [26:0] memadr;
  output [31:0] readdataM;
  output [26:0] wbadr;
  output [31:0] wbdata;
  input [31:0] dmemdata;
  input [31:0] memdata;

  supply1 vdd;
  supply0 gnd;
  memsys_final__cmux2_1x_32 adrmux(.d0({enM, memwriteMb, adrM[29], adrM[28], 
      adrM[27], adrM[26], adrM[25], adrM[24], adrM[23], adrM[22], adrM[21], 
      adrM[20], adrM[19], adrM[18], adrM[17], adrM[16], adrM[15], adrM[14], 
      adrM[13], adrM[12], adrM[11], adrM[10], adrM[9], adrM[8], adrM[7], 
      adrM[6], adrM[5], adrM[4], adrM[3], adrM[2], adrM[1], adrM[0]}), 
      .d1({reF, vdd, pcF[31], pcF[30], pcF[29], pcF[28], pcF[27], pcF[26], 
      pcF[25], pcF[24], pcF[23], pcF[22], pcF[21], pcF[20], pcF[19], pcF[18], 
      pcF[17], pcF[16], pcF[15], pcF[14], pcF[13], pcF[12], pcF[11], pcF[10], 
      pcF[9], pcF[8], pcF[7], pcF[6], pcF[5], pcF[4], pcF[3], pcF[2]}), 
      .s(swc), .y0({den, drwb, dadr[29], dadr[28], dadr[27], dadr[26], 
      dadr[25], dadr[24], dadr[23], dadr[22], dadr[21], dadr[20], dadr[19], 
      dadr[18], dadr[17], dadr[16], dadr[15], dadr[14], dadr[13], dadr[12], 
      dadr[11], dadr[10], dadr[9], dadr[8], dadr[7], dadr[6], dadr[5], dadr[4], 
      dadr[3], dadr[2], dadr[1], dadr[0]}), .y1({ien, irwb, iadr[29], iadr[28], 
      iadr[27], iadr[26], iadr[25], iadr[24], iadr[23], iadr[22], iadr[21], 
      iadr[20], iadr[19], iadr[18], iadr[17], iadr[16], iadr[15], iadr[14], 
      iadr[13], iadr[12], iadr[11], iadr[10], iadr[9], iadr[8], iadr[7], 
      iadr[6], iadr[5], iadr[4], iadr[3], iadr[2], iadr[1], iadr[0]}));
  memsys_final__cmux2_1x_4 byteenmux(.d0(byteenM[3:0]), .d1({gnd, gnd, gnd, 
      vdd}), .s(swc), .y0(dbyteen[3:0]), .y1(ibyteen[3:0]));
  memsys_final__cmux2_1x_32 datamux(.d0(ddata[31:0]), .d1(idata[31:0]), 
      .s(swc), .y0(readdataM[31:0]), .y1(instrF[31:0]));
  memsys_final__buftri_1x_32 ddatatri(.d(writedataM[31:0]), 
      .en(swcb_memwriteM), .y(ddata[31:0]));
  memsys_final__buftri_1x_32 dmemdatatri(.d(memdata[31:0]), .en(dmemrwb_don), 
      .y(dmemdata[31:0]));
  memsys_final__buftri_1x_32 idatatri(.d(writedataM[31:0]), .en(swc_memwriteM), 
      .y(idata[31:0]));
  memsys_final__buftri_1x_32 imemdatatri(.d(memdata[31:0]), .en(imemrwb_ion), 
      .y(imemdata[31:0]));
  memsys_final__mux4_1x_27 memadrmux(.d0({gnd, gnd, gnd, gnd, gnd, gnd, gnd, 
      gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, 
      gnd, gnd, gnd, gnd, gnd, gnd}), .d1(wbmemadr[26:0]), .d2(dadr[26:0]), 
      .d3(iadr[26:0]), .s(state[1:0]), .y(memadr[26:0]));
  memsys_final__buftri_1x_32 memdatatri(.d(wbmemdata[31:0]), .en(wbon), 
      .y(memdata[31:0]));
  memsys_final__buftri_1x_27 wbadrd(.d(dadr[26:0]), .en(swcb_dmemrwbb), 
      .y(wbadr[26:0]));
  memsys_final__buftri_1x_27 wbadri(.d(iadr[26:0]), .en(swc_imemrwbb), 
      .y(wbadr[26:0]));
  memsys_final__buftri_1x_32 wbdatad(.d(dmemdata[31:0]), .en(swcb_dmemrwbb), 
      .y(wbdata[31:0]));
  memsys_final__buftri_1x_32 wbdatai(.d(imemdata[31:0]), .en(swc_imemrwbb), 
      .y(wbdata[31:0]));
endmodule   /* memsys_final__datapath */

module muddlib07__and4_1x(a, b, c, d, y);
  input a;
  input b;
  input c;
  input d;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_1, net_45, net_46, net_9;

  tranif1 nmos_0(net_45, net_9, c);
  tranif1 nmos_1(net_9, net_1, d);
  tranif1 nmos_3(gnd, y, net_1);
  tranif1 nmos_4(net_46, net_45, b);
  tranif1 nmos_6(gnd, net_46, a);
  tranif0 pmos_0(net_1, vdd, d);
  tranif0 pmos_1(y, vdd, net_1);
  tranif0 pmos_2(net_1, vdd, c);
  tranif0 pmos_3(net_1, vdd, b);
  tranif0 pmos_4(net_1, vdd, a);
endmodule   /* muddlib07__and4_1x */

module muddlib07__or2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_58, net_71;

  tranif1 nmos_8(gnd, net_58, b);
  tranif1 nmos_10(gnd, y, net_58);
  tranif1 nmos_11(gnd, net_58, a);
  tranif0 pmos_2(net_58, net_71, b);
  tranif0 pmos_3(net_71, vdd, a);
  tranif0 pmos_4(y, vdd, net_58);
endmodule   /* muddlib07__or2_1x */

module memsys_final__byteenlog(byteen, memdone, reading, validnew);
  input [3:0] byteen;
  input memdone;
  input reading;
  output validnew;

  supply1 vdd;
  supply0 gnd;
  wire net_1, net_2;

  muddlib07__and2_1x and2_1x_0(.a(net_2), .b(memdone), .y(validnew));
  muddlib07__and4_1x and4_1x_0(.a(byteen[0]), .b(byteen[1]), .c(byteen[2]), 
      .d(byteen[3]), .y(net_1));
  muddlib07__or2_1x or2_1x_0(.a(net_1), .b(reading), .y(net_2));
endmodule   /* memsys_final__byteenlog */

module muddlib07__and3_1x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_1, net_45, net_9;

  tranif1 nmos_0(net_45, net_9, b);
  tranif1 nmos_1(net_9, net_1, c);
  tranif1 nmos_3(gnd, y, net_1);
  tranif1 nmos_4(gnd, net_45, a);
  tranif0 pmos_0(net_1, vdd, c);
  tranif0 pmos_1(y, vdd, net_1);
  tranif0 pmos_2(net_1, vdd, a);
  tranif0 pmos_3(net_1, vdd, b);
endmodule   /* muddlib07__and3_1x */

module muddlib07__xnor2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire ab, bb, net_3, net_4, net_7, net_8;

  tranif1 nmos_0(gnd, net_3, a);
  tranif1 nmos_1(gnd, net_4, ab);
  tranif1 nmos_2(net_3, y, bb);
  tranif1 nmos_3(net_4, y, b);
  tranif1 nmos_4(gnd, bb, b);
  tranif1 nmos_5(gnd, ab, a);
  tranif0 pmos_0(y, net_7, b);
  tranif0 pmos_1(net_7, vdd, a);
  tranif0 pmos_2(y, net_8, bb);
  tranif0 pmos_3(net_8, vdd, ab);
  tranif0 pmos_4(bb, vdd, b);
  tranif0 pmos_5(ab, vdd, a);
endmodule   /* muddlib07__xnor2_1x */

module memsys_final__comparator_20(a, b, y);
  input [19:0] a;
  input [19:0] b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_38, net_40;
  wire [19:0] y1;
  wire [4:0] y2;

  muddlib07__and2_1x and2_1x_0(.a(y2[1]), .b(y2[0]), .y(net_40));
  muddlib07__and2_1x and2_1x_1(.a(net_38), .b(net_40), .y(y));
  muddlib07__and3_1x and3_1x_0(.a(y2[4]), .b(y2[3]), .c(y2[2]), .y(net_38));
  muddlib07__and4_1x and4_4_(.a(y1[19]), .b(y1[18]), .c(y1[17]), .d(y1[16]), 
      .y(y2[4]));
  muddlib07__and4_1x and4_3_(.a(y1[15]), .b(y1[14]), .c(y1[13]), .d(y1[12]), 
      .y(y2[3]));
  muddlib07__and4_1x and4_2_(.a(y1[11]), .b(y1[10]), .c(y1[9]), .d(y1[8]), 
      .y(y2[2]));
  muddlib07__and4_1x and4_1_(.a(y1[7]), .b(y1[6]), .c(y1[5]), .d(y1[4]), 
      .y(y2[1]));
  muddlib07__and4_1x and4_0_(.a(y1[3]), .b(y1[2]), .c(y1[1]), .d(y1[0]), 
      .y(y2[0]));
  muddlib07__xnor2_1x xnor2_19_(.a(a[19]), .b(b[19]), .y(y1[19]));
  muddlib07__xnor2_1x xnor2_18_(.a(a[18]), .b(b[18]), .y(y1[18]));
  muddlib07__xnor2_1x xnor2_17_(.a(a[17]), .b(b[17]), .y(y1[17]));
  muddlib07__xnor2_1x xnor2_16_(.a(a[16]), .b(b[16]), .y(y1[16]));
  muddlib07__xnor2_1x xnor2_15_(.a(a[15]), .b(b[15]), .y(y1[15]));
  muddlib07__xnor2_1x xnor2_14_(.a(a[14]), .b(b[14]), .y(y1[14]));
  muddlib07__xnor2_1x xnor2_13_(.a(a[13]), .b(b[13]), .y(y1[13]));
  muddlib07__xnor2_1x xnor2_12_(.a(a[12]), .b(b[12]), .y(y1[12]));
  muddlib07__xnor2_1x xnor2_11_(.a(a[11]), .b(b[11]), .y(y1[11]));
  muddlib07__xnor2_1x xnor2_10_(.a(a[10]), .b(b[10]), .y(y1[10]));
  muddlib07__xnor2_1x xnor2_9_(.a(a[9]), .b(b[9]), .y(y1[9]));
  muddlib07__xnor2_1x xnor2_8_(.a(a[8]), .b(b[8]), .y(y1[8]));
  muddlib07__xnor2_1x xnor2_7_(.a(a[7]), .b(b[7]), .y(y1[7]));
  muddlib07__xnor2_1x xnor2_6_(.a(a[6]), .b(b[6]), .y(y1[6]));
  muddlib07__xnor2_1x xnor2_5_(.a(a[5]), .b(b[5]), .y(y1[5]));
  muddlib07__xnor2_1x xnor2_4_(.a(a[4]), .b(b[4]), .y(y1[4]));
  muddlib07__xnor2_1x xnor2_3_(.a(a[3]), .b(b[3]), .y(y1[3]));
  muddlib07__xnor2_1x xnor2_2_(.a(a[2]), .b(b[2]), .y(y1[2]));
  muddlib07__xnor2_1x xnor2_1_(.a(a[1]), .b(b[1]), .y(y1[1]));
  muddlib07__xnor2_1x xnor2_0_(.a(a[0]), .b(b[0]), .y(y1[0]));
endmodule   /* memsys_final__comparator_20 */

module muddlib07__inv_1x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  tranif1 nmos_0(gnd, y, a);
  tranif0 pmos_0(y, vdd, a);
endmodule   /* muddlib07__inv_1x */

module muddlib07__or4_1x(a, b, c, d, y);
  input a;
  input b;
  input c;
  input d;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_13, net_2, net_3, net_41;

  tranif1 nmos_0(gnd, net_13, d);
  tranif1 nmos_1(gnd, net_13, c);
  tranif1 nmos_2(gnd, net_13, b);
  tranif1 nmos_3(gnd, net_13, a);
  tranif1 nmos_4(gnd, y, net_13);
  tranif0 pmos_0(net_41, vdd, a);
  tranif0 pmos_1(net_2, net_41, b);
  tranif0 pmos_2(net_3, net_2, c);
  tranif0 pmos_3(net_13, net_3, d);
  tranif0 pmos_4(y, vdd, net_13);
endmodule   /* muddlib07__or4_1x */

module memsys_final__adrtagdatalogic(adr, adr_1, en, memdone, reset, rwb, 
      tagdata, valid, waiting, bypass, done);
  input [27:7] adr;
  input [29:29] adr_1;
  input en;
  input memdone;
  input reset;
  input rwb;
  input [19:0] tagdata;
  input valid;
  input waiting;
  output bypass;
  output done;

  supply1 vdd;
  supply0 gnd;
  wire bypass_b, en_b, incache, temp1, temp2, temp3;

  muddlib07__and2_1x and2_1x_0(.a(adr_1[29]), .b(adr[27]), .y(bypass));
  muddlib07__and2_1x and2_1x_1(.a(temp1), .b(valid), .y(incache));
  muddlib07__and2_1x and2_1x_2(.a(waiting), .b(memdone), .y(temp3));
  muddlib07__and3_1x and3_1x_0(.a(incache), .b(rwb), .c(bypass_b), .y(temp2));
  memsys_final__comparator_20 comparat_1(.a(tagdata[19:0]), .b(adr[26:7]), 
      .y(temp1));
  muddlib07__inv_1x inv_1x_0(.a(bypass), .y(bypass_b));
  muddlib07__inv_1x inv_1x_1(.a(en), .y(en_b));
  muddlib07__or4_1x or4_1x_0(.a(temp2), .b(en_b), .c(reset), .d(temp3), 
      .y(done));
endmodule   /* memsys_final__adrtagdatalogic */

module memsys_final__controllerstatelogic(done, memdone, rwb, s0, s1, nexts0, 
      nexts1);
  input done;
  input memdone;
  input rwb;
  input s0;
  input s1;
  output nexts0;
  output nexts1;

  supply1 vdd;
  supply0 gnd;
  wire done_b, memdone_b, net_0, net_5, net_54, net_7, net_83, s0_b, s1_b;

  muddlib07__and3_1x and3_1x_0(.a(s1), .b(s0_b), .c(memdone_b), .y(net_7));
  muddlib07__and3_1x and3_1x_1(.a(s1_b), .b(s0), .c(memdone_b), .y(net_5));
  muddlib07__and4_1x and4_1x_0(.a(s1_b), .b(s0_b), .c(net_54), .d(done_b), 
      .y(net_0));
  muddlib07__and4_1x and4_1x_1(.a(s1_b), .b(s0_b), .c(done_b), .d(rwb), 
      .y(net_83));
  muddlib07__inv_1x inv_1x_0(.a(s1), .y(s1_b));
  muddlib07__inv_1x inv_1x_1(.a(s0), .y(s0_b));
  muddlib07__inv_1x inv_1x_2(.a(done), .y(done_b));
  muddlib07__inv_1x inv_1x_3(.a(memdone), .y(memdone_b));
  muddlib07__inv_1x inv_1x_4(.a(rwb), .y(net_54));
  muddlib07__or2_1x or2_1x_0(.a(net_0), .b(net_7), .y(nexts1));
  muddlib07__or2_1x or2_1x_1(.a(net_5), .b(net_83), .y(nexts0));
endmodule   /* memsys_final__controllerstatelogic */

module muddlib07__flopr_c_1x(d, resetb, q, ph1, ph2);
  input d;
  input resetb;
  output q;
  input ph1;
  input ph2;

  supply1 vdd;
  supply0 gnd;
  wire master, masterinb, n6, n7, n8, n9, net_429, ph1b, ph1buf, ph2b, ph2buf;
  wire slaveb;
  trireg masterb, slave;

  tranif1 nmos_2(masterinb, masterb, ph2buf);
  tranif1 nmos_3(gnd, master, masterb);
  rtranif1 nmos_4(master, slave, ph1buf);
  tranif1 nmos_5(n6, masterb, ph2b);
  tranif1 nmos_6(gnd, n6, master);
  tranif1 nmos_7(gnd, n8, slaveb);
  tranif1 nmos_8(gnd, slaveb, slave);
  tranif1 nmos_10(n8, slave, ph1b);
  tranif1 nmos_11(gnd, q, slaveb);
  tranif1 nmos_17(gnd, net_429, resetb);
  tranif1 nmos_19(net_429, masterinb, d);
  tranif1 nmos_22(gnd, ph2b, ph2);
  tranif1 nmos_25(gnd, ph2buf, ph2b);
  tranif1 nmos_26(gnd, ph1buf, ph1b);
  tranif1 nmos_27(gnd, ph1b, ph1);
  tranif0 pmos_2(masterb, masterinb, ph2b);
  tranif0 pmos_3(master, vdd, masterb);
  rtranif0 pmos_4(slave, master, ph1b);
  tranif0 pmos_5(masterb, n7, ph2buf);
  tranif0 pmos_6(n7, vdd, master);
  tranif0 pmos_7(n9, vdd, slaveb);
  tranif0 pmos_8(slaveb, vdd, slave);
  tranif0 pmos_10(slave, n9, ph1buf);
  tranif0 pmos_11(q, vdd, slaveb);
  tranif0 pmos_16(masterinb, vdd, d);
  tranif0 pmos_18(masterinb, vdd, resetb);
  tranif0 pmos_21(ph1b, vdd, ph1);
  tranif0 pmos_22(ph2b, vdd, ph2);
  tranif0 pmos_24(ph1buf, vdd, ph1b);
  tranif0 pmos_25(ph2buf, vdd, ph2b);
endmodule   /* muddlib07__flopr_c_1x */

module memsys_final__cachecontroller(adr, adr_1, en, memdone, reset, rwb, 
      tagdata, valid, bypass, done, reading, waiting, ph1, ph2);
  input [27:7] adr;
  input [29:29] adr_1;
  input en;
  input memdone;
  input reset;
  input rwb;
  input [19:0] tagdata;
  input valid;
  output bypass;
  output done;
  output reading;
  output waiting;
  input ph1;
  input ph2;

  supply1 vdd;
  supply0 gnd;
  wire nextstate0, nextstate1, reset_b, state1;

  memsys_final__adrtagdatalogic adrtagda_4(.adr(adr[27:7]), 
      .adr_1(adr_1[29:29]), .en(en), .memdone(memdone), .reset(reset), 
      .rwb(rwb), .tagdata(tagdata[19:0]), .valid(valid), .waiting(waiting), 
      .bypass(bypass), .done(done));
  memsys_final__controllerstatelogic controll_3(.done(done), .memdone(memdone), 
      .rwb(rwb), .s0(reading), .s1(state1), .nexts0(nextstate0), 
      .nexts1(nextstate1));
  muddlib07__flopr_c_1x flopr_c__0(.d(nextstate1), .resetb(reset_b), 
      .q(state1), .ph1(ph1), .ph2(ph2));
  muddlib07__flopr_c_1x flopr_c__1(.d(nextstate0), .resetb(reset_b), 
      .q(reading), .ph1(ph1), .ph2(ph2));
  muddlib07__inv_1x inv_1x_2(.a(reset), .y(reset_b));
  muddlib07__or2_1x or2_1x_2(.a(state1), .b(reading), .y(waiting));
endmodule   /* memsys_final__cachecontroller */

module memsys_final__inv_16x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  tranif1 nmos_0(gnd, y, a);
  tranif0 pmos_0(y, vdd, a);
endmodule   /* memsys_final__inv_16x */

module memsys_final__inv_32x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  tranif1 nmos_0(gnd, y, a);
  tranif0 pmos_0(y, vdd, a);
endmodule   /* memsys_final__inv_32x */

module memsys_final__inv_64x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  tranif1 nmos_0(gnd, y, a);
  tranif0 pmos_0(y, vdd, a);
endmodule   /* memsys_final__inv_64x */

module muddlib07__invbuf_4x(s, s_out, sb_out);
  input s;
  output s_out;
  output sb_out;

  supply1 vdd;
  supply0 gnd;
  muddlib07__inv_4x inv_4x_3(.a(s), .y(sb_out));
  muddlib07__inv_4x inv_4x_4(.a(sb_out), .y(s_out));
endmodule   /* muddlib07__invbuf_4x */

module memsys_final__cache_buffers(adr, ph1, ph2, rwb, word, adr_b, adr_buff, 
      ph1_b, ph1_bc_b, ph2_b, rwb_buff);
  input adr;
  input ph1;
  input ph2;
  input rwb;
  input [63:0] word;
  output adr_b;
  output adr_buff;
  output ph1_b;
  output ph1_bc_b;
  output ph2_b;
  output rwb_buff;

  supply1 vdd;
  supply0 gnd;
  wire invbuf_4_1_sb_out, invbuf_4_2_sb_out, net_113, net_49, net_58, net_59;
  wire net_61, net_66, net_69, net_79, net_99;

  muddlib07__inv_1x inv_1x_0(.a(adr_buff), .y(net_69));
  muddlib07__inv_1x inv_1x_1(.a(net_99), .y(net_59));
  muddlib07__inv_4x inv_4x_1(.a(net_113), .y(ph1_b));
  muddlib07__inv_4x inv_4x_2(.a(rwb), .y(net_49));
  muddlib07__inv_4x inv_4x_3(.a(net_59), .y(net_58));
  muddlib07__inv_4x inv_4x_4(.a(adr), .y(net_61));
  muddlib07__inv_4x inv_4x_5(.a(net_69), .y(net_66));
  memsys_final__inv_16x inv_8x_0(.a(ph1_b), .y(net_79));
  memsys_final__inv_32x inv_32x_0(.a(net_49), .y(rwb_buff));
  memsys_final__inv_32x inv_32x_1(.a(net_58), .y(ph2_b));
  memsys_final__inv_32x inv_32x_2(.a(net_61), .y(adr_buff));
  memsys_final__inv_32x inv_32x_3(.a(net_66), .y(adr_b));
  memsys_final__inv_64x inv_64x_0(.a(net_79), .y(ph1_bc_b));
  muddlib07__invbuf_4x invbuf_4_1(.s(ph2), .s_out(net_99), 
      .sb_out(invbuf_4_1_sb_out));
  muddlib07__invbuf_4x invbuf_4_2(.s(ph1), .s_out(net_113), 
      .sb_out(invbuf_4_2_sb_out));
endmodule   /* memsys_final__cache_buffers */

module memsys_final__bitconditioning(ph1_b, y1, y2);
  input ph1_b;
  output y1;  trireg y1;
  output y2;  trireg y2;

  supply1 vdd;
  tranif0 pmos_0(vdd, y1, ph1_b);
  tranif0 pmos_1(y2, vdd, ph1_b);
endmodule   /* memsys_final__bitconditioning */

module muddlib07__srambit(bit, bit_b, word);
  input bit;
  input bit_b;
  input word;

  supply1 vdd;
  supply0 gnd;
  wire net_67, net_68;

  tranif1 nmos_4(gnd, net_67, net_68);
  tranif1 nmos_5(net_68, gnd, net_67);
  tranif1 nmos_6(bit, net_68, word);
  tranif1 nmos_7(net_67, bit_b, word);
  rtranif0 pmos_2(net_67, vdd, net_68);
  rtranif0 pmos_3(vdd, net_68, net_67);
endmodule   /* muddlib07__srambit */

module memsys_final__writedriver(adr, adr_b, din, ph1_b, ph2_b, rwb, dataout, 
      y0, y1, y2, y3);
  input adr;
  input adr_b;
  input din;
  input ph1_b;
  input ph2_b;
  input rwb;
  output dataout;
  input y0;
  input y1;
  input y2;
  input y3;

  supply1 vdd;
  supply0 gnd;
  wire din_b, net_256, net_264, net_274, net_290, net_291, net_323;

  tranif1 nmos_22(gnd, net_256, ph2_b);
  tranif1 nmos_23(gnd, net_256, rwb);
  tranif1 nmos_24(gnd, net_256, din);
  tranif1 nmos_25(gnd, net_264, ph2_b);
  tranif1 nmos_26(gnd, net_264, rwb);
  tranif1 nmos_27(gnd, net_264, din_b);
  tranif1 nmos_28(gnd, net_274, net_256);
  tranif1 nmos_29(net_274, y0, adr);
  tranif1 nmos_30(net_274, y2, adr_b);
  tranif1 nmos_31(gnd, din_b, din);
  tranif1 nmos_32(gnd, net_323, net_264);
  tranif1 nmos_33(net_323, y3, adr_b);
  tranif1 nmos_34(net_323, y1, adr);
  tranif1 nmos_35(gnd, dataout, net_323);
  tranif0 pmos_13(din_b, vdd, din);
  tranif0 pmos_14(net_256, net_291, din);
  tranif0 pmos_15(net_291, net_290, rwb);
  tranif0 pmos_16(net_290, vdd, ph2_b);
  tranif0 pmos_17(net_264, net_291, din_b);
  tranif0 pmos_18(net_323, vdd, ph1_b);
  tranif0 pmos_19(dataout, vdd, net_323);
endmodule   /* memsys_final__writedriver */

module memsys_final__cacheramcolumn(adr, adr_b, din, rwb, word, dout, ph1_b, 
      ph1_b_buff, ph2_b);
  input adr;
  input adr_b;
  input din;
  input rwb;
  input [63:0] word;
  output dout;
  input ph1_b;
  input ph1_b_buff;
  input ph2_b;

  supply1 vdd;
  supply0 gnd;
  wire net_96, net_97, sram1bit, sram1bit_b;

  memsys_final__bitconditioning bitcondi_2(.ph1_b(ph1_b_buff), .y1(sram1bit), 
      .y2(sram1bit_b));
  memsys_final__bitconditioning bitcondi_3(.ph1_b(ph1_b_buff), .y1(net_96), 
      .y2(net_97));
  muddlib07__srambit srambit0_63_(.bit(net_97), .bit_b(net_96), 
      .word(word[63]));
  muddlib07__srambit srambit0_62_(.bit(net_97), .bit_b(net_96), 
      .word(word[62]));
  muddlib07__srambit srambit0_61_(.bit(net_97), .bit_b(net_96), 
      .word(word[61]));
  muddlib07__srambit srambit0_60_(.bit(net_97), .bit_b(net_96), 
      .word(word[60]));
  muddlib07__srambit srambit0_59_(.bit(net_97), .bit_b(net_96), 
      .word(word[59]));
  muddlib07__srambit srambit0_58_(.bit(net_97), .bit_b(net_96), 
      .word(word[58]));
  muddlib07__srambit srambit0_57_(.bit(net_97), .bit_b(net_96), 
      .word(word[57]));
  muddlib07__srambit srambit0_56_(.bit(net_97), .bit_b(net_96), 
      .word(word[56]));
  muddlib07__srambit srambit0_55_(.bit(net_97), .bit_b(net_96), 
      .word(word[55]));
  muddlib07__srambit srambit0_54_(.bit(net_97), .bit_b(net_96), 
      .word(word[54]));
  muddlib07__srambit srambit0_53_(.bit(net_97), .bit_b(net_96), 
      .word(word[53]));
  muddlib07__srambit srambit0_52_(.bit(net_97), .bit_b(net_96), 
      .word(word[52]));
  muddlib07__srambit srambit0_51_(.bit(net_97), .bit_b(net_96), 
      .word(word[51]));
  muddlib07__srambit srambit0_50_(.bit(net_97), .bit_b(net_96), 
      .word(word[50]));
  muddlib07__srambit srambit0_49_(.bit(net_97), .bit_b(net_96), 
      .word(word[49]));
  muddlib07__srambit srambit0_48_(.bit(net_97), .bit_b(net_96), 
      .word(word[48]));
  muddlib07__srambit srambit0_47_(.bit(net_97), .bit_b(net_96), 
      .word(word[47]));
  muddlib07__srambit srambit0_46_(.bit(net_97), .bit_b(net_96), 
      .word(word[46]));
  muddlib07__srambit srambit0_45_(.bit(net_97), .bit_b(net_96), 
      .word(word[45]));
  muddlib07__srambit srambit0_44_(.bit(net_97), .bit_b(net_96), 
      .word(word[44]));
  muddlib07__srambit srambit0_43_(.bit(net_97), .bit_b(net_96), 
      .word(word[43]));
  muddlib07__srambit srambit0_42_(.bit(net_97), .bit_b(net_96), 
      .word(word[42]));
  muddlib07__srambit srambit0_41_(.bit(net_97), .bit_b(net_96), 
      .word(word[41]));
  muddlib07__srambit srambit0_40_(.bit(net_97), .bit_b(net_96), 
      .word(word[40]));
  muddlib07__srambit srambit0_39_(.bit(net_97), .bit_b(net_96), 
      .word(word[39]));
  muddlib07__srambit srambit0_38_(.bit(net_97), .bit_b(net_96), 
      .word(word[38]));
  muddlib07__srambit srambit0_37_(.bit(net_97), .bit_b(net_96), 
      .word(word[37]));
  muddlib07__srambit srambit0_36_(.bit(net_97), .bit_b(net_96), 
      .word(word[36]));
  muddlib07__srambit srambit0_35_(.bit(net_97), .bit_b(net_96), 
      .word(word[35]));
  muddlib07__srambit srambit0_34_(.bit(net_97), .bit_b(net_96), 
      .word(word[34]));
  muddlib07__srambit srambit0_33_(.bit(net_97), .bit_b(net_96), 
      .word(word[33]));
  muddlib07__srambit srambit0_32_(.bit(net_97), .bit_b(net_96), 
      .word(word[32]));
  muddlib07__srambit srambit0_31_(.bit(net_97), .bit_b(net_96), 
      .word(word[31]));
  muddlib07__srambit srambit0_30_(.bit(net_97), .bit_b(net_96), 
      .word(word[30]));
  muddlib07__srambit srambit0_29_(.bit(net_97), .bit_b(net_96), 
      .word(word[29]));
  muddlib07__srambit srambit0_28_(.bit(net_97), .bit_b(net_96), 
      .word(word[28]));
  muddlib07__srambit srambit0_27_(.bit(net_97), .bit_b(net_96), 
      .word(word[27]));
  muddlib07__srambit srambit0_26_(.bit(net_97), .bit_b(net_96), 
      .word(word[26]));
  muddlib07__srambit srambit0_25_(.bit(net_97), .bit_b(net_96), 
      .word(word[25]));
  muddlib07__srambit srambit0_24_(.bit(net_97), .bit_b(net_96), 
      .word(word[24]));
  muddlib07__srambit srambit0_23_(.bit(net_97), .bit_b(net_96), 
      .word(word[23]));
  muddlib07__srambit srambit0_22_(.bit(net_97), .bit_b(net_96), 
      .word(word[22]));
  muddlib07__srambit srambit0_21_(.bit(net_97), .bit_b(net_96), 
      .word(word[21]));
  muddlib07__srambit srambit0_20_(.bit(net_97), .bit_b(net_96), 
      .word(word[20]));
  muddlib07__srambit srambit0_19_(.bit(net_97), .bit_b(net_96), 
      .word(word[19]));
  muddlib07__srambit srambit0_18_(.bit(net_97), .bit_b(net_96), 
      .word(word[18]));
  muddlib07__srambit srambit0_17_(.bit(net_97), .bit_b(net_96), 
      .word(word[17]));
  muddlib07__srambit srambit0_16_(.bit(net_97), .bit_b(net_96), 
      .word(word[16]));
  muddlib07__srambit srambit0_15_(.bit(net_97), .bit_b(net_96), 
      .word(word[15]));
  muddlib07__srambit srambit0_14_(.bit(net_97), .bit_b(net_96), 
      .word(word[14]));
  muddlib07__srambit srambit0_13_(.bit(net_97), .bit_b(net_96), 
      .word(word[13]));
  muddlib07__srambit srambit0_12_(.bit(net_97), .bit_b(net_96), 
      .word(word[12]));
  muddlib07__srambit srambit0_11_(.bit(net_97), .bit_b(net_96), 
      .word(word[11]));
  muddlib07__srambit srambit0_10_(.bit(net_97), .bit_b(net_96), 
      .word(word[10]));
  muddlib07__srambit srambit0_9_(.bit(net_97), .bit_b(net_96), 
      .word(word[9]));
  muddlib07__srambit srambit0_8_(.bit(net_97), .bit_b(net_96), 
      .word(word[8]));
  muddlib07__srambit srambit0_7_(.bit(net_97), .bit_b(net_96), 
      .word(word[7]));
  muddlib07__srambit srambit0_6_(.bit(net_97), .bit_b(net_96), 
      .word(word[6]));
  muddlib07__srambit srambit0_5_(.bit(net_97), .bit_b(net_96), 
      .word(word[5]));
  muddlib07__srambit srambit0_4_(.bit(net_97), .bit_b(net_96), 
      .word(word[4]));
  muddlib07__srambit srambit0_3_(.bit(net_97), .bit_b(net_96), 
      .word(word[3]));
  muddlib07__srambit srambit0_2_(.bit(net_97), .bit_b(net_96), 
      .word(word[2]));
  muddlib07__srambit srambit0_1_(.bit(net_97), .bit_b(net_96), 
      .word(word[1]));
  muddlib07__srambit srambit0_0_(.bit(net_97), .bit_b(net_96), 
      .word(word[0]));
  muddlib07__srambit srambit1_63_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[63]));
  muddlib07__srambit srambit1_62_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[62]));
  muddlib07__srambit srambit1_61_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[61]));
  muddlib07__srambit srambit1_60_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[60]));
  muddlib07__srambit srambit1_59_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[59]));
  muddlib07__srambit srambit1_58_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[58]));
  muddlib07__srambit srambit1_57_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[57]));
  muddlib07__srambit srambit1_56_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[56]));
  muddlib07__srambit srambit1_55_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[55]));
  muddlib07__srambit srambit1_54_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[54]));
  muddlib07__srambit srambit1_53_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[53]));
  muddlib07__srambit srambit1_52_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[52]));
  muddlib07__srambit srambit1_51_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[51]));
  muddlib07__srambit srambit1_50_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[50]));
  muddlib07__srambit srambit1_49_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[49]));
  muddlib07__srambit srambit1_48_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[48]));
  muddlib07__srambit srambit1_47_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[47]));
  muddlib07__srambit srambit1_46_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[46]));
  muddlib07__srambit srambit1_45_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[45]));
  muddlib07__srambit srambit1_44_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[44]));
  muddlib07__srambit srambit1_43_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[43]));
  muddlib07__srambit srambit1_42_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[42]));
  muddlib07__srambit srambit1_41_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[41]));
  muddlib07__srambit srambit1_40_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[40]));
  muddlib07__srambit srambit1_39_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[39]));
  muddlib07__srambit srambit1_38_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[38]));
  muddlib07__srambit srambit1_37_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[37]));
  muddlib07__srambit srambit1_36_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[36]));
  muddlib07__srambit srambit1_35_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[35]));
  muddlib07__srambit srambit1_34_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[34]));
  muddlib07__srambit srambit1_33_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[33]));
  muddlib07__srambit srambit1_32_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[32]));
  muddlib07__srambit srambit1_31_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[31]));
  muddlib07__srambit srambit1_30_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[30]));
  muddlib07__srambit srambit1_29_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[29]));
  muddlib07__srambit srambit1_28_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[28]));
  muddlib07__srambit srambit1_27_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[27]));
  muddlib07__srambit srambit1_26_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[26]));
  muddlib07__srambit srambit1_25_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[25]));
  muddlib07__srambit srambit1_24_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[24]));
  muddlib07__srambit srambit1_23_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[23]));
  muddlib07__srambit srambit1_22_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[22]));
  muddlib07__srambit srambit1_21_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[21]));
  muddlib07__srambit srambit1_20_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[20]));
  muddlib07__srambit srambit1_19_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[19]));
  muddlib07__srambit srambit1_18_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[18]));
  muddlib07__srambit srambit1_17_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[17]));
  muddlib07__srambit srambit1_16_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[16]));
  muddlib07__srambit srambit1_15_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[15]));
  muddlib07__srambit srambit1_14_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[14]));
  muddlib07__srambit srambit1_13_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[13]));
  muddlib07__srambit srambit1_12_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[12]));
  muddlib07__srambit srambit1_11_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[11]));
  muddlib07__srambit srambit1_10_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[10]));
  muddlib07__srambit srambit1_9_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[9]));
  muddlib07__srambit srambit1_8_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[8]));
  muddlib07__srambit srambit1_7_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[7]));
  muddlib07__srambit srambit1_6_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[6]));
  muddlib07__srambit srambit1_5_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[5]));
  muddlib07__srambit srambit1_4_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[4]));
  muddlib07__srambit srambit1_3_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[3]));
  muddlib07__srambit srambit1_2_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[2]));
  muddlib07__srambit srambit1_1_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[1]));
  muddlib07__srambit srambit1_0_(.bit(sram1bit), .bit_b(sram1bit_b), 
      .word(word[0]));
  memsys_final__writedriver writedri_4(.adr(adr), .adr_b(adr_b), .din(din), 
      .ph1_b(ph1_b), .ph2_b(ph2_b), .rwb(rwb), .dataout(dout), .y0(sram1bit), 
      .y1(sram1bit_b), .y2(net_96), .y3(net_97));
endmodule   /* memsys_final__cacheramcolumn */

module memsys_final__cacheramarray(adr, adr_b, din, ph1_b, ph1_b_buff, ph2_b, 
      rwb, word, dout);
  input adr;
  input adr_b;
  input [52:0] din;
  input ph1_b;
  input ph1_b_buff;
  input ph2_b;
  input rwb;
  input [63:0] word;
  output [52:0] dout;

  supply1 vdd;
  supply0 gnd;
  memsys_final__cacheramcolumn cacheramcolumn_52_(.adr(adr), .adr_b(adr_b), 
      .din(din[52]), .rwb(rwb), .word(word[63:0]), .dout(dout[52]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_51_(.adr(adr), .adr_b(adr_b), 
      .din(din[51]), .rwb(rwb), .word(word[63:0]), .dout(dout[51]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_50_(.adr(adr), .adr_b(adr_b), 
      .din(din[50]), .rwb(rwb), .word(word[63:0]), .dout(dout[50]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_49_(.adr(adr), .adr_b(adr_b), 
      .din(din[49]), .rwb(rwb), .word(word[63:0]), .dout(dout[49]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_48_(.adr(adr), .adr_b(adr_b), 
      .din(din[48]), .rwb(rwb), .word(word[63:0]), .dout(dout[48]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_47_(.adr(adr), .adr_b(adr_b), 
      .din(din[47]), .rwb(rwb), .word(word[63:0]), .dout(dout[47]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_46_(.adr(adr), .adr_b(adr_b), 
      .din(din[46]), .rwb(rwb), .word(word[63:0]), .dout(dout[46]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_45_(.adr(adr), .adr_b(adr_b), 
      .din(din[45]), .rwb(rwb), .word(word[63:0]), .dout(dout[45]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_44_(.adr(adr), .adr_b(adr_b), 
      .din(din[44]), .rwb(rwb), .word(word[63:0]), .dout(dout[44]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_43_(.adr(adr), .adr_b(adr_b), 
      .din(din[43]), .rwb(rwb), .word(word[63:0]), .dout(dout[43]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_42_(.adr(adr), .adr_b(adr_b), 
      .din(din[42]), .rwb(rwb), .word(word[63:0]), .dout(dout[42]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_41_(.adr(adr), .adr_b(adr_b), 
      .din(din[41]), .rwb(rwb), .word(word[63:0]), .dout(dout[41]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_40_(.adr(adr), .adr_b(adr_b), 
      .din(din[40]), .rwb(rwb), .word(word[63:0]), .dout(dout[40]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_39_(.adr(adr), .adr_b(adr_b), 
      .din(din[39]), .rwb(rwb), .word(word[63:0]), .dout(dout[39]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_38_(.adr(adr), .adr_b(adr_b), 
      .din(din[38]), .rwb(rwb), .word(word[63:0]), .dout(dout[38]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_37_(.adr(adr), .adr_b(adr_b), 
      .din(din[37]), .rwb(rwb), .word(word[63:0]), .dout(dout[37]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_36_(.adr(adr), .adr_b(adr_b), 
      .din(din[36]), .rwb(rwb), .word(word[63:0]), .dout(dout[36]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_35_(.adr(adr), .adr_b(adr_b), 
      .din(din[35]), .rwb(rwb), .word(word[63:0]), .dout(dout[35]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_34_(.adr(adr), .adr_b(adr_b), 
      .din(din[34]), .rwb(rwb), .word(word[63:0]), .dout(dout[34]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_33_(.adr(adr), .adr_b(adr_b), 
      .din(din[33]), .rwb(rwb), .word(word[63:0]), .dout(dout[33]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_32_(.adr(adr), .adr_b(adr_b), 
      .din(din[32]), .rwb(rwb), .word(word[63:0]), .dout(dout[32]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_31_(.adr(adr), .adr_b(adr_b), 
      .din(din[31]), .rwb(rwb), .word(word[63:0]), .dout(dout[31]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_30_(.adr(adr), .adr_b(adr_b), 
      .din(din[30]), .rwb(rwb), .word(word[63:0]), .dout(dout[30]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_29_(.adr(adr), .adr_b(adr_b), 
      .din(din[29]), .rwb(rwb), .word(word[63:0]), .dout(dout[29]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_28_(.adr(adr), .adr_b(adr_b), 
      .din(din[28]), .rwb(rwb), .word(word[63:0]), .dout(dout[28]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_27_(.adr(adr), .adr_b(adr_b), 
      .din(din[27]), .rwb(rwb), .word(word[63:0]), .dout(dout[27]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_26_(.adr(adr), .adr_b(adr_b), 
      .din(din[26]), .rwb(rwb), .word(word[63:0]), .dout(dout[26]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_25_(.adr(adr), .adr_b(adr_b), 
      .din(din[25]), .rwb(rwb), .word(word[63:0]), .dout(dout[25]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_24_(.adr(adr), .adr_b(adr_b), 
      .din(din[24]), .rwb(rwb), .word(word[63:0]), .dout(dout[24]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_23_(.adr(adr), .adr_b(adr_b), 
      .din(din[23]), .rwb(rwb), .word(word[63:0]), .dout(dout[23]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_22_(.adr(adr), .adr_b(adr_b), 
      .din(din[22]), .rwb(rwb), .word(word[63:0]), .dout(dout[22]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_21_(.adr(adr), .adr_b(adr_b), 
      .din(din[21]), .rwb(rwb), .word(word[63:0]), .dout(dout[21]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_20_(.adr(adr), .adr_b(adr_b), 
      .din(din[20]), .rwb(rwb), .word(word[63:0]), .dout(dout[20]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_19_(.adr(adr), .adr_b(adr_b), 
      .din(din[19]), .rwb(rwb), .word(word[63:0]), .dout(dout[19]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_18_(.adr(adr), .adr_b(adr_b), 
      .din(din[18]), .rwb(rwb), .word(word[63:0]), .dout(dout[18]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_17_(.adr(adr), .adr_b(adr_b), 
      .din(din[17]), .rwb(rwb), .word(word[63:0]), .dout(dout[17]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_16_(.adr(adr), .adr_b(adr_b), 
      .din(din[16]), .rwb(rwb), .word(word[63:0]), .dout(dout[16]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_15_(.adr(adr), .adr_b(adr_b), 
      .din(din[15]), .rwb(rwb), .word(word[63:0]), .dout(dout[15]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_14_(.adr(adr), .adr_b(adr_b), 
      .din(din[14]), .rwb(rwb), .word(word[63:0]), .dout(dout[14]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_13_(.adr(adr), .adr_b(adr_b), 
      .din(din[13]), .rwb(rwb), .word(word[63:0]), .dout(dout[13]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_12_(.adr(adr), .adr_b(adr_b), 
      .din(din[12]), .rwb(rwb), .word(word[63:0]), .dout(dout[12]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_11_(.adr(adr), .adr_b(adr_b), 
      .din(din[11]), .rwb(rwb), .word(word[63:0]), .dout(dout[11]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_10_(.adr(adr), .adr_b(adr_b), 
      .din(din[10]), .rwb(rwb), .word(word[63:0]), .dout(dout[10]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_9_(.adr(adr), .adr_b(adr_b), 
      .din(din[9]), .rwb(rwb), .word(word[63:0]), .dout(dout[9]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_8_(.adr(adr), .adr_b(adr_b), 
      .din(din[8]), .rwb(rwb), .word(word[63:0]), .dout(dout[8]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_7_(.adr(adr), .adr_b(adr_b), 
      .din(din[7]), .rwb(rwb), .word(word[63:0]), .dout(dout[7]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_6_(.adr(adr), .adr_b(adr_b), 
      .din(din[6]), .rwb(rwb), .word(word[63:0]), .dout(dout[6]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_5_(.adr(adr), .adr_b(adr_b), 
      .din(din[5]), .rwb(rwb), .word(word[63:0]), .dout(dout[5]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_4_(.adr(adr), .adr_b(adr_b), 
      .din(din[4]), .rwb(rwb), .word(word[63:0]), .dout(dout[4]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_3_(.adr(adr), .adr_b(adr_b), 
      .din(din[3]), .rwb(rwb), .word(word[63:0]), .dout(dout[3]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_2_(.adr(adr), .adr_b(adr_b), 
      .din(din[2]), .rwb(rwb), .word(word[63:0]), .dout(dout[2]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_1_(.adr(adr), .adr_b(adr_b), 
      .din(din[1]), .rwb(rwb), .word(word[63:0]), .dout(dout[1]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
  memsys_final__cacheramcolumn cacheramcolumn_0_(.adr(adr), .adr_b(adr_b), 
      .din(din[0]), .rwb(rwb), .word(word[63:0]), .dout(dout[0]), 
      .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), .ph2_b(ph2_b));
endmodule   /* memsys_final__cacheramarray */

module muddlib07__inv_2x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  tranif1 nmos_0(gnd, y, a);
  tranif0 pmos_0(y, vdd, a);
endmodule   /* muddlib07__inv_2x */

module memsys_final__nand2_4x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_42, net_5;

  tranif1 nmos_0(net_5, y, b);
  tranif1 nmos_1(gnd, net_5, a);
  tranif1 nmos_2(net_42, y, b);
  tranif1 nmos_3(gnd, net_42, a);
  tranif0 pmos_0(y, vdd, b);
  tranif0 pmos_1(y, vdd, a);
  tranif0 pmos_2(y, vdd, b);
  tranif0 pmos_3(y, vdd, a);
endmodule   /* memsys_final__nand2_4x */

module memsys_final__nand3_2x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_15, net_4;

  tranif1 nmos_0(net_15, net_4, b);
  tranif1 nmos_1(net_4, y, a);
  tranif1 nmos_2(gnd, net_15, c);
  tranif0 pmos_0(y, vdd, a);
  tranif0 pmos_1(y, vdd, b);
  tranif0 pmos_2(y, vdd, c);
endmodule   /* memsys_final__nand3_2x */

module muddlib07__nand2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_5;

  tranif1 nmos_0(net_5, y, b);
  tranif1 nmos_1(gnd, net_5, a);
  tranif0 pmos_0(y, vdd, b);
  tranif0 pmos_1(y, vdd, a);
endmodule   /* muddlib07__nand2_1x */

module memsys_final__decoder64b(a, ph2, y);
  input [5:0] a;
  input ph2;
  output [63:0] y;

  supply1 vdd;
  supply0 gnd;
  wire a0_b, a0buf, a1_b, a1buf, a2_b, a2buf, a3_b, a3buf, a4_b, a4buf, a5_b;
  wire a5buf, c0, c1, c2, c3, c4, c5, c6, c7, d0, d1, d2, d3, d4, d5, d6, d7;
  wire net_1085, net_1086, net_1087, net_1088, net_1089, net_1090, net_1091;
  wire net_1092, net_1093, net_1094, net_1095, net_1096, net_1314, net_1315;
  wire net_1316, net_1317, net_1318, net_1319, net_1320, net_1321, net_1322;
  wire net_1323, net_1324, net_1325, net_1326, net_1327, net_1328, net_1329;
  wire net_1330, net_1331, net_1332, net_1333, net_1334, net_1335, net_1336;
  wire net_1337, net_1338, net_1339, net_1340, net_1341, net_1342, net_1343;
  wire net_1344, net_1345, net_1346, net_1347, net_1348, net_1349, net_1350;
  wire net_1351, net_1352, net_1353, net_1354, net_1355, net_1356, net_1357;
  wire net_1358, net_1359, net_1360, net_1361, net_1362, net_1363, net_1364;
  wire net_1365, net_1366, net_1367, net_1368, net_1369, net_1370, net_1371;
  wire net_1372, net_1373, net_1374, net_1375, net_1376, net_1377, net_1378;
  wire net_1379, net_1380, net_1381, net_1382, net_1383, net_1384, net_1385;
  wire net_1386, net_1387, net_1388, net_1389, net_1390, net_1391, net_1392;
  wire net_1393, net_1394, net_1395, net_1396, net_1397, net_1398, net_1399;
  wire net_1400, net_1401, net_1402, net_1403, net_1404, net_1405, net_1406;
  wire net_1407, net_1408, net_1409, net_1410, net_1411, net_1412, net_1413;
  wire net_1414, net_1415, net_1416, net_1417, net_1418, net_1419, net_1420;
  wire net_1421, net_1422, net_1423, net_1424, net_1425, net_1426, net_1427;
  wire net_1428, net_1429, net_1430, net_1431, net_1432, net_1433, net_1434;
  wire net_1435, net_1436, net_1437, net_1438, net_1439, net_1440, net_1441;
  wire net_1442, net_1443, net_1444, net_1445, net_1446, net_1447, net_1448;
  wire net_1449, net_1450, net_1451, net_1452, net_1453, net_1454, net_1455;
  wire net_1456, net_1457, net_1458, net_1459, net_1460, net_1461, net_1462;
  wire net_1463, net_1464, net_1465, net_1466, net_1467, net_1468, net_1469;
  wire net_1470, net_1471, net_1472, net_1473, net_1474, net_1475, net_1476;
  wire net_1477, net_1478, net_1479, net_1480, net_1481, net_1482, net_1483;
  wire net_1484, net_1485, net_1486, net_1487, net_1488, net_1489, net_1490;
  wire net_1491, net_1492, net_1493, net_1494, net_1495, net_1496, net_1497;
  wire net_1498, net_1499, net_1500, net_1501, net_1502, net_1503, net_1504;
  wire net_1505, net_1570, net_1571, net_1572, net_1573, net_1574, net_1575;
  wire net_1576, net_1577, net_1578, net_1579, net_1580, net_1581, net_1582;
  wire net_1583, net_1584, net_1585, net_1586, net_1587, net_1588, net_1589;
  wire net_1590, net_1591, net_1592, net_1593, net_1594, net_1595, net_1596;
  wire net_1597, net_1598, net_1599, net_1600, net_1601, net_1602, net_1603;
  wire net_1604, net_1605, net_1606, net_1607, net_1608, net_1609, net_1610;
  wire net_1611, net_1612, net_1613, net_1614, net_1615, net_1616, net_1617;
  wire net_1618, net_1619, net_1620, net_1621, net_1622, net_1623, net_1624;
  wire net_1625, net_1626, net_1627, net_1628, net_1629, net_1630, net_1631;
  wire net_1632, net_1633, net_1634, net_1635, net_1636, net_758, net_759;
  wire net_761, ph1_sb_out;

  muddlib07__inv_1x inv_1x_0(.a(net_1636), .y(net_1442));
  muddlib07__inv_1x inv_1x_1(.a(net_1636), .y(net_1443));
  muddlib07__inv_1x inv_1x_2(.a(net_1636), .y(net_1444));
  muddlib07__inv_1x inv_1x_3(.a(net_1636), .y(net_1445));
  muddlib07__inv_1x inv_1x_4(.a(net_1636), .y(net_1446));
  muddlib07__inv_1x inv_1x_5(.a(net_1636), .y(net_1447));
  muddlib07__inv_1x inv_1x_6(.a(net_1636), .y(net_1448));
  muddlib07__inv_1x inv_1x_7(.a(net_1636), .y(net_1449));
  muddlib07__inv_1x inv_1x_8(.a(net_1636), .y(net_1450));
  muddlib07__inv_1x inv_1x_9(.a(net_1636), .y(net_1451));
  muddlib07__inv_1x inv_1x_10(.a(net_1636), .y(net_1452));
  muddlib07__inv_1x inv_1x_11(.a(net_1636), .y(net_1453));
  muddlib07__inv_1x inv_1x_12(.a(net_1636), .y(net_1454));
  muddlib07__inv_1x inv_1x_13(.a(net_1636), .y(net_1455));
  muddlib07__inv_1x inv_1x_14(.a(net_1636), .y(net_1456));
  muddlib07__inv_1x inv_1x_15(.a(net_1636), .y(net_1457));
  muddlib07__inv_1x inv_1x_16(.a(net_1636), .y(net_1458));
  muddlib07__inv_1x inv_1x_17(.a(net_1636), .y(net_1459));
  muddlib07__inv_1x inv_1x_18(.a(net_1636), .y(net_1460));
  muddlib07__inv_1x inv_1x_19(.a(net_1636), .y(net_1461));
  muddlib07__inv_1x inv_1x_20(.a(net_1636), .y(net_1462));
  muddlib07__inv_1x inv_1x_21(.a(net_1636), .y(net_1463));
  muddlib07__inv_1x inv_1x_22(.a(net_1636), .y(net_1464));
  muddlib07__inv_1x inv_1x_23(.a(net_1636), .y(net_1465));
  muddlib07__inv_1x inv_1x_24(.a(net_1636), .y(net_1466));
  muddlib07__inv_1x inv_1x_25(.a(net_1636), .y(net_1467));
  muddlib07__inv_1x inv_1x_26(.a(net_1636), .y(net_1468));
  muddlib07__inv_1x inv_1x_27(.a(net_1636), .y(net_1469));
  muddlib07__inv_1x inv_1x_28(.a(net_1636), .y(net_1470));
  muddlib07__inv_1x inv_1x_29(.a(net_1636), .y(net_1471));
  muddlib07__inv_1x inv_1x_30(.a(net_1636), .y(net_1472));
  muddlib07__inv_1x inv_1x_31(.a(net_1636), .y(net_1473));
  muddlib07__inv_1x inv_1x_32(.a(net_1636), .y(net_1474));
  muddlib07__inv_1x inv_1x_33(.a(net_1636), .y(net_1475));
  muddlib07__inv_1x inv_1x_34(.a(net_1636), .y(net_1476));
  muddlib07__inv_1x inv_1x_35(.a(net_1636), .y(net_1477));
  muddlib07__inv_1x inv_1x_36(.a(net_1636), .y(net_1478));
  muddlib07__inv_1x inv_1x_37(.a(net_1636), .y(net_1479));
  muddlib07__inv_1x inv_1x_38(.a(net_1636), .y(net_1480));
  muddlib07__inv_1x inv_1x_39(.a(net_1636), .y(net_1481));
  muddlib07__inv_1x inv_1x_40(.a(net_1636), .y(net_1482));
  muddlib07__inv_1x inv_1x_41(.a(net_1636), .y(net_1483));
  muddlib07__inv_1x inv_1x_42(.a(net_1636), .y(net_1484));
  muddlib07__inv_1x inv_1x_43(.a(net_1636), .y(net_1485));
  muddlib07__inv_1x inv_1x_44(.a(net_1636), .y(net_1486));
  muddlib07__inv_1x inv_1x_45(.a(net_1636), .y(net_1487));
  muddlib07__inv_1x inv_1x_46(.a(net_1636), .y(net_1488));
  muddlib07__inv_1x inv_1x_47(.a(net_1636), .y(net_1489));
  muddlib07__inv_1x inv_1x_48(.a(net_1636), .y(net_1490));
  muddlib07__inv_1x inv_1x_49(.a(net_1636), .y(net_1491));
  muddlib07__inv_1x inv_1x_50(.a(net_1636), .y(net_1492));
  muddlib07__inv_1x inv_1x_51(.a(net_1636), .y(net_1493));
  muddlib07__inv_1x inv_1x_52(.a(net_1636), .y(net_1494));
  muddlib07__inv_1x inv_1x_53(.a(net_1636), .y(net_1495));
  muddlib07__inv_1x inv_1x_54(.a(net_1636), .y(net_1496));
  muddlib07__inv_1x inv_1x_55(.a(net_1636), .y(net_1497));
  muddlib07__inv_1x inv_1x_56(.a(net_1636), .y(net_1498));
  muddlib07__inv_1x inv_1x_57(.a(net_1636), .y(net_1499));
  muddlib07__inv_1x inv_1x_58(.a(net_1636), .y(net_1500));
  muddlib07__inv_1x inv_1x_59(.a(net_1636), .y(net_1501));
  muddlib07__inv_1x inv_1x_60(.a(net_1636), .y(net_1502));
  muddlib07__inv_1x inv_1x_61(.a(net_1636), .y(net_1503));
  muddlib07__inv_1x inv_1x_62(.a(net_1636), .y(net_1504));
  muddlib07__inv_1x inv_1x_63(.a(net_1636), .y(net_1505));
  memsys_final__inv_16x inv_2x_0(.a(net_1095), .y(c4));
  memsys_final__inv_16x inv_2x_1(.a(net_1093), .y(c6));
  memsys_final__inv_16x inv_2x_2(.a(net_1091), .y(c5));
  memsys_final__inv_16x inv_2x_3(.a(net_1089), .y(c7));
  memsys_final__inv_16x inv_2x_4(.a(net_1087), .y(d4));
  memsys_final__inv_16x inv_2x_5(.a(net_1085), .y(d6));
  memsys_final__inv_16x inv_2x_6(.a(net_1634), .y(d3));
  memsys_final__inv_16x inv_2x_7(.a(net_761), .y(d7));
  memsys_final__inv_16x inv_2x_8(.a(net_759), .y(d5));
  memsys_final__inv_16x inv_2x_9(.a(net_758), .y(d1));
  muddlib07__inv_2x inv_2x_11(.a(net_1314), .y(net_1378));
  muddlib07__inv_2x inv_2x_12(.a(net_1315), .y(net_1379));
  muddlib07__inv_2x inv_2x_13(.a(net_1316), .y(net_1380));
  muddlib07__inv_2x inv_2x_14(.a(net_1317), .y(net_1381));
  muddlib07__inv_2x inv_2x_15(.a(net_1318), .y(net_1382));
  muddlib07__inv_2x inv_2x_16(.a(net_1319), .y(net_1383));
  muddlib07__inv_2x inv_2x_17(.a(net_1320), .y(net_1384));
  muddlib07__inv_2x inv_2x_18(.a(net_1321), .y(net_1385));
  muddlib07__inv_2x inv_2x_19(.a(net_1322), .y(net_1386));
  muddlib07__inv_2x inv_2x_20(.a(net_1323), .y(net_1387));
  muddlib07__inv_2x inv_2x_21(.a(net_1324), .y(net_1388));
  muddlib07__inv_2x inv_2x_22(.a(net_1325), .y(net_1389));
  muddlib07__inv_2x inv_2x_23(.a(net_1326), .y(net_1390));
  muddlib07__inv_2x inv_2x_24(.a(net_1327), .y(net_1391));
  muddlib07__inv_2x inv_2x_25(.a(net_1328), .y(net_1392));
  muddlib07__inv_2x inv_2x_26(.a(net_1329), .y(net_1393));
  muddlib07__inv_2x inv_2x_27(.a(net_1330), .y(net_1394));
  muddlib07__inv_2x inv_2x_28(.a(net_1331), .y(net_1395));
  muddlib07__inv_2x inv_2x_29(.a(net_1332), .y(net_1396));
  muddlib07__inv_2x inv_2x_30(.a(net_1333), .y(net_1397));
  muddlib07__inv_2x inv_2x_31(.a(net_1334), .y(net_1398));
  muddlib07__inv_2x inv_2x_32(.a(net_1335), .y(net_1399));
  muddlib07__inv_2x inv_2x_33(.a(net_1336), .y(net_1400));
  muddlib07__inv_2x inv_2x_34(.a(net_1337), .y(net_1401));
  muddlib07__inv_2x inv_2x_35(.a(net_1338), .y(net_1402));
  muddlib07__inv_2x inv_2x_36(.a(net_1339), .y(net_1403));
  muddlib07__inv_2x inv_2x_37(.a(net_1340), .y(net_1404));
  muddlib07__inv_2x inv_2x_38(.a(net_1341), .y(net_1405));
  muddlib07__inv_2x inv_2x_39(.a(net_1342), .y(net_1406));
  muddlib07__inv_2x inv_2x_40(.a(net_1343), .y(net_1407));
  muddlib07__inv_2x inv_2x_41(.a(net_1344), .y(net_1408));
  muddlib07__inv_2x inv_2x_42(.a(net_1345), .y(net_1409));
  muddlib07__inv_2x inv_2x_43(.a(net_1346), .y(net_1410));
  muddlib07__inv_2x inv_2x_44(.a(net_1347), .y(net_1411));
  muddlib07__inv_2x inv_2x_45(.a(net_1348), .y(net_1412));
  muddlib07__inv_2x inv_2x_46(.a(net_1349), .y(net_1413));
  muddlib07__inv_2x inv_2x_47(.a(net_1350), .y(net_1414));
  muddlib07__inv_2x inv_2x_48(.a(net_1351), .y(net_1415));
  muddlib07__inv_2x inv_2x_49(.a(net_1352), .y(net_1416));
  muddlib07__inv_2x inv_2x_50(.a(net_1353), .y(net_1417));
  muddlib07__inv_2x inv_2x_51(.a(net_1354), .y(net_1418));
  muddlib07__inv_2x inv_2x_52(.a(net_1355), .y(net_1419));
  muddlib07__inv_2x inv_2x_53(.a(net_1356), .y(net_1420));
  muddlib07__inv_2x inv_2x_54(.a(net_1357), .y(net_1421));
  muddlib07__inv_2x inv_2x_55(.a(net_1358), .y(net_1422));
  muddlib07__inv_2x inv_2x_56(.a(net_1359), .y(net_1423));
  muddlib07__inv_2x inv_2x_57(.a(net_1360), .y(net_1424));
  muddlib07__inv_2x inv_2x_58(.a(net_1361), .y(net_1425));
  muddlib07__inv_2x inv_2x_59(.a(net_1362), .y(net_1426));
  muddlib07__inv_2x inv_2x_60(.a(net_1363), .y(net_1427));
  muddlib07__inv_2x inv_2x_61(.a(net_1364), .y(net_1428));
  muddlib07__inv_2x inv_2x_62(.a(net_1365), .y(net_1429));
  muddlib07__inv_2x inv_2x_63(.a(net_1366), .y(net_1430));
  muddlib07__inv_2x inv_2x_64(.a(net_1367), .y(net_1431));
  muddlib07__inv_2x inv_2x_65(.a(net_1368), .y(net_1432));
  muddlib07__inv_2x inv_2x_66(.a(net_1369), .y(net_1433));
  muddlib07__inv_2x inv_2x_67(.a(net_1370), .y(net_1434));
  muddlib07__inv_2x inv_2x_68(.a(net_1371), .y(net_1435));
  muddlib07__inv_2x inv_2x_69(.a(net_1372), .y(net_1436));
  muddlib07__inv_2x inv_2x_70(.a(net_1373), .y(net_1437));
  muddlib07__inv_2x inv_2x_71(.a(net_1374), .y(net_1438));
  muddlib07__inv_2x inv_2x_72(.a(net_1375), .y(net_1439));
  muddlib07__inv_2x inv_2x_73(.a(net_1376), .y(net_1440));
  muddlib07__inv_2x inv_2x_74(.a(net_1377), .y(net_1441));
  memsys_final__inv_16x inv_3x_0(.a(net_1096), .y(c0));
  memsys_final__inv_16x inv_3x_1(.a(net_1094), .y(c2));
  memsys_final__inv_16x inv_3x_2(.a(net_1092), .y(c1));
  memsys_final__inv_16x inv_3x_3(.a(net_1090), .y(c3));
  memsys_final__inv_16x inv_3x_4(.a(net_1088), .y(d0));
  memsys_final__inv_16x inv_3x_5(.a(net_1086), .y(d2));
  memsys_final__inv_16x inv_16x_0(.a(net_1635), .y(net_1636));
  memsys_final__inv_16x inv_16x_1(.a(net_1570), .y(y[0]));
  memsys_final__inv_16x inv_16x_2(.a(net_1571), .y(y[1]));
  memsys_final__inv_16x inv_16x_3(.a(net_1572), .y(y[2]));
  memsys_final__inv_16x inv_16x_4(.a(net_1573), .y(y[3]));
  memsys_final__inv_16x inv_16x_5(.a(net_1574), .y(y[4]));
  memsys_final__inv_16x inv_16x_6(.a(net_1575), .y(y[5]));
  memsys_final__inv_16x inv_16x_7(.a(net_1576), .y(y[6]));
  memsys_final__inv_16x inv_16x_8(.a(net_1577), .y(y[7]));
  memsys_final__inv_16x inv_16x_9(.a(net_1578), .y(y[8]));
  memsys_final__inv_16x inv_16x_10(.a(net_1579), .y(y[9]));
  memsys_final__inv_16x inv_16x_11(.a(net_1580), .y(y[10]));
  memsys_final__inv_16x inv_16x_12(.a(net_1581), .y(y[11]));
  memsys_final__inv_16x inv_16x_13(.a(net_1582), .y(y[12]));
  memsys_final__inv_16x inv_16x_14(.a(net_1583), .y(y[13]));
  memsys_final__inv_16x inv_16x_15(.a(net_1584), .y(y[14]));
  memsys_final__inv_16x inv_16x_16(.a(net_1585), .y(y[15]));
  memsys_final__inv_16x inv_16x_17(.a(net_1586), .y(y[16]));
  memsys_final__inv_16x inv_16x_18(.a(net_1587), .y(y[17]));
  memsys_final__inv_16x inv_16x_19(.a(net_1588), .y(y[18]));
  memsys_final__inv_16x inv_16x_20(.a(net_1589), .y(y[19]));
  memsys_final__inv_16x inv_16x_21(.a(net_1590), .y(y[20]));
  memsys_final__inv_16x inv_16x_22(.a(net_1591), .y(y[21]));
  memsys_final__inv_16x inv_16x_23(.a(net_1592), .y(y[22]));
  memsys_final__inv_16x inv_16x_24(.a(net_1593), .y(y[23]));
  memsys_final__inv_16x inv_16x_25(.a(net_1594), .y(y[24]));
  memsys_final__inv_16x inv_16x_26(.a(net_1595), .y(y[25]));
  memsys_final__inv_16x inv_16x_27(.a(net_1596), .y(y[26]));
  memsys_final__inv_16x inv_16x_28(.a(net_1597), .y(y[27]));
  memsys_final__inv_16x inv_16x_29(.a(net_1598), .y(y[28]));
  memsys_final__inv_16x inv_16x_30(.a(net_1599), .y(y[29]));
  memsys_final__inv_16x inv_16x_31(.a(net_1600), .y(y[30]));
  memsys_final__inv_16x inv_16x_32(.a(net_1601), .y(y[31]));
  memsys_final__inv_16x inv_16x_33(.a(net_1602), .y(y[32]));
  memsys_final__inv_16x inv_16x_34(.a(net_1603), .y(y[33]));
  memsys_final__inv_16x inv_16x_35(.a(net_1604), .y(y[34]));
  memsys_final__inv_16x inv_16x_36(.a(net_1605), .y(y[35]));
  memsys_final__inv_16x inv_16x_37(.a(net_1606), .y(y[36]));
  memsys_final__inv_16x inv_16x_38(.a(net_1607), .y(y[37]));
  memsys_final__inv_16x inv_16x_39(.a(net_1608), .y(y[38]));
  memsys_final__inv_16x inv_16x_40(.a(net_1609), .y(y[39]));
  memsys_final__inv_16x inv_16x_41(.a(net_1610), .y(y[40]));
  memsys_final__inv_16x inv_16x_42(.a(net_1611), .y(y[41]));
  memsys_final__inv_16x inv_16x_43(.a(net_1612), .y(y[42]));
  memsys_final__inv_16x inv_16x_44(.a(net_1613), .y(y[43]));
  memsys_final__inv_16x inv_16x_45(.a(net_1614), .y(y[44]));
  memsys_final__inv_16x inv_16x_46(.a(net_1615), .y(y[45]));
  memsys_final__inv_16x inv_16x_47(.a(net_1616), .y(y[46]));
  memsys_final__inv_16x inv_16x_48(.a(net_1617), .y(y[47]));
  memsys_final__inv_16x inv_16x_49(.a(net_1618), .y(y[48]));
  memsys_final__inv_16x inv_16x_50(.a(net_1619), .y(y[49]));
  memsys_final__inv_16x inv_16x_51(.a(net_1620), .y(y[50]));
  memsys_final__inv_16x inv_16x_52(.a(net_1621), .y(y[51]));
  memsys_final__inv_16x inv_16x_53(.a(net_1622), .y(y[52]));
  memsys_final__inv_16x inv_16x_54(.a(net_1623), .y(y[53]));
  memsys_final__inv_16x inv_16x_55(.a(net_1624), .y(y[54]));
  memsys_final__inv_16x inv_16x_56(.a(net_1625), .y(y[55]));
  memsys_final__inv_16x inv_16x_57(.a(net_1626), .y(y[56]));
  memsys_final__inv_16x inv_16x_58(.a(net_1627), .y(y[57]));
  memsys_final__inv_16x inv_16x_59(.a(net_1628), .y(y[58]));
  memsys_final__inv_16x inv_16x_60(.a(net_1629), .y(y[59]));
  memsys_final__inv_16x inv_16x_61(.a(net_1630), .y(y[60]));
  memsys_final__inv_16x inv_16x_62(.a(net_1631), .y(y[61]));
  memsys_final__inv_16x inv_16x_63(.a(net_1632), .y(y[62]));
  memsys_final__inv_16x inv_16x_64(.a(net_1633), .y(y[63]));
  muddlib07__invbuf_4x invbuf_4_0(.s(a[0]), .s_out(a0buf), .sb_out(a0_b));
  muddlib07__invbuf_4x invbuf_4_1(.s(a[1]), .s_out(a1buf), .sb_out(a1_b));
  muddlib07__invbuf_4x invbuf_4_2(.s(a[3]), .s_out(a3buf), .sb_out(a3_b));
  muddlib07__invbuf_4x invbuf_4_3(.s(a[2]), .s_out(a2buf), .sb_out(a2_b));
  muddlib07__invbuf_4x invbuf_4_4(.s(a[5]), .s_out(a5buf), .sb_out(a5_b));
  muddlib07__invbuf_4x invbuf_4_5(.s(a[4]), .s_out(a4buf), .sb_out(a4_b));
  memsys_final__nand2_4x nand2_4x_0(.a(net_1378), .b(net_1442), .y(net_1633));
  memsys_final__nand2_4x nand2_4x_1(.a(net_1379), .b(net_1443), .y(net_1632));
  memsys_final__nand2_4x nand2_4x_2(.a(net_1380), .b(net_1444), .y(net_1631));
  memsys_final__nand2_4x nand2_4x_3(.a(net_1381), .b(net_1445), .y(net_1630));
  memsys_final__nand2_4x nand2_4x_4(.a(net_1382), .b(net_1446), .y(net_1629));
  memsys_final__nand2_4x nand2_4x_5(.a(net_1383), .b(net_1447), .y(net_1628));
  memsys_final__nand2_4x nand2_4x_6(.a(net_1384), .b(net_1448), .y(net_1627));
  memsys_final__nand2_4x nand2_4x_7(.a(net_1385), .b(net_1449), .y(net_1626));
  memsys_final__nand2_4x nand2_4x_8(.a(net_1386), .b(net_1450), .y(net_1625));
  memsys_final__nand2_4x nand2_4x_9(.a(net_1387), .b(net_1451), .y(net_1624));
  memsys_final__nand2_4x nand2_4x_10(.a(net_1388), .b(net_1452), 
      .y(net_1623));
  memsys_final__nand2_4x nand2_4x_11(.a(net_1389), .b(net_1453), 
      .y(net_1622));
  memsys_final__nand2_4x nand2_4x_12(.a(net_1390), .b(net_1454), 
      .y(net_1621));
  memsys_final__nand2_4x nand2_4x_13(.a(net_1391), .b(net_1455), 
      .y(net_1620));
  memsys_final__nand2_4x nand2_4x_14(.a(net_1392), .b(net_1456), 
      .y(net_1619));
  memsys_final__nand2_4x nand2_4x_15(.a(net_1393), .b(net_1457), 
      .y(net_1618));
  memsys_final__nand2_4x nand2_4x_16(.a(net_1394), .b(net_1458), 
      .y(net_1617));
  memsys_final__nand2_4x nand2_4x_17(.a(net_1395), .b(net_1459), 
      .y(net_1616));
  memsys_final__nand2_4x nand2_4x_18(.a(net_1396), .b(net_1460), 
      .y(net_1615));
  memsys_final__nand2_4x nand2_4x_19(.a(net_1397), .b(net_1461), 
      .y(net_1614));
  memsys_final__nand2_4x nand2_4x_20(.a(net_1398), .b(net_1462), 
      .y(net_1613));
  memsys_final__nand2_4x nand2_4x_21(.a(net_1399), .b(net_1463), 
      .y(net_1612));
  memsys_final__nand2_4x nand2_4x_22(.a(net_1400), .b(net_1464), 
      .y(net_1611));
  memsys_final__nand2_4x nand2_4x_23(.a(net_1401), .b(net_1465), 
      .y(net_1610));
  memsys_final__nand2_4x nand2_4x_24(.a(net_1402), .b(net_1466), 
      .y(net_1609));
  memsys_final__nand2_4x nand2_4x_25(.a(net_1403), .b(net_1467), 
      .y(net_1608));
  memsys_final__nand2_4x nand2_4x_26(.a(net_1404), .b(net_1468), 
      .y(net_1607));
  memsys_final__nand2_4x nand2_4x_27(.a(net_1405), .b(net_1469), 
      .y(net_1606));
  memsys_final__nand2_4x nand2_4x_28(.a(net_1406), .b(net_1470), 
      .y(net_1605));
  memsys_final__nand2_4x nand2_4x_29(.a(net_1407), .b(net_1471), 
      .y(net_1604));
  memsys_final__nand2_4x nand2_4x_30(.a(net_1408), .b(net_1472), 
      .y(net_1603));
  memsys_final__nand2_4x nand2_4x_31(.a(net_1409), .b(net_1473), 
      .y(net_1602));
  memsys_final__nand2_4x nand2_4x_32(.a(net_1410), .b(net_1474), 
      .y(net_1601));
  memsys_final__nand2_4x nand2_4x_33(.a(net_1411), .b(net_1475), 
      .y(net_1600));
  memsys_final__nand2_4x nand2_4x_34(.a(net_1412), .b(net_1476), 
      .y(net_1599));
  memsys_final__nand2_4x nand2_4x_35(.a(net_1413), .b(net_1477), 
      .y(net_1598));
  memsys_final__nand2_4x nand2_4x_36(.a(net_1414), .b(net_1478), 
      .y(net_1597));
  memsys_final__nand2_4x nand2_4x_37(.a(net_1415), .b(net_1479), 
      .y(net_1596));
  memsys_final__nand2_4x nand2_4x_38(.a(net_1416), .b(net_1480), 
      .y(net_1595));
  memsys_final__nand2_4x nand2_4x_39(.a(net_1417), .b(net_1481), 
      .y(net_1594));
  memsys_final__nand2_4x nand2_4x_40(.a(net_1418), .b(net_1482), 
      .y(net_1593));
  memsys_final__nand2_4x nand2_4x_41(.a(net_1419), .b(net_1483), 
      .y(net_1592));
  memsys_final__nand2_4x nand2_4x_42(.a(net_1420), .b(net_1484), 
      .y(net_1591));
  memsys_final__nand2_4x nand2_4x_43(.a(net_1421), .b(net_1485), 
      .y(net_1590));
  memsys_final__nand2_4x nand2_4x_44(.a(net_1422), .b(net_1486), 
      .y(net_1589));
  memsys_final__nand2_4x nand2_4x_45(.a(net_1423), .b(net_1487), 
      .y(net_1588));
  memsys_final__nand2_4x nand2_4x_46(.a(net_1424), .b(net_1488), 
      .y(net_1587));
  memsys_final__nand2_4x nand2_4x_47(.a(net_1425), .b(net_1489), 
      .y(net_1586));
  memsys_final__nand2_4x nand2_4x_48(.a(net_1426), .b(net_1490), 
      .y(net_1585));
  memsys_final__nand2_4x nand2_4x_49(.a(net_1427), .b(net_1491), 
      .y(net_1584));
  memsys_final__nand2_4x nand2_4x_50(.a(net_1428), .b(net_1492), 
      .y(net_1583));
  memsys_final__nand2_4x nand2_4x_51(.a(net_1429), .b(net_1493), 
      .y(net_1582));
  memsys_final__nand2_4x nand2_4x_52(.a(net_1430), .b(net_1494), 
      .y(net_1581));
  memsys_final__nand2_4x nand2_4x_53(.a(net_1431), .b(net_1495), 
      .y(net_1580));
  memsys_final__nand2_4x nand2_4x_54(.a(net_1432), .b(net_1496), 
      .y(net_1579));
  memsys_final__nand2_4x nand2_4x_55(.a(net_1433), .b(net_1497), 
      .y(net_1578));
  memsys_final__nand2_4x nand2_4x_56(.a(net_1434), .b(net_1498), 
      .y(net_1577));
  memsys_final__nand2_4x nand2_4x_57(.a(net_1435), .b(net_1499), 
      .y(net_1576));
  memsys_final__nand2_4x nand2_4x_58(.a(net_1436), .b(net_1500), 
      .y(net_1575));
  memsys_final__nand2_4x nand2_4x_59(.a(net_1437), .b(net_1501), 
      .y(net_1574));
  memsys_final__nand2_4x nand2_4x_60(.a(net_1438), .b(net_1502), 
      .y(net_1573));
  memsys_final__nand2_4x nand2_4x_61(.a(net_1439), .b(net_1503), 
      .y(net_1572));
  memsys_final__nand2_4x nand2_4x_62(.a(net_1440), .b(net_1504), 
      .y(net_1571));
  memsys_final__nand2_4x nand2_4x_63(.a(net_1441), .b(net_1505), 
      .y(net_1570));
  memsys_final__nand3_2x nand2_xx_0(.a(a0buf), .b(a1_b), .c(a2buf), 
      .y(net_1091));
  memsys_final__nand3_2x nand2_xx_1(.a(a3_b), .b(a4buf), .c(a5buf), 
      .y(net_1085));
  memsys_final__nand3_2x nand2_xx_2(.a(a0buf), .b(a1_b), .c(a2_b), 
      .y(net_1092));
  memsys_final__nand3_2x nand2_xx_3(.a(a3_b), .b(a4buf), .c(a5_b), 
      .y(net_1086));
  memsys_final__nand3_2x nand2_xx_4(.a(a0_b), .b(a1buf), .c(a2buf), 
      .y(net_1093));
  memsys_final__nand3_2x nand2_xx_5(.a(a3_b), .b(a4_b), .c(a5buf), 
      .y(net_1087));
  memsys_final__nand3_2x nand2_xx_6(.a(a0_b), .b(a1buf), .c(a2_b), 
      .y(net_1094));
  memsys_final__nand3_2x nand2_xx_7(.a(a3_b), .b(a4_b), .c(a5_b), 
      .y(net_1088));
  memsys_final__nand3_2x nand2_xx_8(.a(a0_b), .b(a1_b), .c(a2buf), 
      .y(net_1095));
  memsys_final__nand3_2x nand2_xx_9(.a(a0buf), .b(a1buf), .c(a2buf), 
      .y(net_1089));
  memsys_final__nand3_2x nand2_xx_10(.a(a0_b), .b(a1_b), .c(a2_b), 
      .y(net_1096));
  memsys_final__nand3_2x nand2_xx_11(.a(a0buf), .b(a1buf), .c(a2_b), 
      .y(net_1090));
  muddlib07__nand2_1x nand2_xx_12(.a(d7), .b(c7), .y(net_1314));
  memsys_final__nand3_2x nand3_2x_12(.a(a3buf), .b(a4_b), .c(a5_b), 
      .y(net_758));
  memsys_final__nand3_2x nand3_2x_13(.a(a3buf), .b(a4_b), .c(a5buf), 
      .y(net_759));
  memsys_final__nand3_2x nand3_2x_14(.a(a3buf), .b(a4buf), .c(a5_b), 
      .y(net_1634));
  memsys_final__nand3_2x nand3_2x_15(.a(a3buf), .b(a4buf), .c(a5buf), 
      .y(net_761));
  muddlib07__nand2_1x nand3_45_63(.a(d0), .b(c0), .y(net_1377));
  muddlib07__nand2_1x nand3_45_64(.a(d0), .b(c1), .y(net_1376));
  muddlib07__nand2_1x nand3_45_65(.a(d0), .b(c2), .y(net_1375));
  muddlib07__nand2_1x nand3_45_66(.a(d0), .b(c3), .y(net_1374));
  muddlib07__nand2_1x nand3_45_67(.a(d0), .b(c4), .y(net_1373));
  muddlib07__nand2_1x nand3_45_68(.a(d0), .b(c5), .y(net_1372));
  muddlib07__nand2_1x nand3_45_69(.a(d0), .b(c6), .y(net_1371));
  muddlib07__nand2_1x nand3_45_70(.a(d0), .b(c7), .y(net_1370));
  muddlib07__nand2_1x nand3_45_71(.a(d1), .b(c0), .y(net_1369));
  muddlib07__nand2_1x nand3_45_72(.a(d1), .b(c1), .y(net_1368));
  muddlib07__nand2_1x nand3_45_73(.a(d1), .b(c2), .y(net_1367));
  muddlib07__nand2_1x nand3_45_74(.a(d1), .b(c3), .y(net_1366));
  muddlib07__nand2_1x nand3_45_75(.a(d1), .b(c4), .y(net_1365));
  muddlib07__nand2_1x nand3_45_76(.a(d1), .b(c5), .y(net_1364));
  muddlib07__nand2_1x nand3_45_77(.a(d1), .b(c6), .y(net_1363));
  muddlib07__nand2_1x nand3_45_78(.a(d1), .b(c7), .y(net_1362));
  muddlib07__nand2_1x nand3_45_79(.a(d2), .b(c0), .y(net_1361));
  muddlib07__nand2_1x nand3_45_80(.a(d2), .b(c1), .y(net_1360));
  muddlib07__nand2_1x nand3_45_81(.a(d2), .b(c2), .y(net_1359));
  muddlib07__nand2_1x nand3_45_82(.a(d2), .b(c3), .y(net_1358));
  muddlib07__nand2_1x nand3_45_83(.a(d2), .b(c4), .y(net_1357));
  muddlib07__nand2_1x nand3_45_84(.a(d2), .b(c5), .y(net_1356));
  muddlib07__nand2_1x nand3_45_85(.a(d2), .b(c6), .y(net_1355));
  muddlib07__nand2_1x nand3_45_86(.a(d2), .b(c7), .y(net_1354));
  muddlib07__nand2_1x nand3_45_87(.a(d3), .b(c0), .y(net_1353));
  muddlib07__nand2_1x nand3_45_88(.a(d3), .b(c1), .y(net_1352));
  muddlib07__nand2_1x nand3_45_89(.a(d3), .b(c2), .y(net_1351));
  muddlib07__nand2_1x nand3_45_90(.a(d3), .b(c3), .y(net_1350));
  muddlib07__nand2_1x nand3_45_91(.a(d3), .b(c4), .y(net_1349));
  muddlib07__nand2_1x nand3_45_92(.a(d3), .b(c5), .y(net_1348));
  muddlib07__nand2_1x nand3_45_93(.a(d3), .b(c6), .y(net_1347));
  muddlib07__nand2_1x nand3_45_94(.a(d3), .b(c7), .y(net_1346));
  muddlib07__nand2_1x nand3_45_95(.a(d4), .b(c0), .y(net_1345));
  muddlib07__nand2_1x nand3_45_96(.a(d4), .b(c1), .y(net_1344));
  muddlib07__nand2_1x nand3_45_97(.a(d4), .b(c2), .y(net_1343));
  muddlib07__nand2_1x nand3_45_98(.a(d4), .b(c3), .y(net_1342));
  muddlib07__nand2_1x nand3_45_99(.a(d4), .b(c4), .y(net_1341));
  muddlib07__nand2_1x nand3_45_100(.a(d4), .b(c5), .y(net_1340));
  muddlib07__nand2_1x nand3_45_101(.a(d4), .b(c6), .y(net_1339));
  muddlib07__nand2_1x nand3_45_102(.a(d4), .b(c7), .y(net_1338));
  muddlib07__nand2_1x nand3_45_103(.a(d5), .b(c0), .y(net_1337));
  muddlib07__nand2_1x nand3_45_104(.a(d5), .b(c1), .y(net_1336));
  muddlib07__nand2_1x nand3_45_105(.a(d5), .b(c2), .y(net_1335));
  muddlib07__nand2_1x nand3_45_106(.a(d5), .b(c3), .y(net_1334));
  muddlib07__nand2_1x nand3_45_107(.a(d5), .b(c4), .y(net_1333));
  muddlib07__nand2_1x nand3_45_108(.a(d5), .b(c5), .y(net_1332));
  muddlib07__nand2_1x nand3_45_109(.a(d5), .b(c6), .y(net_1331));
  muddlib07__nand2_1x nand3_45_110(.a(d5), .b(c7), .y(net_1330));
  muddlib07__nand2_1x nand3_45_111(.a(d6), .b(c0), .y(net_1329));
  muddlib07__nand2_1x nand3_45_112(.a(d6), .b(c1), .y(net_1328));
  muddlib07__nand2_1x nand3_45_113(.a(d6), .b(c2), .y(net_1327));
  muddlib07__nand2_1x nand3_45_114(.a(d6), .b(c3), .y(net_1326));
  muddlib07__nand2_1x nand3_45_115(.a(d6), .b(c4), .y(net_1325));
  muddlib07__nand2_1x nand3_45_116(.a(d6), .b(c5), .y(net_1324));
  muddlib07__nand2_1x nand3_45_117(.a(d6), .b(c6), .y(net_1323));
  muddlib07__nand2_1x nand3_45_118(.a(d6), .b(c7), .y(net_1322));
  muddlib07__nand2_1x nand3_45_119(.a(d7), .b(c0), .y(net_1321));
  muddlib07__nand2_1x nand3_45_120(.a(d7), .b(c1), .y(net_1320));
  muddlib07__nand2_1x nand3_45_121(.a(d7), .b(c2), .y(net_1319));
  muddlib07__nand2_1x nand3_45_122(.a(d7), .b(c3), .y(net_1318));
  muddlib07__nand2_1x nand3_45_123(.a(d7), .b(c4), .y(net_1317));
  muddlib07__nand2_1x nand3_45_124(.a(d7), .b(c5), .y(net_1316));
  muddlib07__nand2_1x nand3_45_125(.a(d7), .b(c6), .y(net_1315));
  muddlib07__invbuf_4x ph1(.s(ph2), .s_out(net_1635), .sb_out(ph1_sb_out));
endmodule   /* memsys_final__decoder64b */

module memsys_final__cacheram(adr, din, ph1, ph2, rwb, dout);
  input [6:0] adr;
  input [52:0] din;
  input ph1;
  input ph2;
  input rwb;
  output [52:0] dout;

  supply1 vdd;
  supply0 gnd;
  wire adr6_b_buff, adr6_buff, ph1_b, ph1_b_buff, ph2_b_buff, rwb_buff;
  wire [63:0] word_buff;

  memsys_final__cache_buffers cache_bu_2(.adr(adr[6]), .ph1(ph1), .ph2(ph2), 
      .rwb(rwb), .word(word_buff[63:0]), .adr_b(adr6_b_buff), 
      .adr_buff(adr6_buff), .ph1_b(ph1_b), .ph1_bc_b(ph1_b_buff), 
      .ph2_b(ph2_b_buff), .rwb_buff(rwb_buff));
  memsys_final__cacheramarray cacheram_4(.adr(adr6_buff), .adr_b(adr6_b_buff), 
      .din(din[52:0]), .ph1_b(ph1_b), .ph1_b_buff(ph1_b_buff), 
      .ph2_b(ph2_b_buff), .rwb(rwb_buff), .word(word_buff[63:0]), 
      .dout(dout[52:0]));
  memsys_final__decoder64b decoder6_8(.a(adr[5:0]), .ph2(ph2), 
      .y(word_buff[63:0]));
endmodule   /* memsys_final__cacheram */

module muddlib07__mux2_dp_1x(d0, d1, s, sb, y);
  input d0;
  input d1;
  input s;
  input sb;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_12, net_15, net_3, net_4, net_8;

  tranif1 nmos_0(gnd, net_3, d1);
  tranif1 nmos_1(gnd, net_4, d0);
  tranif1 nmos_2(net_3, net_8, s);
  tranif1 nmos_3(net_4, net_8, sb);
  tranif1 nmos_4(gnd, y, net_8);
  tranif0 pmos_0(net_8, net_15, sb);
  tranif0 pmos_1(net_15, vdd, d1);
  tranif0 pmos_2(net_8, net_12, s);
  tranif0 pmos_3(net_12, vdd, d0);
  tranif0 pmos_4(y, vdd, net_8);
endmodule   /* muddlib07__mux2_dp_1x */

module memsys_final__mux2_zip(s, s_out, sb_out);
  input s;
  output s_out;
  output sb_out;

  supply1 vdd;
  supply0 gnd;
  muddlib07__inv_4x inv_4x_3(.a(s), .y(sb_out));
  muddlib07__inv_4x inv_4x_4(.a(sb_out), .y(s_out));
endmodule   /* memsys_final__mux2_zip */

module memsys_final__mux2_1x_32(d0, d1, s, y);
  input [31:0] d0;
  input [31:0] d1;
  input s;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  wire sb, sbb;

  muddlib07__mux2_dp_1x mux2_dp_1x_31_(.d0(d0[31]), .d1(d1[31]), .s(sbb), 
      .sb(sb), .y(y[31]));
  muddlib07__mux2_dp_1x mux2_dp_1x_30_(.d0(d0[30]), .d1(d1[30]), .s(sbb), 
      .sb(sb), .y(y[30]));
  muddlib07__mux2_dp_1x mux2_dp_1x_29_(.d0(d0[29]), .d1(d1[29]), .s(sbb), 
      .sb(sb), .y(y[29]));
  muddlib07__mux2_dp_1x mux2_dp_1x_28_(.d0(d0[28]), .d1(d1[28]), .s(sbb), 
      .sb(sb), .y(y[28]));
  muddlib07__mux2_dp_1x mux2_dp_1x_27_(.d0(d0[27]), .d1(d1[27]), .s(sbb), 
      .sb(sb), .y(y[27]));
  muddlib07__mux2_dp_1x mux2_dp_1x_26_(.d0(d0[26]), .d1(d1[26]), .s(sbb), 
      .sb(sb), .y(y[26]));
  muddlib07__mux2_dp_1x mux2_dp_1x_25_(.d0(d0[25]), .d1(d1[25]), .s(sbb), 
      .sb(sb), .y(y[25]));
  muddlib07__mux2_dp_1x mux2_dp_1x_24_(.d0(d0[24]), .d1(d1[24]), .s(sbb), 
      .sb(sb), .y(y[24]));
  muddlib07__mux2_dp_1x mux2_dp_1x_23_(.d0(d0[23]), .d1(d1[23]), .s(sbb), 
      .sb(sb), .y(y[23]));
  muddlib07__mux2_dp_1x mux2_dp_1x_22_(.d0(d0[22]), .d1(d1[22]), .s(sbb), 
      .sb(sb), .y(y[22]));
  muddlib07__mux2_dp_1x mux2_dp_1x_21_(.d0(d0[21]), .d1(d1[21]), .s(sbb), 
      .sb(sb), .y(y[21]));
  muddlib07__mux2_dp_1x mux2_dp_1x_20_(.d0(d0[20]), .d1(d1[20]), .s(sbb), 
      .sb(sb), .y(y[20]));
  muddlib07__mux2_dp_1x mux2_dp_1x_19_(.d0(d0[19]), .d1(d1[19]), .s(sbb), 
      .sb(sb), .y(y[19]));
  muddlib07__mux2_dp_1x mux2_dp_1x_18_(.d0(d0[18]), .d1(d1[18]), .s(sbb), 
      .sb(sb), .y(y[18]));
  muddlib07__mux2_dp_1x mux2_dp_1x_17_(.d0(d0[17]), .d1(d1[17]), .s(sbb), 
      .sb(sb), .y(y[17]));
  muddlib07__mux2_dp_1x mux2_dp_1x_16_(.d0(d0[16]), .d1(d1[16]), .s(sbb), 
      .sb(sb), .y(y[16]));
  muddlib07__mux2_dp_1x mux2_dp_1x_15_(.d0(d0[15]), .d1(d1[15]), .s(sbb), 
      .sb(sb), .y(y[15]));
  muddlib07__mux2_dp_1x mux2_dp_1x_14_(.d0(d0[14]), .d1(d1[14]), .s(sbb), 
      .sb(sb), .y(y[14]));
  muddlib07__mux2_dp_1x mux2_dp_1x_13_(.d0(d0[13]), .d1(d1[13]), .s(sbb), 
      .sb(sb), .y(y[13]));
  muddlib07__mux2_dp_1x mux2_dp_1x_12_(.d0(d0[12]), .d1(d1[12]), .s(sbb), 
      .sb(sb), .y(y[12]));
  muddlib07__mux2_dp_1x mux2_dp_1x_11_(.d0(d0[11]), .d1(d1[11]), .s(sbb), 
      .sb(sb), .y(y[11]));
  muddlib07__mux2_dp_1x mux2_dp_1x_10_(.d0(d0[10]), .d1(d1[10]), .s(sbb), 
      .sb(sb), .y(y[10]));
  muddlib07__mux2_dp_1x mux2_dp_1x_9_(.d0(d0[9]), .d1(d1[9]), .s(sbb), .sb(sb), 
      .y(y[9]));
  muddlib07__mux2_dp_1x mux2_dp_1x_8_(.d0(d0[8]), .d1(d1[8]), .s(sbb), .sb(sb), 
      .y(y[8]));
  muddlib07__mux2_dp_1x mux2_dp_1x_7_(.d0(d0[7]), .d1(d1[7]), .s(sbb), .sb(sb), 
      .y(y[7]));
  muddlib07__mux2_dp_1x mux2_dp_1x_6_(.d0(d0[6]), .d1(d1[6]), .s(sbb), .sb(sb), 
      .y(y[6]));
  muddlib07__mux2_dp_1x mux2_dp_1x_5_(.d0(d0[5]), .d1(d1[5]), .s(sbb), .sb(sb), 
      .y(y[5]));
  muddlib07__mux2_dp_1x mux2_dp_1x_4_(.d0(d0[4]), .d1(d1[4]), .s(sbb), .sb(sb), 
      .y(y[4]));
  muddlib07__mux2_dp_1x mux2_dp_1x_3_(.d0(d0[3]), .d1(d1[3]), .s(sbb), .sb(sb), 
      .y(y[3]));
  muddlib07__mux2_dp_1x mux2_dp_1x_2_(.d0(d0[2]), .d1(d1[2]), .s(sbb), .sb(sb), 
      .y(y[2]));
  muddlib07__mux2_dp_1x mux2_dp_1x_1_(.d0(d0[1]), .d1(d1[1]), .s(sbb), .sb(sb), 
      .y(y[1]));
  muddlib07__mux2_dp_1x mux2_dp_1x_0_(.d0(d0[0]), .d1(d1[0]), .s(sbb), .sb(sb), 
      .y(y[0]));
  memsys_final__mux2_zip mux2_zip_1(.s(s), .s_out(sbb), .sb_out(sb));
endmodule   /* memsys_final__mux2_1x_32 */

module memsys_final__tribuf_32(d, en, y);
  input [31:0] d;
  input en;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_8, net_9;

  memsys_final__buftri_zip buftri_z_0(.en(en), .en_out(net_8), 
      .enb_out(net_9));
  muddlib07__buftri_dp_1x tribuf_31_(.d(d[31]), .en(net_8), .enb(net_9), 
      .y(y[31]));
  muddlib07__buftri_dp_1x tribuf_30_(.d(d[30]), .en(net_8), .enb(net_9), 
      .y(y[30]));
  muddlib07__buftri_dp_1x tribuf_29_(.d(d[29]), .en(net_8), .enb(net_9), 
      .y(y[29]));
  muddlib07__buftri_dp_1x tribuf_28_(.d(d[28]), .en(net_8), .enb(net_9), 
      .y(y[28]));
  muddlib07__buftri_dp_1x tribuf_27_(.d(d[27]), .en(net_8), .enb(net_9), 
      .y(y[27]));
  muddlib07__buftri_dp_1x tribuf_26_(.d(d[26]), .en(net_8), .enb(net_9), 
      .y(y[26]));
  muddlib07__buftri_dp_1x tribuf_25_(.d(d[25]), .en(net_8), .enb(net_9), 
      .y(y[25]));
  muddlib07__buftri_dp_1x tribuf_24_(.d(d[24]), .en(net_8), .enb(net_9), 
      .y(y[24]));
  muddlib07__buftri_dp_1x tribuf_23_(.d(d[23]), .en(net_8), .enb(net_9), 
      .y(y[23]));
  muddlib07__buftri_dp_1x tribuf_22_(.d(d[22]), .en(net_8), .enb(net_9), 
      .y(y[22]));
  muddlib07__buftri_dp_1x tribuf_21_(.d(d[21]), .en(net_8), .enb(net_9), 
      .y(y[21]));
  muddlib07__buftri_dp_1x tribuf_20_(.d(d[20]), .en(net_8), .enb(net_9), 
      .y(y[20]));
  muddlib07__buftri_dp_1x tribuf_19_(.d(d[19]), .en(net_8), .enb(net_9), 
      .y(y[19]));
  muddlib07__buftri_dp_1x tribuf_18_(.d(d[18]), .en(net_8), .enb(net_9), 
      .y(y[18]));
  muddlib07__buftri_dp_1x tribuf_17_(.d(d[17]), .en(net_8), .enb(net_9), 
      .y(y[17]));
  muddlib07__buftri_dp_1x tribuf_16_(.d(d[16]), .en(net_8), .enb(net_9), 
      .y(y[16]));
  muddlib07__buftri_dp_1x tribuf_15_(.d(d[15]), .en(net_8), .enb(net_9), 
      .y(y[15]));
  muddlib07__buftri_dp_1x tribuf_14_(.d(d[14]), .en(net_8), .enb(net_9), 
      .y(y[14]));
  muddlib07__buftri_dp_1x tribuf_13_(.d(d[13]), .en(net_8), .enb(net_9), 
      .y(y[13]));
  muddlib07__buftri_dp_1x tribuf_12_(.d(d[12]), .en(net_8), .enb(net_9), 
      .y(y[12]));
  muddlib07__buftri_dp_1x tribuf_11_(.d(d[11]), .en(net_8), .enb(net_9), 
      .y(y[11]));
  muddlib07__buftri_dp_1x tribuf_10_(.d(d[10]), .en(net_8), .enb(net_9), 
      .y(y[10]));
  muddlib07__buftri_dp_1x tribuf_9_(.d(d[9]), .en(net_8), .enb(net_9), 
      .y(y[9]));
  muddlib07__buftri_dp_1x tribuf_8_(.d(d[8]), .en(net_8), .enb(net_9), 
      .y(y[8]));
  muddlib07__buftri_dp_1x tribuf_7_(.d(d[7]), .en(net_8), .enb(net_9), 
      .y(y[7]));
  muddlib07__buftri_dp_1x tribuf_6_(.d(d[6]), .en(net_8), .enb(net_9), 
      .y(y[6]));
  muddlib07__buftri_dp_1x tribuf_5_(.d(d[5]), .en(net_8), .enb(net_9), 
      .y(y[5]));
  muddlib07__buftri_dp_1x tribuf_4_(.d(d[4]), .en(net_8), .enb(net_9), 
      .y(y[4]));
  muddlib07__buftri_dp_1x tribuf_3_(.d(d[3]), .en(net_8), .enb(net_9), 
      .y(y[3]));
  muddlib07__buftri_dp_1x tribuf_2_(.d(d[2]), .en(net_8), .enb(net_9), 
      .y(y[2]));
  muddlib07__buftri_dp_1x tribuf_1_(.d(d[1]), .en(net_8), .enb(net_9), 
      .y(y[1]));
  muddlib07__buftri_dp_1x tribuf_0_(.d(d[0]), .en(net_8), .enb(net_9), 
      .y(y[0]));
endmodule   /* memsys_final__tribuf_32 */

module memsys_final__dataout(cacheline, rwb, waiting, data, memdata);
  input [31:0] cacheline;
  input rwb;
  input waiting;
  input [31:0] data;
  input [31:0] memdata;

  supply1 vdd;
  supply0 gnd;
  wire rwb_b;
  wire [31:0] readdata;

  muddlib07__inv_1x inv_1x_0(.a(rwb), .y(rwb_b));
  memsys_final__mux2_1x_32 mux2_1x__0(.d0(cacheline[31:0]), .d1(memdata[31:0]), 
      .s(waiting), .y(readdata[31:0]));
  memsys_final__tribuf_32 tribuf_3_0(.d(readdata[31:0]), .en(rwb), 
      .y(data[31:0]));
  memsys_final__tribuf_32 tribuf_3_1(.d(data[31:0]), .en(rwb_b), 
      .y(memdata[31:0]));
endmodule   /* memsys_final__dataout */

module memsys_final__mux2_1x_4(d0, d1, s, y);
  input [3:0] d0;
  input [3:0] d1;
  input s;
  output [3:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_17, net_18;

  muddlib07__mux2_dp_1x mux2_dp_3_(.d0(d0[3]), .d1(d1[3]), .s(net_17), 
      .sb(net_18), .y(y[3]));
  muddlib07__mux2_dp_1x mux2_dp_2_(.d0(d0[2]), .d1(d1[2]), .s(net_17), 
      .sb(net_18), .y(y[2]));
  muddlib07__mux2_dp_1x mux2_dp_1_(.d0(d0[1]), .d1(d1[1]), .s(net_17), 
      .sb(net_18), .y(y[1]));
  muddlib07__mux2_dp_1x mux2_dp_0_(.d0(d0[0]), .d1(d1[0]), .s(net_17), 
      .sb(net_18), .y(y[0]));
  memsys_final__mux2_zip mux2_zip_0(.s(s), .s_out(net_17), .sb_out(net_18));
endmodule   /* memsys_final__mux2_1x_4 */

module memsys_final__dcache(adr, adr_1, byteen, en, memdone, ph1, ph2, reset, 
      rwb, done, membyteen, memen, data, memdata);
  input [27:0] adr;
  input [29:29] adr_1;
  input [3:0] byteen;
  input en;
  input memdone;
  input ph1;
  input ph2;
  input reset;
  input rwb;
  output done;
  output [3:0] membyteen;
  output memen;
  input [31:0] data;
  input [31:0] memdata;

  supply1 vdd;
  supply0 gnd;
  wire bypass, cacheramrwb, reading, valid, validnew, waiting_b;
  wire [31:0] cacheline;
  wire [31:0] cachelinenew;
  wire [19:0] tagdata;

  memsys_final__byteenlog byteenlo_0(.byteen(byteen[3:0]), .memdone(memdone), 
      .reading(reading), .validnew(validnew));
  memsys_final__cachecontroller cachecon_2(.adr(adr[27:7]), 
      .adr_1(adr_1[29:29]), .en(en), .memdone(memdone), .reset(reset), 
      .rwb(rwb), .tagdata(tagdata[19:0]), .valid(valid), .bypass(bypass), 
      .done(done), .reading(reading), .waiting(memen), .ph1(ph1), .ph2(ph2));
  memsys_final__cacheram cacheram_1(.adr(adr[6:0]), .din({cachelinenew[31], 
      cachelinenew[30], cachelinenew[29], cachelinenew[28], cachelinenew[27], 
      adr[26], cachelinenew[26], adr[25], cachelinenew[25], adr[24], 
      cachelinenew[24], adr[23], cachelinenew[23], adr[22], cachelinenew[22], 
      adr[21], cachelinenew[21], adr[20], cachelinenew[20], adr[19], 
      cachelinenew[19], adr[18], cachelinenew[18], adr[17], cachelinenew[17], 
      adr[16], cachelinenew[16], adr[15], cachelinenew[15], adr[14], 
      cachelinenew[14], adr[13], cachelinenew[13], adr[12], cachelinenew[12], 
      adr[11], cachelinenew[11], adr[10], cachelinenew[10], adr[9], 
      cachelinenew[9], adr[8], cachelinenew[8], adr[7], cachelinenew[7], 
      cachelinenew[6], cachelinenew[5], cachelinenew[4], cachelinenew[3], 
      cachelinenew[2], validnew, cachelinenew[1], cachelinenew[0]}), .ph1(ph1), 
      .ph2(ph2), .rwb(cacheramrwb), .dout({cacheline[31], cacheline[30], 
      cacheline[29], cacheline[28], cacheline[27], tagdata[19], cacheline[26], 
      tagdata[18], cacheline[25], tagdata[17], cacheline[24], tagdata[16], 
      cacheline[23], tagdata[15], cacheline[22], tagdata[14], cacheline[21], 
      tagdata[13], cacheline[20], tagdata[12], cacheline[19], tagdata[11], 
      cacheline[18], tagdata[10], cacheline[17], tagdata[9], cacheline[16], 
      tagdata[8], cacheline[15], tagdata[7], cacheline[14], tagdata[6], 
      cacheline[13], tagdata[5], cacheline[12], tagdata[4], cacheline[11], 
      tagdata[3], cacheline[10], tagdata[2], cacheline[9], tagdata[1], 
      cacheline[8], tagdata[0], cacheline[7], cacheline[6], cacheline[5], 
      cacheline[4], cacheline[3], cacheline[2], valid, cacheline[1], 
      cacheline[0]}));
  memsys_final__dataout dataout_1(.cacheline(cacheline[31:0]), .rwb(rwb), 
      .waiting(memen), .data(data[31:0]), .memdata(memdata[31:0]));
  muddlib07__inv_1x inv_1x_0(.a(memen), .y(waiting_b));
  memsys_final__mux2_1x_32 mux2_1x__2(.d0(data[31:0]), .d1(memdata[31:0]), 
      .s(reading), .y(cachelinenew[31:0]));
  memsys_final__mux2_1x_4 mux2_4_0(.d0(byteen[3:0]), .d1({vdd, vdd, vdd, vdd}), 
      .s(reading), .y(membyteen[3:0]));
  muddlib07__or2_1x or2_1x_0(.a(bypass), .b(waiting_b), .y(cacheramrwb));
endmodule   /* memsys_final__dcache */

module memsys_final__greenblock(imembyteen, imemen, ion, memdone, swc_imemrwbb, 
      wbdone, imemdone, wbbyteen, wben);
  input [3:0] imembyteen;
  input imemen;
  input ion;
  input memdone;
  input swc_imemrwbb;
  input wbdone;
  output imemdone;
  output [3:0] wbbyteen;
  output wben;

  supply1 vdd;
  supply0 gnd;
  wire imemdonemem;

  muddlib07__mux2_c_1x imemdonememmux(.d0(gnd), .d1(memdone), .s(ion), 
      .y(imemdonemem));
  muddlib07__mux2_c_1x imemdonemux(.d0(imemdonemem), .d1(wbdone), 
      .s(swc_imemrwbb), .y(imemdone));
  memsys_final__buftri_1x_4 wbbyteeni(.d(imembyteen[3:0]), .en(swc_imemrwbb), 
      .y(wbbyteen[3:0]));
  muddlib07__buftri_c_1x wbeni(.d(imemen), .en(swc_imemrwbb), .y(wben));
endmodule   /* memsys_final__greenblock */

module memsys_final__icache(adr, adr_1, byteen, en, memdone, ph1, ph2, reset, 
      rwb, done, membyteen, memen, data, memdata);
  input [27:0] adr;
  input [29:29] adr_1;
  input [3:0] byteen;
  input en;
  input memdone;
  input ph1;
  input ph2;
  input reset;
  input rwb;
  output done;
  output [3:0] membyteen;
  output memen;
  input [31:0] data;
  input [31:0] memdata;

  supply1 vdd;
  supply0 gnd;
  wire bypass, cacheramrwb, reading, valid, validnew, waiting_b;
  wire [31:0] cacheline;
  wire [31:0] cachelinenew;
  wire [19:0] tagdata;

  memsys_final__byteenlog byteenlo_0(.byteen(byteen[3:0]), .memdone(memdone), 
      .reading(reading), .validnew(validnew));
  memsys_final__cachecontroller cachecon_2(.adr(adr[27:7]), 
      .adr_1(adr_1[29:29]), .en(en), .memdone(memdone), .reset(reset), 
      .rwb(rwb), .tagdata(tagdata[19:0]), .valid(valid), .bypass(bypass), 
      .done(done), .reading(reading), .waiting(memen), .ph1(ph1), .ph2(ph2));
  memsys_final__cacheram cacheram_1(.adr(adr[6:0]), .din({cachelinenew[31], 
      cachelinenew[30], cachelinenew[29], cachelinenew[28], cachelinenew[27], 
      adr[26], cachelinenew[26], adr[25], cachelinenew[25], adr[24], 
      cachelinenew[24], adr[23], cachelinenew[23], adr[22], cachelinenew[22], 
      adr[21], cachelinenew[21], adr[20], cachelinenew[20], adr[19], 
      cachelinenew[19], adr[18], cachelinenew[18], adr[17], cachelinenew[17], 
      adr[16], cachelinenew[16], adr[15], cachelinenew[15], adr[14], 
      cachelinenew[14], adr[13], cachelinenew[13], adr[12], cachelinenew[12], 
      adr[11], cachelinenew[11], adr[10], cachelinenew[10], adr[9], 
      cachelinenew[9], adr[8], cachelinenew[8], adr[7], cachelinenew[7], 
      cachelinenew[6], cachelinenew[5], cachelinenew[4], cachelinenew[3], 
      cachelinenew[2], validnew, cachelinenew[1], cachelinenew[0]}), .ph1(ph1), 
      .ph2(ph2), .rwb(cacheramrwb), .dout({cacheline[31], cacheline[30], 
      cacheline[29], cacheline[28], cacheline[27], tagdata[19], cacheline[26], 
      tagdata[18], cacheline[25], tagdata[17], cacheline[24], tagdata[16], 
      cacheline[23], tagdata[15], cacheline[22], tagdata[14], cacheline[21], 
      tagdata[13], cacheline[20], tagdata[12], cacheline[19], tagdata[11], 
      cacheline[18], tagdata[10], cacheline[17], tagdata[9], cacheline[16], 
      tagdata[8], cacheline[15], tagdata[7], cacheline[14], tagdata[6], 
      cacheline[13], tagdata[5], cacheline[12], tagdata[4], cacheline[11], 
      tagdata[3], cacheline[10], tagdata[2], cacheline[9], tagdata[1], 
      cacheline[8], tagdata[0], cacheline[7], cacheline[6], cacheline[5], 
      cacheline[4], cacheline[3], cacheline[2], valid, cacheline[1], 
      cacheline[0]}));
  memsys_final__dataout dataout_1(.cacheline(cacheline[31:0]), .rwb(rwb), 
      .waiting(memen), .data(data[31:0]), .memdata(memdata[31:0]));
  muddlib07__inv_1x inv_1x_0(.a(memen), .y(waiting_b));
  memsys_final__mux2_1x_32 mux2_1x__2(.d0(data[31:0]), .d1(memdata[31:0]), 
      .s(reading), .y(cachelinenew[31:0]));
  memsys_final__mux2_1x_4 mux2_4_0(.d0(byteen[3:0]), .d1({vdd, vdd, vdd, vdd}), 
      .s(reading), .y(membyteen[3:0]));
  muddlib07__or2_1x or2_1x_0(.a(bypass), .b(waiting_b), .y(cacheramrwb));
endmodule   /* memsys_final__icache */

module muddlib07__nor2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_9;

  tranif1 nmos_0(gnd, y, a);
  tranif1 nmos_1(gnd, y, b);
  tranif0 pmos_0(y, net_9, b);
  tranif0 pmos_1(net_9, vdd, a);
endmodule   /* muddlib07__nor2_1x */

module memsys_final__decoder_msc(a, y);
  input [1:0] a;
  output [3:0] y;

  supply1 vdd;
  supply0 gnd;
  wire a0, a0_b, a1, a1_b;

  muddlib07__invbuf_4x invbuf_4_0(.s(a[0]), .s_out(a0), .sb_out(a0_b));
  muddlib07__invbuf_4x invbuf_4_1(.s(a[1]), .s_out(a1), .sb_out(a1_b));
  muddlib07__nor2_1x nor2_1x_0(.a(a0_b), .b(a1), .y(y[1]));
  muddlib07__nor2_1x nor2_1x_1(.a(a0), .b(a1_b), .y(y[2]));
  muddlib07__nor2_1x nor2_1x_2(.a(a0_b), .b(a1_b), .y(y[3]));
  muddlib07__nor2_1x nor2_1x_3(.a(a0), .b(a1), .y(y[0]));
endmodule   /* memsys_final__decoder_msc */

module muddlib07__nand3_1x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_15, net_4;

  tranif1 nmos_0(net_15, net_4, b);
  tranif1 nmos_1(net_4, y, a);
  tranif1 nmos_2(gnd, net_15, c);
  tranif0 pmos_0(y, vdd, a);
  tranif0 pmos_1(y, vdd, b);
  tranif0 pmos_2(y, vdd, c);
endmodule   /* muddlib07__nand3_1x */

module memsys_final__nextstatelog(dmemen, dmemrwb, imemen, imemrwb, memdone, 
      state, swc, wbmemen, nextstate);
  input dmemen;
  input dmemrwb;
  input imemen;
  input imemrwb;
  input memdone;
  input [1:0] state;
  input swc;
  input wbmemen;
  output [1:0] nextstate;

  supply1 vdd;
  supply0 gnd;
  wire S_READY, dmem, dmem_b, imem_b, memdone_b, net_10, net_101, net_169;
  wire net_244, net_255, net_257, net_47, net_72, net_8, net_91, wbmemen_b;

  muddlib07__and2_1x and2_1x_5(.a(net_10), .b(net_255), .y(net_8));
  muddlib07__inv_1x inv_1x_1(.a(wbmemen), .y(wbmemen_b));
  muddlib07__inv_1x inv_1x_2(.a(memdone), .y(memdone_b));
  muddlib07__inv_1x inv_1x_3(.a(imem_b), .y(net_10));
  muddlib07__inv_1x inv_1x_4(.a(dmem_b), .y(dmem));
  muddlib07__nand2_1x nand2_1x_5(.a(state[1]), .b(memdone_b), .y(net_91));
  muddlib07__nand2_1x nand2_1x_6(.a(imem_b), .b(dmem_b), .y(net_101));
  muddlib07__nand2_1x nand2_1x_7(.a(imemen), .b(imemrwb), .y(imem_b));
  muddlib07__nand2_1x nand2_1x_8(.a(dmemen), .b(dmemrwb), .y(dmem_b));
  muddlib07__nand2_1x nand2_1x_9(.a(S_READY), .b(net_244), .y(net_47));
  muddlib07__nand2_1x nand2_1x_11(.a(memdone_b), .b(state[0]), .y(net_169));
  muddlib07__nand2_1x nand2_1x_12(.a(net_72), .b(net_91), .y(nextstate[1]));
  muddlib07__nand2_1x nand2_1x_13(.a(net_169), .b(net_47), .y(nextstate[0]));
  muddlib07__nand3_1x nand3_1x_0(.a(net_101), .b(wbmemen_b), .c(S_READY), 
      .y(net_72));
  muddlib07__nor2_1x nor2_1x_0(.a(state[0]), .b(state[1]), .y(S_READY));
  muddlib07__nor2_1x nor2_1x_1(.a(swc), .b(dmem), .y(net_257));
  muddlib07__or2_1x or2_1x_3(.a(wbmemen), .b(net_8), .y(net_244));
  muddlib07__or2_1x or2_1x_5(.a(swc), .b(net_257), .y(net_255));
endmodule   /* memsys_final__nextstatelog */

module memsys_final__memsyscontroller(dmemen, dmemrwb, imemen, imemrwb, 
      memdone, reset, swc, wbmemen, don, ion, memen, state, wbon, ph1, ph2);
  input dmemen;
  input dmemrwb;
  input imemen;
  input imemrwb;
  input memdone;
  input reset;
  input swc;
  input wbmemen;
  output don;
  output ion;
  output memen;
  output [1:0] state;
  output wbon;
  input ph1;
  input ph2;

  supply1 vdd;
  supply0 gnd;
  wire ornextstate, reset_b;
  wire [1:0] nextstate;
  wire [3:0] onnext;

  memsys_final__decoder_msc decoder_0(.a(nextstate[1:0]), .y(onnext[3:0]));
  muddlib07__flopr_c_1x flopr_c__0(.d(nextstate[0]), .resetb(reset_b), 
      .q(state[0]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopr_c_1x flopr_c__1(.d(nextstate[1]), .resetb(reset_b), 
      .q(state[1]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopr_c_1x flopr_c__2(.d(ornextstate), .resetb(reset_b), 
      .q(memen), .ph1(ph1), .ph2(ph2));
  muddlib07__flopr_c_1x flopr_c__3(.d(onnext[3]), .resetb(reset_b), .q(ion), 
      .ph1(ph1), .ph2(ph2));
  muddlib07__flopr_c_1x flopr_c__4(.d(onnext[2]), .resetb(reset_b), .q(don), 
      .ph1(ph1), .ph2(ph2));
  muddlib07__flopr_c_1x flopr_c__5(.d(onnext[1]), .resetb(reset_b), .q(wbon), 
      .ph1(ph1), .ph2(ph2));
  muddlib07__inv_1x inv_1x_5(.a(reset), .y(reset_b));
  memsys_final__nextstatelog nextstat_0(.dmemen(dmemen), .dmemrwb(dmemrwb), 
      .imemen(imemen), .imemrwb(imemrwb), .memdone(memdone), 
      .state(state[1:0]), .swc(swc), .wbmemen(wbmemen), 
      .nextstate(nextstate[1:0]));
  muddlib07__or2_1x or2_1x_1(.a(nextstate[0]), .b(nextstate[1]), 
      .y(ornextstate));
endmodule   /* memsys_final__memsyscontroller */

module muddlib07__mux4_c_1x(d0, d1, d2, d3, s0, s1, y);
  input d0;
  input d1;
  input d2;
  input d3;
  input s0;
  input s1;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_28, net_29, net_30, net_5, net_50, net_51, net_56, net_57, net_58;
  wire net_6, net_68, net_70, net_8, s0b, s1b;

  tranif1 nmos_0(gnd, net_5, d0);
  tranif1 nmos_1(gnd, net_6, d1);
  tranif1 nmos_3(net_5, net_8, s0b);
  tranif1 nmos_4(net_6, net_8, s0);
  tranif1 nmos_5(net_8, net_50, s1b);
  tranif1 nmos_7(gnd, net_70, d3);
  tranif1 nmos_8(net_68, net_51, s0b);
  tranif1 nmos_9(net_70, net_51, s0);
  tranif1 nmos_10(net_51, net_50, s1);
  tranif1 nmos_11(gnd, net_68, d2);
  tranif1 nmos_12(gnd, y, net_50);
  tranif1 nmos_13(gnd, s1b, s1);
  tranif1 nmos_14(gnd, s0b, s0);
  tranif0 pmos_0(net_50, net_30, s1);
  tranif0 pmos_2(net_30, net_28, s0);
  tranif0 pmos_3(net_28, vdd, d0);
  tranif0 pmos_4(net_30, net_29, s0b);
  tranif0 pmos_5(net_29, vdd, d1);
  tranif0 pmos_7(net_58, net_56, s0);
  tranif0 pmos_8(net_56, vdd, d2);
  tranif0 pmos_9(net_58, net_57, s0b);
  tranif0 pmos_10(net_57, vdd, d3);
  tranif0 pmos_11(net_50, net_58, s1b);
  tranif0 pmos_12(y, vdd, net_50);
  tranif0 pmos_13(s1b, vdd, s1);
  tranif0 pmos_14(s0b, vdd, s0);
endmodule   /* muddlib07__mux4_c_1x */

module memsys_final__orangeblock(memdone, state, wbon, memrwb, wbmemdone);
  input memdone;
  input [1:0] state;
  input wbon;
  output memrwb;
  output wbmemdone;

  supply1 vdd;
  supply0 gnd;
  muddlib07__mux4_c_1x memrwbmux(.d0(vdd), .d1(gnd), .d2(vdd), .d3(vdd), 
      .s0(state[0]), .s1(state[1]), .y(memrwb));
  muddlib07__mux2_c_1x wbmemdonemux(.d0(gnd), .d1(memdone), .s(wbon), 
      .y(wbmemdone));
endmodule   /* memsys_final__orangeblock */

module muddlib07__a22o2_1x(a, b, c, d, y);
  input a;
  input b;
  input c;
  input d;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_3, net_5, net_7, net_8;

  tranif1 nmos_0(gnd, net_8, a);
  tranif1 nmos_1(gnd, net_7, c);
  tranif1 nmos_2(net_8, net_5, b);
  tranif1 nmos_3(net_7, net_5, d);
  tranif1 nmos_4(gnd, y, net_5);
  tranif0 pmos_0(net_5, net_3, c);
  tranif0 pmos_1(net_3, vdd, a);
  tranif0 pmos_2(net_5, net_3, d);
  tranif0 pmos_3(net_3, vdd, b);
  tranif0 pmos_4(y, vdd, net_5);
endmodule   /* muddlib07__a22o2_1x */

module memsys_final__mux4_1x_4(d0, d1, d2, d3, s, y);
  input [3:0] d0;
  input [3:0] d1;
  input [3:0] d2;
  input [3:0] d3;
  input [1:0] s;
  output [3:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_37, net_38, net_39, net_40;

  muddlib07__mux4_dp_1x mux4_3_(.d0(d0[3]), .d1(d1[3]), .d2(d2[3]), .d3(d3[3]), 
      .s0(net_37), .s0b(net_38), .s1(net_39), .s1b(net_40), .y(y[3]));
  muddlib07__mux4_dp_1x mux4_2_(.d0(d0[2]), .d1(d1[2]), .d2(d2[2]), .d3(d3[2]), 
      .s0(net_37), .s0b(net_38), .s1(net_39), .s1b(net_40), .y(y[2]));
  muddlib07__mux4_dp_1x mux4_1_(.d0(d0[1]), .d1(d1[1]), .d2(d2[1]), .d3(d3[1]), 
      .s0(net_37), .s0b(net_38), .s1(net_39), .s1b(net_40), .y(y[1]));
  muddlib07__mux4_dp_1x mux4_0_(.d0(d0[0]), .d1(d1[0]), .d2(d2[0]), .d3(d3[0]), 
      .s0(net_37), .s0b(net_38), .s1(net_39), .s1b(net_40), .y(y[0]));
  memsys_final__mux4_zip mux4_zip_0(.s(s[1:0]), .s0_out(net_37), 
      .s0b_out(net_38), .s1_out(net_39), .s1b_out(net_40));
endmodule   /* memsys_final__mux4_1x_4 */

module memsys_final__redblock(dmembyteen, dmemrwb, imembyteen, imemrwb, state, 
      swc, wbmembyteen, membyteen, wben);
  input [3:0] dmembyteen;
  input dmemrwb;
  input [3:0] imembyteen;
  input imemrwb;
  input [1:0] state;
  input swc;
  input [3:0] wbmembyteen;
  output [3:0] membyteen;
  output wben;

  supply1 vdd;
  supply0 gnd;
  wire swcb, wbenz_en;

  muddlib07__a22o2_1x a22o2_1x_0(.a(swc), .b(imemrwb), .c(swcb), .d(dmemrwb), 
      .y(wbenz_en));
  muddlib07__inv_1x inv_1x_0(.a(swc), .y(swcb));
  memsys_final__mux4_1x_4 membyteenmux(.d0({gnd, gnd, gnd, vdd}), 
      .d1(wbmembyteen[3:0]), .d2(dmembyteen[3:0]), .d3(imembyteen[3:0]), 
      .s(state[1:0]), .y(membyteen[3:0]));
  muddlib07__buftri_c_1x wbenz(.d(gnd), .en(wbenz_en), .y(wben));
endmodule   /* memsys_final__redblock */

module memsys_final__wb_tribuf_en(dmemrwb, imemrwb, swc, swc_imemrwbb, 
      swcb_dmemrwbb);
  input dmemrwb;
  input imemrwb;
  input swc;
  output swc_imemrwbb;
  output swcb_dmemrwbb;

  supply1 vdd;
  supply0 gnd;
  wire imemrwbb;

  muddlib07__and2_1x and2_1x_0(.a(swc), .b(imemrwbb), .y(swc_imemrwbb));
  muddlib07__inv_1x inv_1x_0(.a(imemrwb), .y(imemrwbb));
  muddlib07__nor2_1x nor2_1x_0(.a(swc), .b(dmemrwb), .y(swcb_dmemrwbb));
endmodule   /* memsys_final__wb_tribuf_en */

module memsys_final__12TSRAM(bit, read, read_b, write, write_b, bit_read);
  input bit;
  input read;
  input read_b;
  input write;
  input write_b;
  output bit_read;

  supply1 vdd;
  supply0 gnd;
  wire net_56, net_58, net_59, net_6, net_61;
  trireg net_5;

  tranif1 nmos_1(net_58, net_5, net_6);
  tranif1 nmos_2(gnd, net_58, write_b);
  tranif1 nmos_3(gnd, net_6, net_5);
  tranif1 nmos_4(net_61, bit_read, read);
  tranif1 nmos_5(gnd, net_61, net_6);
  tranif1 nmos_6(bit, net_5, write);
  tranif0 pmos_0(net_5, bit, write_b);
  tranif0 pmos_1(net_56, vdd, write);
  tranif0 pmos_2(net_5, net_56, net_6);
  tranif0 pmos_3(net_6, vdd, net_5);
  tranif0 pmos_4(net_59, vdd, net_6);
  tranif0 pmos_5(bit_read, net_59, read_b);
endmodule   /* memsys_final__12TSRAM */

module muddlib07__inv_6x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  tranif1 nmos_0(gnd, y, a);
  tranif1 nmos_1(gnd, y, a);
  tranif0 pmos_0(y, vdd, a);
  tranif0 pmos_1(y, vdd, a);
endmodule   /* muddlib07__inv_6x */

module memsys_final__endec(S0, S1, en, d, d_1, d_2, d_3);
  input S0;
  input S1;
  input en;
  output [0:0] d;
  output [1:1] d_1;
  output [2:2] d_2;
  output [3:3] d_3;

  supply1 vdd;
  supply0 gnd;
  wire net_127, net_129;

  muddlib07__and3_1x and3_1x_0(.a(net_127), .b(net_129), .c(en), .y(d[0]));
  muddlib07__and3_1x and3_1x_1(.a(S0), .b(net_129), .c(en), .y(d_1[1]));
  muddlib07__and3_1x and3_1x_2(.a(net_127), .b(S1), .c(en), .y(d_2[2]));
  muddlib07__and3_1x and3_1x_3(.a(S1), .b(S0), .c(en), .y(d_3[3]));
  muddlib07__inv_1x inv_4x_0(.a(S1), .y(net_129));
  muddlib07__inv_1x inv_4x_1(.a(S0), .y(net_127));
endmodule   /* memsys_final__endec */

module memsys_final__SRAMarray(clk, ptr, rwb, writeptr, WBOUT, data);
  input clk;
  input [1:0] ptr;
  input rwb;
  input [1:0] writeptr;
  output [62:0] WBOUT;
  output [62:0] data;

  supply1 vdd;
  supply0 gnd;
  wire net_120, net_135, net_136, net_143, net_144, net_145, net_151, net_153;
  wire net_159, net_16, net_161, net_169, net_170, net_177, net_178, net_187;
  wire net_188, net_195, net_196, net_20, net_24, net_59, net_83, net_88;
  wire net_92, net_94;

  memsys_final__12TSRAM a_62_(.bit(data[62]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[62]));
  memsys_final__12TSRAM a_61_(.bit(data[61]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[61]));
  memsys_final__12TSRAM a_60_(.bit(data[60]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[60]));
  memsys_final__12TSRAM a_59_(.bit(data[59]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[59]));
  memsys_final__12TSRAM a_58_(.bit(data[58]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[58]));
  memsys_final__12TSRAM a_57_(.bit(data[57]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[57]));
  memsys_final__12TSRAM a_56_(.bit(data[56]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[56]));
  memsys_final__12TSRAM a_55_(.bit(data[55]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[55]));
  memsys_final__12TSRAM a_54_(.bit(data[54]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[54]));
  memsys_final__12TSRAM a_53_(.bit(data[53]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[53]));
  memsys_final__12TSRAM a_52_(.bit(data[52]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[52]));
  memsys_final__12TSRAM a_51_(.bit(data[51]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[51]));
  memsys_final__12TSRAM a_50_(.bit(data[50]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[50]));
  memsys_final__12TSRAM a_49_(.bit(data[49]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[49]));
  memsys_final__12TSRAM a_48_(.bit(data[48]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[48]));
  memsys_final__12TSRAM a_47_(.bit(data[47]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[47]));
  memsys_final__12TSRAM a_46_(.bit(data[46]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[46]));
  memsys_final__12TSRAM a_45_(.bit(data[45]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[45]));
  memsys_final__12TSRAM a_44_(.bit(data[44]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[44]));
  memsys_final__12TSRAM a_43_(.bit(data[43]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[43]));
  memsys_final__12TSRAM a_42_(.bit(data[42]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[42]));
  memsys_final__12TSRAM a_41_(.bit(data[41]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[41]));
  memsys_final__12TSRAM a_40_(.bit(data[40]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[40]));
  memsys_final__12TSRAM a_39_(.bit(data[39]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[39]));
  memsys_final__12TSRAM a_38_(.bit(data[38]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[38]));
  memsys_final__12TSRAM a_37_(.bit(data[37]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[37]));
  memsys_final__12TSRAM a_36_(.bit(data[36]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[36]));
  memsys_final__12TSRAM a_35_(.bit(data[35]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[35]));
  memsys_final__12TSRAM a_34_(.bit(data[34]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[34]));
  memsys_final__12TSRAM a_33_(.bit(data[33]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[33]));
  memsys_final__12TSRAM a_32_(.bit(data[32]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[32]));
  memsys_final__12TSRAM a_31_(.bit(data[31]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[31]));
  memsys_final__12TSRAM a_30_(.bit(data[30]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[30]));
  memsys_final__12TSRAM a_29_(.bit(data[29]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[29]));
  memsys_final__12TSRAM a_28_(.bit(data[28]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[28]));
  memsys_final__12TSRAM a_27_(.bit(data[27]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[27]));
  memsys_final__12TSRAM a_26_(.bit(data[26]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[26]));
  memsys_final__12TSRAM a_25_(.bit(data[25]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[25]));
  memsys_final__12TSRAM a_24_(.bit(data[24]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[24]));
  memsys_final__12TSRAM a_23_(.bit(data[23]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[23]));
  memsys_final__12TSRAM a_22_(.bit(data[22]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[22]));
  memsys_final__12TSRAM a_21_(.bit(data[21]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[21]));
  memsys_final__12TSRAM a_20_(.bit(data[20]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[20]));
  memsys_final__12TSRAM a_19_(.bit(data[19]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[19]));
  memsys_final__12TSRAM a_18_(.bit(data[18]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[18]));
  memsys_final__12TSRAM a_17_(.bit(data[17]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[17]));
  memsys_final__12TSRAM a_16_(.bit(data[16]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[16]));
  memsys_final__12TSRAM a_15_(.bit(data[15]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[15]));
  memsys_final__12TSRAM a_14_(.bit(data[14]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[14]));
  memsys_final__12TSRAM a_13_(.bit(data[13]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[13]));
  memsys_final__12TSRAM a_12_(.bit(data[12]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[12]));
  memsys_final__12TSRAM a_11_(.bit(data[11]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[11]));
  memsys_final__12TSRAM a_10_(.bit(data[10]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[10]));
  memsys_final__12TSRAM a_9_(.bit(data[9]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[9]));
  memsys_final__12TSRAM a_8_(.bit(data[8]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[8]));
  memsys_final__12TSRAM a_7_(.bit(data[7]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[7]));
  memsys_final__12TSRAM a_6_(.bit(data[6]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[6]));
  memsys_final__12TSRAM a_5_(.bit(data[5]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[5]));
  memsys_final__12TSRAM a_4_(.bit(data[4]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[4]));
  memsys_final__12TSRAM a_3_(.bit(data[3]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[3]));
  memsys_final__12TSRAM a_2_(.bit(data[2]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[2]));
  memsys_final__12TSRAM a_1_(.bit(data[1]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[1]));
  memsys_final__12TSRAM a_0_(.bit(data[0]), .read(net_135), .read_b(net_136), 
      .write(net_143), .write_b(net_144), .bit_read(WBOUT[0]));
  muddlib07__and2_1x and2_1x_1(.a(net_120), .b(clk), .y(net_59));
  memsys_final__12TSRAM b_62_(.bit(data[62]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[62]));
  memsys_final__12TSRAM b_61_(.bit(data[61]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[61]));
  memsys_final__12TSRAM b_60_(.bit(data[60]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[60]));
  memsys_final__12TSRAM b_59_(.bit(data[59]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[59]));
  memsys_final__12TSRAM b_58_(.bit(data[58]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[58]));
  memsys_final__12TSRAM b_57_(.bit(data[57]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[57]));
  memsys_final__12TSRAM b_56_(.bit(data[56]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[56]));
  memsys_final__12TSRAM b_55_(.bit(data[55]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[55]));
  memsys_final__12TSRAM b_54_(.bit(data[54]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[54]));
  memsys_final__12TSRAM b_53_(.bit(data[53]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[53]));
  memsys_final__12TSRAM b_52_(.bit(data[52]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[52]));
  memsys_final__12TSRAM b_51_(.bit(data[51]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[51]));
  memsys_final__12TSRAM b_50_(.bit(data[50]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[50]));
  memsys_final__12TSRAM b_49_(.bit(data[49]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[49]));
  memsys_final__12TSRAM b_48_(.bit(data[48]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[48]));
  memsys_final__12TSRAM b_47_(.bit(data[47]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[47]));
  memsys_final__12TSRAM b_46_(.bit(data[46]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[46]));
  memsys_final__12TSRAM b_45_(.bit(data[45]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[45]));
  memsys_final__12TSRAM b_44_(.bit(data[44]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[44]));
  memsys_final__12TSRAM b_43_(.bit(data[43]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[43]));
  memsys_final__12TSRAM b_42_(.bit(data[42]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[42]));
  memsys_final__12TSRAM b_41_(.bit(data[41]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[41]));
  memsys_final__12TSRAM b_40_(.bit(data[40]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[40]));
  memsys_final__12TSRAM b_39_(.bit(data[39]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[39]));
  memsys_final__12TSRAM b_38_(.bit(data[38]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[38]));
  memsys_final__12TSRAM b_37_(.bit(data[37]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[37]));
  memsys_final__12TSRAM b_36_(.bit(data[36]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[36]));
  memsys_final__12TSRAM b_35_(.bit(data[35]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[35]));
  memsys_final__12TSRAM b_34_(.bit(data[34]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[34]));
  memsys_final__12TSRAM b_33_(.bit(data[33]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[33]));
  memsys_final__12TSRAM b_32_(.bit(data[32]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[32]));
  memsys_final__12TSRAM b_31_(.bit(data[31]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[31]));
  memsys_final__12TSRAM b_30_(.bit(data[30]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[30]));
  memsys_final__12TSRAM b_29_(.bit(data[29]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[29]));
  memsys_final__12TSRAM b_28_(.bit(data[28]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[28]));
  memsys_final__12TSRAM b_27_(.bit(data[27]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[27]));
  memsys_final__12TSRAM b_26_(.bit(data[26]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[26]));
  memsys_final__12TSRAM b_25_(.bit(data[25]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[25]));
  memsys_final__12TSRAM b_24_(.bit(data[24]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[24]));
  memsys_final__12TSRAM b_23_(.bit(data[23]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[23]));
  memsys_final__12TSRAM b_22_(.bit(data[22]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[22]));
  memsys_final__12TSRAM b_21_(.bit(data[21]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[21]));
  memsys_final__12TSRAM b_20_(.bit(data[20]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[20]));
  memsys_final__12TSRAM b_19_(.bit(data[19]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[19]));
  memsys_final__12TSRAM b_18_(.bit(data[18]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[18]));
  memsys_final__12TSRAM b_17_(.bit(data[17]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[17]));
  memsys_final__12TSRAM b_16_(.bit(data[16]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[16]));
  memsys_final__12TSRAM b_15_(.bit(data[15]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[15]));
  memsys_final__12TSRAM b_14_(.bit(data[14]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[14]));
  memsys_final__12TSRAM b_13_(.bit(data[13]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[13]));
  memsys_final__12TSRAM b_12_(.bit(data[12]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[12]));
  memsys_final__12TSRAM b_11_(.bit(data[11]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[11]));
  memsys_final__12TSRAM b_10_(.bit(data[10]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[10]));
  memsys_final__12TSRAM b_9_(.bit(data[9]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[9]));
  memsys_final__12TSRAM b_8_(.bit(data[8]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[8]));
  memsys_final__12TSRAM b_7_(.bit(data[7]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[7]));
  memsys_final__12TSRAM b_6_(.bit(data[6]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[6]));
  memsys_final__12TSRAM b_5_(.bit(data[5]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[5]));
  memsys_final__12TSRAM b_4_(.bit(data[4]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[4]));
  memsys_final__12TSRAM b_3_(.bit(data[3]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[3]));
  memsys_final__12TSRAM b_2_(.bit(data[2]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[2]));
  memsys_final__12TSRAM b_1_(.bit(data[1]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[1]));
  memsys_final__12TSRAM b_0_(.bit(data[0]), .read(net_153), .read_b(net_151), 
      .write(net_161), .write_b(net_159), .bit_read(WBOUT[0]));
  memsys_final__12TSRAM c_62_(.bit(data[62]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[62]));
  memsys_final__12TSRAM c_61_(.bit(data[61]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[61]));
  memsys_final__12TSRAM c_60_(.bit(data[60]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[60]));
  memsys_final__12TSRAM c_59_(.bit(data[59]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[59]));
  memsys_final__12TSRAM c_58_(.bit(data[58]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[58]));
  memsys_final__12TSRAM c_57_(.bit(data[57]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[57]));
  memsys_final__12TSRAM c_56_(.bit(data[56]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[56]));
  memsys_final__12TSRAM c_55_(.bit(data[55]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[55]));
  memsys_final__12TSRAM c_54_(.bit(data[54]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[54]));
  memsys_final__12TSRAM c_53_(.bit(data[53]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[53]));
  memsys_final__12TSRAM c_52_(.bit(data[52]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[52]));
  memsys_final__12TSRAM c_51_(.bit(data[51]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[51]));
  memsys_final__12TSRAM c_50_(.bit(data[50]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[50]));
  memsys_final__12TSRAM c_49_(.bit(data[49]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[49]));
  memsys_final__12TSRAM c_48_(.bit(data[48]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[48]));
  memsys_final__12TSRAM c_47_(.bit(data[47]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[47]));
  memsys_final__12TSRAM c_46_(.bit(data[46]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[46]));
  memsys_final__12TSRAM c_45_(.bit(data[45]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[45]));
  memsys_final__12TSRAM c_44_(.bit(data[44]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[44]));
  memsys_final__12TSRAM c_43_(.bit(data[43]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[43]));
  memsys_final__12TSRAM c_42_(.bit(data[42]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[42]));
  memsys_final__12TSRAM c_41_(.bit(data[41]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[41]));
  memsys_final__12TSRAM c_40_(.bit(data[40]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[40]));
  memsys_final__12TSRAM c_39_(.bit(data[39]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[39]));
  memsys_final__12TSRAM c_38_(.bit(data[38]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[38]));
  memsys_final__12TSRAM c_37_(.bit(data[37]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[37]));
  memsys_final__12TSRAM c_36_(.bit(data[36]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[36]));
  memsys_final__12TSRAM c_35_(.bit(data[35]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[35]));
  memsys_final__12TSRAM c_34_(.bit(data[34]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[34]));
  memsys_final__12TSRAM c_33_(.bit(data[33]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[33]));
  memsys_final__12TSRAM c_32_(.bit(data[32]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[32]));
  memsys_final__12TSRAM c_31_(.bit(data[31]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[31]));
  memsys_final__12TSRAM c_30_(.bit(data[30]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[30]));
  memsys_final__12TSRAM c_29_(.bit(data[29]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[29]));
  memsys_final__12TSRAM c_28_(.bit(data[28]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[28]));
  memsys_final__12TSRAM c_27_(.bit(data[27]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[27]));
  memsys_final__12TSRAM c_26_(.bit(data[26]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[26]));
  memsys_final__12TSRAM c_25_(.bit(data[25]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[25]));
  memsys_final__12TSRAM c_24_(.bit(data[24]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[24]));
  memsys_final__12TSRAM c_23_(.bit(data[23]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[23]));
  memsys_final__12TSRAM c_22_(.bit(data[22]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[22]));
  memsys_final__12TSRAM c_21_(.bit(data[21]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[21]));
  memsys_final__12TSRAM c_20_(.bit(data[20]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[20]));
  memsys_final__12TSRAM c_19_(.bit(data[19]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[19]));
  memsys_final__12TSRAM c_18_(.bit(data[18]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[18]));
  memsys_final__12TSRAM c_17_(.bit(data[17]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[17]));
  memsys_final__12TSRAM c_16_(.bit(data[16]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[16]));
  memsys_final__12TSRAM c_15_(.bit(data[15]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[15]));
  memsys_final__12TSRAM c_14_(.bit(data[14]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[14]));
  memsys_final__12TSRAM c_13_(.bit(data[13]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[13]));
  memsys_final__12TSRAM c_12_(.bit(data[12]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[12]));
  memsys_final__12TSRAM c_11_(.bit(data[11]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[11]));
  memsys_final__12TSRAM c_10_(.bit(data[10]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[10]));
  memsys_final__12TSRAM c_9_(.bit(data[9]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[9]));
  memsys_final__12TSRAM c_8_(.bit(data[8]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[8]));
  memsys_final__12TSRAM c_7_(.bit(data[7]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[7]));
  memsys_final__12TSRAM c_6_(.bit(data[6]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[6]));
  memsys_final__12TSRAM c_5_(.bit(data[5]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[5]));
  memsys_final__12TSRAM c_4_(.bit(data[4]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[4]));
  memsys_final__12TSRAM c_3_(.bit(data[3]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[3]));
  memsys_final__12TSRAM c_2_(.bit(data[2]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[2]));
  memsys_final__12TSRAM c_1_(.bit(data[1]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[1]));
  memsys_final__12TSRAM c_0_(.bit(data[0]), .read(net_169), .read_b(net_170), 
      .write(net_177), .write_b(net_178), .bit_read(WBOUT[0]));
  memsys_final__12TSRAM d_62_(.bit(data[62]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[62]));
  memsys_final__12TSRAM d_61_(.bit(data[61]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[61]));
  memsys_final__12TSRAM d_60_(.bit(data[60]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[60]));
  memsys_final__12TSRAM d_59_(.bit(data[59]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[59]));
  memsys_final__12TSRAM d_58_(.bit(data[58]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[58]));
  memsys_final__12TSRAM d_57_(.bit(data[57]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[57]));
  memsys_final__12TSRAM d_56_(.bit(data[56]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[56]));
  memsys_final__12TSRAM d_55_(.bit(data[55]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[55]));
  memsys_final__12TSRAM d_54_(.bit(data[54]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[54]));
  memsys_final__12TSRAM d_53_(.bit(data[53]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[53]));
  memsys_final__12TSRAM d_52_(.bit(data[52]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[52]));
  memsys_final__12TSRAM d_51_(.bit(data[51]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[51]));
  memsys_final__12TSRAM d_50_(.bit(data[50]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[50]));
  memsys_final__12TSRAM d_49_(.bit(data[49]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[49]));
  memsys_final__12TSRAM d_48_(.bit(data[48]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[48]));
  memsys_final__12TSRAM d_47_(.bit(data[47]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[47]));
  memsys_final__12TSRAM d_46_(.bit(data[46]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[46]));
  memsys_final__12TSRAM d_45_(.bit(data[45]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[45]));
  memsys_final__12TSRAM d_44_(.bit(data[44]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[44]));
  memsys_final__12TSRAM d_43_(.bit(data[43]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[43]));
  memsys_final__12TSRAM d_42_(.bit(data[42]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[42]));
  memsys_final__12TSRAM d_41_(.bit(data[41]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[41]));
  memsys_final__12TSRAM d_40_(.bit(data[40]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[40]));
  memsys_final__12TSRAM d_39_(.bit(data[39]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[39]));
  memsys_final__12TSRAM d_38_(.bit(data[38]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[38]));
  memsys_final__12TSRAM d_37_(.bit(data[37]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[37]));
  memsys_final__12TSRAM d_36_(.bit(data[36]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[36]));
  memsys_final__12TSRAM d_35_(.bit(data[35]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[35]));
  memsys_final__12TSRAM d_34_(.bit(data[34]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[34]));
  memsys_final__12TSRAM d_33_(.bit(data[33]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[33]));
  memsys_final__12TSRAM d_32_(.bit(data[32]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[32]));
  memsys_final__12TSRAM d_31_(.bit(data[31]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[31]));
  memsys_final__12TSRAM d_30_(.bit(data[30]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[30]));
  memsys_final__12TSRAM d_29_(.bit(data[29]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[29]));
  memsys_final__12TSRAM d_28_(.bit(data[28]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[28]));
  memsys_final__12TSRAM d_27_(.bit(data[27]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[27]));
  memsys_final__12TSRAM d_26_(.bit(data[26]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[26]));
  memsys_final__12TSRAM d_25_(.bit(data[25]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[25]));
  memsys_final__12TSRAM d_24_(.bit(data[24]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[24]));
  memsys_final__12TSRAM d_23_(.bit(data[23]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[23]));
  memsys_final__12TSRAM d_22_(.bit(data[22]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[22]));
  memsys_final__12TSRAM d_21_(.bit(data[21]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[21]));
  memsys_final__12TSRAM d_20_(.bit(data[20]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[20]));
  memsys_final__12TSRAM d_19_(.bit(data[19]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[19]));
  memsys_final__12TSRAM d_18_(.bit(data[18]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[18]));
  memsys_final__12TSRAM d_17_(.bit(data[17]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[17]));
  memsys_final__12TSRAM d_16_(.bit(data[16]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[16]));
  memsys_final__12TSRAM d_15_(.bit(data[15]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[15]));
  memsys_final__12TSRAM d_14_(.bit(data[14]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[14]));
  memsys_final__12TSRAM d_13_(.bit(data[13]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[13]));
  memsys_final__12TSRAM d_12_(.bit(data[12]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[12]));
  memsys_final__12TSRAM d_11_(.bit(data[11]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[11]));
  memsys_final__12TSRAM d_10_(.bit(data[10]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[10]));
  memsys_final__12TSRAM d_9_(.bit(data[9]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[9]));
  memsys_final__12TSRAM d_8_(.bit(data[8]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[8]));
  memsys_final__12TSRAM d_7_(.bit(data[7]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[7]));
  memsys_final__12TSRAM d_6_(.bit(data[6]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[6]));
  memsys_final__12TSRAM d_5_(.bit(data[5]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[5]));
  memsys_final__12TSRAM d_4_(.bit(data[4]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[4]));
  memsys_final__12TSRAM d_3_(.bit(data[3]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[3]));
  memsys_final__12TSRAM d_2_(.bit(data[2]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[2]));
  memsys_final__12TSRAM d_1_(.bit(data[1]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[1]));
  memsys_final__12TSRAM d_0_(.bit(data[0]), .read(net_188), .read_b(net_187), 
      .write(net_195), .write_b(net_196), .bit_read(WBOUT[0]));
  muddlib07__inv_1x inv_1x_5(.a(rwb), .y(net_120));
  muddlib07__inv_6x inv_4x_0(.a(net_83), .y(net_136));
  muddlib07__inv_6x inv_4x_1(.a(net_136), .y(net_135));
  muddlib07__inv_6x inv_4x_2(.a(net_144), .y(net_143));
  muddlib07__inv_6x inv_4x_3(.a(net_145), .y(net_144));
  muddlib07__inv_6x inv_4x_4(.a(net_151), .y(net_153));
  muddlib07__inv_6x inv_4x_5(.a(net_88), .y(net_151));
  muddlib07__inv_6x inv_4x_6(.a(net_159), .y(net_161));
  muddlib07__inv_6x inv_4x_7(.a(net_16), .y(net_159));
  muddlib07__inv_6x inv_4x_8(.a(net_170), .y(net_169));
  muddlib07__inv_6x inv_4x_9(.a(net_92), .y(net_170));
  muddlib07__inv_6x inv_4x_10(.a(net_178), .y(net_177));
  muddlib07__inv_6x inv_4x_11(.a(net_20), .y(net_178));
  muddlib07__inv_6x inv_4x_12(.a(net_187), .y(net_188));
  muddlib07__inv_6x inv_4x_13(.a(net_94), .y(net_187));
  muddlib07__inv_6x inv_4x_14(.a(net_196), .y(net_195));
  muddlib07__inv_6x inv_4x_15(.a(net_24), .y(net_196));
  memsys_final__endec readdec(.S0(ptr[0]), .S1(ptr[1]), .en(vdd), .d({net_83}), 
      .d_1({net_88}), .d_2({net_92}), .d_3({net_94}));
  memsys_final__endec writedec(.S0(writeptr[0]), .S1(writeptr[1]), .en(net_59), 
      .d({net_145}), .d_1({net_16}), .d_2({net_20}), .d_3({net_24}));
endmodule   /* memsys_final__SRAMarray */

module muddlib07__and2_2x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_1, net_2;

  tranif1 nmos_0(net_1, net_2, b);
  tranif1 nmos_1(gnd, net_1, a);
  tranif1 nmos_2(gnd, y, net_2);
  tranif0 pmos_0(net_2, vdd, b);
  tranif0 pmos_1(net_2, vdd, a);
  tranif0 pmos_2(y, vdd, net_2);
endmodule   /* muddlib07__and2_2x */

module muddlib07__flopenr_c_1x(d, en, resetb, q, ph1, ph2);
  input d;
  input en;
  input resetb;
  output q;
  input ph1;
  input ph2;

  supply1 vdd;
  supply0 gnd;
  wire enb, master, masterinb, n1, n2, n3, n4, n5, n6, n7, n8, n9, ph1b, ph1buf;
  wire ph2b, ph2buf, slaveb;
  trireg masterb, slave;

  tranif1 nmos_2(masterinb, masterb, ph2buf);
  tranif1 nmos_3(gnd, master, masterb);
  rtranif1 nmos_4(master, slave, ph1buf);
  tranif1 nmos_5(n6, masterb, ph2b);
  tranif1 nmos_6(gnd, n6, master);
  tranif1 nmos_7(gnd, n8, slaveb);
  tranif1 nmos_8(gnd, slaveb, slave);
  tranif1 nmos_10(n8, slave, ph1b);
  tranif1 nmos_11(gnd, q, slaveb);
  tranif1 nmos_16(n1, n2, en);
  tranif1 nmos_17(gnd, n1, resetb);
  tranif1 nmos_18(n3, n1, enb);
  tranif1 nmos_19(n2, masterinb, d);
  tranif1 nmos_20(masterinb, n3, slave);
  tranif1 nmos_21(gnd, ph1b, ph1);
  tranif1 nmos_22(gnd, ph2b, ph2);
  tranif1 nmos_23(gnd, enb, en);
  tranif1 nmos_24(gnd, ph1buf, ph1b);
  tranif1 nmos_25(gnd, ph2buf, ph2b);
  tranif0 pmos_2(masterb, masterinb, ph2b);
  tranif0 pmos_3(master, vdd, masterb);
  rtranif0 pmos_4(slave, master, ph1b);
  tranif0 pmos_5(masterb, n7, ph2buf);
  tranif0 pmos_6(n7, vdd, master);
  tranif0 pmos_7(n9, vdd, slaveb);
  tranif0 pmos_8(slaveb, vdd, slave);
  tranif0 pmos_10(slave, n9, ph1buf);
  tranif0 pmos_11(q, vdd, slaveb);
  tranif0 pmos_16(masterinb, n4, d);
  tranif0 pmos_17(n4, vdd, enb);
  tranif0 pmos_18(masterinb, vdd, resetb);
  tranif0 pmos_19(n5, masterinb, slave);
  tranif0 pmos_20(vdd, n5, en);
  tranif0 pmos_21(ph1b, vdd, ph1);
  tranif0 pmos_22(ph2b, vdd, ph2);
  tranif0 pmos_23(enb, vdd, en);
  tranif0 pmos_24(ph1buf, vdd, ph1b);
  tranif0 pmos_25(ph2buf, vdd, ph2b);
endmodule   /* muddlib07__flopenr_c_1x */

module memsys_final__combo_logic(a0, a1, a2, a3, ph1, ph2, resetb, out);
  input a0;
  input a1;
  input a2;
  input a3;
  input ph1;
  input ph2;
  input resetb;
  output out;

  supply1 vdd;
  supply0 gnd;
  wire net_27, net_34;

  muddlib07__a22o2_1x a22o2_1x_0(.a(a0), .b(a1), .c(a2), .d(a3), .y(net_27));
  muddlib07__and2_1x and2_1x_0(.a(a0), .b(a1), .y(net_34));
  muddlib07__flopenr_c_1x flopenr__0(.d(net_34), .en(net_27), .resetb(resetb), 
      .q(out), .ph1(ph1), .ph2(ph2));
endmodule   /* memsys_final__combo_logic */

module muddlib07__or2_2x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_0, net_11;

  tranif1 nmos_0(gnd, y, net_0);
  tranif1 nmos_1(gnd, net_0, a);
  tranif1 nmos_2(gnd, net_0, b);
  tranif0 pmos_0(net_0, net_11, b);
  tranif0 pmos_1(net_11, vdd, a);
  tranif0 pmos_2(y, vdd, net_0);
endmodule   /* muddlib07__or2_2x */

module memsys_final__control_logic(done, en, memdone, memen, ph1, ph2, ptrs0, 
      ptrs1, ptrs2, ptrs3, resetb, writeptrs0, writeptrs1, writeptrs2, 
      writeptrs3, bufen0, bufen1, bufen2, bufen3, endone, work);
  input done;
  input en;
  input memdone;
  input memen;
  input ph1;
  input ph2;
  input ptrs0;
  input ptrs1;
  input ptrs2;
  input ptrs3;
  input resetb;
  input writeptrs0;
  input writeptrs1;
  input writeptrs2;
  input writeptrs3;
  output bufen0;
  output bufen1;
  output bufen2;
  output bufen3;
  output endone;
  output work;

  supply1 vdd;
  supply0 gnd;
  wire net_19;

  muddlib07__and2_2x and2_2x_0(.a(en), .b(done), .y(endone));
  memsys_final__combo_logic combo_lo_0(.a0(endone), .a1(ptrs0), 
      .a2(writeptrs0), .a3(work), .ph1(ph1), .ph2(ph2), .resetb(resetb), 
      .out(bufen0));
  memsys_final__combo_logic combo_lo_1(.a0(endone), .a1(ptrs1), 
      .a2(writeptrs1), .a3(work), .ph1(ph1), .ph2(ph2), .resetb(resetb), 
      .out(bufen1));
  memsys_final__combo_logic combo_lo_2(.a0(endone), .a1(ptrs2), 
      .a2(writeptrs2), .a3(work), .ph1(ph1), .ph2(ph2), .resetb(resetb), 
      .out(bufen2));
  memsys_final__combo_logic combo_lo_3(.a0(endone), .a1(ptrs3), 
      .a2(writeptrs3), .a3(work), .ph1(ph1), .ph2(ph2), .resetb(resetb), 
      .out(bufen3));
  muddlib07__inv_1x inv_1x_0(.a(memen), .y(net_19));
  muddlib07__or2_2x or2_2x_0(.a(memdone), .b(net_19), .y(work));
endmodule   /* memsys_final__control_logic */

module memsys_final__decoderwb(decin, dout);
  input [1:0] decin;
  output [3:0] dout;

  supply1 vdd;
  supply0 gnd;
  wire net_87, net_89;

  muddlib07__and2_1x and2_1x_0(.a(net_87), .b(net_89), .y(dout[0]));
  muddlib07__and2_1x and2_1x_1(.a(decin[0]), .b(net_89), .y(dout[1]));
  muddlib07__and2_1x and2_1x_2(.a(net_87), .b(decin[1]), .y(dout[2]));
  muddlib07__and2_1x and2_1x_3(.a(decin[0]), .b(decin[1]), .y(dout[3]));
  muddlib07__inv_1x inv_1x_0(.a(decin[1]), .y(net_89));
  muddlib07__inv_1x inv_1x_1(.a(decin[0]), .y(net_87));
endmodule   /* memsys_final__decoderwb */

module memsys_final__fourmux(d0, d1, d2, d3, en, dout);
  input d0;
  input d1;
  input d2;
  input d3;
  input [3:0] en;
  output dout;

  supply1 vdd;
  supply0 gnd;
  wire net_118, net_120;

  muddlib07__mux4_c_1x mux4_c_1_1(.d0(d0), .d1(d1), .d2(d2), .d3(d3), 
      .s0(net_118), .s1(net_120), .y(dout));
  muddlib07__or2_1x or2_1x_0(.a(en[1]), .b(en[3]), .y(net_118));
  muddlib07__or2_1x or2_1x_1(.a(en[2]), .b(en[3]), .y(net_120));
endmodule   /* memsys_final__fourmux */

module memsys_final__decoder4out(decin, d, d_1, d_2, d_3);
  input [1:0] decin;
  output [0:0] d;
  output [1:1] d_1;
  output [2:2] d_2;
  output [3:3] d_3;

  supply1 vdd;
  supply0 gnd;
  wire net_65, net_67;

  muddlib07__and2_1x and2_1x_0(.a(net_65), .b(net_67), .y(d[0]));
  muddlib07__and2_1x and2_1x_1(.a(decin[0]), .b(net_67), .y(d_1[1]));
  muddlib07__and2_1x and2_1x_2(.a(net_65), .b(decin[1]), .y(d_2[2]));
  muddlib07__and2_1x and2_1x_3(.a(decin[0]), .b(decin[1]), .y(d_3[3]));
  muddlib07__inv_1x inv_1x_0(.a(decin[1]), .y(net_67));
  muddlib07__inv_1x inv_1x_1(.a(decin[0]), .y(net_65));
endmodule   /* memsys_final__decoder4out */

module muddlib07__fulladder(a, b, c, cout, s);
  input a;
  input b;
  input c;
  output cout;
  output s;

  supply1 vdd;
  supply0 gnd;
  wire coutb, net_1, net_11, net_111, net_23, net_32, net_33, net_90, net_92;
  wire net_94, net_95, sb;

  tranif1 nmos_0(gnd, net_1, a);
  tranif1 nmos_1(gnd, net_1, b);
  tranif1 nmos_2(net_1, coutb, c);
  tranif1 nmos_3(gnd, net_11, a);
  tranif1 nmos_4(net_11, coutb, b);
  tranif1 nmos_5(gnd, net_23, a);
  tranif1 nmos_6(gnd, net_23, b);
  tranif1 nmos_7(gnd, net_23, c);
  tranif1 nmos_8(net_23, sb, coutb);
  tranif1 nmos_9(gnd, net_33, a);
  tranif1 nmos_10(net_33, net_32, b);
  tranif1 nmos_11(net_32, sb, c);
  tranif1 nmos_12(gnd, cout, coutb);
  tranif1 nmos_13(gnd, s, sb);
  tranif0 pmos_1(sb, net_92, c);
  tranif0 pmos_2(net_92, net_90, b);
  tranif0 pmos_3(net_90, vdd, a);
  tranif0 pmos_4(sb, net_94, coutb);
  tranif0 pmos_5(net_94, vdd, b);
  tranif0 pmos_6(net_94, vdd, c);
  tranif0 pmos_7(net_94, vdd, a);
  tranif0 pmos_8(cout, vdd, coutb);
  tranif0 pmos_9(net_95, vdd, a);
  tranif0 pmos_10(coutb, net_95, b);
  tranif0 pmos_11(net_111, vdd, a);
  tranif0 pmos_12(net_111, vdd, b);
  tranif0 pmos_13(coutb, net_111, c);
  tranif0 pmos_14(s, vdd, sb);
endmodule   /* muddlib07__fulladder */

module memsys_final__Incr2(a, cout, y);
  input [1:0] a;
  output cout;
  output [1:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_0;

  muddlib07__fulladder fulladde_0(.a(a[0]), .b(vdd), .c(gnd), .cout(net_0), 
      .s(y[0]));
  muddlib07__fulladder fulladde_1(.a(a[1]), .b(gnd), .c(net_0), .cout(cout), 
      .s(y[1]));
endmodule   /* memsys_final__Incr2 */

module memsys_final__writebuffer(adr, byteen, data, en, memdone, ph1, ph2, 
      reset, done, memadr, membyteen, memdata, memen);
  input [26:0] adr;
  input [3:0] byteen;
  input [31:0] data;
  input en;
  input memdone;
  input ph1;
  input ph2;
  input reset;
  output done;
  output [26:0] memadr;
  output [3:0] membyteen;
  output [31:0] memdata;
  output memen;

  supply1 vdd;
  supply0 gnd;
  wire bufen0, bufen1, bufen2, bufen3, endone, net_607, net_706, net_762;
  wire ptrinc_cout, ptrs0, ptrs1, ptrs2, ptrs3, resetb, work, writeptrinc_cout;
  wire writeptrs0, writeptrs1, writeptrs2, writeptrs3;
  wire [0:1] net_555;
  wire [0:1] net_579;
  wire [0:3] net_638;
  wire [0:3] net_639;
  wire [1:0] ptr;
  wire [1:0] writeptr;

  memsys_final__SRAMarray SRAMarra_0(.clk(ph2), .ptr(writeptr[1:0]), 
      .rwb(net_762), .writeptr(ptr[1:0]), .WBOUT({memdata[31], membyteen[3], 
      memdata[30], membyteen[2], memdata[29], membyteen[1], memdata[28], 
      membyteen[0], memdata[27], memadr[26], memdata[26], memadr[25], 
      memdata[25], memadr[24], memdata[24], memadr[23], memdata[23], 
      memadr[22], memdata[22], memadr[21], memdata[21], memadr[20], 
      memdata[20], memadr[19], memdata[19], memadr[18], memdata[18], 
      memadr[17], memdata[17], memadr[16], memdata[16], memadr[15], 
      memdata[15], memadr[14], memdata[14], memadr[13], memdata[13], 
      memadr[12], memdata[12], memadr[11], memdata[11], memadr[10], 
      memdata[10], memadr[9], memdata[9], memadr[8], memdata[8], memadr[7], 
      memdata[7], memadr[6], memdata[6], memadr[5], memdata[5], memadr[4], 
      memdata[4], memadr[3], memdata[3], memadr[2], memdata[2], memadr[1], 
      memdata[1], memadr[0], memdata[0]}), .data({data[31], byteen[3], 
      data[30], byteen[2], data[29], byteen[1], data[28], byteen[0], data[27], 
      adr[26], data[26], adr[25], data[25], adr[24], data[24], adr[23], 
      data[23], adr[22], data[22], adr[21], data[21], adr[20], data[20], 
      adr[19], data[19], adr[18], data[18], adr[17], data[17], adr[16], 
      data[16], adr[15], data[15], adr[14], data[14], adr[13], data[13], 
      adr[12], data[12], adr[11], data[11], adr[10], data[10], adr[9], data[9], 
      adr[8], data[8], adr[7], data[7], adr[6], data[6], adr[5], data[5], 
      adr[4], data[4], adr[3], data[3], adr[2], data[2], adr[1], data[1], 
      adr[0], data[0]}));
  muddlib07__and2_1x and2_2x_6(.a(work), .b(memen), .y(net_706));
  memsys_final__control_logic control__0(.done(done), .en(en), 
      .memdone(memdone), .memen(memen), .ph1(ph1), .ph2(ph2), .ptrs0(ptrs0), 
      .ptrs1(ptrs1), .ptrs2(ptrs2), .ptrs3(ptrs3), .resetb(resetb), 
      .writeptrs0(writeptrs0), .writeptrs1(writeptrs1), 
      .writeptrs2(writeptrs2), .writeptrs3(writeptrs3), .bufen0(bufen0), 
      .bufen1(bufen1), .bufen2(bufen2), .bufen3(bufen3), .endone(endone), 
      .work(work));
  memsys_final__decoderwb donedec(.decin(writeptr[1:0]), .dout({net_638[0], 
      net_638[1], net_638[2], net_638[3]}));
  memsys_final__fourmux fourmux_4(.d0(bufen0), .d1(bufen1), .d2(bufen2), 
      .d3(bufen3), .en({net_638[0], net_638[1], net_638[2], net_638[3]}), 
      .dout(memen));
  memsys_final__fourmux fourmux_5(.d0(bufen0), .d1(bufen1), .d2(bufen2), 
      .d3(bufen3), .en({net_639[0], net_639[1], net_639[2], net_639[3]}), 
      .dout(net_607));
  muddlib07__inv_1x inv_1x_2(.a(net_607), .y(done));
  muddlib07__inv_1x inv_1x_3(.a(endone), .y(net_762));
  muddlib07__inv_4x inv_4x_0(.a(reset), .y(resetb));
  muddlib07__flopenr_c_1x ptflp_1_(.d(net_579[0]), .en(endone), 
      .resetb(resetb), .q(ptr[1]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x ptflp_0_(.d(net_579[1]), .en(endone), 
      .resetb(resetb), .q(ptr[0]), .ph1(ph1), .ph2(ph2));
  memsys_final__decoder4out ptrdec(.decin(ptr[1:0]), .d({ptrs0}), 
      .d_1({ptrs1}), .d_2({ptrs2}), .d_3({ptrs3}));
  memsys_final__Incr2 ptrinc(.a(ptr[1:0]), .cout(ptrinc_cout), .y({net_579[0], 
      net_579[1]}));
  memsys_final__decoder4out writeptrdec(.decin(writeptr[1:0]), 
      .d({writeptrs0}), .d_1({writeptrs1}), .d_2({writeptrs2}), 
      .d_3({writeptrs3}));
  memsys_final__Incr2 writeptrinc(.a(writeptr[1:0]), .cout(writeptrinc_cout), 
      .y({net_555[0], net_555[1]}));
  memsys_final__decoderwb writeready(.decin(ptr[1:0]), .dout({net_639[0], 
      net_639[1], net_639[2], net_639[3]}));
  muddlib07__flopenr_c_1x wrtflp_1_(.d(net_555[0]), .en(net_706), 
      .resetb(resetb), .q(writeptr[1]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x wrtflp_0_(.d(net_555[1]), .en(net_706), 
      .resetb(resetb), .q(writeptr[0]), .ph1(ph1), .ph2(ph2));
endmodule   /* memsys_final__writebuffer */

module memsys_final__memsys(adrM, byteenM, memdone, memwriteM, pcF, ph1, ph2, 
      reF, reM, reset, swc, writedataM, dataackM, instrF, instrackF, memadr, 
      membyteen, memen, memrwb, readdataM, memdata);
  input [29:0] adrM;
  input [3:0] byteenM;
  input memdone;
  input memwriteM;
  input [31:2] pcF;
  input ph1;
  input ph2;
  input reF;
  input reM;
  input reset;
  input swc;
  input [31:0] writedataM;
  output dataackM;
  output [31:0] instrF;
  output instrackF;
  output [26:0] memadr;
  output [3:0] membyteen;
  output memen;
  output memrwb;
  output [31:0] readdataM;
  input [31:0] memdata;

  supply1 vdd;
  supply0 gnd;
  wire ddone, den, dmemdone, dmemen, dmemrwb, don, enM, idone, ien, imemdone;
  wire imemen, imemrwb, ion, memwriteMb, net_15, net_378, net_380, net_393;
  wire net_397, swc_imemrwbb, swcb, swcb_dmemrwbb, wbdone, wben, wbmemdone;
  wire wbmemen, wbon;
  wire [29:0] dadr;
  wire [3:0] dbyteen;
  wire [31:0] ddata;
  wire [3:0] dmembyteen;
  wire [31:0] dmemdata;
  wire [29:0] iadr;
  wire [3:0] ibyteen;
  wire [31:0] idata;
  wire [3:0] imembyteen;
  wire [31:0] imemdata;
  wire [1:0] state;
  wire [26:0] wbadr;
  wire [3:0] wbbyteen;
  wire [31:0] wbdata;
  wire [26:0] wbmemadr;
  wire [3:0] wbmembyteen;
  wire [31:0] wbmemdata;

  muddlib07__and2_1x and2_1x_0(.a(net_15), .b(memwriteM), .y(net_380));
  muddlib07__and2_1x and2_1x_1(.a(swc), .b(memwriteM), .y(net_378));
  muddlib07__and2_1x and2_1x_3(.a(dmemrwb), .b(don), .y(net_393));
  muddlib07__and2_1x and2_1x_4(.a(imemrwb), .b(ion), .y(net_397));
  memsys_final__blueblock bluebloc_0(.dmembyteen(dmembyteen[3:0]), 
      .dmemen(dmemen), .don(don), .memdone(memdone), 
      .swcb_dmemrwbb(swcb_dmemrwbb), .wbdone(wbdone), .dmemdone(dmemdone), 
      .wbbyteen(wbbyteen[3:0]), .wben(wben));
  memsys_final__datapath datapath_4(.adrM(adrM[29:0]), .byteenM(byteenM[3:0]), 
      .dmemrwb_don(net_393), .enM(enM), .imemrwb_ion(net_397), 
      .memwriteMb(memwriteMb), .pcF(pcF[31:2]), .reF(reF), .state(state[1:0]), 
      .swc(swc), .swc_imemrwbb(swc_imemrwbb), .swc_memwriteM(net_378), 
      .swcb_dmemrwbb(swcb_dmemrwbb), .swcb_memwriteM(net_380), 
      .wbmemadr(wbmemadr[26:0]), .wbmemdata(wbmemdata[31:0]), .wbon(wbon), 
      .writedataM(writedataM[31:0]), .dadr(dadr[29:0]), .dbyteen(dbyteen[3:0]), 
      .ddata(ddata[31:0]), .den(den), .drwb(dmemrwb), .iadr(iadr[29:0]), 
      .ibyteen(ibyteen[3:0]), .idata(idata[31:0]), .ien(ien), 
      .imemdata(imemdata[31:0]), .instrF(instrF[31:0]), .irwb(imemrwb), 
      .memadr(memadr[26:0]), .readdataM(readdataM[31:0]), .wbadr(wbadr[26:0]), 
      .wbdata(wbdata[31:0]), .dmemdata(dmemdata[31:0]), 
      .memdata(memdata[31:0]));
  memsys_final__dcache dcache_1(.adr(dadr[27:0]), .adr_1(dadr[29:29]), 
      .byteen(dbyteen[3:0]), .en(den), .memdone(dmemdone), .ph1(ph1), 
      .ph2(ph2), .reset(reset), .rwb(dmemrwb), .done(ddone), 
      .membyteen(dmembyteen[3:0]), .memen(dmemen), .data(ddata[31:0]), 
      .memdata(dmemdata[31:0]));
  memsys_final__cmux2_dp_1x donemux(.d0(ddone), .d1(idone), .s(swc), .sb(swcb), 
      .y0(dataackM), .y1(instrackF));
  memsys_final__greenblock greenblo_0(.imembyteen(imembyteen[3:0]), 
      .imemen(imemen), .ion(ion), .memdone(memdone), 
      .swc_imemrwbb(swc_imemrwbb), .wbdone(wbdone), .imemdone(imemdone), 
      .wbbyteen(wbbyteen[3:0]), .wben(wben));
  memsys_final__icache icache_1(.adr(iadr[27:0]), .adr_1(iadr[29:29]), 
      .byteen(ibyteen[3:0]), .en(ien), .memdone(imemdone), .ph1(ph1), 
      .ph2(ph2), .reset(reset), .rwb(imemrwb), .done(idone), 
      .membyteen(imembyteen[3:0]), .memen(imemen), .data(idata[31:0]), 
      .memdata(imemdata[31:0]));
  muddlib07__inv_1x inv_1x_0(.a(swc), .y(net_15));
  muddlib07__inv_4x inv_4x_2(.a(swc), .y(swcb));
  muddlib07__inv_4x inv_4x_3(.a(memwriteM), .y(memwriteMb));
  memsys_final__memsyscontroller memsysco_4(.dmemen(dmemen), .dmemrwb(dmemrwb), 
      .imemen(imemen), .imemrwb(imemrwb), .memdone(memdone), .reset(reset), 
      .swc(swc), .wbmemen(wbmemen), .don(don), .ion(ion), .memen(memen), 
      .state(state[1:0]), .wbon(wbon), .ph1(ph1), .ph2(ph2));
  muddlib07__or2_1x or2_1x_0(.a(reM), .b(memwriteM), .y(enM));
  memsys_final__orangeblock orangebl_0(.memdone(memdone), .state(state[1:0]), 
      .wbon(wbon), .memrwb(memrwb), .wbmemdone(wbmemdone));
  memsys_final__redblock redblock_0(.dmembyteen(dmembyteen[3:0]), 
      .dmemrwb(dmemrwb), .imembyteen(imembyteen[3:0]), .imemrwb(imemrwb), 
      .state(state[1:0]), .swc(swc), .wbmembyteen(wbmembyteen[3:0]), 
      .membyteen(membyteen[3:0]), .wben(wben));
  memsys_final__wb_tribuf_en wb_tribu_0(.dmemrwb(dmemrwb), .imemrwb(imemrwb), 
      .swc(swc), .swc_imemrwbb(swc_imemrwbb), .swcb_dmemrwbb(swcb_dmemrwbb));
  memsys_final__writebuffer writebuf_2(.adr(wbadr[26:0]), 
      .byteen(wbbyteen[3:0]), .data(wbdata[31:0]), .en(wben), 
      .memdone(wbmemdone), .ph1(ph1), .ph2(ph2), .reset(reset), .done(wbdone), 
      .memadr(wbmemadr[26:0]), .membyteen(wbmembyteen[3:0]), 
      .memdata(wbmemdata[31:0]), .memen(wbmemen));
endmodule   /* memsys_final__memsys */

module DatapathDone__inv_1x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  tranif1 nmos_0(gnd, y, a);
  tranif0 pmos_0(y, vdd, a);
endmodule   /* DatapathDone__inv_1x */

module DatapathDone__nor2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_9;

  tranif1 nmos_0(gnd, y, a);
  tranif1 nmos_1(gnd, y, b);
  tranif0 pmos_0(y, net_9, b);
  tranif0 pmos_1(net_9, vdd, a);
endmodule   /* DatapathDone__nor2_1x */

module DatapathDone__dec2(x0, x1, y);
  input x0;
  input x1;
  output [3:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_240, net_250;

  DatapathDone__inv_1x inv_1x_4(.a(x0), .y(net_240));
  DatapathDone__inv_1x inv_1x_5(.a(x1), .y(net_250));
  DatapathDone__nor2_1x nor2_1x_0(.a(x1), .b(x0), .y(y[0]));
  DatapathDone__nor2_1x nor2_1x_1(.a(x1), .b(net_240), .y(y[1]));
  DatapathDone__nor2_1x nor2_1x_2(.a(net_250), .b(x0), .y(y[2]));
  DatapathDone__nor2_1x nor2_1x_3(.a(net_250), .b(net_240), .y(y[3]));
endmodule   /* DatapathDone__dec2 */

module DatapathDone__inv_4x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  tranif1 nmos_0(gnd, y, a);
  tranif0 pmos_0(y, vdd, a);
endmodule   /* DatapathDone__inv_4x */

module DatapathDone__invbuf_4x(s, s_out, sb_out);
  input s;
  output s_out;
  output sb_out;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__inv_4x inv_4x_3(.a(s), .y(sb_out));
  DatapathDone__inv_4x inv_4x_4(.a(sb_out), .y(s_out));
endmodule   /* DatapathDone__invbuf_4x */

module DatapathDone__mux2_dp_1x(d0, d1, s, sb, y);
  input d0;
  input d1;
  input s;
  input sb;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_12, net_15, net_3, net_4, net_8;

  tranif1 nmos_0(gnd, net_3, d1);
  tranif1 nmos_1(gnd, net_4, d0);
  tranif1 nmos_2(net_3, net_8, s);
  tranif1 nmos_3(net_4, net_8, sb);
  tranif1 nmos_4(gnd, y, net_8);
  tranif0 pmos_0(net_8, net_15, sb);
  tranif0 pmos_1(net_15, vdd, d1);
  tranif0 pmos_2(net_8, net_12, s);
  tranif0 pmos_3(net_12, vdd, d0);
  tranif0 pmos_4(y, vdd, net_8);
endmodule   /* DatapathDone__mux2_dp_1x */

module DatapathDone__mux2_1x_4(d0, d1, s, y);
  input [3:0] d0;
  input [3:0] d1;
  input s;
  output [3:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_3, net_4;

  DatapathDone__invbuf_4x invbuf_4_0(.s(s), .s_out(net_3), .sb_out(net_4));
  DatapathDone__mux2_dp_1x mux2_3_(.d0(d0[3]), .d1(d1[3]), .s(net_3), 
      .sb(net_4), .y(y[3]));
  DatapathDone__mux2_dp_1x mux2_2_(.d0(d0[2]), .d1(d1[2]), .s(net_3), 
      .sb(net_4), .y(y[2]));
  DatapathDone__mux2_dp_1x mux2_1_(.d0(d0[1]), .d1(d1[1]), .s(net_3), 
      .sb(net_4), .y(y[1]));
  DatapathDone__mux2_dp_1x mux2_0_(.d0(d0[0]), .d1(d1[0]), .s(net_3), 
      .sb(net_4), .y(y[0]));
endmodule   /* DatapathDone__mux2_1x_4 */

module DatapathDone__mux2_1x_16(d0, d1, s, y);
  input [15:0] d0;
  input [15:0] d1;
  input s;
  input [15:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_3, net_4;

  DatapathDone__invbuf_4x invbuf_4_0(.s(s), .s_out(net_3), .sb_out(net_4));
  DatapathDone__mux2_dp_1x mux2_15_(.d0(d0[15]), .d1(d1[15]), .s(net_3), 
      .sb(net_4), .y(y[15]));
  DatapathDone__mux2_dp_1x mux2_14_(.d0(d0[14]), .d1(d1[14]), .s(net_3), 
      .sb(net_4), .y(y[14]));
  DatapathDone__mux2_dp_1x mux2_13_(.d0(d0[13]), .d1(d1[13]), .s(net_3), 
      .sb(net_4), .y(y[13]));
  DatapathDone__mux2_dp_1x mux2_12_(.d0(d0[12]), .d1(d1[12]), .s(net_3), 
      .sb(net_4), .y(y[12]));
  DatapathDone__mux2_dp_1x mux2_11_(.d0(d0[11]), .d1(d1[11]), .s(net_3), 
      .sb(net_4), .y(y[11]));
  DatapathDone__mux2_dp_1x mux2_10_(.d0(d0[10]), .d1(d1[10]), .s(net_3), 
      .sb(net_4), .y(y[10]));
  DatapathDone__mux2_dp_1x mux2_9_(.d0(d0[9]), .d1(d1[9]), .s(net_3), 
      .sb(net_4), .y(y[9]));
  DatapathDone__mux2_dp_1x mux2_8_(.d0(d0[8]), .d1(d1[8]), .s(net_3), 
      .sb(net_4), .y(y[8]));
  DatapathDone__mux2_dp_1x mux2_7_(.d0(d0[7]), .d1(d1[7]), .s(net_3), 
      .sb(net_4), .y(y[7]));
  DatapathDone__mux2_dp_1x mux2_6_(.d0(d0[6]), .d1(d1[6]), .s(net_3), 
      .sb(net_4), .y(y[6]));
  DatapathDone__mux2_dp_1x mux2_5_(.d0(d0[5]), .d1(d1[5]), .s(net_3), 
      .sb(net_4), .y(y[5]));
  DatapathDone__mux2_dp_1x mux2_4_(.d0(d0[4]), .d1(d1[4]), .s(net_3), 
      .sb(net_4), .y(y[4]));
  DatapathDone__mux2_dp_1x mux2_3_(.d0(d0[3]), .d1(d1[3]), .s(net_3), 
      .sb(net_4), .y(y[3]));
  DatapathDone__mux2_dp_1x mux2_2_(.d0(d0[2]), .d1(d1[2]), .s(net_3), 
      .sb(net_4), .y(y[2]));
  DatapathDone__mux2_dp_1x mux2_1_(.d0(d0[1]), .d1(d1[1]), .s(net_3), 
      .sb(net_4), .y(y[1]));
  DatapathDone__mux2_dp_1x mux2_0_(.d0(d0[0]), .d1(d1[0]), .s(net_3), 
      .sb(net_4), .y(y[0]));
endmodule   /* DatapathDone__mux2_1x_16 */

module DatapathDone__mux3_dp_1x(d0, d1, d2, s0, s0b, s1, s1b, y);
  input d0;
  input d1;
  input d2;
  input s0;
  input s0b;
  input s1;
  input s1b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_124, net_134, net_135, net_161, net_81, net_83, net_85, net_92;
  wire net_96;

  tranif1 nmos_8(net_92, net_83, s1);
  tranif1 nmos_9(gnd, y, net_83);
  tranif1 nmos_10(gnd, net_85, d0);
  tranif1 nmos_11(gnd, net_161, d1);
  tranif1 nmos_12(gnd, net_92, d2);
  tranif1 nmos_13(net_85, net_96, s0b);
  tranif1 nmos_14(net_161, net_96, s0);
  tranif1 nmos_15(net_96, net_83, s1b);
  tranif0 pmos_8(net_124, vdd, d2);
  tranif0 pmos_9(y, vdd, net_83);
  tranif0 pmos_10(net_83, net_81, s1);
  tranif0 pmos_11(net_83, net_124, s1b);
  tranif0 pmos_12(net_81, net_134, s0);
  tranif0 pmos_13(net_134, vdd, d0);
  tranif0 pmos_14(net_81, net_135, s0b);
  tranif0 pmos_15(net_135, vdd, d1);
endmodule   /* DatapathDone__mux3_dp_1x */

module DatapathDone__mux3_4(d0, d1, d2, s0, s0b, s1, s1b, y);
  input [3:0] d0;
  input [3:0] d1;
  input [3:0] d2;
  input s0;
  input s0b;
  input s1;
  input s1b;
  output [3:0] y;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__mux3_dp_1x mux3_3_(.d0(d0[3]), .d1(d1[3]), .d2(d2[3]), .s0(s0), 
      .s0b(s0b), .s1(s1), .s1b(s1b), .y(y[3]));
  DatapathDone__mux3_dp_1x mux3_2_(.d0(d0[2]), .d1(d1[2]), .d2(d2[2]), .s0(s0), 
      .s0b(s0b), .s1(s1), .s1b(s1b), .y(y[2]));
  DatapathDone__mux3_dp_1x mux3_1_(.d0(d0[1]), .d1(d1[1]), .d2(d2[1]), .s0(s0), 
      .s0b(s0b), .s1(s1), .s1b(s1b), .y(y[1]));
  DatapathDone__mux3_dp_1x mux3_0_(.d0(d0[0]), .d1(d1[0]), .d2(d2[0]), .s0(s0), 
      .s0b(s0b), .s1(s1), .s1b(s1b), .y(y[0]));
endmodule   /* DatapathDone__mux3_4 */

module DatapathDone__mux3_dp_1x_32(d0, d1, d2, s0, s1, y);
  input [31:0] d0;
  input [31:0] d1;
  input [31:0] d2;
  input s0;
  input s1;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_42, net_48, net_49, net_53;

  DatapathDone__invbuf_4x invbuf_4_0(.s(s0), .s_out(net_42), .sb_out(net_53));
  DatapathDone__invbuf_4x invbuf_4_1(.s(s1), .s_out(net_48), .sb_out(net_49));
  DatapathDone__mux3_dp_1x mux3_dp_1x_31_(.d0(d0[31]), .d1(d1[31]), 
      .d2(d2[31]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[31]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_30_(.d0(d0[30]), .d1(d1[30]), 
      .d2(d2[30]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[30]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_29_(.d0(d0[29]), .d1(d1[29]), 
      .d2(d2[29]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[29]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_28_(.d0(d0[28]), .d1(d1[28]), 
      .d2(d2[28]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[28]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_27_(.d0(d0[27]), .d1(d1[27]), 
      .d2(d2[27]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[27]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_26_(.d0(d0[26]), .d1(d1[26]), 
      .d2(d2[26]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[26]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_25_(.d0(d0[25]), .d1(d1[25]), 
      .d2(d2[25]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[25]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_24_(.d0(d0[24]), .d1(d1[24]), 
      .d2(d2[24]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[24]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_23_(.d0(d0[23]), .d1(d1[23]), 
      .d2(d2[23]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[23]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_22_(.d0(d0[22]), .d1(d1[22]), 
      .d2(d2[22]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[22]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_21_(.d0(d0[21]), .d1(d1[21]), 
      .d2(d2[21]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[21]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_20_(.d0(d0[20]), .d1(d1[20]), 
      .d2(d2[20]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[20]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_19_(.d0(d0[19]), .d1(d1[19]), 
      .d2(d2[19]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[19]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_18_(.d0(d0[18]), .d1(d1[18]), 
      .d2(d2[18]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[18]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_17_(.d0(d0[17]), .d1(d1[17]), 
      .d2(d2[17]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[17]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_16_(.d0(d0[16]), .d1(d1[16]), 
      .d2(d2[16]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[16]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_15_(.d0(d0[15]), .d1(d1[15]), 
      .d2(d2[15]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[15]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_14_(.d0(d0[14]), .d1(d1[14]), 
      .d2(d2[14]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[14]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_13_(.d0(d0[13]), .d1(d1[13]), 
      .d2(d2[13]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[13]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_12_(.d0(d0[12]), .d1(d1[12]), 
      .d2(d2[12]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[12]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_11_(.d0(d0[11]), .d1(d1[11]), 
      .d2(d2[11]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[11]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_10_(.d0(d0[10]), .d1(d1[10]), 
      .d2(d2[10]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[10]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_9_(.d0(d0[9]), .d1(d1[9]), .d2(d2[9]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[9]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_8_(.d0(d0[8]), .d1(d1[8]), .d2(d2[8]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[8]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_7_(.d0(d0[7]), .d1(d1[7]), .d2(d2[7]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[7]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_6_(.d0(d0[6]), .d1(d1[6]), .d2(d2[6]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[6]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_5_(.d0(d0[5]), .d1(d1[5]), .d2(d2[5]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[5]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_4_(.d0(d0[4]), .d1(d1[4]), .d2(d2[4]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[4]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_3_(.d0(d0[3]), .d1(d1[3]), .d2(d2[3]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[3]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_2_(.d0(d0[2]), .d1(d1[2]), .d2(d2[2]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[2]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_1_(.d0(d0[1]), .d1(d1[1]), .d2(d2[1]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[1]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_0_(.d0(d0[0]), .d1(d1[0]), .d2(d2[0]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[0]));
endmodule   /* DatapathDone__mux3_dp_1x_32 */

module DatapathDone__mux3_dp_1x_32_special(d0, d1, d2, s0, s1, s0_out, s0b_out, 
      s1_out, s1b_out, y);
  input [31:0] d0;
  input [31:0] d1;
  input [31:0] d2;
  input s0;
  input s1;
  output s0_out;
  output s0b_out;
  output s1_out;
  output s1b_out;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__invbuf_4x invbuf_4_0(.s(s0), .s_out(s0_out), 
      .sb_out(s0b_out));
  DatapathDone__invbuf_4x invbuf_4_1(.s(s1), .s_out(s1_out), 
      .sb_out(s1b_out));
  DatapathDone__mux3_dp_1x mux3_31_(.d0(d0[31]), .d1(d1[31]), .d2(d2[31]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[31]));
  DatapathDone__mux3_dp_1x mux3_30_(.d0(d0[30]), .d1(d1[30]), .d2(d2[30]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[30]));
  DatapathDone__mux3_dp_1x mux3_29_(.d0(d0[29]), .d1(d1[29]), .d2(d2[29]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[29]));
  DatapathDone__mux3_dp_1x mux3_28_(.d0(d0[28]), .d1(d1[28]), .d2(d2[28]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[28]));
  DatapathDone__mux3_dp_1x mux3_27_(.d0(d0[27]), .d1(d1[27]), .d2(d2[27]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[27]));
  DatapathDone__mux3_dp_1x mux3_26_(.d0(d0[26]), .d1(d1[26]), .d2(d2[26]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[26]));
  DatapathDone__mux3_dp_1x mux3_25_(.d0(d0[25]), .d1(d1[25]), .d2(d2[25]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[25]));
  DatapathDone__mux3_dp_1x mux3_24_(.d0(d0[24]), .d1(d1[24]), .d2(d2[24]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[24]));
  DatapathDone__mux3_dp_1x mux3_23_(.d0(d0[23]), .d1(d1[23]), .d2(d2[23]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[23]));
  DatapathDone__mux3_dp_1x mux3_22_(.d0(d0[22]), .d1(d1[22]), .d2(d2[22]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[22]));
  DatapathDone__mux3_dp_1x mux3_21_(.d0(d0[21]), .d1(d1[21]), .d2(d2[21]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[21]));
  DatapathDone__mux3_dp_1x mux3_20_(.d0(d0[20]), .d1(d1[20]), .d2(d2[20]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[20]));
  DatapathDone__mux3_dp_1x mux3_19_(.d0(d0[19]), .d1(d1[19]), .d2(d2[19]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[19]));
  DatapathDone__mux3_dp_1x mux3_18_(.d0(d0[18]), .d1(d1[18]), .d2(d2[18]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[18]));
  DatapathDone__mux3_dp_1x mux3_17_(.d0(d0[17]), .d1(d1[17]), .d2(d2[17]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[17]));
  DatapathDone__mux3_dp_1x mux3_16_(.d0(d0[16]), .d1(d1[16]), .d2(d2[16]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[16]));
  DatapathDone__mux3_dp_1x mux3_15_(.d0(d0[15]), .d1(d1[15]), .d2(d2[15]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[15]));
  DatapathDone__mux3_dp_1x mux3_14_(.d0(d0[14]), .d1(d1[14]), .d2(d2[14]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[14]));
  DatapathDone__mux3_dp_1x mux3_13_(.d0(d0[13]), .d1(d1[13]), .d2(d2[13]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[13]));
  DatapathDone__mux3_dp_1x mux3_12_(.d0(d0[12]), .d1(d1[12]), .d2(d2[12]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[12]));
  DatapathDone__mux3_dp_1x mux3_11_(.d0(d0[11]), .d1(d1[11]), .d2(d2[11]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[11]));
  DatapathDone__mux3_dp_1x mux3_10_(.d0(d0[10]), .d1(d1[10]), .d2(d2[10]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[10]));
  DatapathDone__mux3_dp_1x mux3_9_(.d0(d0[9]), .d1(d1[9]), .d2(d2[9]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[9]));
  DatapathDone__mux3_dp_1x mux3_8_(.d0(d0[8]), .d1(d1[8]), .d2(d2[8]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[8]));
  DatapathDone__mux3_dp_1x mux3_7_(.d0(d0[7]), .d1(d1[7]), .d2(d2[7]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[7]));
  DatapathDone__mux3_dp_1x mux3_6_(.d0(d0[6]), .d1(d1[6]), .d2(d2[6]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[6]));
  DatapathDone__mux3_dp_1x mux3_5_(.d0(d0[5]), .d1(d1[5]), .d2(d2[5]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[5]));
  DatapathDone__mux3_dp_1x mux3_4_(.d0(d0[4]), .d1(d1[4]), .d2(d2[4]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[4]));
  DatapathDone__mux3_dp_1x mux3_3_(.d0(d0[3]), .d1(d1[3]), .d2(d2[3]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[3]));
  DatapathDone__mux3_dp_1x mux3_2_(.d0(d0[2]), .d1(d1[2]), .d2(d2[2]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[2]));
  DatapathDone__mux3_dp_1x mux3_1_(.d0(d0[1]), .d1(d1[1]), .d2(d2[1]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[1]));
  DatapathDone__mux3_dp_1x mux3_0_(.d0(d0[0]), .d1(d1[0]), .d2(d2[0]), 
      .s0(s0_out), .s0b(s0b_out), .s1(s1_out), .s1b(s1b_out), .y(y[0]));
endmodule   /* DatapathDone__mux3_dp_1x_32_special */

module DatapathDone__mux4_dp_1x(d0, d1, d2, d3, s0, s0b, s1, s1b, y);
  input d0;
  input d1;
  input d2;
  input d3;
  input s0;
  input s0b;
  input s1;
  input s1b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_28, net_29, net_30, net_5, net_50, net_51, net_56, net_57, net_58;
  wire net_6, net_68, net_70, net_8;

  tranif1 nmos_0(gnd, net_5, d0);
  tranif1 nmos_1(gnd, net_6, d1);
  tranif1 nmos_3(net_5, net_8, s0b);
  tranif1 nmos_4(net_6, net_8, s0);
  tranif1 nmos_5(net_8, net_50, s1b);
  tranif1 nmos_7(gnd, net_70, d3);
  tranif1 nmos_8(net_68, net_51, s0b);
  tranif1 nmos_9(net_70, net_51, s0);
  tranif1 nmos_10(net_51, net_50, s1);
  tranif1 nmos_11(gnd, net_68, d2);
  tranif1 nmos_12(gnd, y, net_50);
  tranif0 pmos_0(net_50, net_30, s1);
  tranif0 pmos_2(net_30, net_28, s0);
  tranif0 pmos_3(net_28, vdd, d0);
  tranif0 pmos_4(net_30, net_29, s0b);
  tranif0 pmos_5(net_29, vdd, d1);
  tranif0 pmos_7(net_58, net_56, s0);
  tranif0 pmos_8(net_56, vdd, d2);
  tranif0 pmos_9(net_58, net_57, s0b);
  tranif0 pmos_10(net_57, vdd, d3);
  tranif0 pmos_11(net_50, net_58, s1b);
  tranif0 pmos_12(y, vdd, net_50);
endmodule   /* DatapathDone__mux4_dp_1x */

module DatapathDone__mux4_8(d0, d1, d2, d3, s0, s1, y);
  input [7:0] d0;
  input [7:0] d1;
  input [7:0] d2;
  input [7:0] d3;
  input s0;
  input s1;
  output [7:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_11, net_14, net_17, net_9;

  DatapathDone__invbuf_4x invbuf_4_0(.s(s0), .s_out(net_9), .sb_out(net_11));
  DatapathDone__invbuf_4x invbuf_4_1(.s(s1), .s_out(net_17), .sb_out(net_14));
  DatapathDone__mux4_dp_1x mux4_7_(.d0(d0[7]), .d1(d1[7]), .d2(d2[7]), 
      .d3(d3[7]), .s0(net_9), .s0b(net_11), .s1(net_17), .s1b(net_14), 
      .y(y[7]));
  DatapathDone__mux4_dp_1x mux4_6_(.d0(d0[6]), .d1(d1[6]), .d2(d2[6]), 
      .d3(d3[6]), .s0(net_9), .s0b(net_11), .s1(net_17), .s1b(net_14), 
      .y(y[6]));
  DatapathDone__mux4_dp_1x mux4_5_(.d0(d0[5]), .d1(d1[5]), .d2(d2[5]), 
      .d3(d3[5]), .s0(net_9), .s0b(net_11), .s1(net_17), .s1b(net_14), 
      .y(y[5]));
  DatapathDone__mux4_dp_1x mux4_4_(.d0(d0[4]), .d1(d1[4]), .d2(d2[4]), 
      .d3(d3[4]), .s0(net_9), .s0b(net_11), .s1(net_17), .s1b(net_14), 
      .y(y[4]));
  DatapathDone__mux4_dp_1x mux4_3_(.d0(d0[3]), .d1(d1[3]), .d2(d2[3]), 
      .d3(d3[3]), .s0(net_9), .s0b(net_11), .s1(net_17), .s1b(net_14), 
      .y(y[3]));
  DatapathDone__mux4_dp_1x mux4_2_(.d0(d0[2]), .d1(d1[2]), .d2(d2[2]), 
      .d3(d3[2]), .s0(net_9), .s0b(net_11), .s1(net_17), .s1b(net_14), 
      .y(y[2]));
  DatapathDone__mux4_dp_1x mux4_1_(.d0(d0[1]), .d1(d1[1]), .d2(d2[1]), 
      .d3(d3[1]), .s0(net_9), .s0b(net_11), .s1(net_17), .s1b(net_14), 
      .y(y[1]));
  DatapathDone__mux4_dp_1x mux4_0_(.d0(d0[0]), .d1(d1[0]), .d2(d2[0]), 
      .d3(d3[0]), .s0(net_9), .s0b(net_11), .s1(net_17), .s1b(net_14), 
      .y(y[0]));
endmodule   /* DatapathDone__mux4_8 */

module DatapathDone__and2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_1, net_2;

  tranif1 nmos_0(net_1, net_2, b);
  tranif1 nmos_1(gnd, net_1, a);
  tranif1 nmos_2(gnd, y, net_2);
  tranif0 pmos_0(net_2, vdd, b);
  tranif0 pmos_1(net_2, vdd, a);
  tranif0 pmos_2(y, vdd, net_2);
endmodule   /* DatapathDone__and2_1x */

module DatapathDone__buf_6x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_85;

  tranif1 nmos_1(gnd, y, net_85);
  tranif1 nmos_2(gnd, net_85, a);
  tranif1 nmos_3(gnd, y, net_85);
  tranif0 pmos_1(y, vdd, net_85);
  tranif0 pmos_2(net_85, vdd, a);
  tranif0 pmos_3(y, vdd, net_85);
endmodule   /* DatapathDone__buf_6x */

module DatapathDone__signext_8_32(a, enable, extension);
  input [7:7] a;
  input enable;
  output extension;

  supply1 vdd;
  supply0 gnd;
  wire net_56;

  DatapathDone__and2_1x and2_1x_0(.a(a[7]), .b(enable), .y(net_56));
  DatapathDone__buf_6x buf_6x_0(.a(net_56), .y(extension));
endmodule   /* DatapathDone__signext_8_32 */

module DatapathDone__buf_4x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_23;

  tranif1 nmos_0(gnd, net_23, a);
  tranif1 nmos_1(gnd, y, net_23);
  tranif0 pmos_0(net_23, vdd, a);
  tranif0 pmos_1(y, vdd, net_23);
endmodule   /* DatapathDone__buf_4x */

module DatapathDone__signext_16_32(a, enable, extension);
  input [15:15] a;
  input enable;
  output extension;

  supply1 vdd;
  supply0 gnd;
  wire net_220;

  DatapathDone__and2_1x and2_1x_1(.a(a[15]), .b(enable), .y(net_220));
  DatapathDone__buf_4x buf_4x_2(.a(net_220), .y(extension));
endmodule   /* DatapathDone__signext_16_32 */

module DatapathDone__xor2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire ab, bb, net_3, net_4, net_7, net_8;

  tranif1 nmos_0(gnd, net_3, a);
  tranif1 nmos_1(gnd, net_4, ab);
  tranif1 nmos_2(net_3, y, b);
  tranif1 nmos_3(net_4, y, bb);
  tranif1 nmos_4(gnd, bb, b);
  tranif1 nmos_5(gnd, ab, a);
  tranif0 pmos_0(y, net_7, b);
  tranif0 pmos_1(net_7, vdd, ab);
  tranif0 pmos_2(y, net_8, bb);
  tranif0 pmos_3(net_8, vdd, a);
  tranif0 pmos_4(bb, vdd, b);
  tranif0 pmos_5(ab, vdd, a);
endmodule   /* DatapathDone__xor2_1x */

module DatapathDone__memorystage(aluoutM, byteM, halfwordM, loadsignedM, re, 
      readdataM, writedataM, byteenM, readdata2M, writedata2M);
  input [1:0] aluoutM;
  input byteM;
  input halfwordM;
  input loadsignedM;
  input re;
  input [31:0] readdataM;
  input [31:0] writedataM;
  output [3:0] byteenM;
  output [31:0] readdata2M;
  output [31:0] writedata2M;

  supply1 vdd;
  supply0 gnd;
  wire net_634, net_640, net_642, net_645;
  wire [1:0] aluoutreM;
  wire [3:0] bytebyteenM;
  wire [3:0] halfwordbyteenM;
  wire [8:0] rbyteM;
  wire [16:0] rhalfwordM;

  DatapathDone__dec2 dec2_0(.x0(aluoutreM[0]), .x1(aluoutreM[1]), 
      .y(bytebyteenM[3:0]));
  DatapathDone__mux2_1x_4 mux2_1x__0(.d0({gnd, gnd, vdd, vdd}), .d1({vdd, vdd, 
      gnd, gnd}), .s(aluoutreM[1]), .y(halfwordbyteenM[3:0]));
  DatapathDone__mux2_1x_16 mux2_1x__1(.d0(readdataM[15:0]), 
      .d1(readdataM[31:16]), .s(aluoutreM[1]), .y(rhalfwordM[15:0]));
  DatapathDone__mux3_4 mux3_4_0(.d0({vdd, vdd, vdd, vdd}), 
      .d1(halfwordbyteenM[3:0]), .d2(bytebyteenM[3:0]), .s0(net_634), 
      .s0b(net_642), .s1(net_645), .s1b(net_640), .y(byteenM[3:0]));
  DatapathDone__mux3_dp_1x_32 mux3_dp__1(.d0(writedataM[31:0]), 
      .d1({writedataM[15], writedataM[14], writedataM[13], writedataM[12], 
      writedataM[11], writedataM[10], writedataM[9], writedataM[8], 
      writedataM[7], writedataM[6], writedataM[5], writedataM[4], 
      writedataM[3], writedataM[2], writedataM[1], writedataM[0], 
      writedataM[15], writedataM[14], writedataM[13], writedataM[12], 
      writedataM[11], writedataM[10], writedataM[9], writedataM[8], 
      writedataM[7], writedataM[6], writedataM[5], writedataM[4], 
      writedataM[3], writedataM[2], writedataM[1], writedataM[0]}), 
      .d2({writedataM[7], writedataM[6], writedataM[5], writedataM[4], 
      writedataM[3], writedataM[2], writedataM[1], writedataM[0], 
      writedataM[7], writedataM[6], writedataM[5], writedataM[4], 
      writedataM[3], writedataM[2], writedataM[1], writedataM[0], 
      writedataM[7], writedataM[6], writedataM[5], writedataM[4], 
      writedataM[3], writedataM[2], writedataM[1], writedataM[0], 
      writedataM[7], writedataM[6], writedataM[5], writedataM[4], 
      writedataM[3], writedataM[2], writedataM[1], writedataM[0]}), 
      .s0(halfwordM), .s1(byteM), .y(writedata2M[31:0]));
  DatapathDone__mux3_dp_1x_32_special mux3i_dp_0(.d0(readdataM[31:0]), 
      .d1({rhalfwordM[16], rhalfwordM[16], rhalfwordM[16], rhalfwordM[16], 
      rhalfwordM[16], rhalfwordM[16], rhalfwordM[16], rhalfwordM[16], 
      rhalfwordM[16], rhalfwordM[16], rhalfwordM[16], rhalfwordM[16], 
      rhalfwordM[16], rhalfwordM[16], rhalfwordM[16], rhalfwordM[16], 
      rhalfwordM[15], rhalfwordM[14], rhalfwordM[13], rhalfwordM[12], 
      rhalfwordM[11], rhalfwordM[10], rhalfwordM[9], rhalfwordM[8], 
      rhalfwordM[7], rhalfwordM[6], rhalfwordM[5], rhalfwordM[4], 
      rhalfwordM[3], rhalfwordM[2], rhalfwordM[1], rhalfwordM[0]}), 
      .d2({rbyteM[8], rbyteM[8], rbyteM[8], rbyteM[8], rbyteM[8], rbyteM[8], 
      rbyteM[8], rbyteM[8], rbyteM[8], rbyteM[8], rbyteM[8], rbyteM[8], 
      rbyteM[8], rbyteM[8], rbyteM[8], rbyteM[8], rbyteM[8], rbyteM[8], 
      rbyteM[8], rbyteM[8], rbyteM[8], rbyteM[8], rbyteM[8], rbyteM[8], 
      rbyteM[7], rbyteM[6], rbyteM[5], rbyteM[4], rbyteM[3], rbyteM[2], 
      rbyteM[1], rbyteM[0]}), .s0(halfwordM), .s1(byteM), .s0_out(net_634), 
      .s0b_out(net_642), .s1_out(net_645), .s1b_out(net_640), 
      .y(readdata2M[31:0]));
  DatapathDone__mux4_8 mux4_8_0(.d0(readdataM[7:0]), .d1(readdataM[15:8]), 
      .d2(readdataM[23:16]), .d3(readdataM[31:24]), .s0(aluoutreM[0]), 
      .s1(aluoutreM[1]), .y(rbyteM[7:0]));
  DatapathDone__signext_8_32 signext__0(.a(rbyteM[7:7]), .enable(loadsignedM), 
      .extension(rbyteM[8]));
  DatapathDone__signext_16_32 signext__1(.a(rhalfwordM[15:15]), 
      .enable(loadsignedM), .extension(rhalfwordM[16]));
  DatapathDone__xor2_1x xor2_1_(.a(aluoutM[1]), .b(re), .y(aluoutreM[1]));
  DatapathDone__xor2_1x xor2_0_(.a(aluoutM[0]), .b(re), .y(aluoutreM[0]));
endmodule   /* DatapathDone__memorystage */

module DatapathDone__mux2_dp_1x_32(d0, d1, s, y);
  input [31:0] d0;
  input [31:0] d1;
  input s;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_27, net_29;

  DatapathDone__invbuf_4x invbuf_4_0(.s(s), .s_out(net_29), .sb_out(net_27));
  DatapathDone__mux2_dp_1x mux2_1x_dp_31_(.d0(d0[31]), .d1(d1[31]), .s(net_29), 
      .sb(net_27), .y(y[31]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_30_(.d0(d0[30]), .d1(d1[30]), .s(net_29), 
      .sb(net_27), .y(y[30]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_29_(.d0(d0[29]), .d1(d1[29]), .s(net_29), 
      .sb(net_27), .y(y[29]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_28_(.d0(d0[28]), .d1(d1[28]), .s(net_29), 
      .sb(net_27), .y(y[28]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_27_(.d0(d0[27]), .d1(d1[27]), .s(net_29), 
      .sb(net_27), .y(y[27]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_26_(.d0(d0[26]), .d1(d1[26]), .s(net_29), 
      .sb(net_27), .y(y[26]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_25_(.d0(d0[25]), .d1(d1[25]), .s(net_29), 
      .sb(net_27), .y(y[25]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_24_(.d0(d0[24]), .d1(d1[24]), .s(net_29), 
      .sb(net_27), .y(y[24]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_23_(.d0(d0[23]), .d1(d1[23]), .s(net_29), 
      .sb(net_27), .y(y[23]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_22_(.d0(d0[22]), .d1(d1[22]), .s(net_29), 
      .sb(net_27), .y(y[22]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_21_(.d0(d0[21]), .d1(d1[21]), .s(net_29), 
      .sb(net_27), .y(y[21]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_20_(.d0(d0[20]), .d1(d1[20]), .s(net_29), 
      .sb(net_27), .y(y[20]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_19_(.d0(d0[19]), .d1(d1[19]), .s(net_29), 
      .sb(net_27), .y(y[19]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_18_(.d0(d0[18]), .d1(d1[18]), .s(net_29), 
      .sb(net_27), .y(y[18]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_17_(.d0(d0[17]), .d1(d1[17]), .s(net_29), 
      .sb(net_27), .y(y[17]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_16_(.d0(d0[16]), .d1(d1[16]), .s(net_29), 
      .sb(net_27), .y(y[16]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_15_(.d0(d0[15]), .d1(d1[15]), .s(net_29), 
      .sb(net_27), .y(y[15]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_14_(.d0(d0[14]), .d1(d1[14]), .s(net_29), 
      .sb(net_27), .y(y[14]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_13_(.d0(d0[13]), .d1(d1[13]), .s(net_29), 
      .sb(net_27), .y(y[13]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_12_(.d0(d0[12]), .d1(d1[12]), .s(net_29), 
      .sb(net_27), .y(y[12]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_11_(.d0(d0[11]), .d1(d1[11]), .s(net_29), 
      .sb(net_27), .y(y[11]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_10_(.d0(d0[10]), .d1(d1[10]), .s(net_29), 
      .sb(net_27), .y(y[10]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_9_(.d0(d0[9]), .d1(d1[9]), .s(net_29), 
      .sb(net_27), .y(y[9]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_8_(.d0(d0[8]), .d1(d1[8]), .s(net_29), 
      .sb(net_27), .y(y[8]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_7_(.d0(d0[7]), .d1(d1[7]), .s(net_29), 
      .sb(net_27), .y(y[7]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_6_(.d0(d0[6]), .d1(d1[6]), .s(net_29), 
      .sb(net_27), .y(y[6]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_5_(.d0(d0[5]), .d1(d1[5]), .s(net_29), 
      .sb(net_27), .y(y[5]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_4_(.d0(d0[4]), .d1(d1[4]), .s(net_29), 
      .sb(net_27), .y(y[4]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_3_(.d0(d0[3]), .d1(d1[3]), .s(net_29), 
      .sb(net_27), .y(y[3]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_2_(.d0(d0[2]), .d1(d1[2]), .s(net_29), 
      .sb(net_27), .y(y[2]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_1_(.d0(d0[1]), .d1(d1[1]), .s(net_29), 
      .sb(net_27), .y(y[1]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_0_(.d0(d0[0]), .d1(d1[0]), .s(net_29), 
      .sb(net_27), .y(y[0]));
endmodule   /* DatapathDone__mux2_dp_1x_32 */

module DatapathDone__clkinvbuf_4x(ph, phb, phbuf);
  input ph;
  output phb;
  output phbuf;

  supply1 vdd;
  supply0 gnd;
  wire notph;

  tranif1 nmos_0(gnd, phb, ph);
  tranif1 nmos_1(gnd, notph, ph);
  tranif1 nmos_2(gnd, phbuf, notph);
  tranif0 pmos_0(phb, vdd, ph);
  tranif0 pmos_1(notph, vdd, ph);
  tranif0 pmos_2(phbuf, vdd, notph);
endmodule   /* DatapathDone__clkinvbuf_4x */

module DatapathDone__clkinvbufdual_4x(ph1b, ph1buf, ph2b, ph2buf, ph1, ph2);
  output ph1b;
  output ph1buf;
  output ph2b;
  output ph2buf;
  input ph1;
  input ph2;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__clkinvbuf_4x clkinvbu_1(.ph(ph1), .phb(ph1b), .phbuf(ph1buf));
  DatapathDone__clkinvbuf_4x clkinvbu_2(.ph(ph2), .phb(ph2b), .phbuf(ph2buf));
endmodule   /* DatapathDone__clkinvbufdual_4x */

module DatapathDone__flopenr_dp_1x(d, en, enb, resetb, q, ph1, ph1b, ph2, 
      ph2b);
  input d;
  input en;
  input enb;
  input resetb;
  output q;
  input ph1;
  input ph1b;
  input ph2;
  input ph2b;

  supply1 vdd;
  supply0 gnd;
  wire master, masterinb, n1, n2, n3, n4, n5, n6, n7, n8, n9, slaveb;
  trireg masterb, slave;

  tranif1 nmos_2(masterinb, masterb, ph2);
  tranif1 nmos_3(gnd, master, masterb);
  rtranif1 nmos_4(master, slave, ph1);
  tranif1 nmos_5(n6, masterb, ph2b);
  tranif1 nmos_6(gnd, n6, master);
  tranif1 nmos_7(gnd, n8, slaveb);
  tranif1 nmos_8(gnd, slaveb, slave);
  tranif1 nmos_10(n8, slave, ph1b);
  tranif1 nmos_11(gnd, q, slaveb);
  tranif1 nmos_16(n1, n2, en);
  tranif1 nmos_17(gnd, n1, resetb);
  tranif1 nmos_18(n3, n1, enb);
  tranif1 nmos_19(n2, masterinb, d);
  tranif1 nmos_20(masterinb, n3, slave);
  tranif0 pmos_2(masterb, masterinb, ph2b);
  tranif0 pmos_3(master, vdd, masterb);
  rtranif0 pmos_4(slave, master, ph1b);
  tranif0 pmos_5(masterb, n7, ph2);
  tranif0 pmos_6(n7, vdd, master);
  tranif0 pmos_7(n9, vdd, slaveb);
  tranif0 pmos_8(slaveb, vdd, slave);
  tranif0 pmos_10(slave, n9, ph1);
  tranif0 pmos_11(q, vdd, slaveb);
  tranif0 pmos_16(masterinb, n4, d);
  tranif0 pmos_17(n4, vdd, enb);
  tranif0 pmos_18(masterinb, vdd, resetb);
  tranif0 pmos_19(n5, masterinb, slave);
  tranif0 pmos_20(vdd, n5, en);
endmodule   /* DatapathDone__flopenr_dp_1x */

module DatapathDone__flopenr_32(d, en, ph1, ph2, reset, q);
  input [31:0] d;
  input en;
  input ph1;
  input ph2;
  input reset;
  output [31:0] q;

  supply1 vdd;
  supply0 gnd;
  wire net_10, net_11, net_12, net_13, net_16, net_2, net_6;

  DatapathDone__clkinvbufdual_4x clkinvbu_0(.ph1b(net_13), .ph1buf(net_12), 
      .ph2b(net_11), .ph2buf(net_10), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopenr_dp_1x flopenr_32_31_(.d(d[31]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[31]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_30_(.d(d[30]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[30]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_29_(.d(d[29]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[29]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_28_(.d(d[28]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[28]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_27_(.d(d[27]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[27]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_26_(.d(d[26]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[26]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_25_(.d(d[25]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[25]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_24_(.d(d[24]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[24]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_23_(.d(d[23]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[23]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_22_(.d(d[22]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[22]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_21_(.d(d[21]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[21]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_20_(.d(d[20]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[20]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_19_(.d(d[19]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[19]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_18_(.d(d[18]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[18]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_17_(.d(d[17]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[17]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_16_(.d(d[16]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[16]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_15_(.d(d[15]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[15]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_14_(.d(d[14]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[14]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_13_(.d(d[13]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[13]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_12_(.d(d[12]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[12]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_11_(.d(d[11]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[11]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_10_(.d(d[10]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[10]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_9_(.d(d[9]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[9]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_8_(.d(d[8]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[8]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_7_(.d(d[7]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[7]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_6_(.d(d[6]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[6]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_5_(.d(d[5]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[5]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_4_(.d(d[4]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[4]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_3_(.d(d[3]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[3]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_2_(.d(d[2]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[2]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_1_(.d(d[1]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[1]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_0_(.d(d[0]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[0]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__inv_4x inv_4x_0(.a(reset), .y(net_6));
  DatapathDone__invbuf_4x invbuf_4_0(.s(en), .s_out(net_16), .sb_out(net_2));
endmodule   /* DatapathDone__flopenr_32 */

module DatapathDone__Memory_Writeback(aluoutM, byteM, halfwordM, loadsignedM, 
      memtoregW, ph1, ph2, re, readdataM, reset, stallW, writedataM, byteenM, 
      resultW, writedata2M, writedataW);
  input [31:0] aluoutM;
  input byteM;
  input halfwordM;
  input loadsignedM;
  input memtoregW;
  input ph1;
  input ph2;
  input re;
  input [31:0] readdataM;
  input reset;
  input stallW;
  input [31:0] writedataM;
  output [3:0] byteenM;
  output [31:0] resultW;
  output [31:0] writedata2M;
  output [31:0] writedataW;

  supply1 vdd;
  supply0 gnd;
  wire net_163;
  wire [31:0] aluoutW;
  wire [31:0] readdata2M;
  wire [31:0] readdataW;

  DatapathDone__inv_1x inv_1x_1(.a(stallW), .y(net_163));
  DatapathDone__memorystage memoryst_1(.aluoutM(aluoutM[1:0]), .byteM(byteM), 
      .halfwordM(halfwordM), .loadsignedM(loadsignedM), .re(re), 
      .readdataM(readdataM[31:0]), .writedataM(writedataM[31:0]), 
      .byteenM(byteenM[3:0]), .readdata2M(readdata2M[31:0]), 
      .writedata2M(writedata2M[31:0]));
  DatapathDone__mux2_dp_1x_32 mux2_dp__0(.d0(aluoutW[31:0]), 
      .d1(readdataW[31:0]), .s(memtoregW), .y(resultW[31:0]));
  DatapathDone__flopenr_32 r1w(.d(aluoutM[31:0]), .en(net_163), .ph1(ph1), 
      .ph2(ph2), .reset(reset), .q(aluoutW[31:0]));
  DatapathDone__flopenr_32 r2w(.d(readdata2M[31:0]), .en(net_163), .ph1(ph1), 
      .ph2(ph2), .reset(reset), .q(readdataW[31:0]));
  DatapathDone__flopenr_32 r4w(.d(writedata2M[31:0]), .en(net_163), .ph1(ph1), 
      .ph2(ph2), .reset(reset), .q(writedataW[31:0]));
endmodule   /* DatapathDone__Memory_Writeback */

module DatapathDone__a2o1_1x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_0, net_11, net_19;

  tranif1 nmos_0(gnd, net_19, a);
  tranif1 nmos_1(net_19, net_0, b);
  tranif1 nmos_2(gnd, net_0, c);
  tranif1 nmos_3(gnd, y, net_0);
  tranif0 pmos_0(net_0, net_11, c);
  tranif0 pmos_1(net_11, vdd, b);
  tranif0 pmos_2(net_11, vdd, a);
  tranif0 pmos_3(y, vdd, net_0);
endmodule   /* DatapathDone__a2o1_1x */

module DatapathDone__mux2_c_1x(d0, d1, s, y);
  input d0;
  input d1;
  input s;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_12, net_15, net_3, net_4, net_5, sb;

  tranif1 nmos_0(gnd, net_3, d1);
  tranif1 nmos_1(gnd, net_4, d0);
  tranif1 nmos_2(net_3, net_5, s);
  tranif1 nmos_3(net_4, net_5, sb);
  tranif1 nmos_4(gnd, y, net_5);
  tranif1 nmos_5(gnd, sb, s);
  tranif0 pmos_0(net_5, net_15, sb);
  tranif0 pmos_1(net_15, vdd, d1);
  tranif0 pmos_2(net_5, net_12, s);
  tranif0 pmos_3(net_12, vdd, d0);
  tranif0 pmos_4(y, vdd, net_5);
  tranif0 pmos_5(sb, vdd, s);
endmodule   /* DatapathDone__mux2_c_1x */

module DatapathDone__xnor2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire ab, bb, net_3, net_4, net_7, net_8;

  tranif1 nmos_0(gnd, net_3, a);
  tranif1 nmos_1(gnd, net_4, ab);
  tranif1 nmos_2(net_3, y, bb);
  tranif1 nmos_3(net_4, y, b);
  tranif1 nmos_4(gnd, bb, b);
  tranif1 nmos_5(gnd, ab, a);
  tranif0 pmos_0(y, net_7, b);
  tranif0 pmos_1(net_7, vdd, a);
  tranif0 pmos_2(y, net_8, bb);
  tranif0 pmos_3(net_8, vdd, ab);
  tranif0 pmos_4(bb, vdd, b);
  tranif0 pmos_5(ab, vdd, a);
endmodule   /* DatapathDone__xnor2_1x */

module DatapathDone__ALUrandlog(Cout, a, b2, control, sum, overflow, s_binv, 
      s_result, sltselect);
  input Cout;
  input [31:31] a;
  input [31:31] b2;
  input [2:0] control;
  input [31:31] sum;
  output overflow;
  output s_binv;
  output s_result;
  output sltselect;

  supply1 vdd;
  supply0 gnd;
  wire net_11, net_12, net_37, sltU;

  DatapathDone__a2o1_1x a2o1_1x_0(.a(control[0]), .b(control[1]), 
      .c(control[2]), .y(s_binv));
  DatapathDone__and2_1x and2_1x_0(.a(net_11), .b(net_12), .y(overflow));
  DatapathDone__inv_1x inv_1x_0(.a(Cout), .y(sltU));
  DatapathDone__inv_1x inv_1x_1(.a(control[2]), .y(net_37));
  DatapathDone__mux2_c_1x mux2_c_1_0(.d0(sltU), .d1(sum[31]), .s(control[2]), 
      .y(sltselect));
  DatapathDone__nor2_1x nor2_1x_0(.a(net_37), .b(control[1]), .y(s_result));
  DatapathDone__xnor2_1x xnor2_1x_0(.a(a[31]), .b(b2[31]), .y(net_11));
  DatapathDone__xor2_1x xor2_1x_0(.a(a[31]), .b(sum[31]), .y(net_12));
endmodule   /* DatapathDone__ALUrandlog */

module DatapathDone__fulladder(a, b, c, cout, s);
  input a;
  input b;
  input c;
  output cout;
  output s;

  supply1 vdd;
  supply0 gnd;
  wire coutb, net_1, net_11, net_111, net_23, net_32, net_33, net_90, net_92;
  wire net_94, net_95, sb;

  tranif1 nmos_0(gnd, net_1, a);
  tranif1 nmos_1(gnd, net_1, b);
  tranif1 nmos_2(net_1, coutb, c);
  tranif1 nmos_3(gnd, net_11, a);
  tranif1 nmos_4(net_11, coutb, b);
  tranif1 nmos_5(gnd, net_23, a);
  tranif1 nmos_6(gnd, net_23, b);
  tranif1 nmos_7(gnd, net_23, c);
  tranif1 nmos_8(net_23, sb, coutb);
  tranif1 nmos_9(gnd, net_33, a);
  tranif1 nmos_10(net_33, net_32, b);
  tranif1 nmos_11(net_32, sb, c);
  tranif1 nmos_12(gnd, cout, coutb);
  tranif1 nmos_13(gnd, s, sb);
  tranif0 pmos_1(sb, net_92, c);
  tranif0 pmos_2(net_92, net_90, b);
  tranif0 pmos_3(net_90, vdd, a);
  tranif0 pmos_4(sb, net_94, coutb);
  tranif0 pmos_5(net_94, vdd, b);
  tranif0 pmos_6(net_94, vdd, c);
  tranif0 pmos_7(net_94, vdd, a);
  tranif0 pmos_8(cout, vdd, coutb);
  tranif0 pmos_9(net_95, vdd, a);
  tranif0 pmos_10(coutb, net_95, b);
  tranif0 pmos_11(net_111, vdd, a);
  tranif0 pmos_12(net_111, vdd, b);
  tranif0 pmos_13(coutb, net_111, c);
  tranif0 pmos_14(s, vdd, sb);
endmodule   /* DatapathDone__fulladder */

module DatapathDone__adder_32(a, b, cin, cout, s);
  input [31:0] a;
  input [31:0] b;
  input cin;
  output cout;
  output [31:0] s;

  supply1 vdd;
  supply0 gnd;
  wire [30:0] c;

  DatapathDone__fulladder fa_31_(.a(a[31]), .b(b[31]), .c(c[30]), .cout(cout), 
      .s(s[31]));
  DatapathDone__fulladder fa_30_(.a(a[30]), .b(b[30]), .c(c[29]), .cout(c[30]), 
      .s(s[30]));
  DatapathDone__fulladder fa_29_(.a(a[29]), .b(b[29]), .c(c[28]), .cout(c[29]), 
      .s(s[29]));
  DatapathDone__fulladder fa_28_(.a(a[28]), .b(b[28]), .c(c[27]), .cout(c[28]), 
      .s(s[28]));
  DatapathDone__fulladder fa_27_(.a(a[27]), .b(b[27]), .c(c[26]), .cout(c[27]), 
      .s(s[27]));
  DatapathDone__fulladder fa_26_(.a(a[26]), .b(b[26]), .c(c[25]), .cout(c[26]), 
      .s(s[26]));
  DatapathDone__fulladder fa_25_(.a(a[25]), .b(b[25]), .c(c[24]), .cout(c[25]), 
      .s(s[25]));
  DatapathDone__fulladder fa_24_(.a(a[24]), .b(b[24]), .c(c[23]), .cout(c[24]), 
      .s(s[24]));
  DatapathDone__fulladder fa_23_(.a(a[23]), .b(b[23]), .c(c[22]), .cout(c[23]), 
      .s(s[23]));
  DatapathDone__fulladder fa_22_(.a(a[22]), .b(b[22]), .c(c[21]), .cout(c[22]), 
      .s(s[22]));
  DatapathDone__fulladder fa_21_(.a(a[21]), .b(b[21]), .c(c[20]), .cout(c[21]), 
      .s(s[21]));
  DatapathDone__fulladder fa_20_(.a(a[20]), .b(b[20]), .c(c[19]), .cout(c[20]), 
      .s(s[20]));
  DatapathDone__fulladder fa_19_(.a(a[19]), .b(b[19]), .c(c[18]), .cout(c[19]), 
      .s(s[19]));
  DatapathDone__fulladder fa_18_(.a(a[18]), .b(b[18]), .c(c[17]), .cout(c[18]), 
      .s(s[18]));
  DatapathDone__fulladder fa_17_(.a(a[17]), .b(b[17]), .c(c[16]), .cout(c[17]), 
      .s(s[17]));
  DatapathDone__fulladder fa_16_(.a(a[16]), .b(b[16]), .c(c[15]), .cout(c[16]), 
      .s(s[16]));
  DatapathDone__fulladder fa_15_(.a(a[15]), .b(b[15]), .c(c[14]), .cout(c[15]), 
      .s(s[15]));
  DatapathDone__fulladder fa_14_(.a(a[14]), .b(b[14]), .c(c[13]), .cout(c[14]), 
      .s(s[14]));
  DatapathDone__fulladder fa_13_(.a(a[13]), .b(b[13]), .c(c[12]), .cout(c[13]), 
      .s(s[13]));
  DatapathDone__fulladder fa_12_(.a(a[12]), .b(b[12]), .c(c[11]), .cout(c[12]), 
      .s(s[12]));
  DatapathDone__fulladder fa_11_(.a(a[11]), .b(b[11]), .c(c[10]), .cout(c[11]), 
      .s(s[11]));
  DatapathDone__fulladder fa_10_(.a(a[10]), .b(b[10]), .c(c[9]), .cout(c[10]), 
      .s(s[10]));
  DatapathDone__fulladder fa_9_(.a(a[9]), .b(b[9]), .c(c[8]), .cout(c[9]), 
      .s(s[9]));
  DatapathDone__fulladder fa_8_(.a(a[8]), .b(b[8]), .c(c[7]), .cout(c[8]), 
      .s(s[8]));
  DatapathDone__fulladder fa_7_(.a(a[7]), .b(b[7]), .c(c[6]), .cout(c[7]), 
      .s(s[7]));
  DatapathDone__fulladder fa_6_(.a(a[6]), .b(b[6]), .c(c[5]), .cout(c[6]), 
      .s(s[6]));
  DatapathDone__fulladder fa_5_(.a(a[5]), .b(b[5]), .c(c[4]), .cout(c[5]), 
      .s(s[5]));
  DatapathDone__fulladder fa_4_(.a(a[4]), .b(b[4]), .c(c[3]), .cout(c[4]), 
      .s(s[4]));
  DatapathDone__fulladder fa_3_(.a(a[3]), .b(b[3]), .c(c[2]), .cout(c[3]), 
      .s(s[3]));
  DatapathDone__fulladder fa_2_(.a(a[2]), .b(b[2]), .c(c[1]), .cout(c[2]), 
      .s(s[2]));
  DatapathDone__fulladder fa_1_(.a(a[1]), .b(b[1]), .c(c[0]), .cout(c[1]), 
      .s(s[1]));
  DatapathDone__fulladder fa_0_(.a(a[0]), .b(b[0]), .c(cin), .cout(c[0]), 
      .s(s[0]));
endmodule   /* DatapathDone__adder_32 */

module DatapathDone__and2_1x_32(a, b, y);
  input [31:0] a;
  input [31:0] b;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__and2_1x and2_1x_31_(.a(a[31]), .b(b[31]), .y(y[31]));
  DatapathDone__and2_1x and2_1x_30_(.a(a[30]), .b(b[30]), .y(y[30]));
  DatapathDone__and2_1x and2_1x_29_(.a(a[29]), .b(b[29]), .y(y[29]));
  DatapathDone__and2_1x and2_1x_28_(.a(a[28]), .b(b[28]), .y(y[28]));
  DatapathDone__and2_1x and2_1x_27_(.a(a[27]), .b(b[27]), .y(y[27]));
  DatapathDone__and2_1x and2_1x_26_(.a(a[26]), .b(b[26]), .y(y[26]));
  DatapathDone__and2_1x and2_1x_25_(.a(a[25]), .b(b[25]), .y(y[25]));
  DatapathDone__and2_1x and2_1x_24_(.a(a[24]), .b(b[24]), .y(y[24]));
  DatapathDone__and2_1x and2_1x_23_(.a(a[23]), .b(b[23]), .y(y[23]));
  DatapathDone__and2_1x and2_1x_22_(.a(a[22]), .b(b[22]), .y(y[22]));
  DatapathDone__and2_1x and2_1x_21_(.a(a[21]), .b(b[21]), .y(y[21]));
  DatapathDone__and2_1x and2_1x_20_(.a(a[20]), .b(b[20]), .y(y[20]));
  DatapathDone__and2_1x and2_1x_19_(.a(a[19]), .b(b[19]), .y(y[19]));
  DatapathDone__and2_1x and2_1x_18_(.a(a[18]), .b(b[18]), .y(y[18]));
  DatapathDone__and2_1x and2_1x_17_(.a(a[17]), .b(b[17]), .y(y[17]));
  DatapathDone__and2_1x and2_1x_16_(.a(a[16]), .b(b[16]), .y(y[16]));
  DatapathDone__and2_1x and2_1x_15_(.a(a[15]), .b(b[15]), .y(y[15]));
  DatapathDone__and2_1x and2_1x_14_(.a(a[14]), .b(b[14]), .y(y[14]));
  DatapathDone__and2_1x and2_1x_13_(.a(a[13]), .b(b[13]), .y(y[13]));
  DatapathDone__and2_1x and2_1x_12_(.a(a[12]), .b(b[12]), .y(y[12]));
  DatapathDone__and2_1x and2_1x_11_(.a(a[11]), .b(b[11]), .y(y[11]));
  DatapathDone__and2_1x and2_1x_10_(.a(a[10]), .b(b[10]), .y(y[10]));
  DatapathDone__and2_1x and2_1x_9_(.a(a[9]), .b(b[9]), .y(y[9]));
  DatapathDone__and2_1x and2_1x_8_(.a(a[8]), .b(b[8]), .y(y[8]));
  DatapathDone__and2_1x and2_1x_7_(.a(a[7]), .b(b[7]), .y(y[7]));
  DatapathDone__and2_1x and2_1x_6_(.a(a[6]), .b(b[6]), .y(y[6]));
  DatapathDone__and2_1x and2_1x_5_(.a(a[5]), .b(b[5]), .y(y[5]));
  DatapathDone__and2_1x and2_1x_4_(.a(a[4]), .b(b[4]), .y(y[4]));
  DatapathDone__and2_1x and2_1x_3_(.a(a[3]), .b(b[3]), .y(y[3]));
  DatapathDone__and2_1x and2_1x_2_(.a(a[2]), .b(b[2]), .y(y[2]));
  DatapathDone__and2_1x and2_1x_1_(.a(a[1]), .b(b[1]), .y(y[1]));
  DatapathDone__and2_1x and2_1x_0_(.a(a[0]), .b(b[0]), .y(y[0]));
endmodule   /* DatapathDone__and2_1x_32 */

module DatapathDone__inv_1x_32(a, y);
  input [31:0] a;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__inv_1x inv_1x_31_(.a(a[31]), .y(y[31]));
  DatapathDone__inv_1x inv_1x_30_(.a(a[30]), .y(y[30]));
  DatapathDone__inv_1x inv_1x_29_(.a(a[29]), .y(y[29]));
  DatapathDone__inv_1x inv_1x_28_(.a(a[28]), .y(y[28]));
  DatapathDone__inv_1x inv_1x_27_(.a(a[27]), .y(y[27]));
  DatapathDone__inv_1x inv_1x_26_(.a(a[26]), .y(y[26]));
  DatapathDone__inv_1x inv_1x_25_(.a(a[25]), .y(y[25]));
  DatapathDone__inv_1x inv_1x_24_(.a(a[24]), .y(y[24]));
  DatapathDone__inv_1x inv_1x_23_(.a(a[23]), .y(y[23]));
  DatapathDone__inv_1x inv_1x_22_(.a(a[22]), .y(y[22]));
  DatapathDone__inv_1x inv_1x_21_(.a(a[21]), .y(y[21]));
  DatapathDone__inv_1x inv_1x_20_(.a(a[20]), .y(y[20]));
  DatapathDone__inv_1x inv_1x_19_(.a(a[19]), .y(y[19]));
  DatapathDone__inv_1x inv_1x_18_(.a(a[18]), .y(y[18]));
  DatapathDone__inv_1x inv_1x_17_(.a(a[17]), .y(y[17]));
  DatapathDone__inv_1x inv_1x_16_(.a(a[16]), .y(y[16]));
  DatapathDone__inv_1x inv_1x_15_(.a(a[15]), .y(y[15]));
  DatapathDone__inv_1x inv_1x_14_(.a(a[14]), .y(y[14]));
  DatapathDone__inv_1x inv_1x_13_(.a(a[13]), .y(y[13]));
  DatapathDone__inv_1x inv_1x_12_(.a(a[12]), .y(y[12]));
  DatapathDone__inv_1x inv_1x_11_(.a(a[11]), .y(y[11]));
  DatapathDone__inv_1x inv_1x_10_(.a(a[10]), .y(y[10]));
  DatapathDone__inv_1x inv_1x_9_(.a(a[9]), .y(y[9]));
  DatapathDone__inv_1x inv_1x_8_(.a(a[8]), .y(y[8]));
  DatapathDone__inv_1x inv_1x_7_(.a(a[7]), .y(y[7]));
  DatapathDone__inv_1x inv_1x_6_(.a(a[6]), .y(y[6]));
  DatapathDone__inv_1x inv_1x_5_(.a(a[5]), .y(y[5]));
  DatapathDone__inv_1x inv_1x_4_(.a(a[4]), .y(y[4]));
  DatapathDone__inv_1x inv_1x_3_(.a(a[3]), .y(y[3]));
  DatapathDone__inv_1x inv_1x_2_(.a(a[2]), .y(y[2]));
  DatapathDone__inv_1x inv_1x_1_(.a(a[1]), .y(y[1]));
  DatapathDone__inv_1x inv_1x_0_(.a(a[0]), .y(y[0]));
endmodule   /* DatapathDone__inv_1x_32 */

module DatapathDone__mux2i_dp_1x(d0, d1, s, sb, y);
  input d0;
  input d1;
  input s;
  input sb;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_12, net_15, net_3, net_4;

  tranif1 nmos_0(gnd, net_3, d1);
  tranif1 nmos_1(gnd, net_4, d0);
  tranif1 nmos_2(net_3, y, s);
  tranif1 nmos_3(net_4, y, sb);
  tranif0 pmos_0(y, net_15, sb);
  tranif0 pmos_1(net_15, vdd, d1);
  tranif0 pmos_2(y, net_12, s);
  tranif0 pmos_3(net_12, vdd, d0);
endmodule   /* DatapathDone__mux2i_dp_1x */

module DatapathDone__mux2i_dp_1x_32(d0, d1, s, y);
  input [31:0] d0;
  input [31:0] d1;
  input s;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_21, net_25;

  DatapathDone__invbuf_4x invbuf_4_0(.s(s), .s_out(net_25), .sb_out(net_21));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_31_(.d0(d0[31]), .d1(d1[31]), 
      .s(net_25), .sb(net_21), .y(y[31]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_30_(.d0(d0[30]), .d1(d1[30]), 
      .s(net_25), .sb(net_21), .y(y[30]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_29_(.d0(d0[29]), .d1(d1[29]), 
      .s(net_25), .sb(net_21), .y(y[29]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_28_(.d0(d0[28]), .d1(d1[28]), 
      .s(net_25), .sb(net_21), .y(y[28]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_27_(.d0(d0[27]), .d1(d1[27]), 
      .s(net_25), .sb(net_21), .y(y[27]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_26_(.d0(d0[26]), .d1(d1[26]), 
      .s(net_25), .sb(net_21), .y(y[26]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_25_(.d0(d0[25]), .d1(d1[25]), 
      .s(net_25), .sb(net_21), .y(y[25]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_24_(.d0(d0[24]), .d1(d1[24]), 
      .s(net_25), .sb(net_21), .y(y[24]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_23_(.d0(d0[23]), .d1(d1[23]), 
      .s(net_25), .sb(net_21), .y(y[23]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_22_(.d0(d0[22]), .d1(d1[22]), 
      .s(net_25), .sb(net_21), .y(y[22]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_21_(.d0(d0[21]), .d1(d1[21]), 
      .s(net_25), .sb(net_21), .y(y[21]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_20_(.d0(d0[20]), .d1(d1[20]), 
      .s(net_25), .sb(net_21), .y(y[20]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_19_(.d0(d0[19]), .d1(d1[19]), 
      .s(net_25), .sb(net_21), .y(y[19]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_18_(.d0(d0[18]), .d1(d1[18]), 
      .s(net_25), .sb(net_21), .y(y[18]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_17_(.d0(d0[17]), .d1(d1[17]), 
      .s(net_25), .sb(net_21), .y(y[17]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_16_(.d0(d0[16]), .d1(d1[16]), 
      .s(net_25), .sb(net_21), .y(y[16]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_15_(.d0(d0[15]), .d1(d1[15]), 
      .s(net_25), .sb(net_21), .y(y[15]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_14_(.d0(d0[14]), .d1(d1[14]), 
      .s(net_25), .sb(net_21), .y(y[14]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_13_(.d0(d0[13]), .d1(d1[13]), 
      .s(net_25), .sb(net_21), .y(y[13]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_12_(.d0(d0[12]), .d1(d1[12]), 
      .s(net_25), .sb(net_21), .y(y[12]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_11_(.d0(d0[11]), .d1(d1[11]), 
      .s(net_25), .sb(net_21), .y(y[11]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_10_(.d0(d0[10]), .d1(d1[10]), 
      .s(net_25), .sb(net_21), .y(y[10]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_9_(.d0(d0[9]), .d1(d1[9]), .s(net_25), 
      .sb(net_21), .y(y[9]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_8_(.d0(d0[8]), .d1(d1[8]), .s(net_25), 
      .sb(net_21), .y(y[8]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_7_(.d0(d0[7]), .d1(d1[7]), .s(net_25), 
      .sb(net_21), .y(y[7]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_6_(.d0(d0[6]), .d1(d1[6]), .s(net_25), 
      .sb(net_21), .y(y[6]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_5_(.d0(d0[5]), .d1(d1[5]), .s(net_25), 
      .sb(net_21), .y(y[5]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_4_(.d0(d0[4]), .d1(d1[4]), .s(net_25), 
      .sb(net_21), .y(y[4]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_3_(.d0(d0[3]), .d1(d1[3]), .s(net_25), 
      .sb(net_21), .y(y[3]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_2_(.d0(d0[2]), .d1(d1[2]), .s(net_25), 
      .sb(net_21), .y(y[2]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_1_(.d0(d0[1]), .d1(d1[1]), .s(net_25), 
      .sb(net_21), .y(y[1]));
  DatapathDone__mux2i_dp_1x mux2i_dp_1x_0_(.d0(d0[0]), .d1(d1[0]), .s(net_25), 
      .sb(net_21), .y(y[0]));
endmodule   /* DatapathDone__mux2i_dp_1x_32 */

module DatapathDone__mux4i_dp_1x(d0, d1, d2, d3, s0, s0b, s1b, s1, y);
  input d0;
  input d1;
  input d2;
  input d3;
  input s0;
  input s0b;
  input s1b;
  output s1;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_104, net_109, net_112, net_115, net_123, net_127, net_130, net_133;
  wire net_31, net_52, net_59, net_9;

  tranif1 nmos_0(gnd, net_130, d0);
  tranif1 nmos_1(net_112, net_9, s0);
  tranif1 nmos_3(net_130, net_9, s0b);
  tranif1 nmos_4(gnd, net_112, d1);
  tranif1 nmos_5(net_9, y, s1b);
  tranif1 nmos_7(gnd, net_133, d3);
  tranif1 nmos_8(gnd, net_104, d2);
  tranif1 nmos_9(net_133, net_52, s0);
  tranif1 nmos_10(net_52, y, s1);
  tranif1 nmos_11(net_104, net_52, s0b);
  tranif0 pmos_0(y, net_31, s1);
  tranif0 pmos_2(net_31, net_127, s0);
  tranif0 pmos_3(net_127, vdd, d0);
  tranif0 pmos_4(net_115, vdd, d1);
  tranif0 pmos_5(net_31, net_115, s0b);
  tranif0 pmos_7(net_109, vdd, d2);
  tranif0 pmos_8(net_59, net_109, s0);
  tranif0 pmos_9(net_59, net_123, s0b);
  tranif0 pmos_10(net_123, vdd, d3);
  tranif0 pmos_11(y, net_59, s1b);
endmodule   /* DatapathDone__mux4i_dp_1x */

module DatapathDone__mux4i_dp_1x_32(d0, d1, d2, d3, s0, s1, y);
  input [31:0] d0;
  input [31:0] d1;
  input [31:0] d2;
  input [31:0] d3;
  input s0;
  input s1;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_32, net_37, net_68, net_69;

  DatapathDone__invbuf_4x invbuf_4_0(.s(s0), .s_out(net_32), .sb_out(net_68));
  DatapathDone__invbuf_4x invbuf_4_1(.s(s1), .s_out(net_69), .sb_out(net_37));
  DatapathDone__mux4i_dp_1x mux4i_dp_31_(.d0(d0[31]), .d1(d1[31]), .d2(d2[31]), 
      .d3(d3[31]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[31]));
  DatapathDone__mux4i_dp_1x mux4i_dp_30_(.d0(d0[30]), .d1(d1[30]), .d2(d2[30]), 
      .d3(d3[30]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[30]));
  DatapathDone__mux4i_dp_1x mux4i_dp_29_(.d0(d0[29]), .d1(d1[29]), .d2(d2[29]), 
      .d3(d3[29]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[29]));
  DatapathDone__mux4i_dp_1x mux4i_dp_28_(.d0(d0[28]), .d1(d1[28]), .d2(d2[28]), 
      .d3(d3[28]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[28]));
  DatapathDone__mux4i_dp_1x mux4i_dp_27_(.d0(d0[27]), .d1(d1[27]), .d2(d2[27]), 
      .d3(d3[27]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[27]));
  DatapathDone__mux4i_dp_1x mux4i_dp_26_(.d0(d0[26]), .d1(d1[26]), .d2(d2[26]), 
      .d3(d3[26]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[26]));
  DatapathDone__mux4i_dp_1x mux4i_dp_25_(.d0(d0[25]), .d1(d1[25]), .d2(d2[25]), 
      .d3(d3[25]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[25]));
  DatapathDone__mux4i_dp_1x mux4i_dp_24_(.d0(d0[24]), .d1(d1[24]), .d2(d2[24]), 
      .d3(d3[24]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[24]));
  DatapathDone__mux4i_dp_1x mux4i_dp_23_(.d0(d0[23]), .d1(d1[23]), .d2(d2[23]), 
      .d3(d3[23]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[23]));
  DatapathDone__mux4i_dp_1x mux4i_dp_22_(.d0(d0[22]), .d1(d1[22]), .d2(d2[22]), 
      .d3(d3[22]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[22]));
  DatapathDone__mux4i_dp_1x mux4i_dp_21_(.d0(d0[21]), .d1(d1[21]), .d2(d2[21]), 
      .d3(d3[21]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[21]));
  DatapathDone__mux4i_dp_1x mux4i_dp_20_(.d0(d0[20]), .d1(d1[20]), .d2(d2[20]), 
      .d3(d3[20]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[20]));
  DatapathDone__mux4i_dp_1x mux4i_dp_19_(.d0(d0[19]), .d1(d1[19]), .d2(d2[19]), 
      .d3(d3[19]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[19]));
  DatapathDone__mux4i_dp_1x mux4i_dp_18_(.d0(d0[18]), .d1(d1[18]), .d2(d2[18]), 
      .d3(d3[18]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[18]));
  DatapathDone__mux4i_dp_1x mux4i_dp_17_(.d0(d0[17]), .d1(d1[17]), .d2(d2[17]), 
      .d3(d3[17]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[17]));
  DatapathDone__mux4i_dp_1x mux4i_dp_16_(.d0(d0[16]), .d1(d1[16]), .d2(d2[16]), 
      .d3(d3[16]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[16]));
  DatapathDone__mux4i_dp_1x mux4i_dp_15_(.d0(d0[15]), .d1(d1[15]), .d2(d2[15]), 
      .d3(d3[15]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[15]));
  DatapathDone__mux4i_dp_1x mux4i_dp_14_(.d0(d0[14]), .d1(d1[14]), .d2(d2[14]), 
      .d3(d3[14]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[14]));
  DatapathDone__mux4i_dp_1x mux4i_dp_13_(.d0(d0[13]), .d1(d1[13]), .d2(d2[13]), 
      .d3(d3[13]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[13]));
  DatapathDone__mux4i_dp_1x mux4i_dp_12_(.d0(d0[12]), .d1(d1[12]), .d2(d2[12]), 
      .d3(d3[12]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[12]));
  DatapathDone__mux4i_dp_1x mux4i_dp_11_(.d0(d0[11]), .d1(d1[11]), .d2(d2[11]), 
      .d3(d3[11]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[11]));
  DatapathDone__mux4i_dp_1x mux4i_dp_10_(.d0(d0[10]), .d1(d1[10]), .d2(d2[10]), 
      .d3(d3[10]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[10]));
  DatapathDone__mux4i_dp_1x mux4i_dp_9_(.d0(d0[9]), .d1(d1[9]), .d2(d2[9]), 
      .d3(d3[9]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[9]));
  DatapathDone__mux4i_dp_1x mux4i_dp_8_(.d0(d0[8]), .d1(d1[8]), .d2(d2[8]), 
      .d3(d3[8]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[8]));
  DatapathDone__mux4i_dp_1x mux4i_dp_7_(.d0(d0[7]), .d1(d1[7]), .d2(d2[7]), 
      .d3(d3[7]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[7]));
  DatapathDone__mux4i_dp_1x mux4i_dp_6_(.d0(d0[6]), .d1(d1[6]), .d2(d2[6]), 
      .d3(d3[6]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[6]));
  DatapathDone__mux4i_dp_1x mux4i_dp_5_(.d0(d0[5]), .d1(d1[5]), .d2(d2[5]), 
      .d3(d3[5]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[5]));
  DatapathDone__mux4i_dp_1x mux4i_dp_4_(.d0(d0[4]), .d1(d1[4]), .d2(d2[4]), 
      .d3(d3[4]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[4]));
  DatapathDone__mux4i_dp_1x mux4i_dp_3_(.d0(d0[3]), .d1(d1[3]), .d2(d2[3]), 
      .d3(d3[3]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[3]));
  DatapathDone__mux4i_dp_1x mux4i_dp_2_(.d0(d0[2]), .d1(d1[2]), .d2(d2[2]), 
      .d3(d3[2]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[2]));
  DatapathDone__mux4i_dp_1x mux4i_dp_1_(.d0(d0[1]), .d1(d1[1]), .d2(d2[1]), 
      .d3(d3[1]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[1]));
  DatapathDone__mux4i_dp_1x mux4i_dp_0_(.d0(d0[0]), .d1(d1[0]), .d2(d2[0]), 
      .d3(d3[0]), .s0(net_32), .s0b(net_68), .s1b(net_37), .s1(net_69), 
      .y(y[0]));
endmodule   /* DatapathDone__mux4i_dp_1x_32 */

module DatapathDone__nor2_1x_32(a, b, y);
  input [31:0] a;
  input [31:0] b;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__nor2_1x nor2_1x_31_(.a(a[31]), .b(b[31]), .y(y[31]));
  DatapathDone__nor2_1x nor2_1x_30_(.a(a[30]), .b(b[30]), .y(y[30]));
  DatapathDone__nor2_1x nor2_1x_29_(.a(a[29]), .b(b[29]), .y(y[29]));
  DatapathDone__nor2_1x nor2_1x_28_(.a(a[28]), .b(b[28]), .y(y[28]));
  DatapathDone__nor2_1x nor2_1x_27_(.a(a[27]), .b(b[27]), .y(y[27]));
  DatapathDone__nor2_1x nor2_1x_26_(.a(a[26]), .b(b[26]), .y(y[26]));
  DatapathDone__nor2_1x nor2_1x_25_(.a(a[25]), .b(b[25]), .y(y[25]));
  DatapathDone__nor2_1x nor2_1x_24_(.a(a[24]), .b(b[24]), .y(y[24]));
  DatapathDone__nor2_1x nor2_1x_23_(.a(a[23]), .b(b[23]), .y(y[23]));
  DatapathDone__nor2_1x nor2_1x_22_(.a(a[22]), .b(b[22]), .y(y[22]));
  DatapathDone__nor2_1x nor2_1x_21_(.a(a[21]), .b(b[21]), .y(y[21]));
  DatapathDone__nor2_1x nor2_1x_20_(.a(a[20]), .b(b[20]), .y(y[20]));
  DatapathDone__nor2_1x nor2_1x_19_(.a(a[19]), .b(b[19]), .y(y[19]));
  DatapathDone__nor2_1x nor2_1x_18_(.a(a[18]), .b(b[18]), .y(y[18]));
  DatapathDone__nor2_1x nor2_1x_17_(.a(a[17]), .b(b[17]), .y(y[17]));
  DatapathDone__nor2_1x nor2_1x_16_(.a(a[16]), .b(b[16]), .y(y[16]));
  DatapathDone__nor2_1x nor2_1x_15_(.a(a[15]), .b(b[15]), .y(y[15]));
  DatapathDone__nor2_1x nor2_1x_14_(.a(a[14]), .b(b[14]), .y(y[14]));
  DatapathDone__nor2_1x nor2_1x_13_(.a(a[13]), .b(b[13]), .y(y[13]));
  DatapathDone__nor2_1x nor2_1x_12_(.a(a[12]), .b(b[12]), .y(y[12]));
  DatapathDone__nor2_1x nor2_1x_11_(.a(a[11]), .b(b[11]), .y(y[11]));
  DatapathDone__nor2_1x nor2_1x_10_(.a(a[10]), .b(b[10]), .y(y[10]));
  DatapathDone__nor2_1x nor2_1x_9_(.a(a[9]), .b(b[9]), .y(y[9]));
  DatapathDone__nor2_1x nor2_1x_8_(.a(a[8]), .b(b[8]), .y(y[8]));
  DatapathDone__nor2_1x nor2_1x_7_(.a(a[7]), .b(b[7]), .y(y[7]));
  DatapathDone__nor2_1x nor2_1x_6_(.a(a[6]), .b(b[6]), .y(y[6]));
  DatapathDone__nor2_1x nor2_1x_5_(.a(a[5]), .b(b[5]), .y(y[5]));
  DatapathDone__nor2_1x nor2_1x_4_(.a(a[4]), .b(b[4]), .y(y[4]));
  DatapathDone__nor2_1x nor2_1x_3_(.a(a[3]), .b(b[3]), .y(y[3]));
  DatapathDone__nor2_1x nor2_1x_2_(.a(a[2]), .b(b[2]), .y(y[2]));
  DatapathDone__nor2_1x nor2_1x_1_(.a(a[1]), .b(b[1]), .y(y[1]));
  DatapathDone__nor2_1x nor2_1x_0_(.a(a[0]), .b(b[0]), .y(y[0]));
endmodule   /* DatapathDone__nor2_1x_32 */

module DatapathDone__xor2_1x_32(a, b, y);
  input [31:0] a;
  input [31:0] b;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__xor2_1x xor2_1x_31_(.a(a[31]), .b(b[31]), .y(y[31]));
  DatapathDone__xor2_1x xor2_1x_30_(.a(a[30]), .b(b[30]), .y(y[30]));
  DatapathDone__xor2_1x xor2_1x_29_(.a(a[29]), .b(b[29]), .y(y[29]));
  DatapathDone__xor2_1x xor2_1x_28_(.a(a[28]), .b(b[28]), .y(y[28]));
  DatapathDone__xor2_1x xor2_1x_27_(.a(a[27]), .b(b[27]), .y(y[27]));
  DatapathDone__xor2_1x xor2_1x_26_(.a(a[26]), .b(b[26]), .y(y[26]));
  DatapathDone__xor2_1x xor2_1x_25_(.a(a[25]), .b(b[25]), .y(y[25]));
  DatapathDone__xor2_1x xor2_1x_24_(.a(a[24]), .b(b[24]), .y(y[24]));
  DatapathDone__xor2_1x xor2_1x_23_(.a(a[23]), .b(b[23]), .y(y[23]));
  DatapathDone__xor2_1x xor2_1x_22_(.a(a[22]), .b(b[22]), .y(y[22]));
  DatapathDone__xor2_1x xor2_1x_21_(.a(a[21]), .b(b[21]), .y(y[21]));
  DatapathDone__xor2_1x xor2_1x_20_(.a(a[20]), .b(b[20]), .y(y[20]));
  DatapathDone__xor2_1x xor2_1x_19_(.a(a[19]), .b(b[19]), .y(y[19]));
  DatapathDone__xor2_1x xor2_1x_18_(.a(a[18]), .b(b[18]), .y(y[18]));
  DatapathDone__xor2_1x xor2_1x_17_(.a(a[17]), .b(b[17]), .y(y[17]));
  DatapathDone__xor2_1x xor2_1x_16_(.a(a[16]), .b(b[16]), .y(y[16]));
  DatapathDone__xor2_1x xor2_1x_15_(.a(a[15]), .b(b[15]), .y(y[15]));
  DatapathDone__xor2_1x xor2_1x_14_(.a(a[14]), .b(b[14]), .y(y[14]));
  DatapathDone__xor2_1x xor2_1x_13_(.a(a[13]), .b(b[13]), .y(y[13]));
  DatapathDone__xor2_1x xor2_1x_12_(.a(a[12]), .b(b[12]), .y(y[12]));
  DatapathDone__xor2_1x xor2_1x_11_(.a(a[11]), .b(b[11]), .y(y[11]));
  DatapathDone__xor2_1x xor2_1x_10_(.a(a[10]), .b(b[10]), .y(y[10]));
  DatapathDone__xor2_1x xor2_1x_9_(.a(a[9]), .b(b[9]), .y(y[9]));
  DatapathDone__xor2_1x xor2_1x_8_(.a(a[8]), .b(b[8]), .y(y[8]));
  DatapathDone__xor2_1x xor2_1x_7_(.a(a[7]), .b(b[7]), .y(y[7]));
  DatapathDone__xor2_1x xor2_1x_6_(.a(a[6]), .b(b[6]), .y(y[6]));
  DatapathDone__xor2_1x xor2_1x_5_(.a(a[5]), .b(b[5]), .y(y[5]));
  DatapathDone__xor2_1x xor2_1x_4_(.a(a[4]), .b(b[4]), .y(y[4]));
  DatapathDone__xor2_1x xor2_1x_3_(.a(a[3]), .b(b[3]), .y(y[3]));
  DatapathDone__xor2_1x xor2_1x_2_(.a(a[2]), .b(b[2]), .y(y[2]));
  DatapathDone__xor2_1x xor2_1x_1_(.a(a[1]), .b(b[1]), .y(y[1]));
  DatapathDone__xor2_1x xor2_1x_0_(.a(a[0]), .b(b[0]), .y(y[0]));
endmodule   /* DatapathDone__xor2_1x_32 */

module DatapathDone__ALU_dp(alushcontrolE, srca2E, srcb3E, ALUresultE, 
      overflowE);
  input [2:0] alushcontrolE;
  input [31:0] srca2E;
  input [31:0] srcb3E;
  output [31:0] ALUresultE;
  output overflowE;

  supply1 vdd;
  supply0 gnd;
  wire coutALU, s_binv, s_result, sltselect;
  wire [31:0] aandb;
  wire [31:0] anorb;
  wire [31:0] aorb;
  wire [31:0] axorb;
  wire [31:0] b2;
  wire [31:0] mux2i_out;
  wire [31:0] mux4i_1_out;
  wire [31:0] srcb3bE;
  wire [31:0] sumALU;

  DatapathDone__ALUrandlog ALUrandl_2(.Cout(coutALU), .a(srca2E[31:31]), 
      .b2(b2[31:31]), .control(alushcontrolE[2:0]), .sum(sumALU[31:31]), 
      .overflow(overflowE), .s_binv(s_binv), .s_result(s_result), 
      .sltselect(sltselect));
  DatapathDone__adder_32 adder_32_0(.a(b2[31:0]), .b(srca2E[31:0]), 
      .cin(s_binv), .cout(coutALU), .s(sumALU[31:0]));
  DatapathDone__and2_1x_32 and2_1x__1(.a(srca2E[31:0]), .b(srcb3E[31:0]), 
      .y(aandb[31:0]));
  DatapathDone__inv_1x_32 inv_1x_3_2(.a(srcb3E[31:0]), .y(srcb3bE[31:0]));
  DatapathDone__inv_1x_32 inv_1x_3_3(.a(anorb[31:0]), .y(aorb[31:0]));
  DatapathDone__mux2_dp_1x_32 mux2_dp__0(.d0(srcb3E[31:0]), .d1(srcb3bE[31:0]), 
      .s(s_binv), .y(b2[31:0]));
  DatapathDone__mux2i_dp_1x_32 mux2i_dp_0(.d0(axorb[31:0]), .d1(anorb[31:0]), 
      .s(alushcontrolE[0]), .y(mux2i_out[31:0]));
  DatapathDone__mux2i_dp_1x_32 mux2i_dp_1(.d0(mux4i_1_out[31:0]), 
      .d1(mux2i_out[31:0]), .s(s_result), .y(ALUresultE[31:0]));
  DatapathDone__mux4i_dp_1x_32 mux4i_1(.d0(aandb[31:0]), .d1(aorb[31:0]), 
      .d2(sumALU[31:0]), .d3({gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, 
      gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, 
      gnd, gnd, gnd, gnd, gnd, gnd, gnd, sltselect}), .s0(alushcontrolE[0]), 
      .s1(alushcontrolE[1]), .y(mux4i_1_out[31:0]));
  DatapathDone__nor2_1x_32 nor2_1x__1(.a(srca2E[31:0]), .b(srcb3E[31:0]), 
      .y(anorb[31:0]));
  DatapathDone__xor2_1x_32 xor2_1x__1(.a(srca2E[31:0]), .b(srcb3E[31:0]), 
      .y(axorb[31:0]));
endmodule   /* DatapathDone__ALU_dp */

module DatapathDone__mux2_c_4x(d0, d1, s, y);
  input d0;
  input d1;
  input s;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_12, net_15, net_3, net_4, net_6, sb;

  tranif1 nmos_0(gnd, net_3, d1);
  tranif1 nmos_1(gnd, net_4, d0);
  tranif1 nmos_2(net_3, net_6, s);
  tranif1 nmos_3(net_4, net_6, sb);
  tranif1 nmos_4(gnd, y, net_6);
  tranif1 nmos_5(gnd, sb, s);
  tranif0 pmos_0(net_6, net_15, sb);
  tranif0 pmos_1(net_15, vdd, d1);
  tranif0 pmos_2(net_6, net_12, s);
  tranif0 pmos_3(net_12, vdd, d0);
  tranif0 pmos_4(y, vdd, net_6);
  tranif0 pmos_5(sb, vdd, s);
endmodule   /* DatapathDone__mux2_c_4x */

module DatapathDone__ShifterRandLog_dp(alushcontrolE, srcb3E, fillerbit);
  input [0:0] alushcontrolE;
  input [31:31] srcb3E;
  output fillerbit;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__mux2_c_4x mux2_c_4_0(.d0(gnd), .d1(srcb3E[31]), 
      .s(alushcontrolE[0]), .y(fillerbit));
endmodule   /* DatapathDone__ShifterRandLog_dp */

module DatapathDone__and2_1x_5(a, b, y);
  input [4:0] a;
  input [4:0] b;
  output [4:0] y;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__and2_1x and2_1x_4_(.a(a[4]), .b(b[4]), .y(y[4]));
  DatapathDone__and2_1x and2_1x_3_(.a(a[3]), .b(b[3]), .y(y[3]));
  DatapathDone__and2_1x and2_1x_2_(.a(a[2]), .b(b[2]), .y(y[2]));
  DatapathDone__and2_1x and2_1x_1_(.a(a[1]), .b(b[1]), .y(y[1]));
  DatapathDone__and2_1x and2_1x_0_(.a(a[0]), .b(b[0]), .y(y[0]));
endmodule   /* DatapathDone__and2_1x_5 */

module DatapathDone__Shiftermuxcon_dp(alushcontrolE, kshift, muxcon_0, 
      muxcon_1);
  input [1:1] alushcontrolE;
  input [4:0] kshift;
  output [4:0] muxcon_0;
  output [4:0] muxcon_1;

  supply1 vdd;
  supply0 gnd;
  wire [0:0] alushcontrolE_1b;

  DatapathDone__and2_1x_5 and2_1x__0(.a({alushcontrolE[1], alushcontrolE[1], 
      alushcontrolE[1], alushcontrolE[1], alushcontrolE[1]}), .b(kshift[4:0]), 
      .y(muxcon_1[4:0]));
  DatapathDone__and2_1x_5 and2_1x__1(.a({alushcontrolE_1b[0], 
      alushcontrolE_1b[0], alushcontrolE_1b[0], alushcontrolE_1b[0], 
      alushcontrolE_1b[0]}), .b(kshift[4:0]), .y(muxcon_0[4:0]));
  DatapathDone__inv_4x inv_4x_0(.a(alushcontrolE[1]), 
      .y(alushcontrolE_1b[0]));
endmodule   /* DatapathDone__Shiftermuxcon_dp */

module DatapathDone__mux3_dp_1x_5(d0, d1, d2, s0, s1, y);
  input [4:0] d0;
  input [4:0] d1;
  input [4:0] d2;
  input s0;
  input s1;
  output [4:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_104, net_105, net_109, net_98;

  DatapathDone__invbuf_4x invbuf_4_0(.s(s1), .s_out(net_104), 
      .sb_out(net_105));
  DatapathDone__invbuf_4x invbuf_4_1(.s(s0), .s_out(net_98), 
      .sb_out(net_109));
  DatapathDone__mux3_dp_1x mux3_dp_1x_4_(.d0(d0[4]), .d1(d1[4]), .d2(d2[4]), 
      .s0(net_98), .s0b(net_109), .s1(net_104), .s1b(net_105), .y(y[4]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_3_(.d0(d0[3]), .d1(d1[3]), .d2(d2[3]), 
      .s0(net_98), .s0b(net_109), .s1(net_104), .s1b(net_105), .y(y[3]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_2_(.d0(d0[2]), .d1(d1[2]), .d2(d2[2]), 
      .s0(net_98), .s0b(net_109), .s1(net_104), .s1b(net_105), .y(y[2]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_1_(.d0(d0[1]), .d1(d1[1]), .d2(d2[1]), 
      .s0(net_98), .s0b(net_109), .s1(net_104), .s1b(net_105), .y(y[1]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_0_(.d0(d0[0]), .d1(d1[0]), .d2(d2[0]), 
      .s0(net_98), .s0b(net_109), .s1(net_104), .s1b(net_105), .y(y[0]));
endmodule   /* DatapathDone__mux3_dp_1x_5 */

module DatapathDone__Shiftvalselect_dp(alushcontrolE, luiE, signimmE, srca2E, 
      kshiftE);
  input [2:2] alushcontrolE;
  input luiE;
  input [10:6] signimmE;
  input [4:0] srca2E;
  output [4:0] kshiftE;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__mux3_dp_1x_5 mux3_dp__1(.d0(srca2E[4:0]), .d1(signimmE[10:6]), 
      .d2({vdd, gnd, gnd, gnd, gnd}), .s0(alushcontrolE[2]), .s1(luiE), 
      .y(kshiftE[4:0]));
endmodule   /* DatapathDone__Shiftvalselect_dp */

module DatapathDone__Shifter_dp(alushcontrolE, luiE, signimmE, srca2E, srcb3E, 
      shiftresultE);
  input [2:0] alushcontrolE;
  input luiE;
  input [10:6] signimmE;
  input [4:0] srca2E;
  input [31:0] srcb3E;
  output [31:0] shiftresultE;

  supply1 vdd;
  supply0 gnd;
  wire f;
  wire [4:0] kshiftE;
  wire [4:0] muxcon_0;
  wire [4:0] muxcon_1;
  wire [31:0] sh16;
  wire [31:0] sh2;
  wire [31:0] sh4;
  wire [31:0] sh8;

  DatapathDone__ShifterRandLog_dp 
      ShifterR_1(.alushcontrolE(alushcontrolE[0:0]), .srcb3E(srcb3E[31:31]), 
      .fillerbit(f));
  DatapathDone__Shiftermuxcon_dp Shifterm_0(.alushcontrolE(alushcontrolE[1:1]), 
      .kshift(kshiftE[4:0]), .muxcon_0(muxcon_0[4:0]), 
      .muxcon_1(muxcon_1[4:0]));
  DatapathDone__Shiftvalselect_dp 
      Shiftval_2(.alushcontrolE(alushcontrolE[2:2]), .luiE(luiE), 
      .signimmE(signimmE[10:6]), .srca2E(srca2E[4:0]), 
      .kshiftE(kshiftE[4:0]));
  DatapathDone__mux3_dp_1x_32 mux3_sh1(.d0(sh2[31:0]), .d1({f, sh2[31], 
      sh2[30], sh2[29], sh2[28], sh2[27], sh2[26], sh2[25], sh2[24], sh2[23], 
      sh2[22], sh2[21], sh2[20], sh2[19], sh2[18], sh2[17], sh2[16], sh2[15], 
      sh2[14], sh2[13], sh2[12], sh2[11], sh2[10], sh2[9], sh2[8], sh2[7], 
      sh2[6], sh2[5], sh2[4], sh2[3], sh2[2], sh2[1]}), .d2({sh2[30], sh2[29], 
      sh2[28], sh2[27], sh2[26], sh2[25], sh2[24], sh2[23], sh2[22], sh2[21], 
      sh2[20], sh2[19], sh2[18], sh2[17], sh2[16], sh2[15], sh2[14], sh2[13], 
      sh2[12], sh2[11], sh2[10], sh2[9], sh2[8], sh2[7], sh2[6], sh2[5], 
      sh2[4], sh2[3], sh2[2], sh2[1], sh2[0], gnd}), .s0(muxcon_0[0]), 
      .s1(muxcon_1[0]), .y(shiftresultE[31:0]));
  DatapathDone__mux3_dp_1x_32 mux3_sh2(.d0(sh4[31:0]), .d1({f, f, sh4[31], 
      sh4[30], sh4[29], sh4[28], sh4[27], sh4[26], sh4[25], sh4[24], sh4[23], 
      sh4[22], sh4[21], sh4[20], sh4[19], sh4[18], sh4[17], sh4[16], sh4[15], 
      sh4[14], sh4[13], sh4[12], sh4[11], sh4[10], sh4[9], sh4[8], sh4[7], 
      sh4[6], sh4[5], sh4[4], sh4[3], sh4[2]}), .d2({sh4[29], sh4[28], sh4[27], 
      sh4[26], sh4[25], sh4[24], sh4[23], sh4[22], sh4[21], sh4[20], sh4[19], 
      sh4[18], sh4[17], sh4[16], sh4[15], sh4[14], sh4[13], sh4[12], sh4[11], 
      sh4[10], sh4[9], sh4[8], sh4[7], sh4[6], sh4[5], sh4[4], sh4[3], sh4[2], 
      sh4[1], sh4[0], gnd, gnd}), .s0(muxcon_0[1]), .s1(muxcon_1[1]), 
      .y(sh2[31:0]));
  DatapathDone__mux3_dp_1x_32 mux3_sh4(.d0(sh8[31:0]), .d1({f, f, f, f, 
      sh8[31], sh8[30], sh8[29], sh8[28], sh8[27], sh8[26], sh8[25], sh8[24], 
      sh8[23], sh8[22], sh8[21], sh8[20], sh8[19], sh8[18], sh8[17], sh8[16], 
      sh8[15], sh8[14], sh8[13], sh8[12], sh8[11], sh8[10], sh8[9], sh8[8], 
      sh8[7], sh8[6], sh8[5], sh8[4]}), .d2({sh8[27], sh8[26], sh8[25], 
      sh8[24], sh8[23], sh8[22], sh8[21], sh8[20], sh8[19], sh8[18], sh8[17], 
      sh8[16], sh8[15], sh8[14], sh8[13], sh8[12], sh8[11], sh8[10], sh8[9], 
      sh8[8], sh8[7], sh8[6], sh8[5], sh8[4], sh8[3], sh8[2], sh8[1], sh8[0], 
      gnd, gnd, gnd, gnd}), .s0(muxcon_0[2]), .s1(muxcon_1[2]), 
      .y(sh4[31:0]));
  DatapathDone__mux3_dp_1x_32 mux3_sh8(.d0(sh16[31:0]), .d1({f, f, f, f, f, f, 
      f, f, sh16[31], sh16[30], sh16[29], sh16[28], sh16[27], sh16[26], 
      sh16[25], sh16[24], sh16[23], sh16[22], sh16[21], sh16[20], sh16[19], 
      sh16[18], sh16[17], sh16[16], sh16[15], sh16[14], sh16[13], sh16[12], 
      sh16[11], sh16[10], sh16[9], sh16[8]}), .d2({sh16[23], sh16[22], 
      sh16[21], sh16[20], sh16[19], sh16[18], sh16[17], sh16[16], sh16[15], 
      sh16[14], sh16[13], sh16[12], sh16[11], sh16[10], sh16[9], sh16[8], 
      sh16[7], sh16[6], sh16[5], sh16[4], sh16[3], sh16[2], sh16[1], sh16[0], 
      gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd}), .s0(muxcon_0[3]), 
      .s1(muxcon_1[3]), .y(sh8[31:0]));
  DatapathDone__mux3_dp_1x_32 mux3_sh16(.d0(srcb3E[31:0]), .d1({f, f, f, f, f, 
      f, f, f, f, f, f, f, f, f, f, f, srcb3E[31], srcb3E[30], srcb3E[29], 
      srcb3E[28], srcb3E[27], srcb3E[26], srcb3E[25], srcb3E[24], srcb3E[23], 
      srcb3E[22], srcb3E[21], srcb3E[20], srcb3E[19], srcb3E[18], srcb3E[17], 
      srcb3E[16]}), .d2({srcb3E[15], srcb3E[14], srcb3E[13], srcb3E[12], 
      srcb3E[11], srcb3E[10], srcb3E[9], srcb3E[8], srcb3E[7], srcb3E[6], 
      srcb3E[5], srcb3E[4], srcb3E[3], srcb3E[2], srcb3E[1], srcb3E[0], gnd, 
      gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, 
      gnd}), .s0(muxcon_0[4]), .s1(muxcon_1[4]), .y(sh16[31:0]));
endmodule   /* DatapathDone__Shifter_dp */

module DatapathDone__mux4_dp_1x_32(d0, d1, d2, d3, s0, s1, y);
  input [31:0] d0;
  input [31:0] d1;
  input [31:0] d2;
  input [31:0] d3;
  input s0;
  input s1;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_66, net_70, net_78, net_79;

  DatapathDone__invbuf_4x invbuf_4_0(.s(s0), .s_out(net_66), .sb_out(net_78));
  DatapathDone__invbuf_4x invbuf_4_1(.s(s1), .s_out(net_79), .sb_out(net_70));
  DatapathDone__mux4_dp_1x mux4_dp_1x_31_(.d0(d0[31]), .d1(d1[31]), 
      .d2(d2[31]), .d3(d3[31]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[31]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_30_(.d0(d0[30]), .d1(d1[30]), 
      .d2(d2[30]), .d3(d3[30]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[30]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_29_(.d0(d0[29]), .d1(d1[29]), 
      .d2(d2[29]), .d3(d3[29]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[29]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_28_(.d0(d0[28]), .d1(d1[28]), 
      .d2(d2[28]), .d3(d3[28]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[28]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_27_(.d0(d0[27]), .d1(d1[27]), 
      .d2(d2[27]), .d3(d3[27]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[27]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_26_(.d0(d0[26]), .d1(d1[26]), 
      .d2(d2[26]), .d3(d3[26]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[26]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_25_(.d0(d0[25]), .d1(d1[25]), 
      .d2(d2[25]), .d3(d3[25]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[25]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_24_(.d0(d0[24]), .d1(d1[24]), 
      .d2(d2[24]), .d3(d3[24]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[24]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_23_(.d0(d0[23]), .d1(d1[23]), 
      .d2(d2[23]), .d3(d3[23]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[23]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_22_(.d0(d0[22]), .d1(d1[22]), 
      .d2(d2[22]), .d3(d3[22]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[22]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_21_(.d0(d0[21]), .d1(d1[21]), 
      .d2(d2[21]), .d3(d3[21]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[21]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_20_(.d0(d0[20]), .d1(d1[20]), 
      .d2(d2[20]), .d3(d3[20]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[20]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_19_(.d0(d0[19]), .d1(d1[19]), 
      .d2(d2[19]), .d3(d3[19]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[19]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_18_(.d0(d0[18]), .d1(d1[18]), 
      .d2(d2[18]), .d3(d3[18]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[18]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_17_(.d0(d0[17]), .d1(d1[17]), 
      .d2(d2[17]), .d3(d3[17]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[17]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_16_(.d0(d0[16]), .d1(d1[16]), 
      .d2(d2[16]), .d3(d3[16]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[16]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_15_(.d0(d0[15]), .d1(d1[15]), 
      .d2(d2[15]), .d3(d3[15]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[15]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_14_(.d0(d0[14]), .d1(d1[14]), 
      .d2(d2[14]), .d3(d3[14]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[14]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_13_(.d0(d0[13]), .d1(d1[13]), 
      .d2(d2[13]), .d3(d3[13]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[13]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_12_(.d0(d0[12]), .d1(d1[12]), 
      .d2(d2[12]), .d3(d3[12]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[12]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_11_(.d0(d0[11]), .d1(d1[11]), 
      .d2(d2[11]), .d3(d3[11]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[11]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_10_(.d0(d0[10]), .d1(d1[10]), 
      .d2(d2[10]), .d3(d3[10]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[10]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_9_(.d0(d0[9]), .d1(d1[9]), .d2(d2[9]), 
      .d3(d3[9]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[9]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_8_(.d0(d0[8]), .d1(d1[8]), .d2(d2[8]), 
      .d3(d3[8]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[8]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_7_(.d0(d0[7]), .d1(d1[7]), .d2(d2[7]), 
      .d3(d3[7]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[7]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_6_(.d0(d0[6]), .d1(d1[6]), .d2(d2[6]), 
      .d3(d3[6]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[6]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_5_(.d0(d0[5]), .d1(d1[5]), .d2(d2[5]), 
      .d3(d3[5]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[5]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_4_(.d0(d0[4]), .d1(d1[4]), .d2(d2[4]), 
      .d3(d3[4]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[4]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_3_(.d0(d0[3]), .d1(d1[3]), .d2(d2[3]), 
      .d3(d3[3]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[3]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_2_(.d0(d0[2]), .d1(d1[2]), .d2(d2[2]), 
      .d3(d3[2]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[2]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_1_(.d0(d0[1]), .d1(d1[1]), .d2(d2[1]), 
      .d3(d3[1]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[1]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_0_(.d0(d0[0]), .d1(d1[0]), .d2(d2[0]), 
      .d3(d3[0]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[0]));
endmodule   /* DatapathDone__mux4_dp_1x_32 */

module DatapathDone__adder_34(a, b, cin, cout, s);
  input [33:0] a;
  input [33:0] b;
  input cin;
  output cout;
  output [33:0] s;

  supply1 vdd;
  supply0 gnd;
  wire [32:0] c;

  DatapathDone__fulladder fa_33_(.a(a[33]), .b(b[33]), .c(c[32]), .cout(cout), 
      .s(s[33]));
  DatapathDone__fulladder fa_32_(.a(a[32]), .b(b[32]), .c(c[31]), .cout(c[32]), 
      .s(s[32]));
  DatapathDone__fulladder fa_31_(.a(a[31]), .b(b[31]), .c(c[30]), .cout(c[31]), 
      .s(s[31]));
  DatapathDone__fulladder fa_30_(.a(a[30]), .b(b[30]), .c(c[29]), .cout(c[30]), 
      .s(s[30]));
  DatapathDone__fulladder fa_29_(.a(a[29]), .b(b[29]), .c(c[28]), .cout(c[29]), 
      .s(s[29]));
  DatapathDone__fulladder fa_28_(.a(a[28]), .b(b[28]), .c(c[27]), .cout(c[28]), 
      .s(s[28]));
  DatapathDone__fulladder fa_27_(.a(a[27]), .b(b[27]), .c(c[26]), .cout(c[27]), 
      .s(s[27]));
  DatapathDone__fulladder fa_26_(.a(a[26]), .b(b[26]), .c(c[25]), .cout(c[26]), 
      .s(s[26]));
  DatapathDone__fulladder fa_25_(.a(a[25]), .b(b[25]), .c(c[24]), .cout(c[25]), 
      .s(s[25]));
  DatapathDone__fulladder fa_24_(.a(a[24]), .b(b[24]), .c(c[23]), .cout(c[24]), 
      .s(s[24]));
  DatapathDone__fulladder fa_23_(.a(a[23]), .b(b[23]), .c(c[22]), .cout(c[23]), 
      .s(s[23]));
  DatapathDone__fulladder fa_22_(.a(a[22]), .b(b[22]), .c(c[21]), .cout(c[22]), 
      .s(s[22]));
  DatapathDone__fulladder fa_21_(.a(a[21]), .b(b[21]), .c(c[20]), .cout(c[21]), 
      .s(s[21]));
  DatapathDone__fulladder fa_20_(.a(a[20]), .b(b[20]), .c(c[19]), .cout(c[20]), 
      .s(s[20]));
  DatapathDone__fulladder fa_19_(.a(a[19]), .b(b[19]), .c(c[18]), .cout(c[19]), 
      .s(s[19]));
  DatapathDone__fulladder fa_18_(.a(a[18]), .b(b[18]), .c(c[17]), .cout(c[18]), 
      .s(s[18]));
  DatapathDone__fulladder fa_17_(.a(a[17]), .b(b[17]), .c(c[16]), .cout(c[17]), 
      .s(s[17]));
  DatapathDone__fulladder fa_16_(.a(a[16]), .b(b[16]), .c(c[15]), .cout(c[16]), 
      .s(s[16]));
  DatapathDone__fulladder fa_15_(.a(a[15]), .b(b[15]), .c(c[14]), .cout(c[15]), 
      .s(s[15]));
  DatapathDone__fulladder fa_14_(.a(a[14]), .b(b[14]), .c(c[13]), .cout(c[14]), 
      .s(s[14]));
  DatapathDone__fulladder fa_13_(.a(a[13]), .b(b[13]), .c(c[12]), .cout(c[13]), 
      .s(s[13]));
  DatapathDone__fulladder fa_12_(.a(a[12]), .b(b[12]), .c(c[11]), .cout(c[12]), 
      .s(s[12]));
  DatapathDone__fulladder fa_11_(.a(a[11]), .b(b[11]), .c(c[10]), .cout(c[11]), 
      .s(s[11]));
  DatapathDone__fulladder fa_10_(.a(a[10]), .b(b[10]), .c(c[9]), .cout(c[10]), 
      .s(s[10]));
  DatapathDone__fulladder fa_9_(.a(a[9]), .b(b[9]), .c(c[8]), .cout(c[9]), 
      .s(s[9]));
  DatapathDone__fulladder fa_8_(.a(a[8]), .b(b[8]), .c(c[7]), .cout(c[8]), 
      .s(s[8]));
  DatapathDone__fulladder fa_7_(.a(a[7]), .b(b[7]), .c(c[6]), .cout(c[7]), 
      .s(s[7]));
  DatapathDone__fulladder fa_6_(.a(a[6]), .b(b[6]), .c(c[5]), .cout(c[6]), 
      .s(s[6]));
  DatapathDone__fulladder fa_5_(.a(a[5]), .b(b[5]), .c(c[4]), .cout(c[5]), 
      .s(s[5]));
  DatapathDone__fulladder fa_4_(.a(a[4]), .b(b[4]), .c(c[3]), .cout(c[4]), 
      .s(s[4]));
  DatapathDone__fulladder fa_3_(.a(a[3]), .b(b[3]), .c(c[2]), .cout(c[3]), 
      .s(s[3]));
  DatapathDone__fulladder fa_2_(.a(a[2]), .b(b[2]), .c(c[1]), .cout(c[2]), 
      .s(s[2]));
  DatapathDone__fulladder fa_1_(.a(a[1]), .b(b[1]), .c(c[0]), .cout(c[1]), 
      .s(s[1]));
  DatapathDone__fulladder fa_0_(.a(a[0]), .b(b[0]), .c(cin), .cout(c[0]), 
      .s(s[0]));
endmodule   /* DatapathDone__adder_34 */

module DatapathDone__mux4_dp_1x_34(d0, d1, d2, d3, s0, s1, y);
  input [33:0] d0;
  input [33:0] d1;
  input [33:0] d2;
  input [33:0] d3;
  input s0;
  input s1;
  output [33:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_66, net_70, net_78, net_79;

  DatapathDone__invbuf_4x invbuf_4_0(.s(s0), .s_out(net_66), .sb_out(net_78));
  DatapathDone__invbuf_4x invbuf_4_1(.s(s1), .s_out(net_79), .sb_out(net_70));
  DatapathDone__mux4_dp_1x mux4_dp_1x_33_(.d0(d0[33]), .d1(d1[33]), 
      .d2(d2[33]), .d3(d3[33]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[33]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_32_(.d0(d0[32]), .d1(d1[32]), 
      .d2(d2[32]), .d3(d3[32]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[32]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_31_(.d0(d0[31]), .d1(d1[31]), 
      .d2(d2[31]), .d3(d3[31]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[31]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_30_(.d0(d0[30]), .d1(d1[30]), 
      .d2(d2[30]), .d3(d3[30]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[30]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_29_(.d0(d0[29]), .d1(d1[29]), 
      .d2(d2[29]), .d3(d3[29]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[29]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_28_(.d0(d0[28]), .d1(d1[28]), 
      .d2(d2[28]), .d3(d3[28]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[28]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_27_(.d0(d0[27]), .d1(d1[27]), 
      .d2(d2[27]), .d3(d3[27]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[27]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_26_(.d0(d0[26]), .d1(d1[26]), 
      .d2(d2[26]), .d3(d3[26]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[26]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_25_(.d0(d0[25]), .d1(d1[25]), 
      .d2(d2[25]), .d3(d3[25]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[25]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_24_(.d0(d0[24]), .d1(d1[24]), 
      .d2(d2[24]), .d3(d3[24]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[24]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_23_(.d0(d0[23]), .d1(d1[23]), 
      .d2(d2[23]), .d3(d3[23]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[23]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_22_(.d0(d0[22]), .d1(d1[22]), 
      .d2(d2[22]), .d3(d3[22]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[22]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_21_(.d0(d0[21]), .d1(d1[21]), 
      .d2(d2[21]), .d3(d3[21]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[21]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_20_(.d0(d0[20]), .d1(d1[20]), 
      .d2(d2[20]), .d3(d3[20]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[20]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_19_(.d0(d0[19]), .d1(d1[19]), 
      .d2(d2[19]), .d3(d3[19]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[19]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_18_(.d0(d0[18]), .d1(d1[18]), 
      .d2(d2[18]), .d3(d3[18]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[18]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_17_(.d0(d0[17]), .d1(d1[17]), 
      .d2(d2[17]), .d3(d3[17]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[17]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_16_(.d0(d0[16]), .d1(d1[16]), 
      .d2(d2[16]), .d3(d3[16]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[16]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_15_(.d0(d0[15]), .d1(d1[15]), 
      .d2(d2[15]), .d3(d3[15]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[15]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_14_(.d0(d0[14]), .d1(d1[14]), 
      .d2(d2[14]), .d3(d3[14]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[14]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_13_(.d0(d0[13]), .d1(d1[13]), 
      .d2(d2[13]), .d3(d3[13]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[13]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_12_(.d0(d0[12]), .d1(d1[12]), 
      .d2(d2[12]), .d3(d3[12]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[12]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_11_(.d0(d0[11]), .d1(d1[11]), 
      .d2(d2[11]), .d3(d3[11]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[11]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_10_(.d0(d0[10]), .d1(d1[10]), 
      .d2(d2[10]), .d3(d3[10]), .s0(net_66), .s0b(net_78), .s1(net_79), 
      .s1b(net_70), .y(y[10]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_9_(.d0(d0[9]), .d1(d1[9]), .d2(d2[9]), 
      .d3(d3[9]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[9]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_8_(.d0(d0[8]), .d1(d1[8]), .d2(d2[8]), 
      .d3(d3[8]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[8]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_7_(.d0(d0[7]), .d1(d1[7]), .d2(d2[7]), 
      .d3(d3[7]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[7]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_6_(.d0(d0[6]), .d1(d1[6]), .d2(d2[6]), 
      .d3(d3[6]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[6]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_5_(.d0(d0[5]), .d1(d1[5]), .d2(d2[5]), 
      .d3(d3[5]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[5]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_4_(.d0(d0[4]), .d1(d1[4]), .d2(d2[4]), 
      .d3(d3[4]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[4]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_3_(.d0(d0[3]), .d1(d1[3]), .d2(d2[3]), 
      .d3(d3[3]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[3]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_2_(.d0(d0[2]), .d1(d1[2]), .d2(d2[2]), 
      .d3(d3[2]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[2]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_1_(.d0(d0[1]), .d1(d1[1]), .d2(d2[1]), 
      .d3(d3[1]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[1]));
  DatapathDone__mux4_dp_1x mux4_dp_1x_0_(.d0(d0[0]), .d1(d1[0]), .d2(d2[0]), 
      .d3(d3[0]), .s0(net_66), .s0b(net_78), .s1(net_79), .s1b(net_70), 
      .y(y[0]));
endmodule   /* DatapathDone__mux4_dp_1x_34 */

module DatapathDone__boothsel(a, boothsel, signedopsaved, y);
  input [31:0] a;
  input [2:0] boothsel;
  input signedopsaved;
  output [33:0] y;

  supply1 vdd;
  supply0 gnd;
  wire boothsel2b;
  wire [33:0] yb;
  wire [33:0] ym1;
  wire [33:0] ym2;
  wire [32:32] yp1;

  DatapathDone__and2_1x and_1(.a(a[31]), .b(signedopsaved), .y(yp1[32]));
  DatapathDone__mux4_dp_1x_34 boothmux_34(.d0({yp1[32], yp1[32], a[31], a[30], 
      a[29], a[28], a[27], a[26], a[25], a[24], a[23], a[22], a[21], a[20], 
      a[19], a[18], a[17], a[16], a[15], a[14], a[13], a[12], a[11], a[10], 
      a[9], a[8], a[7], a[6], a[5], a[4], a[3], a[2], a[1], a[0]}), 
      .d1({yp1[32], a[31], a[30], a[29], a[28], a[27], a[26], a[25], a[24], 
      a[23], a[22], a[21], a[20], a[19], a[18], a[17], a[16], a[15], a[14], 
      a[13], a[12], a[11], a[10], a[9], a[8], a[7], a[6], a[5], a[4], a[3], 
      a[2], a[1], a[0], gnd}), .d2(ym1[33:0]), .d3(ym2[33:0]), 
      .s0(boothsel[0]), .s1(boothsel[1]), .y(yb[33:0]));
  DatapathDone__and2_1x boothzero_33_(.a(boothsel2b), .b(yb[33]), .y(y[33]));
  DatapathDone__and2_1x boothzero_32_(.a(boothsel2b), .b(yb[32]), .y(y[32]));
  DatapathDone__and2_1x boothzero_31_(.a(boothsel2b), .b(yb[31]), .y(y[31]));
  DatapathDone__and2_1x boothzero_30_(.a(boothsel2b), .b(yb[30]), .y(y[30]));
  DatapathDone__and2_1x boothzero_29_(.a(boothsel2b), .b(yb[29]), .y(y[29]));
  DatapathDone__and2_1x boothzero_28_(.a(boothsel2b), .b(yb[28]), .y(y[28]));
  DatapathDone__and2_1x boothzero_27_(.a(boothsel2b), .b(yb[27]), .y(y[27]));
  DatapathDone__and2_1x boothzero_26_(.a(boothsel2b), .b(yb[26]), .y(y[26]));
  DatapathDone__and2_1x boothzero_25_(.a(boothsel2b), .b(yb[25]), .y(y[25]));
  DatapathDone__and2_1x boothzero_24_(.a(boothsel2b), .b(yb[24]), .y(y[24]));
  DatapathDone__and2_1x boothzero_23_(.a(boothsel2b), .b(yb[23]), .y(y[23]));
  DatapathDone__and2_1x boothzero_22_(.a(boothsel2b), .b(yb[22]), .y(y[22]));
  DatapathDone__and2_1x boothzero_21_(.a(boothsel2b), .b(yb[21]), .y(y[21]));
  DatapathDone__and2_1x boothzero_20_(.a(boothsel2b), .b(yb[20]), .y(y[20]));
  DatapathDone__and2_1x boothzero_19_(.a(boothsel2b), .b(yb[19]), .y(y[19]));
  DatapathDone__and2_1x boothzero_18_(.a(boothsel2b), .b(yb[18]), .y(y[18]));
  DatapathDone__and2_1x boothzero_17_(.a(boothsel2b), .b(yb[17]), .y(y[17]));
  DatapathDone__and2_1x boothzero_16_(.a(boothsel2b), .b(yb[16]), .y(y[16]));
  DatapathDone__and2_1x boothzero_15_(.a(boothsel2b), .b(yb[15]), .y(y[15]));
  DatapathDone__and2_1x boothzero_14_(.a(boothsel2b), .b(yb[14]), .y(y[14]));
  DatapathDone__and2_1x boothzero_13_(.a(boothsel2b), .b(yb[13]), .y(y[13]));
  DatapathDone__and2_1x boothzero_12_(.a(boothsel2b), .b(yb[12]), .y(y[12]));
  DatapathDone__and2_1x boothzero_11_(.a(boothsel2b), .b(yb[11]), .y(y[11]));
  DatapathDone__and2_1x boothzero_10_(.a(boothsel2b), .b(yb[10]), .y(y[10]));
  DatapathDone__and2_1x boothzero_9_(.a(boothsel2b), .b(yb[9]), .y(y[9]));
  DatapathDone__and2_1x boothzero_8_(.a(boothsel2b), .b(yb[8]), .y(y[8]));
  DatapathDone__and2_1x boothzero_7_(.a(boothsel2b), .b(yb[7]), .y(y[7]));
  DatapathDone__and2_1x boothzero_6_(.a(boothsel2b), .b(yb[6]), .y(y[6]));
  DatapathDone__and2_1x boothzero_5_(.a(boothsel2b), .b(yb[5]), .y(y[5]));
  DatapathDone__and2_1x boothzero_4_(.a(boothsel2b), .b(yb[4]), .y(y[4]));
  DatapathDone__and2_1x boothzero_3_(.a(boothsel2b), .b(yb[3]), .y(y[3]));
  DatapathDone__and2_1x boothzero_2_(.a(boothsel2b), .b(yb[2]), .y(y[2]));
  DatapathDone__and2_1x boothzero_1_(.a(boothsel2b), .b(yb[1]), .y(y[1]));
  DatapathDone__and2_1x boothzero_0_(.a(boothsel2b), .b(yb[0]), .y(y[0]));
  DatapathDone__inv_1x inv_1x_2_33_(.a(yp1[32]), .y(ym1[33]));
  DatapathDone__inv_1x inv_1x_2_32_(.a(yp1[32]), .y(ym1[32]));
  DatapathDone__inv_1x inv_1x_2_31_(.a(a[31]), .y(ym1[31]));
  DatapathDone__inv_1x inv_1x_2_30_(.a(a[30]), .y(ym1[30]));
  DatapathDone__inv_1x inv_1x_2_29_(.a(a[29]), .y(ym1[29]));
  DatapathDone__inv_1x inv_1x_2_28_(.a(a[28]), .y(ym1[28]));
  DatapathDone__inv_1x inv_1x_2_27_(.a(a[27]), .y(ym1[27]));
  DatapathDone__inv_1x inv_1x_2_26_(.a(a[26]), .y(ym1[26]));
  DatapathDone__inv_1x inv_1x_2_25_(.a(a[25]), .y(ym1[25]));
  DatapathDone__inv_1x inv_1x_2_24_(.a(a[24]), .y(ym1[24]));
  DatapathDone__inv_1x inv_1x_2_23_(.a(a[23]), .y(ym1[23]));
  DatapathDone__inv_1x inv_1x_2_22_(.a(a[22]), .y(ym1[22]));
  DatapathDone__inv_1x inv_1x_2_21_(.a(a[21]), .y(ym1[21]));
  DatapathDone__inv_1x inv_1x_2_20_(.a(a[20]), .y(ym1[20]));
  DatapathDone__inv_1x inv_1x_2_19_(.a(a[19]), .y(ym1[19]));
  DatapathDone__inv_1x inv_1x_2_18_(.a(a[18]), .y(ym1[18]));
  DatapathDone__inv_1x inv_1x_2_17_(.a(a[17]), .y(ym1[17]));
  DatapathDone__inv_1x inv_1x_2_16_(.a(a[16]), .y(ym1[16]));
  DatapathDone__inv_1x inv_1x_2_15_(.a(a[15]), .y(ym1[15]));
  DatapathDone__inv_1x inv_1x_2_14_(.a(a[14]), .y(ym1[14]));
  DatapathDone__inv_1x inv_1x_2_13_(.a(a[13]), .y(ym1[13]));
  DatapathDone__inv_1x inv_1x_2_12_(.a(a[12]), .y(ym1[12]));
  DatapathDone__inv_1x inv_1x_2_11_(.a(a[11]), .y(ym1[11]));
  DatapathDone__inv_1x inv_1x_2_10_(.a(a[10]), .y(ym1[10]));
  DatapathDone__inv_1x inv_1x_2_9_(.a(a[9]), .y(ym1[9]));
  DatapathDone__inv_1x inv_1x_2_8_(.a(a[8]), .y(ym1[8]));
  DatapathDone__inv_1x inv_1x_2_7_(.a(a[7]), .y(ym1[7]));
  DatapathDone__inv_1x inv_1x_2_6_(.a(a[6]), .y(ym1[6]));
  DatapathDone__inv_1x inv_1x_2_5_(.a(a[5]), .y(ym1[5]));
  DatapathDone__inv_1x inv_1x_2_4_(.a(a[4]), .y(ym1[4]));
  DatapathDone__inv_1x inv_1x_2_3_(.a(a[3]), .y(ym1[3]));
  DatapathDone__inv_1x inv_1x_2_2_(.a(a[2]), .y(ym1[2]));
  DatapathDone__inv_1x inv_1x_2_1_(.a(a[1]), .y(ym1[1]));
  DatapathDone__inv_1x inv_1x_2_0_(.a(a[0]), .y(ym1[0]));
  DatapathDone__inv_1x inv_1x_3_33_(.a(yp1[32]), .y(ym2[33]));
  DatapathDone__inv_1x inv_1x_3_32_(.a(a[31]), .y(ym2[32]));
  DatapathDone__inv_1x inv_1x_3_31_(.a(a[30]), .y(ym2[31]));
  DatapathDone__inv_1x inv_1x_3_30_(.a(a[29]), .y(ym2[30]));
  DatapathDone__inv_1x inv_1x_3_29_(.a(a[28]), .y(ym2[29]));
  DatapathDone__inv_1x inv_1x_3_28_(.a(a[27]), .y(ym2[28]));
  DatapathDone__inv_1x inv_1x_3_27_(.a(a[26]), .y(ym2[27]));
  DatapathDone__inv_1x inv_1x_3_26_(.a(a[25]), .y(ym2[26]));
  DatapathDone__inv_1x inv_1x_3_25_(.a(a[24]), .y(ym2[25]));
  DatapathDone__inv_1x inv_1x_3_24_(.a(a[23]), .y(ym2[24]));
  DatapathDone__inv_1x inv_1x_3_23_(.a(a[22]), .y(ym2[23]));
  DatapathDone__inv_1x inv_1x_3_22_(.a(a[21]), .y(ym2[22]));
  DatapathDone__inv_1x inv_1x_3_21_(.a(a[20]), .y(ym2[21]));
  DatapathDone__inv_1x inv_1x_3_20_(.a(a[19]), .y(ym2[20]));
  DatapathDone__inv_1x inv_1x_3_19_(.a(a[18]), .y(ym2[19]));
  DatapathDone__inv_1x inv_1x_3_18_(.a(a[17]), .y(ym2[18]));
  DatapathDone__inv_1x inv_1x_3_17_(.a(a[16]), .y(ym2[17]));
  DatapathDone__inv_1x inv_1x_3_16_(.a(a[15]), .y(ym2[16]));
  DatapathDone__inv_1x inv_1x_3_15_(.a(a[14]), .y(ym2[15]));
  DatapathDone__inv_1x inv_1x_3_14_(.a(a[13]), .y(ym2[14]));
  DatapathDone__inv_1x inv_1x_3_13_(.a(a[12]), .y(ym2[13]));
  DatapathDone__inv_1x inv_1x_3_12_(.a(a[11]), .y(ym2[12]));
  DatapathDone__inv_1x inv_1x_3_11_(.a(a[10]), .y(ym2[11]));
  DatapathDone__inv_1x inv_1x_3_10_(.a(a[9]), .y(ym2[10]));
  DatapathDone__inv_1x inv_1x_3_9_(.a(a[8]), .y(ym2[9]));
  DatapathDone__inv_1x inv_1x_3_8_(.a(a[7]), .y(ym2[8]));
  DatapathDone__inv_1x inv_1x_3_7_(.a(a[6]), .y(ym2[7]));
  DatapathDone__inv_1x inv_1x_3_6_(.a(a[5]), .y(ym2[6]));
  DatapathDone__inv_1x inv_1x_3_5_(.a(a[4]), .y(ym2[5]));
  DatapathDone__inv_1x inv_1x_3_4_(.a(a[3]), .y(ym2[4]));
  DatapathDone__inv_1x inv_1x_3_3_(.a(a[2]), .y(ym2[3]));
  DatapathDone__inv_1x inv_1x_3_2_(.a(a[1]), .y(ym2[2]));
  DatapathDone__inv_1x inv_1x_3_1_(.a(a[0]), .y(ym2[1]));
  DatapathDone__inv_1x inv_1x_3_0_(.a(gnd), .y(ym2[0]));
  DatapathDone__inv_4x inv_4x_0(.a(boothsel[2]), .y(boothsel2b));
endmodule   /* DatapathDone__boothsel */

module DatapathDone__controlPLA(casein, casein_1, casein_10, casein_11, 
      casein_12, casein_13, casein_14, casein_15, casein_16, casein_2, 
      casein_3, casein_4, casein_5, casein_6, casein_7, casein_8, casein_9, 
      caseout, caseout_1, caseout_10, caseout_2, caseout_3, caseout_4, 
      caseout_5, caseout_6, caseout_7, caseout_8, caseout_9);
  input [0:0] casein;
  input [1:1] casein_1;
  input [10:10] casein_10;
  input [11:11] casein_11;
  input [12:12] casein_12;
  input [13:13] casein_13;
  input [14:14] casein_14;
  input [15:15] casein_15;
  input [16:16] casein_16;
  input [2:2] casein_2;
  input [3:3] casein_3;
  input [4:4] casein_4;
  input [5:5] casein_5;
  input [6:6] casein_6;
  input [7:7] casein_7;
  input [8:8] casein_8;
  input [9:9] casein_9;
  output [0:0] caseout;
  output [1:1] caseout_1;
  output [10:10] caseout_10;
  output [2:2] caseout_2;
  output [3:3] caseout_3;
  output [4:4] caseout_4;
  output [5:5] caseout_5;
  output [6:6] caseout_6;
  output [7:7] caseout_7;
  output [8:8] caseout_8;
  output [9:9] caseout_9;

  supply1 vdd;
  supply0 gnd;
  wire net_0, net_1007, net_1017, net_1034, net_104, net_1044, net_1061;
  wire net_1071, net_1088, net_1099, net_112, net_1120, net_1131, net_1152;
  wire net_1163, net_1184, net_1195, net_120, net_1216, net_1227, net_1248;
  wire net_1259, net_128, net_1280, net_1291, net_1312, net_1323, net_1344;
  wire net_1356, net_16, net_1613, net_1622, net_1627, net_1634, net_1643;
  wire net_1674, net_1701, net_1730, net_1759, net_1784, net_1789, net_24;
  wire net_32, net_40, net_48, net_503, net_517, net_550, net_56, net_564;
  wire net_597, net_611, net_64, net_644, net_658, net_691, net_703, net_72;
  wire net_728, net_741, net_770, net_783, net_8, net_80, net_812, net_825;
  wire net_854, net_867, net_88, net_896, net_909, net_938, net_951, net_96;
  wire net_980, net_990;

  tranif1 nmos_4(gnd, net_0, casein_16[16]);
  tranif1 nmos_12(gnd, net_8, casein_15[15]);
  tranif1 nmos_20(gnd, net_16, casein_14[14]);
  tranif1 nmos_28(gnd, net_24, casein_13[13]);
  tranif1 nmos_36(gnd, net_32, casein_12[12]);
  tranif1 nmos_44(gnd, net_40, casein_11[11]);
  tranif1 nmos_52(gnd, net_48, casein_10[10]);
  tranif1 nmos_60(gnd, net_56, casein_9[9]);
  tranif1 nmos_68(gnd, net_64, casein_8[8]);
  tranif1 nmos_76(gnd, net_72, casein_7[7]);
  tranif1 nmos_84(gnd, net_80, casein_6[6]);
  tranif1 nmos_92(gnd, net_88, casein_5[5]);
  tranif1 nmos_100(gnd, net_96, casein_4[4]);
  tranif1 nmos_108(gnd, net_104, casein_3[3]);
  tranif1 nmos_116(gnd, net_112, casein_2[2]);
  tranif1 nmos_124(gnd, net_120, casein_1[1]);
  tranif1 nmos_132(gnd, net_128, casein[0]);
  tranif1 nmos_138(net_503, gnd, casein_16[16]);
  tranif1 nmos_139(net_503, gnd, net_8);
  tranif1 nmos_140(net_503, gnd, casein_14[14]);
  tranif1 nmos_141(net_503, gnd, casein_11[11]);
  tranif1 nmos_142(net_503, gnd, casein_10[10]);
  tranif1 nmos_143(net_503, gnd, casein_9[9]);
  tranif1 nmos_144(net_503, gnd, net_104);
  tranif1 nmos_145(net_503, gnd, net_120);
  tranif1 nmos_146(net_503, gnd, net_128);
  tranif1 nmos_147(gnd, net_517, casein_16[16]);
  tranif1 nmos_148(gnd, net_517, net_8);
  tranif1 nmos_149(gnd, net_517, casein_14[14]);
  tranif1 nmos_150(gnd, net_517, casein_11[11]);
  tranif1 nmos_151(gnd, net_517, casein_10[10]);
  tranif1 nmos_152(gnd, net_517, casein_9[9]);
  tranif1 nmos_153(gnd, net_517, net_104);
  tranif1 nmos_154(gnd, net_517, net_120);
  tranif1 nmos_155(gnd, net_517, casein[0]);
  tranif1 nmos_156(net_550, gnd, casein_16[16]);
  tranif1 nmos_157(net_550, gnd, net_8);
  tranif1 nmos_158(net_550, gnd, casein_14[14]);
  tranif1 nmos_159(net_550, gnd, casein_11[11]);
  tranif1 nmos_160(net_550, gnd, casein_10[10]);
  tranif1 nmos_161(net_550, gnd, casein_9[9]);
  tranif1 nmos_162(net_550, gnd, net_104);
  tranif1 nmos_163(net_550, gnd, casein_1[1]);
  tranif1 nmos_164(net_550, gnd, net_128);
  tranif1 nmos_165(gnd, net_564, casein_16[16]);
  tranif1 nmos_166(gnd, net_564, net_8);
  tranif1 nmos_167(gnd, net_564, casein_14[14]);
  tranif1 nmos_168(gnd, net_564, casein_11[11]);
  tranif1 nmos_169(gnd, net_564, casein_10[10]);
  tranif1 nmos_170(gnd, net_564, casein_9[9]);
  tranif1 nmos_171(gnd, net_564, net_104);
  tranif1 nmos_172(gnd, net_564, casein_1[1]);
  tranif1 nmos_173(gnd, net_564, casein[0]);
  tranif1 nmos_174(net_597, gnd, casein_16[16]);
  tranif1 nmos_175(net_597, gnd, net_8);
  tranif1 nmos_176(net_597, gnd, casein_14[14]);
  tranif1 nmos_177(net_597, gnd, casein_11[11]);
  tranif1 nmos_178(net_597, gnd, casein_10[10]);
  tranif1 nmos_179(net_597, gnd, casein_9[9]);
  tranif1 nmos_180(net_597, gnd, casein_3[3]);
  tranif1 nmos_181(net_597, gnd, net_120);
  tranif1 nmos_182(net_597, gnd, net_128);
  tranif1 nmos_183(gnd, net_611, casein_16[16]);
  tranif1 nmos_184(gnd, net_611, net_8);
  tranif1 nmos_185(gnd, net_611, casein_14[14]);
  tranif1 nmos_186(gnd, net_611, casein_11[11]);
  tranif1 nmos_187(gnd, net_611, casein_10[10]);
  tranif1 nmos_188(gnd, net_611, casein_9[9]);
  tranif1 nmos_189(gnd, net_611, casein_3[3]);
  tranif1 nmos_190(gnd, net_611, net_120);
  tranif1 nmos_191(gnd, net_611, casein[0]);
  tranif1 nmos_192(net_644, gnd, casein_16[16]);
  tranif1 nmos_193(net_644, gnd, net_8);
  tranif1 nmos_194(net_644, gnd, casein_14[14]);
  tranif1 nmos_195(net_644, gnd, casein_11[11]);
  tranif1 nmos_196(net_644, gnd, casein_10[10]);
  tranif1 nmos_197(net_644, gnd, casein_9[9]);
  tranif1 nmos_198(net_644, gnd, casein_3[3]);
  tranif1 nmos_199(net_644, gnd, casein_1[1]);
  tranif1 nmos_200(net_644, gnd, net_128);
  tranif1 nmos_201(gnd, net_658, casein_16[16]);
  tranif1 nmos_202(gnd, net_658, net_8);
  tranif1 nmos_203(gnd, net_658, casein_14[14]);
  tranif1 nmos_204(gnd, net_658, casein_11[11]);
  tranif1 nmos_205(gnd, net_658, casein_10[10]);
  tranif1 nmos_206(gnd, net_658, casein_9[9]);
  tranif1 nmos_207(gnd, net_658, casein_3[3]);
  tranif1 nmos_208(gnd, net_658, casein_1[1]);
  tranif1 nmos_209(gnd, net_658, casein[0]);
  tranif1 nmos_210(net_691, gnd, casein_16[16]);
  tranif1 nmos_211(net_691, gnd, net_8);
  tranif1 nmos_212(net_691, gnd, casein_14[14]);
  tranif1 nmos_213(net_691, gnd, casein_11[11]);
  tranif1 nmos_214(net_691, gnd, casein_10[10]);
  tranif1 nmos_215(net_691, gnd, net_56);
  tranif1 nmos_216(net_691, gnd, net_128);
  tranif1 nmos_217(gnd, net_703, casein_16[16]);
  tranif1 nmos_218(gnd, net_703, net_8);
  tranif1 nmos_219(gnd, net_703, casein_14[14]);
  tranif1 nmos_220(gnd, net_703, casein_11[11]);
  tranif1 nmos_221(gnd, net_703, casein_10[10]);
  tranif1 nmos_222(gnd, net_703, net_56);
  tranif1 nmos_223(gnd, net_703, casein[0]);
  tranif1 nmos_224(net_728, gnd, casein_16[16]);
  tranif1 nmos_225(net_728, gnd, net_8);
  tranif1 nmos_226(net_728, gnd, casein_14[14]);
  tranif1 nmos_227(net_728, gnd, casein_11[11]);
  tranif1 nmos_228(net_728, gnd, net_48);
  tranif1 nmos_229(net_728, gnd, casein_9[9]);
  tranif1 nmos_230(net_728, gnd, net_112);
  tranif1 nmos_231(net_728, gnd, net_128);
  tranif1 nmos_232(gnd, net_741, casein_16[16]);
  tranif1 nmos_233(gnd, net_741, net_8);
  tranif1 nmos_234(gnd, net_741, casein_14[14]);
  tranif1 nmos_235(gnd, net_741, casein_11[11]);
  tranif1 nmos_236(gnd, net_741, net_48);
  tranif1 nmos_237(gnd, net_741, casein_9[9]);
  tranif1 nmos_238(gnd, net_741, net_112);
  tranif1 nmos_239(gnd, net_741, casein[0]);
  tranif1 nmos_240(net_770, gnd, casein_16[16]);
  tranif1 nmos_241(net_770, gnd, net_8);
  tranif1 nmos_242(net_770, gnd, casein_14[14]);
  tranif1 nmos_243(net_770, gnd, casein_11[11]);
  tranif1 nmos_244(net_770, gnd, net_48);
  tranif1 nmos_245(net_770, gnd, casein_9[9]);
  tranif1 nmos_246(net_770, gnd, casein_2[2]);
  tranif1 nmos_247(net_770, gnd, net_128);
  tranif1 nmos_248(gnd, net_783, casein_16[16]);
  tranif1 nmos_249(gnd, net_783, net_8);
  tranif1 nmos_250(gnd, net_783, casein_14[14]);
  tranif1 nmos_251(gnd, net_783, casein_11[11]);
  tranif1 nmos_252(gnd, net_783, net_48);
  tranif1 nmos_253(gnd, net_783, casein_9[9]);
  tranif1 nmos_254(gnd, net_783, casein_2[2]);
  tranif1 nmos_255(gnd, net_783, casein[0]);
  tranif1 nmos_256(net_812, gnd, casein_16[16]);
  tranif1 nmos_257(net_812, gnd, net_8);
  tranif1 nmos_258(net_812, gnd, casein_14[14]);
  tranif1 nmos_259(net_812, gnd, net_40);
  tranif1 nmos_260(net_812, gnd, casein_10[10]);
  tranif1 nmos_261(net_812, gnd, casein_9[9]);
  tranif1 nmos_262(net_812, gnd, net_96);
  tranif1 nmos_263(net_812, gnd, net_128);
  tranif1 nmos_264(gnd, net_825, casein_16[16]);
  tranif1 nmos_265(gnd, net_825, net_8);
  tranif1 nmos_266(gnd, net_825, casein_14[14]);
  tranif1 nmos_267(gnd, net_825, net_40);
  tranif1 nmos_268(gnd, net_825, casein_10[10]);
  tranif1 nmos_269(gnd, net_825, casein_9[9]);
  tranif1 nmos_270(gnd, net_825, net_96);
  tranif1 nmos_271(gnd, net_825, casein[0]);
  tranif1 nmos_272(net_854, gnd, casein_16[16]);
  tranif1 nmos_273(net_854, gnd, net_8);
  tranif1 nmos_274(net_854, gnd, casein_14[14]);
  tranif1 nmos_275(net_854, gnd, net_40);
  tranif1 nmos_276(net_854, gnd, casein_10[10]);
  tranif1 nmos_277(net_854, gnd, casein_9[9]);
  tranif1 nmos_278(net_854, gnd, casein_4[4]);
  tranif1 nmos_279(net_854, gnd, net_128);
  tranif1 nmos_280(gnd, net_867, casein_16[16]);
  tranif1 nmos_281(gnd, net_867, net_8);
  tranif1 nmos_282(gnd, net_867, casein_14[14]);
  tranif1 nmos_283(gnd, net_867, net_40);
  tranif1 nmos_284(gnd, net_867, casein_10[10]);
  tranif1 nmos_285(gnd, net_867, casein_9[9]);
  tranif1 nmos_286(gnd, net_867, casein_4[4]);
  tranif1 nmos_287(gnd, net_867, casein[0]);
  tranif1 nmos_288(net_896, gnd, casein_16[16]);
  tranif1 nmos_289(net_896, gnd, net_8);
  tranif1 nmos_290(net_896, gnd, net_16);
  tranif1 nmos_291(net_896, gnd, casein_11[11]);
  tranif1 nmos_292(net_896, gnd, casein_10[10]);
  tranif1 nmos_293(net_896, gnd, casein_9[9]);
  tranif1 nmos_294(net_896, gnd, net_88);
  tranif1 nmos_295(net_896, gnd, net_128);
  tranif1 nmos_296(gnd, net_909, casein_16[16]);
  tranif1 nmos_297(gnd, net_909, net_8);
  tranif1 nmos_298(gnd, net_909, net_16);
  tranif1 nmos_299(gnd, net_909, casein_11[11]);
  tranif1 nmos_300(gnd, net_909, casein_10[10]);
  tranif1 nmos_301(gnd, net_909, casein_9[9]);
  tranif1 nmos_302(gnd, net_909, casein_5[5]);
  tranif1 nmos_303(gnd, net_909, net_128);
  tranif1 nmos_304(net_938, gnd, casein_16[16]);
  tranif1 nmos_305(net_938, gnd, net_8);
  tranif1 nmos_306(net_938, gnd, net_16);
  tranif1 nmos_307(net_938, gnd, casein_11[11]);
  tranif1 nmos_308(net_938, gnd, casein_10[10]);
  tranif1 nmos_309(net_938, gnd, casein_9[9]);
  tranif1 nmos_310(net_938, gnd, net_88);
  tranif1 nmos_311(net_938, gnd, casein[0]);
  tranif1 nmos_312(gnd, net_951, casein_16[16]);
  tranif1 nmos_313(gnd, net_951, net_8);
  tranif1 nmos_314(gnd, net_951, net_16);
  tranif1 nmos_315(gnd, net_951, casein_11[11]);
  tranif1 nmos_316(gnd, net_951, casein_10[10]);
  tranif1 nmos_317(gnd, net_951, casein_9[9]);
  tranif1 nmos_318(gnd, net_951, casein_5[5]);
  tranif1 nmos_319(gnd, net_951, casein[0]);
  tranif1 nmos_320(net_980, gnd, casein_16[16]);
  tranif1 nmos_321(net_980, gnd, casein_15[15]);
  tranif1 nmos_322(net_980, gnd, casein_12[12]);
  tranif1 nmos_323(net_980, gnd, net_120);
  tranif1 nmos_324(net_980, gnd, net_128);
  tranif1 nmos_325(gnd, net_990, casein_16[16]);
  tranif1 nmos_326(gnd, net_990, casein_15[15]);
  tranif1 nmos_327(gnd, net_990, casein_12[12]);
  tranif1 nmos_328(gnd, net_990, casein_1[1]);
  tranif1 nmos_329(gnd, net_990, net_128);
  tranif1 nmos_330(net_1007, gnd, casein_16[16]);
  tranif1 nmos_331(net_1007, gnd, casein_15[15]);
  tranif1 nmos_332(net_1007, gnd, casein_12[12]);
  tranif1 nmos_333(net_1007, gnd, net_120);
  tranif1 nmos_334(net_1007, gnd, casein[0]);
  tranif1 nmos_335(gnd, net_1017, casein_16[16]);
  tranif1 nmos_336(gnd, net_1017, casein_15[15]);
  tranif1 nmos_337(gnd, net_1017, casein_12[12]);
  tranif1 nmos_338(gnd, net_1017, casein_1[1]);
  tranif1 nmos_339(gnd, net_1017, casein[0]);
  tranif1 nmos_340(net_1034, gnd, casein_16[16]);
  tranif1 nmos_341(net_1034, gnd, casein_15[15]);
  tranif1 nmos_342(net_1034, gnd, net_32);
  tranif1 nmos_343(net_1034, gnd, net_120);
  tranif1 nmos_344(net_1034, gnd, net_128);
  tranif1 nmos_345(gnd, net_1044, casein_16[16]);
  tranif1 nmos_346(gnd, net_1044, casein_15[15]);
  tranif1 nmos_347(gnd, net_1044, net_32);
  tranif1 nmos_348(gnd, net_1044, net_120);
  tranif1 nmos_349(gnd, net_1044, casein[0]);
  tranif1 nmos_350(net_1061, gnd, casein_16[16]);
  tranif1 nmos_351(net_1061, gnd, casein_15[15]);
  tranif1 nmos_352(net_1061, gnd, net_32);
  tranif1 nmos_353(net_1061, gnd, casein_1[1]);
  tranif1 nmos_354(net_1061, gnd, net_128);
  tranif1 nmos_355(gnd, net_1071, casein_16[16]);
  tranif1 nmos_356(gnd, net_1071, casein_15[15]);
  tranif1 nmos_357(gnd, net_1071, net_32);
  tranif1 nmos_358(gnd, net_1071, casein_1[1]);
  tranif1 nmos_359(gnd, net_1071, casein[0]);
  tranif1 nmos_360(net_1088, gnd, net_0);
  tranif1 nmos_361(net_1088, gnd, casein_13[13]);
  tranif1 nmos_362(net_1088, gnd, net_64);
  tranif1 nmos_363(net_1088, gnd, net_72);
  tranif1 nmos_364(net_1088, gnd, net_80);
  tranif1 nmos_365(net_1088, gnd, net_128);
  tranif1 nmos_366(gnd, net_1099, net_0);
  tranif1 nmos_367(gnd, net_1099, casein_13[13]);
  tranif1 nmos_368(gnd, net_1099, net_64);
  tranif1 nmos_369(gnd, net_1099, net_72);
  tranif1 nmos_370(gnd, net_1099, casein_6[6]);
  tranif1 nmos_371(gnd, net_1099, net_128);
  tranif1 nmos_372(net_1120, gnd, net_0);
  tranif1 nmos_373(net_1120, gnd, casein_13[13]);
  tranif1 nmos_374(net_1120, gnd, net_64);
  tranif1 nmos_375(net_1120, gnd, casein_7[7]);
  tranif1 nmos_376(net_1120, gnd, net_80);
  tranif1 nmos_377(net_1120, gnd, net_128);
  tranif1 nmos_378(gnd, net_1131, net_0);
  tranif1 nmos_379(gnd, net_1131, casein_13[13]);
  tranif1 nmos_380(gnd, net_1131, net_64);
  tranif1 nmos_381(gnd, net_1131, casein_7[7]);
  tranif1 nmos_382(gnd, net_1131, casein_6[6]);
  tranif1 nmos_383(gnd, net_1131, net_128);
  tranif1 nmos_384(net_1152, gnd, net_0);
  tranif1 nmos_385(net_1152, gnd, casein_13[13]);
  tranif1 nmos_386(net_1152, gnd, casein_8[8]);
  tranif1 nmos_387(net_1152, gnd, net_72);
  tranif1 nmos_388(net_1152, gnd, net_80);
  tranif1 nmos_389(net_1152, gnd, net_128);
  tranif1 nmos_390(gnd, net_1163, net_0);
  tranif1 nmos_391(gnd, net_1163, casein_13[13]);
  tranif1 nmos_392(gnd, net_1163, casein_8[8]);
  tranif1 nmos_393(gnd, net_1163, net_72);
  tranif1 nmos_394(gnd, net_1163, casein_6[6]);
  tranif1 nmos_395(gnd, net_1163, net_128);
  tranif1 nmos_396(net_1184, gnd, net_0);
  tranif1 nmos_397(net_1184, gnd, casein_13[13]);
  tranif1 nmos_398(net_1184, gnd, casein_8[8]);
  tranif1 nmos_399(net_1184, gnd, casein_7[7]);
  tranif1 nmos_400(net_1184, gnd, net_80);
  tranif1 nmos_401(net_1184, gnd, net_128);
  tranif1 nmos_402(gnd, net_1195, net_0);
  tranif1 nmos_403(gnd, net_1195, casein_13[13]);
  tranif1 nmos_404(gnd, net_1195, casein_8[8]);
  tranif1 nmos_405(gnd, net_1195, casein_7[7]);
  tranif1 nmos_406(gnd, net_1195, casein_6[6]);
  tranif1 nmos_407(gnd, net_1195, net_128);
  tranif1 nmos_408(net_1216, gnd, net_0);
  tranif1 nmos_409(net_1216, gnd, casein_13[13]);
  tranif1 nmos_410(net_1216, gnd, net_64);
  tranif1 nmos_411(net_1216, gnd, net_72);
  tranif1 nmos_412(net_1216, gnd, net_80);
  tranif1 nmos_413(net_1216, gnd, casein[0]);
  tranif1 nmos_414(gnd, net_1227, net_0);
  tranif1 nmos_415(gnd, net_1227, casein_13[13]);
  tranif1 nmos_416(gnd, net_1227, net_64);
  tranif1 nmos_417(gnd, net_1227, net_72);
  tranif1 nmos_418(gnd, net_1227, casein_6[6]);
  tranif1 nmos_419(gnd, net_1227, casein[0]);
  tranif1 nmos_420(net_1248, gnd, net_0);
  tranif1 nmos_421(net_1248, gnd, casein_13[13]);
  tranif1 nmos_422(net_1248, gnd, net_64);
  tranif1 nmos_423(net_1248, gnd, casein_7[7]);
  tranif1 nmos_424(net_1248, gnd, net_80);
  tranif1 nmos_425(net_1248, gnd, casein[0]);
  tranif1 nmos_426(gnd, net_1259, net_0);
  tranif1 nmos_427(gnd, net_1259, casein_13[13]);
  tranif1 nmos_428(gnd, net_1259, net_64);
  tranif1 nmos_429(gnd, net_1259, casein_7[7]);
  tranif1 nmos_430(gnd, net_1259, casein_6[6]);
  tranif1 nmos_431(gnd, net_1259, casein[0]);
  tranif1 nmos_432(net_1280, gnd, net_0);
  tranif1 nmos_433(net_1280, gnd, casein_13[13]);
  tranif1 nmos_434(net_1280, gnd, casein_8[8]);
  tranif1 nmos_435(net_1280, gnd, net_72);
  tranif1 nmos_436(net_1280, gnd, net_80);
  tranif1 nmos_437(net_1280, gnd, casein[0]);
  tranif1 nmos_438(gnd, net_1291, net_0);
  tranif1 nmos_439(gnd, net_1291, casein_13[13]);
  tranif1 nmos_440(gnd, net_1291, casein_8[8]);
  tranif1 nmos_441(gnd, net_1291, net_72);
  tranif1 nmos_442(gnd, net_1291, casein_6[6]);
  tranif1 nmos_443(gnd, net_1291, casein[0]);
  tranif1 nmos_444(net_1312, gnd, net_0);
  tranif1 nmos_445(net_1312, gnd, casein_13[13]);
  tranif1 nmos_446(net_1312, gnd, casein_8[8]);
  tranif1 nmos_447(net_1312, gnd, casein_7[7]);
  tranif1 nmos_448(net_1312, gnd, net_80);
  tranif1 nmos_449(net_1312, gnd, casein[0]);
  tranif1 nmos_450(gnd, net_1323, net_0);
  tranif1 nmos_451(gnd, net_1323, casein_13[13]);
  tranif1 nmos_452(gnd, net_1323, casein_8[8]);
  tranif1 nmos_453(gnd, net_1323, casein_7[7]);
  tranif1 nmos_454(gnd, net_1323, casein_6[6]);
  tranif1 nmos_455(gnd, net_1323, casein[0]);
  tranif1 nmos_456(net_1344, gnd, net_0);
  tranif1 nmos_457(net_1344, gnd, net_24);
  tranif1 nmos_458(net_1344, gnd, casein_12[12]);
  tranif1 nmos_459(net_1344, gnd, casein_11[11]);
  tranif1 nmos_460(net_1344, gnd, casein_10[10]);
  tranif1 nmos_461(net_1344, gnd, casein_9[9]);
  tranif1 nmos_462(net_1344, gnd, net_128);
  tranif1 nmos_463(gnd, net_1356, net_0);
  tranif1 nmos_464(gnd, net_1356, net_24);
  tranif1 nmos_465(gnd, net_1356, casein_12[12]);
  tranif1 nmos_466(gnd, net_1356, casein_11[11]);
  tranif1 nmos_467(gnd, net_1356, casein_10[10]);
  tranif1 nmos_468(gnd, net_1356, casein_9[9]);
  tranif1 nmos_469(gnd, net_1356, casein[0]);
  tranif1 nmos_791(gnd, net_1643, net_503);
  tranif1 nmos_792(gnd, net_1674, net_503);
  tranif1 nmos_793(gnd, net_1701, net_503);
  tranif1 nmos_794(gnd, net_1730, net_503);
  tranif1 nmos_795(gnd, net_1643, net_517);
  tranif1 nmos_796(gnd, net_1730, net_517);
  tranif1 nmos_797(gnd, net_1674, net_550);
  tranif1 nmos_798(gnd, net_1701, net_550);
  tranif1 nmos_799(gnd, net_1730, net_550);
  tranif1 nmos_800(gnd, net_1730, net_564);
  tranif1 nmos_801(gnd, net_1643, net_597);
  tranif1 nmos_802(gnd, net_1674, net_597);
  tranif1 nmos_803(gnd, net_1701, net_597);
  tranif1 nmos_804(gnd, net_1730, net_597);
  tranif1 nmos_805(gnd, net_1759, net_597);
  tranif1 nmos_806(gnd, net_1643, net_611);
  tranif1 nmos_807(gnd, net_1730, net_611);
  tranif1 nmos_808(gnd, net_1759, net_611);
  tranif1 nmos_809(gnd, net_1674, net_644);
  tranif1 nmos_810(gnd, net_1701, net_644);
  tranif1 nmos_811(gnd, net_1730, net_644);
  tranif1 nmos_812(gnd, net_1759, net_644);
  tranif1 nmos_813(gnd, net_1730, net_658);
  tranif1 nmos_814(gnd, net_1759, net_658);
  tranif1 nmos_815(gnd, net_1674, net_691);
  tranif1 nmos_816(gnd, net_1701, net_691);
  tranif1 nmos_817(gnd, net_1789, net_691);
  tranif1 nmos_818(gnd, net_1789, net_703);
  tranif1 nmos_819(gnd, net_1622, net_728);
  tranif1 nmos_820(gnd, net_1627, net_728);
  tranif1 nmos_821(gnd, net_1643, net_728);
  tranif1 nmos_822(gnd, net_1674, net_728);
  tranif1 nmos_823(gnd, net_1701, net_728);
  tranif1 nmos_824(gnd, net_1759, net_728);
  tranif1 nmos_825(gnd, net_1622, net_741);
  tranif1 nmos_826(gnd, net_1627, net_741);
  tranif1 nmos_827(gnd, net_1643, net_741);
  tranif1 nmos_828(gnd, net_1674, net_741);
  tranif1 nmos_829(gnd, net_1759, net_741);
  tranif1 nmos_830(gnd, net_1622, net_770);
  tranif1 nmos_831(gnd, net_1643, net_770);
  tranif1 nmos_832(gnd, net_1674, net_770);
  tranif1 nmos_833(gnd, net_1701, net_770);
  tranif1 nmos_834(gnd, net_1622, net_783);
  tranif1 nmos_835(gnd, net_1643, net_783);
  tranif1 nmos_836(gnd, net_1674, net_783);
  tranif1 nmos_837(gnd, net_1613, net_812);
  tranif1 nmos_838(gnd, net_1627, net_812);
  tranif1 nmos_839(gnd, net_1634, net_812);
  tranif1 nmos_840(gnd, net_1674, net_812);
  tranif1 nmos_841(gnd, net_1701, net_812);
  tranif1 nmos_842(gnd, net_1759, net_812);
  tranif1 nmos_843(gnd, net_1613, net_825);
  tranif1 nmos_844(gnd, net_1627, net_825);
  tranif1 nmos_845(gnd, net_1634, net_825);
  tranif1 nmos_846(gnd, net_1701, net_825);
  tranif1 nmos_847(gnd, net_1759, net_825);
  tranif1 nmos_848(gnd, net_1613, net_854);
  tranif1 nmos_849(gnd, net_1634, net_854);
  tranif1 nmos_850(gnd, net_1674, net_854);
  tranif1 nmos_851(gnd, net_1701, net_854);
  tranif1 nmos_852(gnd, net_1613, net_867);
  tranif1 nmos_853(gnd, net_1634, net_867);
  tranif1 nmos_854(gnd, net_1701, net_867);
  tranif1 nmos_855(gnd, net_1613, net_896);
  tranif1 nmos_856(gnd, net_1627, net_896);
  tranif1 nmos_857(gnd, net_1634, net_896);
  tranif1 nmos_858(gnd, net_1674, net_896);
  tranif1 nmos_859(gnd, net_1701, net_896);
  tranif1 nmos_860(gnd, net_1759, net_896);
  tranif1 nmos_861(gnd, net_1613, net_909);
  tranif1 nmos_862(gnd, net_1634, net_909);
  tranif1 nmos_863(gnd, net_1674, net_909);
  tranif1 nmos_864(gnd, net_1701, net_909);
  tranif1 nmos_865(gnd, net_1613, net_938);
  tranif1 nmos_866(gnd, net_1627, net_938);
  tranif1 nmos_867(gnd, net_1634, net_938);
  tranif1 nmos_868(gnd, net_1701, net_938);
  tranif1 nmos_869(gnd, net_1759, net_938);
  tranif1 nmos_870(gnd, net_1613, net_951);
  tranif1 nmos_871(gnd, net_1634, net_951);
  tranif1 nmos_872(gnd, net_1701, net_951);
  tranif1 nmos_873(gnd, net_1643, net_980);
  tranif1 nmos_874(gnd, net_1674, net_980);
  tranif1 nmos_875(gnd, net_1701, net_980);
  tranif1 nmos_876(gnd, net_1730, net_980);
  tranif1 nmos_877(gnd, net_1759, net_980);
  tranif1 nmos_878(gnd, net_1674, net_990);
  tranif1 nmos_879(gnd, net_1701, net_990);
  tranif1 nmos_880(gnd, net_1730, net_990);
  tranif1 nmos_881(gnd, net_1759, net_990);
  tranif1 nmos_882(gnd, net_1643, net_1007);
  tranif1 nmos_883(gnd, net_1730, net_1007);
  tranif1 nmos_884(gnd, net_1759, net_1007);
  tranif1 nmos_885(gnd, net_1730, net_1017);
  tranif1 nmos_886(gnd, net_1759, net_1017);
  tranif1 nmos_887(gnd, net_1643, net_1034);
  tranif1 nmos_888(gnd, net_1674, net_1034);
  tranif1 nmos_889(gnd, net_1701, net_1034);
  tranif1 nmos_890(gnd, net_1730, net_1034);
  tranif1 nmos_891(gnd, net_1759, net_1034);
  tranif1 nmos_892(gnd, net_1789, net_1034);
  tranif1 nmos_893(gnd, net_1643, net_1044);
  tranif1 nmos_894(gnd, net_1730, net_1044);
  tranif1 nmos_895(gnd, net_1759, net_1044);
  tranif1 nmos_896(gnd, net_1789, net_1044);
  tranif1 nmos_897(gnd, net_1674, net_1061);
  tranif1 nmos_898(gnd, net_1701, net_1061);
  tranif1 nmos_899(gnd, net_1730, net_1061);
  tranif1 nmos_900(gnd, net_1759, net_1061);
  tranif1 nmos_901(gnd, net_1789, net_1061);
  tranif1 nmos_902(gnd, net_1730, net_1071);
  tranif1 nmos_903(gnd, net_1759, net_1071);
  tranif1 nmos_904(gnd, net_1789, net_1071);
  tranif1 nmos_905(gnd, net_1643, net_1088);
  tranif1 nmos_906(gnd, net_1674, net_1088);
  tranif1 nmos_907(gnd, net_1701, net_1088);
  tranif1 nmos_908(gnd, net_1643, net_1099);
  tranif1 nmos_909(gnd, net_1674, net_1099);
  tranif1 nmos_910(gnd, net_1701, net_1099);
  tranif1 nmos_911(gnd, net_1730, net_1099);
  tranif1 nmos_912(gnd, net_1759, net_1099);
  tranif1 nmos_913(gnd, net_1643, net_1120);
  tranif1 nmos_914(gnd, net_1674, net_1120);
  tranif1 nmos_915(gnd, net_1701, net_1120);
  tranif1 nmos_916(gnd, net_1730, net_1120);
  tranif1 nmos_917(gnd, net_1759, net_1120);
  tranif1 nmos_918(gnd, net_1643, net_1131);
  tranif1 nmos_919(gnd, net_1674, net_1131);
  tranif1 nmos_920(gnd, net_1701, net_1131);
  tranif1 nmos_921(gnd, net_1730, net_1131);
  tranif1 nmos_922(gnd, net_1759, net_1131);
  tranif1 nmos_923(gnd, net_1784, net_1131);
  tranif1 nmos_924(gnd, net_1643, net_1152);
  tranif1 nmos_925(gnd, net_1674, net_1152);
  tranif1 nmos_926(gnd, net_1701, net_1152);
  tranif1 nmos_927(gnd, net_1730, net_1152);
  tranif1 nmos_928(gnd, net_1784, net_1152);
  tranif1 nmos_929(gnd, net_1643, net_1163);
  tranif1 nmos_930(gnd, net_1674, net_1163);
  tranif1 nmos_931(gnd, net_1701, net_1163);
  tranif1 nmos_932(gnd, net_1730, net_1163);
  tranif1 nmos_933(gnd, net_1643, net_1184);
  tranif1 nmos_934(gnd, net_1674, net_1184);
  tranif1 nmos_935(gnd, net_1701, net_1184);
  tranif1 nmos_936(gnd, net_1730, net_1184);
  tranif1 nmos_937(gnd, net_1643, net_1195);
  tranif1 nmos_938(gnd, net_1674, net_1195);
  tranif1 nmos_939(gnd, net_1701, net_1195);
  tranif1 nmos_940(gnd, net_1643, net_1216);
  tranif1 nmos_941(gnd, net_1643, net_1227);
  tranif1 nmos_942(gnd, net_1730, net_1227);
  tranif1 nmos_943(gnd, net_1759, net_1227);
  tranif1 nmos_944(gnd, net_1643, net_1248);
  tranif1 nmos_945(gnd, net_1730, net_1248);
  tranif1 nmos_946(gnd, net_1759, net_1248);
  tranif1 nmos_947(gnd, net_1643, net_1259);
  tranif1 nmos_948(gnd, net_1730, net_1259);
  tranif1 nmos_949(gnd, net_1759, net_1259);
  tranif1 nmos_950(gnd, net_1784, net_1259);
  tranif1 nmos_951(gnd, net_1643, net_1280);
  tranif1 nmos_952(gnd, net_1730, net_1280);
  tranif1 nmos_953(gnd, net_1784, net_1280);
  tranif1 nmos_954(gnd, net_1643, net_1291);
  tranif1 nmos_955(gnd, net_1730, net_1291);
  tranif1 nmos_956(gnd, net_1643, net_1312);
  tranif1 nmos_957(gnd, net_1730, net_1312);
  tranif1 nmos_958(gnd, net_1643, net_1323);
  tranif1 nmos_959(gnd, net_1643, net_1344);
  tranif1 nmos_960(gnd, net_1674, net_1344);
  tranif1 nmos_961(gnd, net_1701, net_1344);
  tranif1 nmos_962(gnd, net_1789, net_1344);
  tranif1 nmos_963(gnd, net_1643, net_1356);
  tranif1 nmos_964(gnd, net_1789, net_1356);
  tranif1 nmos_1051(gnd, caseout_10[10], net_1613);
  tranif1 nmos_1059(gnd, caseout_9[9], net_1622);
  tranif1 nmos_1067(gnd, caseout_8[8], net_1627);
  tranif1 nmos_1075(gnd, caseout_7[7], net_1634);
  tranif1 nmos_1083(gnd, caseout_6[6], net_1643);
  tranif1 nmos_1091(gnd, caseout_5[5], net_1674);
  tranif1 nmos_1099(gnd, caseout_4[4], net_1701);
  tranif1 nmos_1107(gnd, caseout_3[3], net_1730);
  tranif1 nmos_1115(gnd, caseout_2[2], net_1759);
  tranif1 nmos_1123(gnd, caseout_1[1], net_1784);
  tranif1 nmos_1131(gnd, caseout[0], net_1789);
  tranif0 pmos_5(net_0, vdd, casein_16[16]);
  tranif0 pmos_13(net_8, vdd, casein_15[15]);
  tranif0 pmos_21(net_16, vdd, casein_14[14]);
  tranif0 pmos_29(net_24, vdd, casein_13[13]);
  tranif0 pmos_37(net_32, vdd, casein_12[12]);
  tranif0 pmos_45(net_40, vdd, casein_11[11]);
  tranif0 pmos_53(net_48, vdd, casein_10[10]);
  tranif0 pmos_61(net_56, vdd, casein_9[9]);
  tranif0 pmos_69(net_64, vdd, casein_8[8]);
  tranif0 pmos_77(net_72, vdd, casein_7[7]);
  tranif0 pmos_85(net_80, vdd, casein_6[6]);
  tranif0 pmos_93(net_88, vdd, casein_5[5]);
  tranif0 pmos_101(net_96, vdd, casein_4[4]);
  tranif0 pmos_109(net_104, vdd, casein_3[3]);
  tranif0 pmos_117(net_112, vdd, casein_2[2]);
  tranif0 pmos_125(net_120, vdd, casein_1[1]);
  tranif0 pmos_133(net_128, vdd, casein[0]);
  tranif0 pmos_1052(caseout_10[10], vdd, net_1613);
  tranif0 pmos_1060(caseout_9[9], vdd, net_1622);
  tranif0 pmos_1068(caseout_8[8], vdd, net_1627);
  tranif0 pmos_1076(caseout_7[7], vdd, net_1634);
  tranif0 pmos_1084(caseout_6[6], vdd, net_1643);
  tranif0 pmos_1092(caseout_5[5], vdd, net_1674);
  tranif0 pmos_1100(caseout_4[4], vdd, net_1701);
  tranif0 pmos_1108(caseout_3[3], vdd, net_1730);
  tranif0 pmos_1116(caseout_2[2], vdd, net_1759);
  tranif0 pmos_1124(caseout_1[1], vdd, net_1784);
  tranif0 pmos_1132(caseout[0], vdd, net_1789);
  rtranif0 pmos_1137(net_1613, vdd, gnd);
  rtranif0 pmos_1139(net_1622, vdd, gnd);
  rtranif0 pmos_1141(net_1627, vdd, gnd);
  rtranif0 pmos_1143(net_1634, vdd, gnd);
  rtranif0 pmos_1145(net_1643, vdd, gnd);
  rtranif0 pmos_1147(net_1674, vdd, gnd);
  rtranif0 pmos_1149(net_1701, vdd, gnd);
  rtranif0 pmos_1151(net_1730, vdd, gnd);
  rtranif0 pmos_1153(net_1759, vdd, gnd);
  rtranif0 pmos_1155(net_1784, vdd, gnd);
  rtranif0 pmos_1157(net_1789, vdd, gnd);
  rtranif0 pmos_1161(vdd, net_1356, gnd);
  rtranif0 pmos_1163(vdd, net_1344, gnd);
  rtranif0 pmos_1165(vdd, net_1323, gnd);
  rtranif0 pmos_1167(vdd, net_1312, gnd);
  rtranif0 pmos_1169(vdd, net_1291, gnd);
  rtranif0 pmos_1171(vdd, net_1280, gnd);
  rtranif0 pmos_1173(vdd, net_1259, gnd);
  rtranif0 pmos_1175(vdd, net_1248, gnd);
  rtranif0 pmos_1177(vdd, net_1227, gnd);
  rtranif0 pmos_1179(vdd, net_1216, gnd);
  rtranif0 pmos_1181(vdd, net_1195, gnd);
  rtranif0 pmos_1183(vdd, net_1184, gnd);
  rtranif0 pmos_1185(vdd, net_1163, gnd);
  rtranif0 pmos_1187(vdd, net_1152, gnd);
  rtranif0 pmos_1189(vdd, net_1131, gnd);
  rtranif0 pmos_1191(vdd, net_1120, gnd);
  rtranif0 pmos_1193(vdd, net_1099, gnd);
  rtranif0 pmos_1195(vdd, net_1088, gnd);
  rtranif0 pmos_1197(vdd, net_1071, gnd);
  rtranif0 pmos_1199(vdd, net_1061, gnd);
  rtranif0 pmos_1201(vdd, net_1044, gnd);
  rtranif0 pmos_1203(vdd, net_1034, gnd);
  rtranif0 pmos_1205(vdd, net_1017, gnd);
  rtranif0 pmos_1207(vdd, net_1007, gnd);
  rtranif0 pmos_1209(vdd, net_990, gnd);
  rtranif0 pmos_1211(vdd, net_980, gnd);
  rtranif0 pmos_1213(vdd, net_951, gnd);
  rtranif0 pmos_1215(vdd, net_938, gnd);
  rtranif0 pmos_1217(vdd, net_909, gnd);
  rtranif0 pmos_1219(vdd, net_896, gnd);
  rtranif0 pmos_1221(vdd, net_867, gnd);
  rtranif0 pmos_1223(vdd, net_854, gnd);
  rtranif0 pmos_1225(vdd, net_825, gnd);
  rtranif0 pmos_1227(vdd, net_812, gnd);
  rtranif0 pmos_1229(vdd, net_783, gnd);
  rtranif0 pmos_1231(vdd, net_770, gnd);
  rtranif0 pmos_1233(vdd, net_741, gnd);
  rtranif0 pmos_1235(vdd, net_728, gnd);
  rtranif0 pmos_1237(vdd, net_703, gnd);
  rtranif0 pmos_1239(vdd, net_691, gnd);
  rtranif0 pmos_1241(vdd, net_658, gnd);
  rtranif0 pmos_1243(vdd, net_644, gnd);
  rtranif0 pmos_1245(vdd, net_611, gnd);
  rtranif0 pmos_1247(vdd, net_597, gnd);
  rtranif0 pmos_1249(vdd, net_564, gnd);
  rtranif0 pmos_1251(vdd, net_550, gnd);
  rtranif0 pmos_1253(vdd, net_517, gnd);
  rtranif0 pmos_1255(vdd, net_503, gnd);
endmodule   /* DatapathDone__controlPLA */

module DatapathDone__flopen_c_1x(d, en, q, ph1, ph2);
  input d;
  input en;
  output q;
  input ph1;
  input ph2;

  supply1 vdd;
  supply0 gnd;
  wire enb, master, masterinb, n2, n3, n4, n5, n6, n7, n8, n9, ph1b, ph1buf;
  wire ph2b, ph2buf, slaveb;
  trireg masterb, slave;

  tranif1 nmos_2(masterinb, masterb, ph2buf);
  tranif1 nmos_3(gnd, master, masterb);
  rtranif1 nmos_4(master, slave, ph1buf);
  tranif1 nmos_5(n6, masterb, ph2b);
  tranif1 nmos_6(gnd, n6, master);
  tranif1 nmos_7(gnd, n8, slaveb);
  tranif1 nmos_8(gnd, slaveb, slave);
  tranif1 nmos_10(n8, slave, ph1b);
  tranif1 nmos_11(gnd, q, slaveb);
  tranif1 nmos_16(gnd, n2, en);
  tranif1 nmos_18(n3, gnd, enb);
  tranif1 nmos_19(n2, masterinb, d);
  tranif1 nmos_20(masterinb, n3, slave);
  tranif1 nmos_21(gnd, ph1b, ph1);
  tranif1 nmos_22(gnd, ph2b, ph2);
  tranif1 nmos_23(gnd, enb, en);
  tranif1 nmos_24(gnd, ph1buf, ph1b);
  tranif1 nmos_25(gnd, ph2buf, ph2b);
  tranif0 pmos_2(masterb, masterinb, ph2b);
  tranif0 pmos_3(master, vdd, masterb);
  rtranif0 pmos_4(slave, master, ph1b);
  tranif0 pmos_5(masterb, n7, ph2buf);
  tranif0 pmos_6(n7, vdd, master);
  tranif0 pmos_7(n9, vdd, slaveb);
  tranif0 pmos_8(slaveb, vdd, slave);
  tranif0 pmos_10(slave, n9, ph1buf);
  tranif0 pmos_11(q, vdd, slaveb);
  tranif0 pmos_16(masterinb, n4, d);
  tranif0 pmos_17(n4, vdd, enb);
  tranif0 pmos_19(n5, masterinb, slave);
  tranif0 pmos_20(vdd, n5, en);
  tranif0 pmos_21(ph1b, vdd, ph1);
  tranif0 pmos_22(ph2b, vdd, ph2);
  tranif0 pmos_23(enb, vdd, en);
  tranif0 pmos_24(ph1buf, vdd, ph1b);
  tranif0 pmos_25(ph2buf, vdd, ph2b);
endmodule   /* DatapathDone__flopen_c_1x */

module DatapathDone__countPLA(count, count_1, count_2, count_3, count_4, 
      count_5, countvals, countvals_1, countvals_2, countvals_3, countvals_4, 
      countvals_5, countvals_6);
  input [0:0] count;
  input [1:1] count_1;
  input [2:2] count_2;
  input [3:3] count_3;
  input [4:4] count_4;
  input [5:5] count_5;
  output [0:0] countvals;
  output [1:1] countvals_1;
  output [2:2] countvals_2;
  output [3:3] countvals_3;
  output [4:4] countvals_4;
  output [5:5] countvals_5;
  output [6:6] countvals_6;

  supply1 vdd;
  supply0 gnd;
  wire net_0, net_103, net_114, net_135, net_146, net_167, net_178, net_199;
  wire net_269, net_277, net_285, net_293, net_301, net_309, net_317, net_32;
  wire net_40, net_462, net_463, net_8;

  tranif1 nmos_4(gnd, net_0, count_5[5]);
  tranif1 nmos_12(gnd, net_8, count_4[4]);
  tranif1 nmos_20(gnd, net_463, count_3[3]);
  tranif1 nmos_28(gnd, net_462, count_2[2]);
  tranif1 nmos_36(gnd, net_32, count_1[1]);
  tranif1 nmos_44(gnd, net_40, count[0]);
  tranif1 nmos_50(net_103, gnd, net_0);
  tranif1 nmos_51(net_103, gnd, count_4[4]);
  tranif1 nmos_52(net_103, gnd, count_3[3]);
  tranif1 nmos_53(net_103, gnd, count_2[2]);
  tranif1 nmos_54(net_103, gnd, net_32);
  tranif1 nmos_55(net_103, gnd, net_40);
  tranif1 nmos_56(gnd, net_114, net_0);
  tranif1 nmos_57(gnd, net_114, count_4[4]);
  tranif1 nmos_58(gnd, net_114, count_3[3]);
  tranif1 nmos_59(gnd, net_114, count_2[2]);
  tranif1 nmos_60(gnd, net_114, net_32);
  tranif1 nmos_61(gnd, net_114, count[0]);
  tranif1 nmos_62(net_135, gnd, net_0);
  tranif1 nmos_63(net_135, gnd, count_4[4]);
  tranif1 nmos_64(net_135, gnd, count_3[3]);
  tranif1 nmos_65(net_135, gnd, count_2[2]);
  tranif1 nmos_66(net_135, gnd, count_1[1]);
  tranif1 nmos_67(net_135, gnd, net_40);
  tranif1 nmos_68(gnd, net_146, net_0);
  tranif1 nmos_69(gnd, net_146, count_4[4]);
  tranif1 nmos_70(gnd, net_146, count_3[3]);
  tranif1 nmos_71(gnd, net_146, count_2[2]);
  tranif1 nmos_72(gnd, net_146, count_1[1]);
  tranif1 nmos_73(gnd, net_146, count[0]);
  tranif1 nmos_74(net_167, gnd, count_5[5]);
  tranif1 nmos_75(net_167, gnd, net_8);
  tranif1 nmos_76(net_167, gnd, count_3[3]);
  tranif1 nmos_77(net_167, gnd, count_2[2]);
  tranif1 nmos_78(net_167, gnd, count_1[1]);
  tranif1 nmos_79(net_167, gnd, net_40);
  tranif1 nmos_80(gnd, net_178, count_5[5]);
  tranif1 nmos_81(gnd, net_178, count_4[4]);
  tranif1 nmos_82(gnd, net_178, count_3[3]);
  tranif1 nmos_83(gnd, net_178, count_2[2]);
  tranif1 nmos_84(gnd, net_178, count_1[1]);
  tranif1 nmos_85(gnd, net_178, count[0]);
  tranif1 nmos_86(net_199, gnd, count_5[5]);
  tranif1 nmos_87(net_199, gnd, net_8);
  tranif1 nmos_88(net_199, gnd, count_3[3]);
  tranif1 nmos_89(net_199, gnd, count_2[2]);
  tranif1 nmos_90(net_199, gnd, count_1[1]);
  tranif1 nmos_91(net_199, gnd, count[0]);
  tranif1 nmos_139(gnd, net_317, net_103);
  tranif1 nmos_140(gnd, net_309, net_114);
  tranif1 nmos_141(gnd, net_301, net_135);
  tranif1 nmos_142(gnd, net_293, net_146);
  tranif1 nmos_143(gnd, net_285, net_167);
  tranif1 nmos_144(gnd, net_277, net_178);
  tranif1 nmos_145(gnd, net_269, net_199);
  tranif1 nmos_179(gnd, countvals_6[6], net_269);
  tranif1 nmos_187(gnd, countvals_5[5], net_277);
  tranif1 nmos_195(gnd, countvals_4[4], net_285);
  tranif1 nmos_203(gnd, countvals_3[3], net_293);
  tranif1 nmos_211(gnd, countvals_2[2], net_301);
  tranif1 nmos_219(gnd, countvals_1[1], net_309);
  tranif1 nmos_227(gnd, countvals[0], net_317);
  tranif0 pmos_5(net_0, vdd, count_5[5]);
  tranif0 pmos_13(net_8, vdd, count_4[4]);
  tranif0 pmos_21(net_463, vdd, count_3[3]);
  tranif0 pmos_29(net_462, vdd, count_2[2]);
  tranif0 pmos_37(net_32, vdd, count_1[1]);
  tranif0 pmos_45(net_40, vdd, count[0]);
  tranif0 pmos_180(countvals_6[6], vdd, net_269);
  tranif0 pmos_188(countvals_5[5], vdd, net_277);
  tranif0 pmos_196(countvals_4[4], vdd, net_285);
  tranif0 pmos_204(countvals_3[3], vdd, net_293);
  tranif0 pmos_212(countvals_2[2], vdd, net_301);
  tranif0 pmos_220(countvals_1[1], vdd, net_309);
  tranif0 pmos_228(countvals[0], vdd, net_317);
  rtranif0 pmos_233(net_269, vdd, gnd);
  rtranif0 pmos_235(net_277, vdd, gnd);
  rtranif0 pmos_237(net_285, vdd, gnd);
  rtranif0 pmos_239(net_293, vdd, gnd);
  rtranif0 pmos_241(net_301, vdd, gnd);
  rtranif0 pmos_243(net_309, vdd, gnd);
  rtranif0 pmos_245(net_317, vdd, gnd);
  rtranif0 pmos_249(vdd, net_199, gnd);
  rtranif0 pmos_251(vdd, net_178, gnd);
  rtranif0 pmos_253(vdd, net_167, gnd);
  rtranif0 pmos_255(vdd, net_146, gnd);
  rtranif0 pmos_257(vdd, net_135, gnd);
  rtranif0 pmos_259(vdd, net_114, gnd);
  rtranif0 pmos_261(vdd, net_103, gnd);
endmodule   /* DatapathDone__countPLA */

module DatapathDone__flopenr_c_1x(d, en, resetb, q, ph1, ph2);
  input d;
  input en;
  input resetb;
  output q;
  input ph1;
  input ph2;

  supply1 vdd;
  supply0 gnd;
  wire enb, master, masterinb, n1, n2, n3, n4, n5, n6, n7, n8, n9, ph1b, ph1buf;
  wire ph2b, ph2buf, slaveb;
  trireg masterb, slave;

  tranif1 nmos_2(masterinb, masterb, ph2buf);
  tranif1 nmos_3(gnd, master, masterb);
  rtranif1 nmos_4(master, slave, ph1buf);
  tranif1 nmos_5(n6, masterb, ph2b);
  tranif1 nmos_6(gnd, n6, master);
  tranif1 nmos_7(gnd, n8, slaveb);
  tranif1 nmos_8(gnd, slaveb, slave);
  tranif1 nmos_10(n8, slave, ph1b);
  tranif1 nmos_11(gnd, q, slaveb);
  tranif1 nmos_16(n1, n2, en);
  tranif1 nmos_17(gnd, n1, resetb);
  tranif1 nmos_18(n3, n1, enb);
  tranif1 nmos_19(n2, masterinb, d);
  tranif1 nmos_20(masterinb, n3, slave);
  tranif1 nmos_21(gnd, ph1b, ph1);
  tranif1 nmos_22(gnd, ph2b, ph2);
  tranif1 nmos_23(gnd, enb, en);
  tranif1 nmos_24(gnd, ph1buf, ph1b);
  tranif1 nmos_25(gnd, ph2buf, ph2b);
  tranif0 pmos_2(masterb, masterinb, ph2b);
  tranif0 pmos_3(master, vdd, masterb);
  rtranif0 pmos_4(slave, master, ph1b);
  tranif0 pmos_5(masterb, n7, ph2buf);
  tranif0 pmos_6(n7, vdd, master);
  tranif0 pmos_7(n9, vdd, slaveb);
  tranif0 pmos_8(slaveb, vdd, slave);
  tranif0 pmos_10(slave, n9, ph1buf);
  tranif0 pmos_11(q, vdd, slaveb);
  tranif0 pmos_16(masterinb, n4, d);
  tranif0 pmos_17(n4, vdd, enb);
  tranif0 pmos_18(masterinb, vdd, resetb);
  tranif0 pmos_19(n5, masterinb, slave);
  tranif0 pmos_20(vdd, n5, en);
  tranif0 pmos_21(ph1b, vdd, ph1);
  tranif0 pmos_22(ph2b, vdd, ph2);
  tranif0 pmos_23(enb, vdd, en);
  tranif0 pmos_24(ph1buf, vdd, ph1b);
  tranif0 pmos_25(ph2buf, vdd, ph2b);
endmodule   /* DatapathDone__flopenr_c_1x */

module DatapathDone__or2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_58, net_71;

  tranif1 nmos_8(gnd, net_58, b);
  tranif1 nmos_10(gnd, y, net_58);
  tranif1 nmos_11(gnd, net_58, a);
  tranif0 pmos_2(net_58, net_71, b);
  tranif0 pmos_3(net_71, vdd, a);
  tranif0 pmos_4(y, vdd, net_58);
endmodule   /* DatapathDone__or2_1x */

module DatapathDone__adder_6(a, b, cin, cout, s);
  input [5:0] a;
  input [5:0] b;
  input cin;
  output cout;
  output [5:0] s;

  supply1 vdd;
  supply0 gnd;
  wire [4:0] c;

  DatapathDone__fulladder fa_5_(.a(a[5]), .b(b[5]), .c(c[4]), .cout(cout), 
      .s(s[5]));
  DatapathDone__fulladder fa_4_(.a(a[4]), .b(b[4]), .c(c[3]), .cout(c[4]), 
      .s(s[4]));
  DatapathDone__fulladder fa_3_(.a(a[3]), .b(b[3]), .c(c[2]), .cout(c[3]), 
      .s(s[3]));
  DatapathDone__fulladder fa_2_(.a(a[2]), .b(b[2]), .c(c[1]), .cout(c[2]), 
      .s(s[2]));
  DatapathDone__fulladder fa_1_(.a(a[1]), .b(b[1]), .c(c[0]), .cout(c[1]), 
      .s(s[1]));
  DatapathDone__fulladder fa_0_(.a(a[0]), .b(b[0]), .c(cin), .cout(c[0]), 
      .s(s[0]));
endmodule   /* DatapathDone__adder_6 */

module DatapathDone__flopr_c_1x(d, resetb, q, ph1, ph2);
  input d;
  input resetb;
  output q;
  input ph1;
  input ph2;

  supply1 vdd;
  supply0 gnd;
  wire master, masterinb, n6, n7, n8, n9, net_429, ph1b, ph1buf, ph2b, ph2buf;
  wire slaveb;
  trireg masterb, slave;

  tranif1 nmos_2(masterinb, masterb, ph2buf);
  tranif1 nmos_3(gnd, master, masterb);
  rtranif1 nmos_4(master, slave, ph1buf);
  tranif1 nmos_5(n6, masterb, ph2b);
  tranif1 nmos_6(gnd, n6, master);
  tranif1 nmos_7(gnd, n8, slaveb);
  tranif1 nmos_8(gnd, slaveb, slave);
  tranif1 nmos_10(n8, slave, ph1b);
  tranif1 nmos_11(gnd, q, slaveb);
  tranif1 nmos_17(gnd, net_429, resetb);
  tranif1 nmos_19(net_429, masterinb, d);
  tranif1 nmos_22(gnd, ph2b, ph2);
  tranif1 nmos_25(gnd, ph2buf, ph2b);
  tranif1 nmos_26(gnd, ph1buf, ph1b);
  tranif1 nmos_27(gnd, ph1b, ph1);
  tranif0 pmos_2(masterb, masterinb, ph2b);
  tranif0 pmos_3(master, vdd, masterb);
  rtranif0 pmos_4(slave, master, ph1b);
  tranif0 pmos_5(masterb, n7, ph2buf);
  tranif0 pmos_6(n7, vdd, master);
  tranif0 pmos_7(n9, vdd, slaveb);
  tranif0 pmos_8(slaveb, vdd, slave);
  tranif0 pmos_10(slave, n9, ph1buf);
  tranif0 pmos_11(q, vdd, slaveb);
  tranif0 pmos_16(masterinb, vdd, d);
  tranif0 pmos_18(masterinb, vdd, resetb);
  tranif0 pmos_21(ph1b, vdd, ph1);
  tranif0 pmos_22(ph2b, vdd, ph2);
  tranif0 pmos_24(ph1buf, vdd, ph1b);
  tranif0 pmos_25(ph2buf, vdd, ph2b);
endmodule   /* DatapathDone__flopr_c_1x */

module DatapathDone__mdcon(addsign, muldivb, reset, signedop, srchsign, start, 
      x, xsavedsign, xsign, ysavedsign, ysign, done, init, muldivbsaved, 
      prodhsel, prodlsel, qi, run, signedopsaved, srchinv, srchsel, ysel, ph1, 
      ph2);
  input addsign;
  input muldivb;
  input reset;
  input signedop;
  input srchsign;
  input start;
  input [1:0] x;
  input xsavedsign;
  input xsign;
  input ysavedsign;
  input ysign;
  output done;
  output init;
  output muldivbsaved;
  output [1:0] prodhsel;
  output [1:0] prodlsel;
  output qi;
  output run;
  output signedopsaved;
  output srchinv;
  output [1:0] srchsel;
  output [2:0] ysel;
  input ph1;
  input ph2;

  supply1 vdd;
  supply0 gnd;
  wire initb, muldivbreg, nccout, net_122, net_3, oldrun, oldrunINVANDdone;
  wire oldx, resetb, signedopreg, signsdisagree, xysign, ysel2b;
  wire [5:0] count;
  wire [6:0] countvals;
  wire [0:1] net_146;
  wire [5:0] nextcount;
  wire [1:0] x2;

  DatapathDone__and2_1x and2_1x_0(.a(oldrun), .b(net_3), 
      .y(oldrunINVANDdone));
  DatapathDone__and2_1x and2_1x_1(.a(muldivbsaved), .b(countvals[6]), 
      .y(net_122));
  DatapathDone__controlPLA controlP_0(.casein({start}), .casein_1({qi}), 
      .casein_10(countvals[1:1]), .casein_11(countvals[2:2]), 
      .casein_12(countvals[3:3]), .casein_13(countvals[4:4]), 
      .casein_14(countvals[5:5]), .casein_15({signedopsaved}), 
      .casein_16({muldivbsaved}), .casein_2({xsavedsign}), 
      .casein_3({ysavedsign}), .casein_4({signsdisagree}), 
      .casein_5({srchsign}), .casein_6({oldx}), .casein_7(x2[0:0]), 
      .casein_8(x2[1:1]), .casein_9(countvals[0:0]), .caseout({done}), 
      .caseout_1(ysel[0:0]), .caseout_10(srchsel[1:1]), .caseout_2(ysel[1:1]), 
      .caseout_3({ysel2b}), .caseout_4(prodlsel[0:0]), 
      .caseout_5(prodlsel[1:1]), .caseout_6(prodhsel[0:0]), 
      .caseout_7(prodhsel[1:1]), .caseout_8({srchinv}), 
      .caseout_9(srchsel[0:0]));
  DatapathDone__flopen_c_1x controlreg_1_(.d(muldivb), .en(start), 
      .q(muldivbreg), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopen_c_1x controlreg_0_(.d(signedop), .en(start), 
      .q(signedopreg), .ph1(ph1), .ph2(ph2));
  DatapathDone__countPLA countPLA_0(.count(count[0:0]), .count_1(count[1:1]), 
      .count_2(count[2:2]), .count_3(count[3:3]), .count_4(count[4:4]), 
      .count_5(count[5:5]), .countvals(countvals[0:0]), 
      .countvals_1(countvals[1:1]), .countvals_2(countvals[2:2]), 
      .countvals_3(countvals[3:3]), .countvals_4(countvals[4:4]), 
      .countvals_5(countvals[5:5]), .countvals_6(countvals[6:6]));
  DatapathDone__flopenr_c_1x countreg_5_(.d(nextcount[5]), .en(run), 
      .resetb(initb), .q(count[5]), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopenr_c_1x countreg_4_(.d(nextcount[4]), .en(run), 
      .resetb(initb), .q(count[4]), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopenr_c_1x countreg_3_(.d(nextcount[3]), .en(run), 
      .resetb(initb), .q(count[3]), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopenr_c_1x countreg_2_(.d(nextcount[2]), .en(run), 
      .resetb(initb), .q(count[2]), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopenr_c_1x countreg_1_(.d(nextcount[1]), .en(run), 
      .resetb(initb), .q(count[1]), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopenr_c_1x countreg_0_(.d(nextcount[0]), .en(run), 
      .resetb(initb), .q(count[0]), .ph1(ph1), .ph2(ph2));
  DatapathDone__or2_1x init_or(.a(reset), .b(start), .y(init));
  DatapathDone__inv_1x inv_1x_0(.a(done), .y(net_3));
  DatapathDone__inv_1x inv_1x_1(.a(addsign), .y(qi));
  DatapathDone__inv_1x inv_1x_4(.a(init), .y(initb));
  DatapathDone__inv_1x inv_1x_5(.a(reset), .y(resetb));
  DatapathDone__inv_1x inv_1x_7(.a(ysel2b), .y(ysel[2]));
  DatapathDone__mux2_c_1x muldivbsignedopmux_1_(.d0(muldivbreg), .d1(muldivb), 
      .s(start), .y(muldivbsaved));
  DatapathDone__mux2_c_1x muldivbsignedopmux_0_(.d0(signedopreg), 
      .d1(signedop), .s(start), .y(signedopsaved));
  DatapathDone__adder_6 nc(.a(count[5:0]), .b({gnd, gnd, gnd, gnd, gnd, vdd}), 
      .cin(gnd), .cout(nccout), .s(nextcount[5:0]));
  DatapathDone__or2_1x or2_1x_0(.a(oldrunINVANDdone), .b(start), .y(run));
  DatapathDone__flopr_c_1x runreg(.d(run), .resetb(resetb), .q(oldrun), 
      .ph1(ph1), .ph2(ph2));
  DatapathDone__xor2_1x signs_xor(.a(xsign), .b(ysign), .y(xysign));
  DatapathDone__flopenr_c_1x signsdisagreereg(.d(xysign), .en(start), 
      .resetb(resetb), .q(signsdisagree), .ph1(ph1), .ph2(ph2));
  DatapathDone__mux2_c_1x x2mux_1_(.d0(x[1]), .d1(net_146[0]), .s(net_122), 
      .y(x2[1]));
  DatapathDone__mux2_c_1x x2mux_0_(.d0(x[0]), .d1(net_146[1]), .s(net_122), 
      .y(x2[0]));
  DatapathDone__mux2_c_1x x2signedmux_1_(.d0(gnd), .d1(oldx), 
      .s(signedopsaved), .y(net_146[0]));
  DatapathDone__mux2_c_1x x2signedmux_0_(.d0(gnd), .d1(oldx), 
      .s(signedopsaved), .y(net_146[1]));
  DatapathDone__flopr_c_1x xoldreg(.d(x[1]), .resetb(initb), .q(oldx), 
      .ph1(ph1), .ph2(ph2));
endmodule   /* DatapathDone__mdcon */

module DatapathDone__mux3_dp_1x_34(d0, d1, d2, s0, s1, y);
  input [33:0] d0;
  input [33:0] d1;
  input [33:0] d2;
  input s0;
  input s1;
  input [33:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_42, net_48, net_49, net_53;

  DatapathDone__invbuf_4x invbuf_4_0(.s(s0), .s_out(net_42), .sb_out(net_53));
  DatapathDone__invbuf_4x invbuf_4_1(.s(s1), .s_out(net_48), .sb_out(net_49));
  DatapathDone__mux3_dp_1x mux3_dp_1x_33_(.d0(d0[33]), .d1(d1[33]), 
      .d2(d2[33]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[33]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_32_(.d0(d0[32]), .d1(d1[32]), 
      .d2(d2[32]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[32]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_31_(.d0(d0[31]), .d1(d1[31]), 
      .d2(d2[31]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[31]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_30_(.d0(d0[30]), .d1(d1[30]), 
      .d2(d2[30]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[30]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_29_(.d0(d0[29]), .d1(d1[29]), 
      .d2(d2[29]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[29]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_28_(.d0(d0[28]), .d1(d1[28]), 
      .d2(d2[28]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[28]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_27_(.d0(d0[27]), .d1(d1[27]), 
      .d2(d2[27]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[27]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_26_(.d0(d0[26]), .d1(d1[26]), 
      .d2(d2[26]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[26]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_25_(.d0(d0[25]), .d1(d1[25]), 
      .d2(d2[25]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[25]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_24_(.d0(d0[24]), .d1(d1[24]), 
      .d2(d2[24]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[24]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_23_(.d0(d0[23]), .d1(d1[23]), 
      .d2(d2[23]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[23]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_22_(.d0(d0[22]), .d1(d1[22]), 
      .d2(d2[22]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[22]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_21_(.d0(d0[21]), .d1(d1[21]), 
      .d2(d2[21]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[21]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_20_(.d0(d0[20]), .d1(d1[20]), 
      .d2(d2[20]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[20]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_19_(.d0(d0[19]), .d1(d1[19]), 
      .d2(d2[19]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[19]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_18_(.d0(d0[18]), .d1(d1[18]), 
      .d2(d2[18]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[18]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_17_(.d0(d0[17]), .d1(d1[17]), 
      .d2(d2[17]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[17]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_16_(.d0(d0[16]), .d1(d1[16]), 
      .d2(d2[16]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[16]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_15_(.d0(d0[15]), .d1(d1[15]), 
      .d2(d2[15]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[15]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_14_(.d0(d0[14]), .d1(d1[14]), 
      .d2(d2[14]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[14]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_13_(.d0(d0[13]), .d1(d1[13]), 
      .d2(d2[13]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[13]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_12_(.d0(d0[12]), .d1(d1[12]), 
      .d2(d2[12]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[12]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_11_(.d0(d0[11]), .d1(d1[11]), 
      .d2(d2[11]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[11]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_10_(.d0(d0[10]), .d1(d1[10]), 
      .d2(d2[10]), .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), 
      .y(y[10]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_9_(.d0(d0[9]), .d1(d1[9]), .d2(d2[9]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[9]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_8_(.d0(d0[8]), .d1(d1[8]), .d2(d2[8]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[8]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_7_(.d0(d0[7]), .d1(d1[7]), .d2(d2[7]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[7]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_6_(.d0(d0[6]), .d1(d1[6]), .d2(d2[6]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[6]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_5_(.d0(d0[5]), .d1(d1[5]), .d2(d2[5]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[5]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_4_(.d0(d0[4]), .d1(d1[4]), .d2(d2[4]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[4]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_3_(.d0(d0[3]), .d1(d1[3]), .d2(d2[3]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[3]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_2_(.d0(d0[2]), .d1(d1[2]), .d2(d2[2]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[2]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_1_(.d0(d0[1]), .d1(d1[1]), .d2(d2[1]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[1]));
  DatapathDone__mux3_dp_1x mux3_dp_1x_0_(.d0(d0[0]), .d1(d1[0]), .d2(d2[0]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[0]));
endmodule   /* DatapathDone__mux3_dp_1x_34 */

module DatapathDone__flopenr_34(d, en, ph1, ph2, reset, q);
  input [33:0] d;
  input en;
  input ph1;
  input ph2;
  input reset;
  output [33:0] q;

  supply1 vdd;
  supply0 gnd;
  wire net_10, net_11, net_12, net_13, net_16, net_2, net_6;

  DatapathDone__clkinvbufdual_4x clkinvbu_0(.ph1b(net_13), .ph1buf(net_12), 
      .ph2b(net_11), .ph2buf(net_10), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopenr_dp_1x flopenr_34_33_(.d(d[33]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[33]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_32_(.d(d[32]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[32]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_31_(.d(d[31]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[31]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_30_(.d(d[30]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[30]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_29_(.d(d[29]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[29]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_28_(.d(d[28]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[28]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_27_(.d(d[27]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[27]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_26_(.d(d[26]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[26]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_25_(.d(d[25]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[25]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_24_(.d(d[24]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[24]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_23_(.d(d[23]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[23]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_22_(.d(d[22]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[22]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_21_(.d(d[21]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[21]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_20_(.d(d[20]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[20]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_19_(.d(d[19]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[19]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_18_(.d(d[18]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[18]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_17_(.d(d[17]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[17]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_16_(.d(d[16]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[16]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_15_(.d(d[15]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[15]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_14_(.d(d[14]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[14]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_13_(.d(d[13]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[13]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_12_(.d(d[12]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[12]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_11_(.d(d[11]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[11]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_10_(.d(d[10]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[10]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_9_(.d(d[9]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[9]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_8_(.d(d[8]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[8]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_7_(.d(d[7]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[7]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_6_(.d(d[6]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[6]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_5_(.d(d[5]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[5]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_4_(.d(d[4]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[4]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_3_(.d(d[3]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[3]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_2_(.d(d[2]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[2]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_1_(.d(d[1]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[1]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_34_0_(.d(d[0]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[0]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__inv_4x inv_4x_0(.a(reset), .y(net_6));
  DatapathDone__invbuf_4x invbuf_4_0(.s(en), .s_out(net_16), .sb_out(net_2));
endmodule   /* DatapathDone__flopenr_34 */

module DatapathDone__flopenr_32_mod(d, en, ph1, ph2, reset, q);
  input [32:0] d;
  input en;
  input ph1;
  input ph2;
  input reset;
  output [32:0] q;

  supply1 vdd;
  supply0 gnd;
  wire net_10, net_11, net_12, net_13, net_16, net_2, net_6;

  DatapathDone__clkinvbufdual_4x clkinvbu_0(.ph1b(net_13), .ph1buf(net_12), 
      .ph2b(net_11), .ph2buf(net_10), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopenr_dp_1x flopenr_32_32_(.d(d[32]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[32]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_31_(.d(d[31]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[31]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_30_(.d(d[30]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[30]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_29_(.d(d[29]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[29]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_28_(.d(d[28]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[28]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_27_(.d(d[27]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[27]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_26_(.d(d[26]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[26]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_25_(.d(d[25]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[25]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_24_(.d(d[24]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[24]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_23_(.d(d[23]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[23]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_22_(.d(d[22]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[22]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_21_(.d(d[21]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[21]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_20_(.d(d[20]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[20]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_19_(.d(d[19]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[19]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_18_(.d(d[18]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[18]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_17_(.d(d[17]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[17]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_16_(.d(d[16]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[16]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_15_(.d(d[15]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[15]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_14_(.d(d[14]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[14]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_13_(.d(d[13]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[13]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_12_(.d(d[12]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[12]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_11_(.d(d[11]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[11]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_10_(.d(d[10]), .en(net_16), 
      .enb(net_2), .resetb(net_6), .q(q[10]), .ph1(net_12), .ph1b(net_13), 
      .ph2(net_10), .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_9_(.d(d[9]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[9]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_8_(.d(d[8]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[8]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_7_(.d(d[7]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[7]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_6_(.d(d[6]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[6]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_5_(.d(d[5]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[5]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_4_(.d(d[4]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[4]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_3_(.d(d[3]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[3]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_2_(.d(d[2]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[2]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_1_(.d(d[1]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[1]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flopenr_32_0_(.d(d[0]), .en(net_16), .enb(net_2), 
      .resetb(net_6), .q(q[0]), .ph1(net_12), .ph1b(net_13), .ph2(net_10), 
      .ph2b(net_11));
  DatapathDone__inv_4x inv_4x_0(.a(reset), .y(net_6));
  DatapathDone__invbuf_4x invbuf_4_0(.s(en), .s_out(net_16), .sb_out(net_2));
endmodule   /* DatapathDone__flopenr_32_mod */

module DatapathDone__mux2_dp_1x_34(d0, d1, s, y);
  input [33:0] d0;
  input [33:0] d1;
  input s;
  output [33:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_27, net_29;

  DatapathDone__invbuf_4x invbuf_4_0(.s(s), .s_out(net_29), .sb_out(net_27));
  DatapathDone__mux2_dp_1x mux2_1x_dp_33_(.d0(d0[33]), .d1(d1[33]), .s(net_29), 
      .sb(net_27), .y(y[33]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_32_(.d0(d0[32]), .d1(d1[32]), .s(net_29), 
      .sb(net_27), .y(y[32]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_31_(.d0(d0[31]), .d1(d1[31]), .s(net_29), 
      .sb(net_27), .y(y[31]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_30_(.d0(d0[30]), .d1(d1[30]), .s(net_29), 
      .sb(net_27), .y(y[30]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_29_(.d0(d0[29]), .d1(d1[29]), .s(net_29), 
      .sb(net_27), .y(y[29]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_28_(.d0(d0[28]), .d1(d1[28]), .s(net_29), 
      .sb(net_27), .y(y[28]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_27_(.d0(d0[27]), .d1(d1[27]), .s(net_29), 
      .sb(net_27), .y(y[27]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_26_(.d0(d0[26]), .d1(d1[26]), .s(net_29), 
      .sb(net_27), .y(y[26]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_25_(.d0(d0[25]), .d1(d1[25]), .s(net_29), 
      .sb(net_27), .y(y[25]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_24_(.d0(d0[24]), .d1(d1[24]), .s(net_29), 
      .sb(net_27), .y(y[24]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_23_(.d0(d0[23]), .d1(d1[23]), .s(net_29), 
      .sb(net_27), .y(y[23]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_22_(.d0(d0[22]), .d1(d1[22]), .s(net_29), 
      .sb(net_27), .y(y[22]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_21_(.d0(d0[21]), .d1(d1[21]), .s(net_29), 
      .sb(net_27), .y(y[21]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_20_(.d0(d0[20]), .d1(d1[20]), .s(net_29), 
      .sb(net_27), .y(y[20]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_19_(.d0(d0[19]), .d1(d1[19]), .s(net_29), 
      .sb(net_27), .y(y[19]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_18_(.d0(d0[18]), .d1(d1[18]), .s(net_29), 
      .sb(net_27), .y(y[18]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_17_(.d0(d0[17]), .d1(d1[17]), .s(net_29), 
      .sb(net_27), .y(y[17]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_16_(.d0(d0[16]), .d1(d1[16]), .s(net_29), 
      .sb(net_27), .y(y[16]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_15_(.d0(d0[15]), .d1(d1[15]), .s(net_29), 
      .sb(net_27), .y(y[15]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_14_(.d0(d0[14]), .d1(d1[14]), .s(net_29), 
      .sb(net_27), .y(y[14]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_13_(.d0(d0[13]), .d1(d1[13]), .s(net_29), 
      .sb(net_27), .y(y[13]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_12_(.d0(d0[12]), .d1(d1[12]), .s(net_29), 
      .sb(net_27), .y(y[12]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_11_(.d0(d0[11]), .d1(d1[11]), .s(net_29), 
      .sb(net_27), .y(y[11]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_10_(.d0(d0[10]), .d1(d1[10]), .s(net_29), 
      .sb(net_27), .y(y[10]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_9_(.d0(d0[9]), .d1(d1[9]), .s(net_29), 
      .sb(net_27), .y(y[9]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_8_(.d0(d0[8]), .d1(d1[8]), .s(net_29), 
      .sb(net_27), .y(y[8]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_7_(.d0(d0[7]), .d1(d1[7]), .s(net_29), 
      .sb(net_27), .y(y[7]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_6_(.d0(d0[6]), .d1(d1[6]), .s(net_29), 
      .sb(net_27), .y(y[6]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_5_(.d0(d0[5]), .d1(d1[5]), .s(net_29), 
      .sb(net_27), .y(y[5]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_4_(.d0(d0[4]), .d1(d1[4]), .s(net_29), 
      .sb(net_27), .y(y[4]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_3_(.d0(d0[3]), .d1(d1[3]), .s(net_29), 
      .sb(net_27), .y(y[3]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_2_(.d0(d0[2]), .d1(d1[2]), .s(net_29), 
      .sb(net_27), .y(y[2]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_1_(.d0(d0[1]), .d1(d1[1]), .s(net_29), 
      .sb(net_27), .y(y[1]));
  DatapathDone__mux2_dp_1x mux2_1x_dp_0_(.d0(d0[0]), .d1(d1[0]), .s(net_29), 
      .sb(net_27), .y(y[0]));
endmodule   /* DatapathDone__mux2_dp_1x_34 */

module DatapathDone__shl1r2_34(a, dir, inl, inr, y);
  input [33:0] a;
  input dir;
  input [1:0] inl;
  input inr;
  output [33:0] y;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__mux2_dp_1x_34 mux2_dp__0(.d0({a[32], a[31], a[30], a[29], 
      a[28], a[27], a[26], a[25], a[24], a[23], a[22], a[21], a[20], a[19], 
      a[18], a[17], a[16], a[15], a[14], a[13], a[12], a[11], a[10], a[9], 
      a[8], a[7], a[6], a[5], a[4], a[3], a[2], a[1], a[0], inr}), .d1({inl[1], 
      inl[0], a[33], a[32], a[31], a[30], a[29], a[28], a[27], a[26], a[25], 
      a[24], a[23], a[22], a[21], a[20], a[19], a[18], a[17], a[16], a[15], 
      a[14], a[13], a[12], a[11], a[10], a[9], a[8], a[7], a[6], a[5], a[4], 
      a[3], a[2]}), .s(dir), .y(y[33:0]));
endmodule   /* DatapathDone__shl1r2_34 */

module DatapathDone__shl1r2_32(a, dir, inl, inr, y);
  input [31:0] a;
  input dir;
  input [1:0] inl;
  input inr;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__mux2_dp_1x_32 mux2_dp__0(.d0({a[30], a[29], a[28], a[27], 
      a[26], a[25], a[24], a[23], a[22], a[21], a[20], a[19], a[18], a[17], 
      a[16], a[15], a[14], a[13], a[12], a[11], a[10], a[9], a[8], a[7], a[6], 
      a[5], a[4], a[3], a[2], a[1], a[0], inr}), .d1({inl[1], inl[0], a[31], 
      a[30], a[29], a[28], a[27], a[26], a[25], a[24], a[23], a[22], a[21], 
      a[20], a[19], a[18], a[17], a[16], a[15], a[14], a[13], a[12], a[11], 
      a[10], a[9], a[8], a[7], a[6], a[5], a[4], a[3], a[2]}), .s(dir), 
      .y(y[31:0]));
endmodule   /* DatapathDone__shl1r2_32 */

module DatapathDone__xor2_1x_34(a, b, y);
  input [33:0] a;
  input [33:0] b;
  output [33:0] y;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__xor2_1x xor2_1x_33_(.a(a[33]), .b(b[33]), .y(y[33]));
  DatapathDone__xor2_1x xor2_1x_32_(.a(a[32]), .b(b[32]), .y(y[32]));
  DatapathDone__xor2_1x xor2_1x_31_(.a(a[31]), .b(b[31]), .y(y[31]));
  DatapathDone__xor2_1x xor2_1x_30_(.a(a[30]), .b(b[30]), .y(y[30]));
  DatapathDone__xor2_1x xor2_1x_29_(.a(a[29]), .b(b[29]), .y(y[29]));
  DatapathDone__xor2_1x xor2_1x_28_(.a(a[28]), .b(b[28]), .y(y[28]));
  DatapathDone__xor2_1x xor2_1x_27_(.a(a[27]), .b(b[27]), .y(y[27]));
  DatapathDone__xor2_1x xor2_1x_26_(.a(a[26]), .b(b[26]), .y(y[26]));
  DatapathDone__xor2_1x xor2_1x_25_(.a(a[25]), .b(b[25]), .y(y[25]));
  DatapathDone__xor2_1x xor2_1x_24_(.a(a[24]), .b(b[24]), .y(y[24]));
  DatapathDone__xor2_1x xor2_1x_23_(.a(a[23]), .b(b[23]), .y(y[23]));
  DatapathDone__xor2_1x xor2_1x_22_(.a(a[22]), .b(b[22]), .y(y[22]));
  DatapathDone__xor2_1x xor2_1x_21_(.a(a[21]), .b(b[21]), .y(y[21]));
  DatapathDone__xor2_1x xor2_1x_20_(.a(a[20]), .b(b[20]), .y(y[20]));
  DatapathDone__xor2_1x xor2_1x_19_(.a(a[19]), .b(b[19]), .y(y[19]));
  DatapathDone__xor2_1x xor2_1x_18_(.a(a[18]), .b(b[18]), .y(y[18]));
  DatapathDone__xor2_1x xor2_1x_17_(.a(a[17]), .b(b[17]), .y(y[17]));
  DatapathDone__xor2_1x xor2_1x_16_(.a(a[16]), .b(b[16]), .y(y[16]));
  DatapathDone__xor2_1x xor2_1x_15_(.a(a[15]), .b(b[15]), .y(y[15]));
  DatapathDone__xor2_1x xor2_1x_14_(.a(a[14]), .b(b[14]), .y(y[14]));
  DatapathDone__xor2_1x xor2_1x_13_(.a(a[13]), .b(b[13]), .y(y[13]));
  DatapathDone__xor2_1x xor2_1x_12_(.a(a[12]), .b(b[12]), .y(y[12]));
  DatapathDone__xor2_1x xor2_1x_11_(.a(a[11]), .b(b[11]), .y(y[11]));
  DatapathDone__xor2_1x xor2_1x_10_(.a(a[10]), .b(b[10]), .y(y[10]));
  DatapathDone__xor2_1x xor2_1x_9_(.a(a[9]), .b(b[9]), .y(y[9]));
  DatapathDone__xor2_1x xor2_1x_8_(.a(a[8]), .b(b[8]), .y(y[8]));
  DatapathDone__xor2_1x xor2_1x_7_(.a(a[7]), .b(b[7]), .y(y[7]));
  DatapathDone__xor2_1x xor2_1x_6_(.a(a[6]), .b(b[6]), .y(y[6]));
  DatapathDone__xor2_1x xor2_1x_5_(.a(a[5]), .b(b[5]), .y(y[5]));
  DatapathDone__xor2_1x xor2_1x_4_(.a(a[4]), .b(b[4]), .y(y[4]));
  DatapathDone__xor2_1x xor2_1x_3_(.a(a[3]), .b(b[3]), .y(y[3]));
  DatapathDone__xor2_1x xor2_1x_2_(.a(a[2]), .b(b[2]), .y(y[2]));
  DatapathDone__xor2_1x xor2_1x_1_(.a(a[1]), .b(b[1]), .y(y[1]));
  DatapathDone__xor2_1x xor2_1x_0_(.a(a[0]), .b(b[0]), .y(y[0]));
endmodule   /* DatapathDone__xor2_1x_34 */

module DatapathDone__nand2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_5;

  tranif1 nmos_0(net_5, y, b);
  tranif1 nmos_1(gnd, net_5, a);
  tranif0 pmos_0(y, vdd, b);
  tranif0 pmos_1(y, vdd, a);
endmodule   /* DatapathDone__nand2_1x */

module DatapathDone__yzdetect_32(a, yzero);
  input [31:0] a;
  output yzero;

  supply1 vdd;
  supply0 gnd;
  wire net_142, net_143, net_145, net_146, net_148, net_149, net_151, net_152;
  wire net_154, net_155, net_157, net_158, net_160, net_161, net_163, net_164;
  wire net_166, net_168, net_170, net_172, net_174, net_177, net_179, net_182;
  wire net_185, net_187, net_189, net_191, net_193, net_195;

  DatapathDone__nand2_1x nand2_1x_0(.a(net_142), .b(net_143), .y(net_182));
  DatapathDone__nand2_1x nand2_1x_1(.a(net_145), .b(net_146), .y(net_179));
  DatapathDone__nand2_1x nand2_1x_2(.a(net_148), .b(net_149), .y(net_168));
  DatapathDone__nand2_1x nand2_1x_4(.a(net_151), .b(net_152), .y(net_166));
  DatapathDone__nand2_1x nand2_1x_5(.a(net_154), .b(net_155), .y(net_170));
  DatapathDone__nand2_1x nand2_1x_6(.a(net_157), .b(net_158), .y(net_172));
  DatapathDone__nand2_1x nand2_1x_7(.a(net_160), .b(net_161), .y(net_174));
  DatapathDone__nand2_1x nand2_1x_8(.a(net_163), .b(net_164), .y(net_177));
  DatapathDone__nand2_1x nand2_1x_9(.a(net_182), .b(net_179), .y(net_187));
  DatapathDone__nand2_1x nand2_1x_10(.a(net_168), .b(net_166), .y(net_185));
  DatapathDone__nand2_1x nand2_1x_11(.a(net_170), .b(net_172), .y(net_189));
  DatapathDone__nand2_1x nand2_1x_12(.a(net_174), .b(net_177), .y(net_191));
  DatapathDone__nand2_1x nand2_1x_13(.a(net_187), .b(net_185), .y(net_193));
  DatapathDone__nand2_1x nand2_1x_14(.a(net_189), .b(net_191), .y(net_195));
  DatapathDone__nand2_1x nand2_1x_15(.a(net_193), .b(net_195), .y(yzero));
  DatapathDone__nor2_1x nor2_1x_0(.a(a[0]), .b(a[1]), .y(net_142));
  DatapathDone__nor2_1x nor2_1x_1(.a(a[4]), .b(a[5]), .y(net_145));
  DatapathDone__nor2_1x nor2_1x_2(.a(a[8]), .b(a[9]), .y(net_148));
  DatapathDone__nor2_1x nor2_1x_3(.a(a[12]), .b(a[13]), .y(net_151));
  DatapathDone__nor2_1x nor2_1x_5(.a(a[16]), .b(a[17]), .y(net_154));
  DatapathDone__nor2_1x nor2_1x_6(.a(a[20]), .b(a[21]), .y(net_157));
  DatapathDone__nor2_1x nor2_1x_7(.a(a[24]), .b(a[25]), .y(net_160));
  DatapathDone__nor2_1x nor2_1x_8(.a(a[28]), .b(a[29]), .y(net_163));
  DatapathDone__nor2_1x nor2_1x_9(.a(a[2]), .b(a[3]), .y(net_143));
  DatapathDone__nor2_1x nor2_1x_10(.a(a[6]), .b(a[7]), .y(net_146));
  DatapathDone__nor2_1x nor2_1x_11(.a(a[10]), .b(a[11]), .y(net_149));
  DatapathDone__nor2_1x nor2_1x_12(.a(a[14]), .b(a[15]), .y(net_152));
  DatapathDone__nor2_1x nor2_1x_13(.a(a[18]), .b(a[19]), .y(net_155));
  DatapathDone__nor2_1x nor2_1x_14(.a(a[22]), .b(a[23]), .y(net_158));
  DatapathDone__nor2_1x nor2_1x_15(.a(a[26]), .b(a[27]), .y(net_161));
  DatapathDone__nor2_1x nor2_1x_16(.a(a[30]), .b(a[31]), .y(net_164));
endmodule   /* DatapathDone__yzdetect_32 */

module DatapathDone__multdiv(muldivb, ph1, ph2, reset, signedop, start, x, y, 
      prodh, prodl, run);
  input muldivb;
  input ph1;
  input ph2;
  input reset;
  input signedop;
  input start;
  input [31:0] x;
  input [31:0] y;
  output [31:0] prodh;
  output [31:0] prodl;
  output run;

  supply1 vdd;
  supply0 gnd;
  wire cin, cout, done, init, muldivbsaved, qi, signedopsaved, srchinv;
  wire srchinvBBB, xsavedsign, yzero;
  wire [33:0] nextprodh;
  wire [31:0] nextprodl;
  wire [1:0] prodhextra;
  wire [1:0] prodhsel;
  wire [33:0] prodhsh;
  wire [1:0] prodlsel;
  wire [31:0] prodlsh;
  wire [33:0] srch;
  wire [33:0] srch1;
  wire [33:0] srchplusyy;
  wire [1:0] srchsel;
  wire [31:0] ysaved;
  wire [0:0] ysel;
  wire [2:2] ysel_1;
  wire [33:0] yy;

  DatapathDone__adder_34 addh_34(.a(srch[33:0]), .b(yy[33:0]), .cin(cin), 
      .cout(cout), .s(srchplusyy[33:0]));
  DatapathDone__boothsel boothsel_0(.a(ysaved[31:0]), .boothsel({ysel_1[2], 
      cin, ysel[0]}), .signedopsaved(signedopsaved), .y(yy[33:0]));
  DatapathDone__buf_4x buf_4x_0(.a(srchinv), .y(srchinvBBB));
  DatapathDone__mdcon mdcon_1(.addsign(srchplusyy[33]), .muldivb(muldivb), 
      .reset(reset), .signedop(signedop), .srchsign(srch1[31]), .start(start), 
      .x(prodl[1:0]), .xsavedsign(xsavedsign), .xsign(x[31]), 
      .ysavedsign(ysaved[31]), .ysign(yzero), .done(done), .init(init), 
      .muldivbsaved(muldivbsaved), .prodhsel(prodhsel[1:0]), 
      .prodlsel(prodlsel[1:0]), .qi(qi), .run(run), 
      .signedopsaved(signedopsaved), .srchinv(srchinv), .srchsel(srchsel[1:0]), 
      .ysel({ysel_1[2], cin, ysel[0]}), .ph1(ph1), .ph2(ph2));
  DatapathDone__mux3_dp_1x_34 prodhmux_34(.d0(prodhsh[33:0]), 
      .d1(srchplusyy[33:0]), .d2({prodhextra[1], prodhextra[0], prodh[31], 
      prodh[30], prodh[29], prodh[28], prodh[27], prodh[26], prodh[25], 
      prodh[24], prodh[23], prodh[22], prodh[21], prodh[20], prodh[19], 
      prodh[18], prodh[17], prodh[16], prodh[15], prodh[14], prodh[13], 
      prodh[12], prodh[11], prodh[10], prodh[9], prodh[8], prodh[7], prodh[6], 
      prodh[5], prodh[4], prodh[3], prodh[2], prodh[1], prodh[0]}), 
      .s0(prodhsel[0]), .s1(prodhsel[1]), .y(nextprodh[33:0]));
  DatapathDone__flopenr_34 prodhreg_34(.d(nextprodh[33:0]), .en(run), 
      .ph1(ph1), .ph2(ph2), .reset(init), .q({prodhextra[1], prodhextra[0], 
      prodh[31], prodh[30], prodh[29], prodh[28], prodh[27], prodh[26], 
      prodh[25], prodh[24], prodh[23], prodh[22], prodh[21], prodh[20], 
      prodh[19], prodh[18], prodh[17], prodh[16], prodh[15], prodh[14], 
      prodh[13], prodh[12], prodh[11], prodh[10], prodh[9], prodh[8], prodh[7], 
      prodh[6], prodh[5], prodh[4], prodh[3], prodh[2], prodh[1], prodh[0]}));
  DatapathDone__mux4_dp_1x_32 prodlmux_32(.d0(prodlsh[31:0]), 
      .d1(srchplusyy[31:0]), .d2(prodl[31:0]), .d3(x[31:0]), .s0(prodlsel[0]), 
      .s1(prodlsel[1]), .y(nextprodl[31:0]));
  DatapathDone__flopenr_32_mod prodlreg_32andxreg(.d({x[31], nextprodl[31], 
      nextprodl[30], nextprodl[29], nextprodl[28], nextprodl[27], 
      nextprodl[26], nextprodl[25], nextprodl[24], nextprodl[23], 
      nextprodl[22], nextprodl[21], nextprodl[20], nextprodl[19], 
      nextprodl[18], nextprodl[17], nextprodl[16], nextprodl[15], 
      nextprodl[14], nextprodl[13], nextprodl[12], nextprodl[11], 
      nextprodl[10], nextprodl[9], nextprodl[8], nextprodl[7], nextprodl[6], 
      nextprodl[5], nextprodl[4], nextprodl[3], nextprodl[2], nextprodl[1], 
      nextprodl[0]}), .en(run), .ph1(ph1), .ph2(ph2), .reset(reset), 
      .q({xsavedsign, prodl[31], prodl[30], prodl[29], prodl[28], prodl[27], 
      prodl[26], prodl[25], prodl[24], prodl[23], prodl[22], prodl[21], 
      prodl[20], prodl[19], prodl[18], prodl[17], prodl[16], prodl[15], 
      prodl[14], prodl[13], prodl[12], prodl[11], prodl[10], prodl[9], 
      prodl[8], prodl[7], prodl[6], prodl[5], prodl[4], prodl[3], prodl[2], 
      prodl[1], prodl[0]}));
  DatapathDone__shl1r2_34 shl1r2_3_0(.a({prodhextra[1], prodhextra[0], 
      prodh[31], prodh[30], prodh[29], prodh[28], prodh[27], prodh[26], 
      prodh[25], prodh[24], prodh[23], prodh[22], prodh[21], prodh[20], 
      prodh[19], prodh[18], prodh[17], prodh[16], prodh[15], prodh[14], 
      prodh[13], prodh[12], prodh[11], prodh[10], prodh[9], prodh[8], prodh[7], 
      prodh[6], prodh[5], prodh[4], prodh[3], prodh[2], prodh[1], prodh[0]}), 
      .dir(muldivbsaved), .inl({prodhextra[1], prodhextra[1]}), 
      .inr(prodl[31]), .y(prodhsh[33:0]));
  DatapathDone__shl1r2_32 shl1r2_3_1(.a(prodl[31:0]), .dir(muldivbsaved), 
      .inl(prodh[1:0]), .inr(qi), .y(prodlsh[31:0]));
  DatapathDone__mux3_dp_1x_34 srchmux_34(.d0(prodhsh[33:0]), 
      .d1({prodhextra[1], prodhextra[0], prodh[31], prodh[30], prodh[29], 
      prodh[28], prodh[27], prodh[26], prodh[25], prodh[24], prodh[23], 
      prodh[22], prodh[21], prodh[20], prodh[19], prodh[18], prodh[17], 
      prodh[16], prodh[15], prodh[14], prodh[13], prodh[12], prodh[11], 
      prodh[10], prodh[9], prodh[8], prodh[7], prodh[6], prodh[5], prodh[4], 
      prodh[3], prodh[2], prodh[1], prodh[0]}), .d2({gnd, gnd, prodl[31], 
      prodl[30], prodl[29], prodl[28], prodl[27], prodl[26], prodl[25], 
      prodl[24], prodl[23], prodl[22], prodl[21], prodl[20], prodl[19], 
      prodl[18], prodl[17], prodl[16], prodl[15], prodl[14], prodl[13], 
      prodl[12], prodl[11], prodl[10], prodl[9], prodl[8], prodl[7], prodl[6], 
      prodl[5], prodl[4], prodl[3], prodl[2], prodl[1], prodl[0]}), 
      .s0(srchsel[0]), .s1(srchsel[1]), .y(srch1[33:0]));
  DatapathDone__xor2_1x_34 srchxor_34(.a(srch1[33:0]), .b({srchinvBBB, 
      srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, 
      srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, 
      srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, 
      srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, 
      srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, srchinvBBB, 
      srchinvBBB, srchinvBBB, srchinvBBB}), .y(srch[33:0]));
  DatapathDone__flopenr_32 yreg_32(.d(y[31:0]), .en(start), .ph1(ph1), 
      .ph2(ph2), .reset(reset), .q(ysaved[31:0]));
  DatapathDone__yzdetect_32 yzdetect_0(.a(ysaved[31:0]), .yzero(yzero));
endmodule   /* DatapathDone__multdiv */

module DatapathDone__mdunit(alushcontrol, hilodisable, hilosrc, mdstart, ph1, 
      ph2, reset, srca, srcb, hi, lo, mdrun);
  input [2:0] alushcontrol;
  input [1:0] hilodisable;
  input hilosrc;
  input mdstart;
  input ph1;
  input ph2;
  input reset;
  input [31:0] srca;
  input [31:0] srcb;
  output [31:0] hi;
  output [31:0] lo;
  output mdrun;

  supply1 vdd;
  supply0 gnd;
  wire [1:0] hilodisableb;
  wire [31:0] hinext;
  wire [31:0] lonext;
  wire [31:0] prodh;
  wire [31:0] prodl;

  DatapathDone__flopenr_32 hireg_32(.d(hinext[31:0]), .en(hilodisableb[1]), 
      .ph1(ph1), .ph2(ph2), .reset(reset), .q(hi[31:0]));
  DatapathDone__mux2_dp_1x_32 hisrcmux_32(.d0(prodh[31:0]), .d1(srca[31:0]), 
      .s(hilosrc), .y(hinext[31:0]));
  DatapathDone__inv_1x inv_1x_1_(.a(hilodisable[1]), .y(hilodisableb[1]));
  DatapathDone__inv_1x inv_1x_0_(.a(hilodisable[0]), .y(hilodisableb[0]));
  DatapathDone__flopenr_32 loreg_32(.d(lonext[31:0]), .en(hilodisableb[0]), 
      .ph1(ph1), .ph2(ph2), .reset(reset), .q(lo[31:0]));
  DatapathDone__mux2_dp_1x_32 losrcmux_32(.d0(prodl[31:0]), .d1(srca[31:0]), 
      .s(hilosrc), .y(lonext[31:0]));
  DatapathDone__multdiv multdiv_0(.muldivb(alushcontrol[0]), .ph1(ph1), 
      .ph2(ph2), .reset(reset), .signedop(alushcontrol[1]), .start(mdstart), 
      .x(srca[31:0]), .y(srcb[31:0]), .prodh(prodh[31:0]), .prodl(prodl[31:0]), 
      .run(mdrun));
endmodule   /* DatapathDone__mdunit */

module DatapathDone__executestage(aluoutM, aluoutsrcE, alushcontrolE, alusrcE, 
      cop0readdataE, forwardaE, forwardbE, hilodisableE, hilosrcE, luiE, 
      mdstartE, pcE, ph1, ph2, reset, resultW, signimmE, specialregsrcE, srcaE, 
      srcbE, aluoutE, mdrunE, misalignedwE, overflowE, srcb2E);
  input [31:0] aluoutM;
  input [1:0] aluoutsrcE;
  input [2:0] alushcontrolE;
  input alusrcE;
  input [31:0] cop0readdataE;
  input [1:0] forwardaE;
  input [1:0] forwardbE;
  input [1:0] hilodisableE;
  input hilosrcE;
  input luiE;
  input mdstartE;
  input [31:0] pcE;
  input ph1;
  input ph2;
  input reset;
  input [31:0] resultW;
  input [31:0] signimmE;
  input [1:0] specialregsrcE;
  input [31:0] srcaE;
  input [31:0] srcbE;
  output [31:0] aluoutE;
  output mdrunE;
  output misalignedwE;
  output overflowE;
  output [31:0] srcb2E;

  supply1 vdd;
  supply0 gnd;
  wire pcadd2_32_cout;
  wire [31:0] aluresultE;
  wire [31:0] hiE;
  wire [31:0] loE;
  wire [31:0] pcplus8E;
  wire [31:0] shiftresultE;
  wire [31:0] specialregE;
  wire [31:0] srca2E;
  wire [31:0] srcb3E;

  DatapathDone__ALU_dp ALU_dp_0(.alushcontrolE(alushcontrolE[2:0]), 
      .srca2E(srca2E[31:0]), .srcb3E(srcb3E[31:0]), 
      .ALUresultE(aluresultE[31:0]), .overflowE(overflowE));
  DatapathDone__Shifter_dp Shifter__2(.alushcontrolE(alushcontrolE[2:0]), 
      .luiE(luiE), .signimmE(signimmE[10:6]), .srca2E(srca2E[4:0]), 
      .srcb3E(srcb3E[31:0]), .shiftresultE(shiftresultE[31:0]));
  DatapathDone__mux4_dp_1x_32 aluoutmux_32(.d0(aluresultE[31:0]), 
      .d1(shiftresultE[31:0]), .d2(pcplus8E[31:0]), .d3(specialregE[31:0]), 
      .s0(aluoutsrcE[0]), .s1(aluoutsrcE[1]), .y(aluoutE[31:0]));
  DatapathDone__mux3_dp_1x_32 forwardaemux_32(.d0(srcaE[31:0]), 
      .d1(resultW[31:0]), .d2(aluoutM[31:0]), .s0(forwardaE[0]), 
      .s1(forwardaE[1]), .y(srca2E[31:0]));
  DatapathDone__mux3_dp_1x_32 forwardbemux_32(.d0(srcbE[31:0]), 
      .d1(resultW[31:0]), .d2(aluoutM[31:0]), .s0(forwardbE[0]), 
      .s1(forwardbE[1]), .y(srcb2E[31:0]));
  DatapathDone__mdunit mdunit_1(.alushcontrol(alushcontrolE[2:0]), 
      .hilodisable(hilodisableE[1:0]), .hilosrc(hilosrcE), .mdstart(mdstartE), 
      .ph1(ph1), .ph2(ph2), .reset(reset), .srca(srca2E[31:0]), 
      .srcb(srcb3E[31:0]), .hi(hiE[31:0]), .lo(loE[31:0]), .mdrun(mdrunE));
  DatapathDone__or2_1x or2_1x_0(.a(aluoutE[1]), .b(aluoutE[0]), 
      .y(misalignedwE));
  DatapathDone__adder_32 pcadd2_32(.a(pcE[31:0]), .b({gnd, gnd, gnd, gnd, gnd, 
      gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, 
      gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, vdd, gnd, gnd, gnd}), 
      .cin(gnd), .cout(pcadd2_32_cout), .s(pcplus8E[31:0]));
  DatapathDone__mux3_dp_1x_32 specialregmux_32(.d0(cop0readdataE[31:0]), 
      .d1(hiE[31:0]), .d2(loE[31:0]), .s0(specialregsrcE[0]), 
      .s1(specialregsrcE[1]), .y(specialregE[31:0]));
  DatapathDone__mux2_dp_1x_32 srcbmux_32(.d0(srcb2E[31:0]), 
      .d1(signimmE[31:0]), .s(alusrcE), .y(srcb3E[31:0]));
endmodule   /* DatapathDone__executestage */

module DatapathDone__nor2_2x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_9;

  tranif1 nmos_0(gnd, y, a);
  tranif1 nmos_1(gnd, y, b);
  tranif0 pmos_0(y, net_9, b);
  tranif0 pmos_1(net_9, vdd, a);
endmodule   /* DatapathDone__nor2_2x */

module DatapathDone__flopenrc_32(clear, d, en, ph1, ph2, reset, q);
  input clear;
  input [31:0] d;
  input en;
  input ph1;
  input ph2;
  input reset;
  output [31:0] q;

  supply1 vdd;
  supply0 gnd;
  wire enb, enbuf, net_0, net_1, net_2, net_3, rci;

  DatapathDone__clkinvbufdual_4x clkinvbu_0(.ph1b(net_2), .ph1buf(net_1), 
      .ph2b(net_3), .ph2buf(net_0), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopenr_dp_1x flopenr_31_(.d(d[31]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[31]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_30_(.d(d[30]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[30]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_29_(.d(d[29]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[29]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_28_(.d(d[28]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[28]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_27_(.d(d[27]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[27]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_26_(.d(d[26]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[26]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_25_(.d(d[25]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[25]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_24_(.d(d[24]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[24]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_23_(.d(d[23]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[23]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_22_(.d(d[22]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[22]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_21_(.d(d[21]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[21]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_20_(.d(d[20]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[20]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_19_(.d(d[19]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[19]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_18_(.d(d[18]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[18]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_17_(.d(d[17]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[17]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_16_(.d(d[16]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[16]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_15_(.d(d[15]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[15]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_14_(.d(d[14]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[14]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_13_(.d(d[13]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[13]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_12_(.d(d[12]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[12]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_11_(.d(d[11]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[11]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_10_(.d(d[10]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[10]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_9_(.d(d[9]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[9]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_8_(.d(d[8]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[8]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_7_(.d(d[7]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[7]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_6_(.d(d[6]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[6]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_5_(.d(d[5]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[5]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_4_(.d(d[4]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[4]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_3_(.d(d[3]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[3]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_2_(.d(d[2]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[2]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_1_(.d(d[1]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[1]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__flopenr_dp_1x flopenr_0_(.d(d[0]), .en(enbuf), .enb(enb), 
      .resetb(rci), .q(q[0]), .ph1(net_1), .ph1b(net_2), .ph2(net_0), 
      .ph2b(net_3));
  DatapathDone__invbuf_4x invbuf_4_0(.s(en), .s_out(enbuf), .sb_out(enb));
  DatapathDone__nor2_2x nor2_2x_0(.a(reset), .b(clear), .y(rci));
endmodule   /* DatapathDone__flopenrc_32 */

module DatapathDone__Execute_Memory_Writeback(aluoutsrcE, alushcontrolE, 
      alusrcE, byteM, cop0readdataE, flushM, forwardaE, forwardbE, halfwordM, 
      hilodisableE, hilosrcE, loadsignedM, luiE, mdstartE, memtoregW, pcE, ph1, 
      ph2, re, reset, signimmE, specialregsrcE, srcaE, srcbE, stallM, stallW, 
      aluoutM, byteenM, mdrunE, misalignedhE, misalignedwE, overflowE, 
      readdataM, resultW, writedata2M, writedataW);
  input [1:0] aluoutsrcE;
  input [2:0] alushcontrolE;
  input alusrcE;
  input byteM;
  input [31:0] cop0readdataE;
  input flushM;
  input [1:0] forwardaE;
  input [1:0] forwardbE;
  input halfwordM;
  input [1:0] hilodisableE;
  input hilosrcE;
  input loadsignedM;
  input luiE;
  input mdstartE;
  input memtoregW;
  input [31:0] pcE;
  input ph1;
  input ph2;
  input re;
  input reset;
  input [31:0] signimmE;
  input [1:0] specialregsrcE;
  input [31:0] srcaE;
  input [31:0] srcbE;
  input stallM;
  input stallW;
  output [31:0] aluoutM;
  output [3:0] byteenM;
  output mdrunE;
  output misalignedhE;
  output misalignedwE;
  output overflowE;
  output [31:0] readdataM;
  output [31:0] resultW;
  output [31:0] writedata2M;
  output [31:0] writedataW;

  supply1 vdd;
  supply0 gnd;
  wire stallMb;
  wire [31:1] aluoutE;
  wire [31:0] srcb2E;
  wire [31:0] writedataM;

  DatapathDone__Memory_Writeback Memory_W_0(.aluoutM(aluoutM[31:0]), 
      .byteM(byteM), .halfwordM(halfwordM), .loadsignedM(loadsignedM), 
      .memtoregW(memtoregW), .ph1(ph1), .ph2(ph2), .re(re), 
      .readdataM(readdataM[31:0]), .reset(reset), .stallW(stallW), 
      .writedataM(writedataM[31:0]), .byteenM(byteenM[3:0]), 
      .resultW(resultW[31:0]), .writedata2M(writedata2M[31:0]), 
      .writedataW(writedataW[31:0]));
  DatapathDone__inv_4x inv_4x_1(.a(stallM), .y(stallMb));
  DatapathDone__executestage mdrunExecute(.aluoutM(aluoutM[31:0]), 
      .aluoutsrcE(aluoutsrcE[1:0]), .alushcontrolE(alushcontrolE[2:0]), 
      .alusrcE(alusrcE), .cop0readdataE(cop0readdataE[31:0]), 
      .forwardaE(forwardaE[1:0]), .forwardbE(forwardbE[1:0]), 
      .hilodisableE(hilodisableE[1:0]), .hilosrcE(hilosrcE), .luiE(luiE), 
      .mdstartE(mdstartE), .pcE(pcE[31:0]), .ph1(ph1), .ph2(ph2), 
      .reset(reset), .resultW(resultW[31:0]), .signimmE(signimmE[31:0]), 
      .specialregsrcE(specialregsrcE[1:0]), .srcaE(srcaE[31:0]), 
      .srcbE(srcbE[31:0]), .aluoutE({aluoutE[31], aluoutE[30], aluoutE[29], 
      aluoutE[28], aluoutE[27], aluoutE[26], aluoutE[25], aluoutE[24], 
      aluoutE[23], aluoutE[22], aluoutE[21], aluoutE[20], aluoutE[19], 
      aluoutE[18], aluoutE[17], aluoutE[16], aluoutE[15], aluoutE[14], 
      aluoutE[13], aluoutE[12], aluoutE[11], aluoutE[10], aluoutE[9], 
      aluoutE[8], aluoutE[7], aluoutE[6], aluoutE[5], aluoutE[4], aluoutE[3], 
      aluoutE[2], aluoutE[1], misalignedhE}), .mdrunE(mdrunE), 
      .misalignedwE(misalignedwE), .overflowE(overflowE), 
      .srcb2E(srcb2E[31:0]));
  DatapathDone__flopenrc_32 r1M_32(.clear(flushM), .d(srcb2E[31:0]), 
      .en(stallMb), .ph1(ph1), .ph2(ph2), .reset(reset), 
      .q(writedataM[31:0]));
  DatapathDone__flopenrc_32 r2M_32(.clear(flushM), .d({aluoutE[31], 
      aluoutE[30], aluoutE[29], aluoutE[28], aluoutE[27], aluoutE[26], 
      aluoutE[25], aluoutE[24], aluoutE[23], aluoutE[22], aluoutE[21], 
      aluoutE[20], aluoutE[19], aluoutE[18], aluoutE[17], aluoutE[16], 
      aluoutE[15], aluoutE[14], aluoutE[13], aluoutE[12], aluoutE[11], 
      aluoutE[10], aluoutE[9], aluoutE[8], aluoutE[7], aluoutE[6], aluoutE[5], 
      aluoutE[4], aluoutE[3], aluoutE[2], aluoutE[1], misalignedhE}), 
      .en(stallMb), .ph1(ph1), .ph2(ph2), .reset(reset), .q(aluoutM[31:0]));
endmodule   /* DatapathDone__Execute_Memory_Writeback */

module DatapathDone__nand3_1x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_15, net_4;

  tranif1 nmos_0(net_15, net_4, b);
  tranif1 nmos_1(net_4, y, a);
  tranif1 nmos_2(gnd, net_15, c);
  tranif0 pmos_0(y, vdd, a);
  tranif0 pmos_1(y, vdd, b);
  tranif0 pmos_2(y, vdd, c);
endmodule   /* DatapathDone__nand3_1x */

module DatapathDone__fivebitcomp(a, b, eq);
  input [4:0] a;
  input [4:0] b;
  output eq;

  supply1 vdd;
  supply0 gnd;
  wire net_2, net_4;
  wire [4:0] aeqb;

  DatapathDone__nand2_1x nand2_1x_0(.a(aeqb[1]), .b(aeqb[0]), .y(net_4));
  DatapathDone__nand3_1x nand3_1x_0(.a(aeqb[4]), .b(aeqb[3]), .c(aeqb[2]), 
      .y(net_2));
  DatapathDone__nor2_1x nor2_1x_0(.a(net_2), .b(net_4), .y(eq));
  DatapathDone__xnor2_1x xnor2_4_(.a(a[4]), .b(b[4]), .y(aeqb[4]));
  DatapathDone__xnor2_1x xnor2_3_(.a(a[3]), .b(b[3]), .y(aeqb[3]));
  DatapathDone__xnor2_1x xnor2_2_(.a(a[2]), .b(b[2]), .y(aeqb[2]));
  DatapathDone__xnor2_1x xnor2_1_(.a(a[1]), .b(b[1]), .y(aeqb[1]));
  DatapathDone__xnor2_1x xnor2_0_(.a(a[0]), .b(b[0]), .y(aeqb[0]));
endmodule   /* DatapathDone__fivebitcomp */

module DatapathDone__nor3_1x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_13, net_7;

  tranif1 nmos_0(gnd, y, a);
  tranif1 nmos_1(gnd, y, b);
  tranif1 nmos_2(gnd, y, c);
  tranif0 pmos_0(net_7, vdd, a);
  tranif0 pmos_1(net_13, net_7, b);
  tranif0 pmos_2(y, net_13, c);
endmodule   /* DatapathDone__nor3_1x */

module DatapathDone__fivebiton(in, on);
  input [4:0] in;
  output on;

  supply1 vdd;
  supply0 gnd;
  wire net_11, net_2;

  DatapathDone__nand2_1x nand2_1x_0(.a(net_11), .b(net_2), .y(on));
  DatapathDone__nor2_1x nor2_1x_0(.a(in[1]), .b(in[0]), .y(net_2));
  DatapathDone__nor3_1x nor3_1x_0(.a(in[4]), .b(in[3]), .c(in[2]), 
      .y(net_11));
endmodule   /* DatapathDone__fivebiton */

module DatapathDone__flopenr_zip(en, flush, ph1, ph2, reset, enb, enbuf, ph1b, 
      ph1buf, ph2b, ph2buf, resetb);
  input en;
  input flush;
  input ph1;
  input ph2;
  input reset;
  output enb;
  output enbuf;
  output ph1b;
  output ph1buf;
  output ph2b;
  output ph2buf;
  output resetb;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__clkinvbufdual_4x clkinvbu_0(.ph1b(ph1b), .ph1buf(ph1buf), 
      .ph2b(ph2b), .ph2buf(ph2buf), .ph1(ph1), .ph2(ph2));
  DatapathDone__inv_4x inv_4x_0(.a(en), .y(enb));
  DatapathDone__inv_4x inv_4x_1(.a(enb), .y(enbuf));
  DatapathDone__nor2_1x nor2_1x_0(.a(flush), .b(reset), .y(resetb));
endmodule   /* DatapathDone__flopenr_zip */

module DatapathDone__flopenr_dp_1x_5(d, en, flush, ph1, ph2, reset, q);
  input [4:0] d;
  input en;
  input flush;
  input ph1;
  input ph2;
  input reset;
  output [4:0] q;

  supply1 vdd;
  supply0 gnd;
  wire net_10, net_12, net_15, net_17, net_25, net_26, net_4;

  DatapathDone__flopenr_dp_1x flop_4_(.d(d[4]), .en(net_17), .enb(net_15), 
      .resetb(net_12), .q(q[4]), .ph1(net_25), .ph1b(net_10), .ph2(net_4), 
      .ph2b(net_26));
  DatapathDone__flopenr_dp_1x flop_3_(.d(d[3]), .en(net_17), .enb(net_15), 
      .resetb(net_12), .q(q[3]), .ph1(net_25), .ph1b(net_10), .ph2(net_4), 
      .ph2b(net_26));
  DatapathDone__flopenr_dp_1x flop_2_(.d(d[2]), .en(net_17), .enb(net_15), 
      .resetb(net_12), .q(q[2]), .ph1(net_25), .ph1b(net_10), .ph2(net_4), 
      .ph2b(net_26));
  DatapathDone__flopenr_dp_1x flop_1_(.d(d[1]), .en(net_17), .enb(net_15), 
      .resetb(net_12), .q(q[1]), .ph1(net_25), .ph1b(net_10), .ph2(net_4), 
      .ph2b(net_26));
  DatapathDone__flopenr_dp_1x flop_0_(.d(d[0]), .en(net_17), .enb(net_15), 
      .resetb(net_12), .q(q[0]), .ph1(net_25), .ph1b(net_10), .ph2(net_4), 
      .ph2b(net_26));
  DatapathDone__flopenr_zip flopenr__1(.en(en), .flush(flush), .ph1(ph1), 
      .ph2(ph2), .reset(reset), .enb(net_15), .enbuf(net_17), .ph1b(net_10), 
      .ph1buf(net_25), .ph2b(net_26), .ph2buf(net_4), .resetb(net_12));
endmodule   /* DatapathDone__flopenr_dp_1x_5 */

module DatapathDone__flopenr_nof_zip(en, ph1, ph2, reset, enb, enbuf, ph1b, 
      ph1buf, ph2b, ph2buf, resetb);
  input en;
  input ph1;
  input ph2;
  input reset;
  output enb;
  output enbuf;
  output ph1b;
  output ph1buf;
  output ph2b;
  output ph2buf;
  output resetb;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__clkinvbufdual_4x clkinvbu_0(.ph1b(ph1b), .ph1buf(ph1buf), 
      .ph2b(ph2b), .ph2buf(ph2buf), .ph1(ph1), .ph2(ph2));
  DatapathDone__inv_4x inv_4x_6(.a(reset), .y(resetb));
  DatapathDone__inv_4x inv_4x_7(.a(en), .y(enb));
  DatapathDone__inv_4x inv_4x_8(.a(enb), .y(enbuf));
endmodule   /* DatapathDone__flopenr_nof_zip */

module DatapathDone__flopenr_nof(d, en, ph1, ph2, reset, q);
  input [4:0] d;
  input en;
  input ph1;
  input ph2;
  input reset;
  output [4:0] q;

  supply1 vdd;
  supply0 gnd;
  wire net_11, net_13, net_16, net_19, net_2, net_7, net_9;

  DatapathDone__flopenr_dp_1x flop_4_(.d(d[4]), .en(net_13), .enb(net_16), 
      .resetb(net_19), .q(q[4]), .ph1(net_7), .ph1b(net_9), .ph2(net_2), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flop_3_(.d(d[3]), .en(net_13), .enb(net_16), 
      .resetb(net_19), .q(q[3]), .ph1(net_7), .ph1b(net_9), .ph2(net_2), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flop_2_(.d(d[2]), .en(net_13), .enb(net_16), 
      .resetb(net_19), .q(q[2]), .ph1(net_7), .ph1b(net_9), .ph2(net_2), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flop_1_(.d(d[1]), .en(net_13), .enb(net_16), 
      .resetb(net_19), .q(q[1]), .ph1(net_7), .ph1b(net_9), .ph2(net_2), 
      .ph2b(net_11));
  DatapathDone__flopenr_dp_1x flop_0_(.d(d[0]), .en(net_13), .enb(net_16), 
      .resetb(net_19), .q(q[0]), .ph1(net_7), .ph1b(net_9), .ph2(net_2), 
      .ph2b(net_11));
  DatapathDone__flopenr_nof_zip flopenr__1(.en(en), .ph1(ph1), .ph2(ph2), 
      .reset(reset), .enb(net_16), .enbuf(net_13), .ph1b(net_9), 
      .ph1buf(net_7), .ph2b(net_11), .ph2buf(net_2), .resetb(net_19));
endmodule   /* DatapathDone__flopenr_nof */

module DatapathDone__mux2_zip(s, sb, sbuf);
  input s;
  output sb;
  output sbuf;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__inv_4x inv_4x_0(.a(s), .y(sb));
  DatapathDone__inv_4x inv_4x_1(.a(sb), .y(sbuf));
endmodule   /* DatapathDone__mux2_zip */

module DatapathDone__mux_dp_1x_5(d0, d1, s, y);
  input [4:0] d0;
  input [4:0] d1;
  input s;
  output [4:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_0, net_2;

  DatapathDone__mux2_dp_1x mux2_4_(.d0(d0[4]), .d1(d1[4]), .s(net_2), 
      .sb(net_0), .y(y[4]));
  DatapathDone__mux2_dp_1x mux2_3_(.d0(d0[3]), .d1(d1[3]), .s(net_2), 
      .sb(net_0), .y(y[3]));
  DatapathDone__mux2_dp_1x mux2_2_(.d0(d0[2]), .d1(d1[2]), .s(net_2), 
      .sb(net_0), .y(y[2]));
  DatapathDone__mux2_dp_1x mux2_1_(.d0(d0[1]), .d1(d1[1]), .s(net_2), 
      .sb(net_0), .y(y[1]));
  DatapathDone__mux2_dp_1x mux2_0_(.d0(d0[0]), .d1(d1[0]), .s(net_2), 
      .sb(net_0), .y(y[0]));
  DatapathDone__mux2_zip mux2_zip_0(.s(s), .sb(net_0), .sbuf(net_2));
endmodule   /* DatapathDone__mux_dp_1x_5 */

module DatapathDone__fivebitdp(flushE, flushM, ph1, ph2, rdD, rdsrcD, regdstE, 
      reset, rsD, rtD, stallE, stallM, stallW, rdE, rseqwrDE, rseqwrDM, 
      rseqwrEM, rseqwrEW, rsonD, rsonE, rteqrsED, rteqrtED, rteqwrDE, rteqwrDM, 
      rteqwrEM, rteqwrEW, rtonD, rtonE, writeregW);
  input flushE;
  input flushM;
  input ph1;
  input ph2;
  input [4:0] rdD;
  input rdsrcD;
  input regdstE;
  input reset;
  input [4:0] rsD;
  input [4:0] rtD;
  input stallE;
  input stallM;
  input stallW;
  output [4:0] rdE;
  output rseqwrDE;
  output rseqwrDM;
  output rseqwrEM;
  output rseqwrEW;
  output rsonD;
  output rsonE;
  output rteqrsED;
  output rteqrtED;
  output rteqwrDE;
  output rteqwrDM;
  output rteqwrEM;
  output rteqwrEW;
  output rtonD;
  output rtonE;
  output [4:0] writeregW;

  supply1 vdd;
  supply0 gnd;
  wire stallEb, stallMb, stallWb;
  wire [4:0] rd2D;
  wire [4:0] rsE;
  wire [4:0] rtE;
  wire [4:0] writeregE;
  wire [4:0] writeregM;

  DatapathDone__fivebitcomp fivebitc_0(.a(rsD[4:0]), .b(writeregM[4:0]), 
      .eq(rseqwrDM));
  DatapathDone__fivebitcomp fivebitc_1(.a(rtD[4:0]), .b(writeregM[4:0]), 
      .eq(rteqwrDM));
  DatapathDone__fivebitcomp fivebitc_2(.a(rsE[4:0]), .b(writeregM[4:0]), 
      .eq(rseqwrEM));
  DatapathDone__fivebitcomp fivebitc_3(.a(rsE[4:0]), .b(writeregW[4:0]), 
      .eq(rseqwrEW));
  DatapathDone__fivebitcomp fivebitc_4(.a(rtE[4:0]), .b(writeregM[4:0]), 
      .eq(rteqwrEM));
  DatapathDone__fivebitcomp fivebitc_5(.a(rtE[4:0]), .b(writeregW[4:0]), 
      .eq(rteqwrEW));
  DatapathDone__fivebitcomp fivebitc_6(.a(rtE[4:0]), .b(rsD[4:0]), 
      .eq(rteqrsED));
  DatapathDone__fivebitcomp fivebitc_7(.a(rtE[4:0]), .b(rtD[4:0]), 
      .eq(rteqrtED));
  DatapathDone__fivebitcomp fivebitc_8(.a(rsD[4:0]), .b(writeregE[4:0]), 
      .eq(rseqwrDE));
  DatapathDone__fivebitcomp fivebitc_9(.a(rtD[4:0]), .b(writeregE[4:0]), 
      .eq(rteqwrDE));
  DatapathDone__fivebiton fivebito_0(.in(rsD[4:0]), .on(rsonD));
  DatapathDone__fivebiton fivebito_1(.in(rtD[4:0]), .on(rtonD));
  DatapathDone__fivebiton fivebito_2(.in(rsE[4:0]), .on(rsonE));
  DatapathDone__fivebiton fivebito_3(.in(rtE[4:0]), .on(rtonE));
  DatapathDone__flopenr_dp_1x_5 flopenr__1(.d(rsD[4:0]), .en(stallEb), 
      .flush(flushE), .ph1(ph1), .ph2(ph2), .reset(reset), .q(rsE[4:0]));
  DatapathDone__flopenr_dp_1x_5 flopenr__2(.d(rtD[4:0]), .en(stallEb), 
      .flush(flushE), .ph1(ph1), .ph2(ph2), .reset(reset), .q(rtE[4:0]));
  DatapathDone__flopenr_dp_1x_5 flopenr__3(.d(rd2D[4:0]), .en(stallEb), 
      .flush(flushE), .ph1(ph1), .ph2(ph2), .reset(reset), .q(rdE[4:0]));
  DatapathDone__flopenr_dp_1x_5 flopenr__4(.d(writeregE[4:0]), .en(stallMb), 
      .flush(flushM), .ph1(ph1), .ph2(ph2), .reset(reset), 
      .q(writeregM[4:0]));
  DatapathDone__flopenr_nof flopenr__5(.d(writeregM[4:0]), .en(stallWb), 
      .ph1(ph1), .ph2(ph2), .reset(reset), .q(writeregW[4:0]));
  DatapathDone__inv_1x inv_1x_0(.a(stallE), .y(stallEb));
  DatapathDone__inv_1x inv_1x_1(.a(stallM), .y(stallMb));
  DatapathDone__inv_1x inv_1x_2(.a(stallW), .y(stallWb));
  DatapathDone__mux_dp_1x_5 mux_dp_1_0(.d0(rdD[4:0]), .d1({vdd, vdd, vdd, vdd, 
      vdd}), .s(rdsrcD), .y(rd2D[4:0]));
  DatapathDone__mux_dp_1x_5 mux_dp_1_1(.d0(rtE[4:0]), .d1(rdE[4:0]), 
      .s(regdstE), .y(writeregE[4:0]));
endmodule   /* DatapathDone__fivebitdp */

module DatapathDone__and3_1x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_1, net_45, net_9;

  tranif1 nmos_0(net_45, net_9, b);
  tranif1 nmos_1(net_9, net_1, c);
  tranif1 nmos_3(gnd, y, net_1);
  tranif1 nmos_4(gnd, net_45, a);
  tranif0 pmos_0(net_1, vdd, c);
  tranif0 pmos_1(y, vdd, net_1);
  tranif0 pmos_2(net_1, vdd, a);
  tranif0 pmos_3(net_1, vdd, b);
endmodule   /* DatapathDone__and3_1x */

module DatapathDone__buf_1x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_23;

  tranif1 nmos_0(gnd, net_23, a);
  tranif1 nmos_1(gnd, y, net_23);
  tranif0 pmos_0(net_23, vdd, a);
  tranif0 pmos_1(y, vdd, net_23);
endmodule   /* DatapathDone__buf_1x */

module DatapathDone__o2a1_1x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_12, net_35, net_7;

  tranif1 nmos_0(gnd, net_7, a);
  tranif1 nmos_1(gnd, net_7, b);
  tranif1 nmos_2(net_7, net_12, c);
  tranif1 nmos_3(gnd, y, net_12);
  tranif0 pmos_0(net_12, net_35, b);
  tranif0 pmos_1(net_35, vdd, a);
  tranif0 pmos_3(net_12, vdd, c);
  tranif0 pmos_4(y, vdd, net_12);
endmodule   /* DatapathDone__o2a1_1x */

module DatapathDone__flush(dataackM, instrackF, pendingexception, ph1, ph2, 
      reset, stallD, activeexception, datamissM, flushD, flushE, flushM, 
      instrmissF, stallE, stallM, stallW);
  input dataackM;
  input instrackF;
  input pendingexception;
  input ph1;
  input ph2;
  input reset;
  input stallD;
  output activeexception;
  output datamissM;
  output flushD;
  output flushE;
  output flushM;
  output instrmissF;
  output stallE;
  output stallM;
  output stallW;

  supply1 vdd;
  supply0 gnd;
  wire net_1, net_21, net_29, net_30, net_34, net_53, net_63, net_77, net_8;

  DatapathDone__a2o1_1x a2o1_1x_0(.a(net_21), .b(net_34), .c(activeexception), 
      .y(flushM));
  DatapathDone__and2_1x and2_1x_0(.a(pendingexception), .b(net_8), 
      .y(net_30));
  DatapathDone__buf_1x buf_1x_0(.a(activeexception), .y(flushD));
  DatapathDone__buf_1x buf_1x_1(.a(datamissM), .y(stallW));
  DatapathDone__buf_1x buf_1x_2(.a(datamissM), .y(stallM));
  DatapathDone__flopr_c_1x flopr_c__0(.d(net_1), .resetb(net_77), .q(net_8), 
      .ph1(ph1), .ph2(ph2));
  DatapathDone__inv_1x inv_1x_0(.a(instrackF), .y(instrmissF));
  DatapathDone__inv_1x inv_1x_1(.a(dataackM), .y(datamissM));
  DatapathDone__inv_1x inv_1x_2(.a(pendingexception), .y(net_29));
  DatapathDone__inv_1x inv_1x_3(.a(stallD), .y(net_53));
  DatapathDone__inv_1x inv_1x_4(.a(reset), .y(net_77));
  DatapathDone__inv_1x inv_1x_5(.a(datamissM), .y(net_34));
  DatapathDone__nor3_1x nor3_1x_0(.a(net_21), .b(net_29), .c(net_30), 
      .y(activeexception));
  DatapathDone__nor3_1x nor3_1x_1(.a(net_53), .b(datamissM), .c(net_21), 
      .y(net_63));
  DatapathDone__o2a1_1x o2a1_1x_0(.a(flushE), .b(net_8), .c(stallD), 
      .y(net_1));
  DatapathDone__o2a1_1x o2a1_1x_1(.a(datamissM), .b(instrmissF), 
      .c(pendingexception), .y(net_21));
  DatapathDone__or2_1x or2_1x_0(.a(datamissM), .b(net_21), .y(stallE));
  DatapathDone__or2_1x or2_1x_1(.a(net_63), .b(activeexception), .y(flushE));
endmodule   /* DatapathDone__flush */

module DatapathDone__forwardE(regwriteM, regwriteW, reqwrEM, reqwrEW, ronE, 
      forward0, forward1);
  input regwriteM;
  input regwriteW;
  input reqwrEM;
  input reqwrEW;
  input ronE;
  output forward0;
  output forward1;

  supply1 vdd;
  supply0 gnd;
  wire net_0, net_3, net_5;

  DatapathDone__inv_1x inv_1x_0(.a(net_0), .y(forward1));
  DatapathDone__nand2_1x nand2_1x_0(.a(net_0), .b(ronE), .y(net_3));
  DatapathDone__nand2_1x nand2_1x_1(.a(reqwrEW), .b(regwriteW), .y(net_5));
  DatapathDone__nand3_1x nand3_1x_0(.a(ronE), .b(reqwrEM), .c(regwriteM), 
      .y(net_0));
  DatapathDone__nor2_1x nor2_1x_0(.a(net_3), .b(net_5), .y(forward0));
endmodule   /* DatapathDone__forwardE */

module DatapathDone__o22a2i_1x(a, b, c, d, y);
  input a;
  input b;
  input c;
  input d;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_34, net_35, net_7;

  tranif1 nmos_0(gnd, net_7, a);
  tranif1 nmos_1(gnd, net_7, b);
  tranif1 nmos_2(net_7, y, c);
  tranif1 nmos_3(net_7, y, d);
  tranif0 pmos_0(y, net_35, b);
  tranif0 pmos_1(net_35, vdd, a);
  tranif0 pmos_2(y, net_34, d);
  tranif0 pmos_3(net_34, vdd, c);
endmodule   /* DatapathDone__o22a2i_1x */

module DatapathDone__stallD(branchD, datamissM, hiloaccessD, instrmissF, 
      jumpregD, mdrunE, memtoregE, memtoregM, regwriteE, rseqwrDE, rseqwrDM, 
      rteqrsED, rteqrtED, rteqwrDE, rteqwrDM, stallD, stallF);
  input branchD;
  input datamissM;
  input hiloaccessD;
  input instrmissF;
  input jumpregD;
  input mdrunE;
  input memtoregE;
  input memtoregM;
  input regwriteE;
  input rseqwrDE;
  input rseqwrDM;
  input rteqrsED;
  input rteqrtED;
  input rteqwrDE;
  input rteqwrDM;
  output stallD;
  output stallF;

  supply1 vdd;
  supply0 gnd;
  wire lwstallD, multdivDE, net_0, net_2, net_6, net_7, net_8;

  DatapathDone__and2_1x and2_1x_0(.a(hiloaccessD), .b(mdrunE), .y(multdivDE));
  DatapathDone__buf_1x buf_1x_0(.a(stallD), .y(stallF));
  DatapathDone__nand3_1x nand3_1x_0(.a(net_6), .b(net_7), .c(net_8), 
      .y(stallD));
  DatapathDone__nor2_1x nor2_1x_0(.a(datamissM), .b(instrmissF), .y(net_7));
  DatapathDone__nor2_1x nor2_1x_1(.a(lwstallD), .b(multdivDE), .y(net_8));
  DatapathDone__o2a1_1x o2a1_1x_0(.a(rseqwrDE), .b(rteqwrDE), .c(regwriteE), 
      .y(net_0));
  DatapathDone__o2a1_1x o2a1_1x_1(.a(rseqwrDM), .b(rteqwrDM), .c(memtoregM), 
      .y(net_2));
  DatapathDone__o2a1_1x o2a1_1x_2(.a(rteqrsED), .b(rteqrtED), .c(memtoregE), 
      .y(lwstallD));
  DatapathDone__o22a2i_1x o22a2i_1_0(.a(net_0), .b(net_2), .c(branchD), 
      .d(jumpregD), .y(net_6));
endmodule   /* DatapathDone__stallD */

module DatapathDone__hazard(branchD, dataackM, hiloaccessD, instrackF, 
      jumpregD, mdrunE, memtoregE, memtoregM, pendingexception, ph1, ph2, 
      regwriteE, regwriteM, regwriteW, reset, rseqwrDE, rseqwrDM, rseqwrEM, 
      rseqwrEW, rsonD, rsonE, rteqrsED, rteqrtED, rteqwrDE, rteqwrDM, rteqwrEM, 
      rteqwrEW, rtonD, rtonE, activeexception, flushD, flushE, flushM, 
      forwardaD, forwardaE, forwardbD, forwardbE, stallD, stallE, stallF, 
      stallM, stallW);
  input branchD;
  input dataackM;
  input hiloaccessD;
  input instrackF;
  input jumpregD;
  input mdrunE;
  input memtoregE;
  input memtoregM;
  input pendingexception;
  input ph1;
  input ph2;
  input regwriteE;
  input regwriteM;
  input regwriteW;
  input reset;
  input rseqwrDE;
  input rseqwrDM;
  input rseqwrEM;
  input rseqwrEW;
  input rsonD;
  input rsonE;
  input rteqrsED;
  input rteqrtED;
  input rteqwrDE;
  input rteqwrDM;
  input rteqwrEM;
  input rteqwrEW;
  input rtonD;
  input rtonE;
  output activeexception;
  output flushD;
  output flushE;
  output flushM;
  output forwardaD;
  output [1:0] forwardaE;
  output forwardbD;
  output [1:0] forwardbE;
  output stallD;
  output stallE;
  output stallF;
  output stallM;
  output stallW;

  supply1 vdd;
  supply0 gnd;
  wire net_238, net_242;

  DatapathDone__and3_1x and3_1x_5(.a(rsonD), .b(rseqwrDM), .c(regwriteM), 
      .y(forwardaD));
  DatapathDone__and3_1x and3_1x_6(.a(rtonD), .b(rteqwrDM), .c(regwriteM), 
      .y(forwardbD));
  DatapathDone__flush flush_0(.dataackM(dataackM), .instrackF(instrackF), 
      .pendingexception(pendingexception), .ph1(ph1), .ph2(ph2), .reset(reset), 
      .stallD(stallD), .activeexception(activeexception), .datamissM(net_238), 
      .flushD(flushD), .flushE(flushE), .flushM(flushM), .instrmissF(net_242), 
      .stallE(stallE), .stallM(stallM), .stallW(stallW));
  DatapathDone__forwardE forwardE_0(.regwriteM(regwriteM), 
      .regwriteW(regwriteW), .reqwrEM(rseqwrEM), .reqwrEW(rseqwrEW), 
      .ronE(rsonE), .forward0(forwardaE[0]), .forward1(forwardaE[1]));
  DatapathDone__forwardE forwardE_1(.regwriteM(regwriteM), 
      .regwriteW(regwriteW), .reqwrEM(rteqwrEM), .reqwrEW(rteqwrEW), 
      .ronE(rtonE), .forward0(forwardbE[0]), .forward1(forwardbE[1]));
  DatapathDone__stallD stallD_0(.branchD(branchD), .datamissM(net_238), 
      .hiloaccessD(hiloaccessD), .instrmissF(net_242), .jumpregD(jumpregD), 
      .mdrunE(mdrunE), .memtoregE(memtoregE), .memtoregM(memtoregM), 
      .regwriteE(regwriteE), .rseqwrDE(rseqwrDE), .rseqwrDM(rseqwrDM), 
      .rteqrsED(rteqrsED), .rteqrtED(rteqrtED), .rteqwrDE(rteqwrDE), 
      .rteqwrDM(rteqwrDM), .stallD(stallD), .stallF(stallF));
endmodule   /* DatapathDone__hazard */

module DatapathDone__Execute_Memory_Writeback_Five_Haz(aluoutsrcE, 
      alushcontrolE, alusrcE, branchD, byteM, cop0readdataE, dataackM, 
      halfwordM, hiloaccessD, hilodisableE, hilosrcE, instrackF, jumpregD, 
      loadsignedM, luiE, mdstartE, memtoregE, memtoregM, memtoregW, pcE, 
      pendingexception, ph1, ph2, rdD, rdsrcD, re, readdataM, regdstE, 
      regwriteE, regwriteM, regwriteW, reset, rsD, rtD, signimmE, 
      specialregsrcE, srcaE, srcbE, activeexception, aluoutM, byteenM, flushD, 
      flushE, flushM, forwardaD, forwardbD, mdrunE, misalignedhE, misalignedwE, 
      overflowE, rdE, resultW, stallD, stallE, stallF, stallM, stallW, 
      writedata2M, writedataW, writeregW);
  input [1:0] aluoutsrcE;
  input [2:0] alushcontrolE;
  input alusrcE;
  input branchD;
  input byteM;
  input [31:0] cop0readdataE;
  input dataackM;
  input halfwordM;
  input hiloaccessD;
  input [1:0] hilodisableE;
  input hilosrcE;
  input instrackF;
  input jumpregD;
  input loadsignedM;
  input luiE;
  input mdstartE;
  input memtoregE;
  input memtoregM;
  input memtoregW;
  input [31:0] pcE;
  input pendingexception;
  input ph1;
  input ph2;
  input [4:0] rdD;
  input rdsrcD;
  input re;
  input [31:0] readdataM;
  input regdstE;
  input regwriteE;
  input regwriteM;
  input regwriteW;
  input reset;
  input [4:0] rsD;
  input [4:0] rtD;
  input [31:0] signimmE;
  input [1:0] specialregsrcE;
  input [31:0] srcaE;
  input [31:0] srcbE;
  output activeexception;
  output [31:0] aluoutM;
  output [3:0] byteenM;
  output flushD;
  output flushE;
  output flushM;
  output forwardaD;
  output forwardbD;
  output mdrunE;
  output misalignedhE;
  output misalignedwE;
  output overflowE;
  output [4:0] rdE;
  output [31:0] resultW;
  output stallD;
  output stallE;
  output stallF;
  output stallM;
  output stallW;
  output [31:0] writedata2M;
  output [31:0] writedataW;
  output [4:0] writeregW;

  supply1 vdd;
  supply0 gnd;
  wire rseqwrDE, rseqwrDM, rseqwrEM, rseqwrEW, rsonD, rsonE, rteqrsED, rteqrtED;
  wire rteqwrDE, rteqwrDM, rteqwrEM, rteqwrEW, rtonD, rtonE;
  wire [1:0] forwardaE;
  wire [1:0] forwardbE;

  DatapathDone__Execute_Memory_Writeback 
      Execute__0(.aluoutsrcE(aluoutsrcE[1:0]), 
      .alushcontrolE(alushcontrolE[2:0]), .alusrcE(alusrcE), .byteM(byteM), 
      .cop0readdataE(cop0readdataE[31:0]), .flushM(flushM), 
      .forwardaE(forwardaE[1:0]), .forwardbE(forwardbE[1:0]), 
      .halfwordM(halfwordM), .hilodisableE(hilodisableE[1:0]), 
      .hilosrcE(hilosrcE), .loadsignedM(loadsignedM), .luiE(luiE), 
      .mdstartE(mdstartE), .memtoregW(memtoregW), .pcE(pcE[31:0]), .ph1(ph1), 
      .ph2(ph2), .re(re), .reset(reset), .signimmE(signimmE[31:0]), 
      .specialregsrcE(specialregsrcE[1:0]), .srcaE(srcaE[31:0]), 
      .srcbE(srcbE[31:0]), .stallM(stallM), .stallW(stallW), 
      .aluoutM(aluoutM[31:0]), .byteenM(byteenM[3:0]), .mdrunE(mdrunE), 
      .misalignedhE(misalignedhE), .misalignedwE(misalignedwE), 
      .overflowE(overflowE), .readdataM(readdataM[31:0]), 
      .resultW(resultW[31:0]), .writedata2M(writedata2M[31:0]), 
      .writedataW(writedataW[31:0]));
  DatapathDone__fivebitdp fivebitd_0(.flushE(flushE), .flushM(flushM), 
      .ph1(ph1), .ph2(ph2), .rdD(rdD[4:0]), .rdsrcD(rdsrcD), .regdstE(regdstE), 
      .reset(reset), .rsD(rsD[4:0]), .rtD(rtD[4:0]), .stallE(stallE), 
      .stallM(stallM), .stallW(stallW), .rdE(rdE[4:0]), .rseqwrDE(rseqwrDE), 
      .rseqwrDM(rseqwrDM), .rseqwrEM(rseqwrEM), .rseqwrEW(rseqwrEW), 
      .rsonD(rsonD), .rsonE(rsonE), .rteqrsED(rteqrsED), .rteqrtED(rteqrtED), 
      .rteqwrDE(rteqwrDE), .rteqwrDM(rteqwrDM), .rteqwrEM(rteqwrEM), 
      .rteqwrEW(rteqwrEW), .rtonD(rtonD), .rtonE(rtonE), 
      .writeregW(writeregW[4:0]));
  DatapathDone__hazard hazard_0(.branchD(branchD), .dataackM(dataackM), 
      .hiloaccessD(hiloaccessD), .instrackF(instrackF), .jumpregD(jumpregD), 
      .mdrunE(mdrunE), .memtoregE(memtoregE), .memtoregM(memtoregM), 
      .pendingexception(pendingexception), .ph1(ph1), .ph2(ph2), 
      .regwriteE(regwriteE), .regwriteM(regwriteM), .regwriteW(regwriteW), 
      .reset(reset), .rseqwrDE(rseqwrDE), .rseqwrDM(rseqwrDM), 
      .rseqwrEM(rseqwrEM), .rseqwrEW(rseqwrEW), .rsonD(rsonD), .rsonE(rsonE), 
      .rteqrsED(rteqrsED), .rteqrtED(rteqrtED), .rteqwrDE(rteqwrDE), 
      .rteqwrDM(rteqwrDM), .rteqwrEM(rteqwrEM), .rteqwrEW(rteqwrEW), 
      .rtonD(rtonD), .rtonE(rtonE), .activeexception(activeexception), 
      .flushD(flushD), .flushE(flushE), .flushM(flushM), .forwardaD(forwardaD), 
      .forwardaE(forwardaE[1:0]), .forwardbD(forwardbD), 
      .forwardbE(forwardbE[1:0]), .stallD(stallD), .stallE(stallE), 
      .stallF(stallF), .stallM(stallM), .stallW(stallW));
endmodule   /* DatapathDone__Execute_Memory_Writeback_Five_Haz */

module DatapathDone__flopen_dp_1x(d, en, enb, q, ph1, ph1b, ph2, ph2b);
  input d;
  input en;
  input enb;
  output q;
  input ph1;
  input ph1b;
  input ph2;
  input ph2b;

  supply1 vdd;
  supply0 gnd;
  wire master, masterinb, n2, n3, n4, n5, n6, n7, n8, n9, slaveb;
  trireg masterb, slave;

  tranif1 nmos_2(masterinb, masterb, ph2);
  tranif1 nmos_3(gnd, master, masterb);
  rtranif1 nmos_4(master, slave, ph1);
  tranif1 nmos_5(n6, masterb, ph2b);
  tranif1 nmos_6(gnd, n6, master);
  tranif1 nmos_7(gnd, n8, slaveb);
  tranif1 nmos_8(gnd, slaveb, slave);
  tranif1 nmos_10(n8, slave, ph1b);
  tranif1 nmos_11(gnd, q, slaveb);
  tranif1 nmos_16(gnd, n2, en);
  tranif1 nmos_18(n3, gnd, enb);
  tranif1 nmos_19(n2, masterinb, d);
  tranif1 nmos_20(masterinb, n3, slave);
  tranif0 pmos_2(masterb, masterinb, ph2b);
  tranif0 pmos_3(master, vdd, masterb);
  rtranif0 pmos_4(slave, master, ph1b);
  tranif0 pmos_5(masterb, n7, ph2);
  tranif0 pmos_6(n7, vdd, master);
  tranif0 pmos_7(n9, vdd, slaveb);
  tranif0 pmos_8(slaveb, vdd, slave);
  tranif0 pmos_10(slave, n9, ph1);
  tranif0 pmos_11(q, vdd, slaveb);
  tranif0 pmos_16(masterinb, n4, d);
  tranif0 pmos_17(n4, vdd, enb);
  tranif0 pmos_19(n5, masterinb, slave);
  tranif0 pmos_20(vdd, n5, en);
endmodule   /* DatapathDone__flopen_dp_1x */

module DatapathDone__flopen_32(d, en, ph1, ph2, q);
  input [31:0] d;
  input en;
  input ph1;
  input ph2;
  output [31:0] q;

  supply1 vdd;
  supply0 gnd;
  wire net_15, net_16, net_17, net_18, net_19, net_21;

  DatapathDone__clkinvbufdual_4x clkinvbu_0(.ph1b(net_18), .ph1buf(net_17), 
      .ph2b(net_16), .ph2buf(net_15), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopen_dp_1x flopen_32_31_(.d(d[31]), .en(net_21), 
      .enb(net_19), .q(q[31]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_30_(.d(d[30]), .en(net_21), 
      .enb(net_19), .q(q[30]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_29_(.d(d[29]), .en(net_21), 
      .enb(net_19), .q(q[29]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_28_(.d(d[28]), .en(net_21), 
      .enb(net_19), .q(q[28]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_27_(.d(d[27]), .en(net_21), 
      .enb(net_19), .q(q[27]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_26_(.d(d[26]), .en(net_21), 
      .enb(net_19), .q(q[26]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_25_(.d(d[25]), .en(net_21), 
      .enb(net_19), .q(q[25]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_24_(.d(d[24]), .en(net_21), 
      .enb(net_19), .q(q[24]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_23_(.d(d[23]), .en(net_21), 
      .enb(net_19), .q(q[23]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_22_(.d(d[22]), .en(net_21), 
      .enb(net_19), .q(q[22]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_21_(.d(d[21]), .en(net_21), 
      .enb(net_19), .q(q[21]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_20_(.d(d[20]), .en(net_21), 
      .enb(net_19), .q(q[20]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_19_(.d(d[19]), .en(net_21), 
      .enb(net_19), .q(q[19]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_18_(.d(d[18]), .en(net_21), 
      .enb(net_19), .q(q[18]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_17_(.d(d[17]), .en(net_21), 
      .enb(net_19), .q(q[17]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_16_(.d(d[16]), .en(net_21), 
      .enb(net_19), .q(q[16]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_15_(.d(d[15]), .en(net_21), 
      .enb(net_19), .q(q[15]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_14_(.d(d[14]), .en(net_21), 
      .enb(net_19), .q(q[14]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_13_(.d(d[13]), .en(net_21), 
      .enb(net_19), .q(q[13]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_12_(.d(d[12]), .en(net_21), 
      .enb(net_19), .q(q[12]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_11_(.d(d[11]), .en(net_21), 
      .enb(net_19), .q(q[11]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_10_(.d(d[10]), .en(net_21), 
      .enb(net_19), .q(q[10]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), 
      .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_9_(.d(d[9]), .en(net_21), .enb(net_19), 
      .q(q[9]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_8_(.d(d[8]), .en(net_21), .enb(net_19), 
      .q(q[8]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_7_(.d(d[7]), .en(net_21), .enb(net_19), 
      .q(q[7]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_6_(.d(d[6]), .en(net_21), .enb(net_19), 
      .q(q[6]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_5_(.d(d[5]), .en(net_21), .enb(net_19), 
      .q(q[5]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_4_(.d(d[4]), .en(net_21), .enb(net_19), 
      .q(q[4]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_3_(.d(d[3]), .en(net_21), .enb(net_19), 
      .q(q[3]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_2_(.d(d[2]), .en(net_21), .enb(net_19), 
      .q(q[2]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_1_(.d(d[1]), .en(net_21), .enb(net_19), 
      .q(q[1]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  DatapathDone__flopen_dp_1x flopen_32_0_(.d(d[0]), .en(net_21), .enb(net_19), 
      .q(q[0]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  DatapathDone__invbuf_4x invbuf_4_0(.s(en), .s_out(net_21), .sb_out(net_19));
endmodule   /* DatapathDone__flopen_32 */

module DatapathDone__fetchstage(pcnextbrFD, pcsrcFD, ph1, ph2, stallF, 
      adelthrownF, pcF, pcplus4F);
  input [31:0] pcnextbrFD;
  input [1:0] pcsrcFD;
  input ph1;
  input ph2;
  input stallF;
  output adelthrownF;
  output [31:0] pcF;
  output [31:0] pcplus4F;

  supply1 vdd;
  supply0 gnd;
  wire adder_32_2_cout, net_166;
  wire [31:0] pcnextF;

  DatapathDone__adder_32 adder_32_2(.a(pcF[31:0]), .b({gnd, gnd, gnd, gnd, gnd, 
      gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, 
      gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, vdd, gnd, gnd}), 
      .cin(gnd), .cout(adder_32_2_cout), .s(pcplus4F[31:0]));
  DatapathDone__flopen_32 flopen_3_0(.d(pcnextF[31:0]), .en(net_166), 
      .ph1(ph1), .ph2(ph2), .q(pcF[31:0]));
  DatapathDone__inv_1x inv_1x_4(.a(stallF), .y(net_166));
  DatapathDone__mux4_dp_1x_32 mux4_dp__0(.d0({vdd, gnd, vdd, vdd, vdd, vdd, 
      vdd, vdd, vdd, vdd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, 
      gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd}), .d1({vdd, 
      gnd, vdd, vdd, vdd, vdd, vdd, vdd, vdd, vdd, gnd, gnd, gnd, gnd, gnd, 
      gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, vdd, gnd, gnd, gnd, gnd, gnd, 
      gnd, gnd, gnd}), .d2(pcplus4F[31:0]), .d3(pcnextbrFD[31:0]), 
      .s0(pcsrcFD[0]), .s1(pcsrcFD[1]), .y(pcnextF[31:0]));
  DatapathDone__or2_1x or2_1x_3(.a(pcF[1]), .b(pcF[0]), .y(adelthrownF));
endmodule   /* DatapathDone__fetchstage */

module DatapathDone__invbuf_1x(s, s_out, sb_out);
  input s;
  input s_out;
  input sb_out;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__inv_1x inv_1x_0(.a(s), .y(sb_out));
  DatapathDone__inv_1x inv_1x_1(.a(sb_out), .y(s_out));
endmodule   /* DatapathDone__invbuf_1x */

module DatapathDone__flopenrc_1x_1(clear, d, en, reset, q, ph1, ph2);
  input clear;
  input d;
  input en;
  input reset;
  output q;
  input ph1;
  input ph2;

  supply1 vdd;
  supply0 gnd;
  wire net_182, net_308, net_312, net_313, net_314, net_315, net_328, ph1b;
  wire ph1buf, ph2b;

  DatapathDone__clkinvbufdual_4x clkinvbu_4(.ph1b(net_315), .ph1buf(net_314), 
      .ph2b(net_313), .ph2buf(net_312), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopenr_dp_1x flopenr__4(.d(d), .en(net_182), .enb(net_328), 
      .resetb(net_308), .q(q), .ph1(net_314), .ph1b(net_315), .ph2(net_312), 
      .ph2b(net_313));
  DatapathDone__invbuf_1x invbuf_1_0(.s(en), .s_out(net_182), 
      .sb_out(net_328));
  DatapathDone__nor2_1x nor2_1x_0(.a(reset), .b(clear), .y(net_308));
endmodule   /* DatapathDone__flopenrc_1x_1 */

module DatapathDone__Fetch_Stage(pcF, flushD, instrF, pcnextbrFD, pcsrcFD, ph1, 
      ph2, reset, stallD, stallF, adelthrownD, instrD, pcD, pcplus4D);
  input [31:0] pcF;
  input flushD;
  input [31:0] instrF;
  input [31:0] pcnextbrFD;
  input [1:0] pcsrcFD;
  input ph1;
  input ph2;
  input reset;
  input stallD;
  input stallF;
  output adelthrownD;
  output [31:0] instrD;
  output [31:0] pcD;
  output [31:0] pcplus4D;

  supply1 vdd;
  supply0 gnd;
  wire net_38, net_63;
  wire [0:31] net_163;

  DatapathDone__fetchstage fetchsta_0(.pcnextbrFD(pcnextbrFD[31:0]), 
      .pcsrcFD(pcsrcFD[1:0]), .ph1(ph1), .ph2(ph2), .stallF(stallF), 
      .adelthrownF(net_38), .pcF(pcF[31:0]), .pcplus4F({net_163[0], net_163[1], 
      net_163[2], net_163[3], net_163[4], net_163[5], net_163[6], net_163[7], 
      net_163[8], net_163[9], net_163[10], net_163[11], net_163[12], 
      net_163[13], net_163[14], net_163[15], net_163[16], net_163[17], 
      net_163[18], net_163[19], net_163[20], net_163[21], net_163[22], 
      net_163[23], net_163[24], net_163[25], net_163[26], net_163[27], 
      net_163[28], net_163[29], net_163[30], net_163[31]}));
  DatapathDone__flopenr_32 flopenr__2(.d(pcF[31:0]), .en(net_63), .ph1(ph1), 
      .ph2(ph2), .reset(reset), .q(pcD[31:0]));
  DatapathDone__flopenr_32 flopenr__3(.d({net_163[0], net_163[1], net_163[2], 
      net_163[3], net_163[4], net_163[5], net_163[6], net_163[7], net_163[8], 
      net_163[9], net_163[10], net_163[11], net_163[12], net_163[13], 
      net_163[14], net_163[15], net_163[16], net_163[17], net_163[18], 
      net_163[19], net_163[20], net_163[21], net_163[22], net_163[23], 
      net_163[24], net_163[25], net_163[26], net_163[27], net_163[28], 
      net_163[29], net_163[30], net_163[31]}), .en(net_63), .ph1(ph1), 
      .ph2(ph2), .reset(reset), .q(pcplus4D[31:0]));
  DatapathDone__flopenrc_1x_1 flopenrc_1(.clear(flushD), .d(net_38), 
      .en(net_63), .reset(reset), .q(adelthrownD), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopenrc_32 flopenrc_2(.clear(flushD), .d(instrF[31:0]), 
      .en(net_63), .ph1(ph1), .ph2(ph2), .reset(reset), .q(instrD[31:0]));
  DatapathDone__inv_1x inv_1x_2(.a(stallD), .y(net_63));
endmodule   /* DatapathDone__Fetch_Stage */

module DatapathDone__nand4_1x(a, b, c, d, y);
  input a;
  input b;
  input c;
  input d;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_5, net_6, net_7;

  tranif1 nmos_0(net_5, net_7, b);
  tranif1 nmos_1(net_6, y, d);
  tranif1 nmos_2(gnd, net_5, a);
  tranif1 nmos_3(net_7, net_6, c);
  tranif0 pmos_0(y, vdd, a);
  tranif0 pmos_1(y, vdd, b);
  tranif0 pmos_2(y, vdd, c);
  tranif0 pmos_3(y, vdd, d);
endmodule   /* DatapathDone__nand4_1x */

module DatapathDone__nor4_1x(a, b, c, d, y);
  input a;
  input b;
  input c;
  input d;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_2, net_3, net_41;

  tranif1 nmos_0(gnd, y, d);
  tranif1 nmos_1(gnd, y, c);
  tranif1 nmos_2(gnd, y, b);
  tranif1 nmos_3(gnd, y, a);
  tranif0 pmos_0(net_41, vdd, a);
  tranif0 pmos_1(net_2, net_41, b);
  tranif0 pmos_2(net_3, net_2, c);
  tranif0 pmos_3(y, net_3, d);
endmodule   /* DatapathDone__nor4_1x */

module DatapathDone__xnor2_1x_32(a, b, y);
  input [31:0] a;
  input [31:0] b;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__xnor2_1x xnor2_1_31_(.a(a[31]), .b(b[31]), .y(y[31]));
  DatapathDone__xnor2_1x xnor2_1_30_(.a(a[30]), .b(b[30]), .y(y[30]));
  DatapathDone__xnor2_1x xnor2_1_29_(.a(a[29]), .b(b[29]), .y(y[29]));
  DatapathDone__xnor2_1x xnor2_1_28_(.a(a[28]), .b(b[28]), .y(y[28]));
  DatapathDone__xnor2_1x xnor2_1_27_(.a(a[27]), .b(b[27]), .y(y[27]));
  DatapathDone__xnor2_1x xnor2_1_26_(.a(a[26]), .b(b[26]), .y(y[26]));
  DatapathDone__xnor2_1x xnor2_1_25_(.a(a[25]), .b(b[25]), .y(y[25]));
  DatapathDone__xnor2_1x xnor2_1_24_(.a(a[24]), .b(b[24]), .y(y[24]));
  DatapathDone__xnor2_1x xnor2_1_23_(.a(a[23]), .b(b[23]), .y(y[23]));
  DatapathDone__xnor2_1x xnor2_1_22_(.a(a[22]), .b(b[22]), .y(y[22]));
  DatapathDone__xnor2_1x xnor2_1_21_(.a(a[21]), .b(b[21]), .y(y[21]));
  DatapathDone__xnor2_1x xnor2_1_20_(.a(a[20]), .b(b[20]), .y(y[20]));
  DatapathDone__xnor2_1x xnor2_1_19_(.a(a[19]), .b(b[19]), .y(y[19]));
  DatapathDone__xnor2_1x xnor2_1_18_(.a(a[18]), .b(b[18]), .y(y[18]));
  DatapathDone__xnor2_1x xnor2_1_17_(.a(a[17]), .b(b[17]), .y(y[17]));
  DatapathDone__xnor2_1x xnor2_1_16_(.a(a[16]), .b(b[16]), .y(y[16]));
  DatapathDone__xnor2_1x xnor2_1_15_(.a(a[15]), .b(b[15]), .y(y[15]));
  DatapathDone__xnor2_1x xnor2_1_14_(.a(a[14]), .b(b[14]), .y(y[14]));
  DatapathDone__xnor2_1x xnor2_1_13_(.a(a[13]), .b(b[13]), .y(y[13]));
  DatapathDone__xnor2_1x xnor2_1_12_(.a(a[12]), .b(b[12]), .y(y[12]));
  DatapathDone__xnor2_1x xnor2_1_11_(.a(a[11]), .b(b[11]), .y(y[11]));
  DatapathDone__xnor2_1x xnor2_1_10_(.a(a[10]), .b(b[10]), .y(y[10]));
  DatapathDone__xnor2_1x xnor2_1_9_(.a(a[9]), .b(b[9]), .y(y[9]));
  DatapathDone__xnor2_1x xnor2_1_8_(.a(a[8]), .b(b[8]), .y(y[8]));
  DatapathDone__xnor2_1x xnor2_1_7_(.a(a[7]), .b(b[7]), .y(y[7]));
  DatapathDone__xnor2_1x xnor2_1_6_(.a(a[6]), .b(b[6]), .y(y[6]));
  DatapathDone__xnor2_1x xnor2_1_5_(.a(a[5]), .b(b[5]), .y(y[5]));
  DatapathDone__xnor2_1x xnor2_1_4_(.a(a[4]), .b(b[4]), .y(y[4]));
  DatapathDone__xnor2_1x xnor2_1_3_(.a(a[3]), .b(b[3]), .y(y[3]));
  DatapathDone__xnor2_1x xnor2_1_2_(.a(a[2]), .b(b[2]), .y(y[2]));
  DatapathDone__xnor2_1x xnor2_1_1_(.a(a[1]), .b(b[1]), .y(y[1]));
  DatapathDone__xnor2_1x xnor2_1_0_(.a(a[0]), .b(b[0]), .y(y[0]));
endmodule   /* DatapathDone__xnor2_1x_32 */

module DatapathDone__aeqbcmp_32(a, b, eq);
  input [31:0] a;
  input [31:0] b;
  output eq;

  supply1 vdd;
  supply0 gnd;
  wire [31:0] abeq1;
  wire [7:0] abeq2;
  wire [1:0] abeq3;

  DatapathDone__and2_1x abeqand3(.a(abeq3[0]), .b(abeq3[1]), .y(eq));
  DatapathDone__nand4_1x abeqnand1_7_(.a(abeq1[0]), .b(abeq1[1]), .c(abeq1[2]), 
      .d(abeq1[3]), .y(abeq2[7]));
  DatapathDone__nand4_1x abeqnand1_6_(.a(abeq1[4]), .b(abeq1[5]), .c(abeq1[6]), 
      .d(abeq1[7]), .y(abeq2[6]));
  DatapathDone__nand4_1x abeqnand1_5_(.a(abeq1[8]), .b(abeq1[9]), 
      .c(abeq1[10]), .d(abeq1[11]), .y(abeq2[5]));
  DatapathDone__nand4_1x abeqnand1_4_(.a(abeq1[12]), .b(abeq1[13]), 
      .c(abeq1[14]), .d(abeq1[15]), .y(abeq2[4]));
  DatapathDone__nand4_1x abeqnand1_3_(.a(abeq1[16]), .b(abeq1[17]), 
      .c(abeq1[18]), .d(abeq1[19]), .y(abeq2[3]));
  DatapathDone__nand4_1x abeqnand1_2_(.a(abeq1[20]), .b(abeq1[21]), 
      .c(abeq1[22]), .d(abeq1[23]), .y(abeq2[2]));
  DatapathDone__nand4_1x abeqnand1_1_(.a(abeq1[24]), .b(abeq1[25]), 
      .c(abeq1[26]), .d(abeq1[27]), .y(abeq2[1]));
  DatapathDone__nand4_1x abeqnand1_0_(.a(abeq1[28]), .b(abeq1[29]), 
      .c(abeq1[30]), .d(abeq1[31]), .y(abeq2[0]));
  DatapathDone__nor4_1x abeqnor1_1_(.a(abeq2[3]), .b(abeq2[2]), .c(abeq2[1]), 
      .d(abeq2[0]), .y(abeq3[1]));
  DatapathDone__nor4_1x abeqnor1_0_(.a(abeq2[7]), .b(abeq2[6]), .c(abeq2[5]), 
      .d(abeq2[4]), .y(abeq3[0]));
  DatapathDone__xnor2_1x_32 xnor2_1x_0(.a(a[31:0]), .b(b[31:0]), 
      .y(abeq1[31:0]));
endmodule   /* DatapathDone__aeqbcmp_32 */

module DatapathDone__aeqzcmp_32(a, eq);
  input [31:0] a;
  output eq;

  supply1 vdd;
  supply0 gnd;
  wire [7:0] aeqz2;
  wire [1:0] aeqz3;

  DatapathDone__nor4_1x aeqzcmpnor1_7_(.a(a[12]), .b(a[13]), .c(a[14]), 
      .d(a[15]), .y(aeqz2[7]));
  DatapathDone__nor4_1x aeqzcmpnor1_6_(.a(a[8]), .b(a[9]), .c(a[10]), 
      .d(a[11]), .y(aeqz2[6]));
  DatapathDone__nor4_1x aeqzcmpnor1_5_(.a(a[4]), .b(a[5]), .c(a[6]), .d(a[7]), 
      .y(aeqz2[5]));
  DatapathDone__nor4_1x aeqzcmpnor1_4_(.a(a[0]), .b(a[1]), .c(a[2]), .d(a[3]), 
      .y(aeqz2[4]));
  DatapathDone__nor4_1x aeqzcmpnor1_3_(.a(a[28]), .b(a[29]), .c(a[30]), 
      .d(a[31]), .y(aeqz2[3]));
  DatapathDone__nor4_1x aeqzcmpnor1_2_(.a(a[24]), .b(a[25]), .c(a[26]), 
      .d(a[27]), .y(aeqz2[2]));
  DatapathDone__nor4_1x aeqzcmpnor1_1_(.a(a[20]), .b(a[21]), .c(a[22]), 
      .d(a[23]), .y(aeqz2[1]));
  DatapathDone__nor4_1x aeqzcmpnor1_0_(.a(a[16]), .b(a[17]), .c(a[18]), 
      .d(a[19]), .y(aeqz2[0]));
  DatapathDone__nand4_1x aeqznand2_1_(.a(aeqz2[0]), .b(aeqz2[1]), .c(aeqz2[2]), 
      .d(aeqz2[3]), .y(aeqz3[1]));
  DatapathDone__nand4_1x aeqznand2_0_(.a(aeqz2[4]), .b(aeqz2[5]), .c(aeqz2[6]), 
      .d(aeqz2[7]), .y(aeqz3[0]));
  DatapathDone__nor2_1x nor2_1x_0(.a(aeqz3[0]), .b(aeqz3[1]), .y(eq));
endmodule   /* DatapathDone__aeqzcmp_32 */

module DatapathDone__nor5_1x(a, b, c, d, e, y);
  input a;
  input b;
  input c;
  input d;
  input e;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_14, net_24, net_3, net_38;

  tranif1 nmos_0(gnd, y, d);
  tranif1 nmos_1(gnd, y, c);
  tranif1 nmos_2(gnd, y, b);
  tranif1 nmos_3(gnd, y, e);
  tranif1 nmos_4(gnd, y, a);
  tranif0 pmos_0(net_3, net_24, c);
  tranif0 pmos_1(net_14, net_3, d);
  tranif0 pmos_2(y, net_14, e);
  tranif0 pmos_3(net_24, net_38, b);
  tranif0 pmos_4(net_38, vdd, a);
endmodule   /* DatapathDone__nor5_1x */

module DatapathDone__decoder_read(rdecin, rdecin_1, rdecin_2, rdecin_3, 
      rdecin_4, rdecout_unbuf);
  input [0:0] rdecin;
  input [1:1] rdecin_1;
  input [2:2] rdecin_2;
  input [3:3] rdecin_3;
  input [4:4] rdecin_4;
  output rdecout_unbuf;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__nor5_1x nor5_1x_0(.a(rdecin[0]), .b(rdecin_1[1]), 
      .c(rdecin_2[2]), .d(rdecin_3[3]), .e(rdecin_4[4]), .y(rdecout_unbuf));
endmodule   /* DatapathDone__decoder_read */

module DatapathDone__decoder_write(RegWrite, ph2, wdecin, wdecin_1, wdecin_2, 
      wdecin_3, wdecin_4, wdecout_prenor1, wdecout_prenor2);
  input RegWrite;
  input ph2;
  input [0:0] wdecin;
  input [1:1] wdecin_1;
  input [2:2] wdecin_2;
  input [3:3] wdecin_3;
  input [4:4] wdecin_4;
  output wdecout_prenor1;
  output wdecout_prenor2;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__nand3_1x nand3_1x_0(.a(wdecin_2[2]), .b(wdecin_1[1]), 
      .c(wdecin[0]), .y(wdecout_prenor1));
  DatapathDone__nand4_1x nand4_1x_0(.a(wdecin_3[3]), .b(wdecin_4[4]), .c(ph2), 
      .d(RegWrite), .y(wdecout_prenor2));
endmodule   /* DatapathDone__decoder_write */

module DatapathDone__reg_decoder(RegWrite, ph2, r1add, r2add, wadd, r1do, 
      r1doi, r2do, r2doi, wdo, wdoi);
  input RegWrite;
  input ph2;
  input [4:0] r1add;
  input [4:0] r2add;
  input [4:0] wadd;
  output [31:0] r1do;
  output [31:1] r1doi;
  output [31:0] r2do;
  output [31:1] r2doi;
  output [31:1] wdo;
  output [31:1] wdoi;

  supply1 vdd;
  supply0 gnd;
  wire invbuf_4_132_sb_out, invbuf_4_165_sb_out, net_1460, net_1462, net_1464;
  wire net_1466, net_1468, net_1470, net_1472, net_1474, net_1476, net_1478;
  wire net_1480, net_1482, net_1484, net_1486, net_1488, net_1490, net_1492;
  wire net_1494, net_1496, net_1498, net_1500, net_1502, net_1504, net_1506;
  wire net_1508, net_1510, net_1512, net_1514, net_1516, net_1518, net_1520;
  wire net_1522, net_1524, net_1526, net_1528, net_1530, net_1532, net_1534;
  wire net_1536, net_1538, net_1540, net_1542, net_1544, net_1546, net_1548;
  wire net_1550, net_1552, net_1554, net_1556, net_1558, net_1560, net_1562;
  wire net_1564, net_1566, net_1568, net_1570, net_1572, net_1574, net_1576;
  wire net_1578, net_1580, net_1582, net_1584, net_1585, net_1586, net_1587;
  wire net_1588, net_1589, net_1590, net_1591, net_1592, net_1593, net_1594;
  wire net_1595, net_1596, net_1597, net_1598, net_1599, net_1600, net_1601;
  wire net_1602, net_1603, net_1604, net_1605, net_1606, net_1607, net_1608;
  wire net_1609, net_1610, net_1611, net_1612, net_1613, net_1614, net_1742;
  wire net_1743, net_1744, net_1745, net_1746, net_1747, net_1748, net_1749;
  wire net_1750, net_1751, net_1752, net_1753, net_1754, net_1755, net_1756;
  wire net_1757, net_1758, net_1759, net_1760, net_1761, net_1762, net_1763;
  wire net_1764, net_1765, net_1766, net_1767, net_1768, net_1769, net_1770;
  wire net_1771, net_1772, net_1773, net_1838, net_1839, net_1840, net_1841;
  wire net_1842, net_1843, net_1844, net_1845, net_1846, net_1847, net_1848;
  wire net_1849, net_1850, net_1851, net_1852, net_1853, net_1854, net_1855;
  wire net_1856, net_1857, net_1858, net_1859, net_1860, net_1861, net_1862;
  wire net_1863, net_1864, net_1865, net_1866, net_1867, net_1868, net_1869;
  wire [4:0] r1addi;
  wire [4:0] r2addi;
  wire [4:0] waddi;

  DatapathDone__invbuf_4x invbuf_4_101(.s(net_1584), .s_out(wdo[1]), 
      .sb_out(wdoi[1]));
  DatapathDone__invbuf_4x invbuf_4_102(.s(net_1585), .s_out(wdo[2]), 
      .sb_out(wdoi[2]));
  DatapathDone__invbuf_4x invbuf_4_103(.s(net_1586), .s_out(wdo[3]), 
      .sb_out(wdoi[3]));
  DatapathDone__invbuf_4x invbuf_4_104(.s(net_1587), .s_out(wdo[4]), 
      .sb_out(wdoi[4]));
  DatapathDone__invbuf_4x invbuf_4_105(.s(net_1588), .s_out(wdo[5]), 
      .sb_out(wdoi[5]));
  DatapathDone__invbuf_4x invbuf_4_106(.s(net_1589), .s_out(wdo[6]), 
      .sb_out(wdoi[6]));
  DatapathDone__invbuf_4x invbuf_4_107(.s(net_1590), .s_out(wdo[7]), 
      .sb_out(wdoi[7]));
  DatapathDone__invbuf_4x invbuf_4_108(.s(net_1591), .s_out(wdo[8]), 
      .sb_out(wdoi[8]));
  DatapathDone__invbuf_4x invbuf_4_109(.s(net_1592), .s_out(wdo[9]), 
      .sb_out(wdoi[9]));
  DatapathDone__invbuf_4x invbuf_4_110(.s(net_1593), .s_out(wdo[10]), 
      .sb_out(wdoi[10]));
  DatapathDone__invbuf_4x invbuf_4_111(.s(net_1594), .s_out(wdo[11]), 
      .sb_out(wdoi[11]));
  DatapathDone__invbuf_4x invbuf_4_112(.s(net_1595), .s_out(wdo[12]), 
      .sb_out(wdoi[12]));
  DatapathDone__invbuf_4x invbuf_4_113(.s(net_1596), .s_out(wdo[13]), 
      .sb_out(wdoi[13]));
  DatapathDone__invbuf_4x invbuf_4_114(.s(net_1597), .s_out(wdo[14]), 
      .sb_out(wdoi[14]));
  DatapathDone__invbuf_4x invbuf_4_115(.s(net_1598), .s_out(wdo[15]), 
      .sb_out(wdoi[15]));
  DatapathDone__invbuf_4x invbuf_4_116(.s(net_1599), .s_out(wdo[16]), 
      .sb_out(wdoi[16]));
  DatapathDone__invbuf_4x invbuf_4_117(.s(net_1600), .s_out(wdo[17]), 
      .sb_out(wdoi[17]));
  DatapathDone__invbuf_4x invbuf_4_118(.s(net_1601), .s_out(wdo[18]), 
      .sb_out(wdoi[18]));
  DatapathDone__invbuf_4x invbuf_4_119(.s(net_1602), .s_out(wdo[19]), 
      .sb_out(wdoi[19]));
  DatapathDone__invbuf_4x invbuf_4_120(.s(net_1603), .s_out(wdo[20]), 
      .sb_out(wdoi[20]));
  DatapathDone__invbuf_4x invbuf_4_121(.s(net_1604), .s_out(wdo[21]), 
      .sb_out(wdoi[21]));
  DatapathDone__invbuf_4x invbuf_4_122(.s(net_1605), .s_out(wdo[22]), 
      .sb_out(wdoi[22]));
  DatapathDone__invbuf_4x invbuf_4_123(.s(net_1606), .s_out(wdo[23]), 
      .sb_out(wdoi[23]));
  DatapathDone__invbuf_4x invbuf_4_124(.s(net_1607), .s_out(wdo[24]), 
      .sb_out(wdoi[24]));
  DatapathDone__invbuf_4x invbuf_4_125(.s(net_1608), .s_out(wdo[25]), 
      .sb_out(wdoi[25]));
  DatapathDone__invbuf_4x invbuf_4_126(.s(net_1609), .s_out(wdo[26]), 
      .sb_out(wdoi[26]));
  DatapathDone__invbuf_4x invbuf_4_127(.s(net_1610), .s_out(wdo[27]), 
      .sb_out(wdoi[27]));
  DatapathDone__invbuf_4x invbuf_4_128(.s(net_1611), .s_out(wdo[28]), 
      .sb_out(wdoi[28]));
  DatapathDone__invbuf_4x invbuf_4_129(.s(net_1612), .s_out(wdo[29]), 
      .sb_out(wdoi[29]));
  DatapathDone__invbuf_4x invbuf_4_130(.s(net_1613), .s_out(wdo[30]), 
      .sb_out(wdoi[30]));
  DatapathDone__invbuf_4x invbuf_4_131(.s(net_1614), .s_out(wdo[31]), 
      .sb_out(wdoi[31]));
  DatapathDone__invbuf_4x invbuf_4_132(.s(net_1742), .s_out(r1do[0]), 
      .sb_out(invbuf_4_132_sb_out));
  DatapathDone__invbuf_4x invbuf_4_165(.s(net_1838), .s_out(r2do[0]), 
      .sb_out(invbuf_4_165_sb_out));
  DatapathDone__invbuf_4x invbuf_4_197(.s(net_1743), .s_out(r1do[1]), 
      .sb_out(r1doi[1]));
  DatapathDone__invbuf_4x invbuf_4_198(.s(net_1744), .s_out(r1do[2]), 
      .sb_out(r1doi[2]));
  DatapathDone__invbuf_4x invbuf_4_199(.s(net_1745), .s_out(r1do[3]), 
      .sb_out(r1doi[3]));
  DatapathDone__invbuf_4x invbuf_4_200(.s(net_1746), .s_out(r1do[4]), 
      .sb_out(r1doi[4]));
  DatapathDone__invbuf_4x invbuf_4_201(.s(net_1747), .s_out(r1do[5]), 
      .sb_out(r1doi[5]));
  DatapathDone__invbuf_4x invbuf_4_202(.s(net_1748), .s_out(r1do[6]), 
      .sb_out(r1doi[6]));
  DatapathDone__invbuf_4x invbuf_4_203(.s(net_1749), .s_out(r1do[7]), 
      .sb_out(r1doi[7]));
  DatapathDone__invbuf_4x invbuf_4_204(.s(net_1750), .s_out(r1do[8]), 
      .sb_out(r1doi[8]));
  DatapathDone__invbuf_4x invbuf_4_205(.s(net_1751), .s_out(r1do[9]), 
      .sb_out(r1doi[9]));
  DatapathDone__invbuf_4x invbuf_4_206(.s(net_1752), .s_out(r1do[10]), 
      .sb_out(r1doi[10]));
  DatapathDone__invbuf_4x invbuf_4_207(.s(net_1753), .s_out(r1do[11]), 
      .sb_out(r1doi[11]));
  DatapathDone__invbuf_4x invbuf_4_208(.s(net_1754), .s_out(r1do[12]), 
      .sb_out(r1doi[12]));
  DatapathDone__invbuf_4x invbuf_4_209(.s(net_1755), .s_out(r1do[13]), 
      .sb_out(r1doi[13]));
  DatapathDone__invbuf_4x invbuf_4_210(.s(net_1756), .s_out(r1do[14]), 
      .sb_out(r1doi[14]));
  DatapathDone__invbuf_4x invbuf_4_211(.s(net_1757), .s_out(r1do[15]), 
      .sb_out(r1doi[15]));
  DatapathDone__invbuf_4x invbuf_4_212(.s(net_1758), .s_out(r1do[16]), 
      .sb_out(r1doi[16]));
  DatapathDone__invbuf_4x invbuf_4_213(.s(net_1759), .s_out(r1do[17]), 
      .sb_out(r1doi[17]));
  DatapathDone__invbuf_4x invbuf_4_214(.s(net_1760), .s_out(r1do[18]), 
      .sb_out(r1doi[18]));
  DatapathDone__invbuf_4x invbuf_4_215(.s(net_1761), .s_out(r1do[19]), 
      .sb_out(r1doi[19]));
  DatapathDone__invbuf_4x invbuf_4_216(.s(net_1762), .s_out(r1do[20]), 
      .sb_out(r1doi[20]));
  DatapathDone__invbuf_4x invbuf_4_217(.s(net_1763), .s_out(r1do[21]), 
      .sb_out(r1doi[21]));
  DatapathDone__invbuf_4x invbuf_4_218(.s(net_1764), .s_out(r1do[22]), 
      .sb_out(r1doi[22]));
  DatapathDone__invbuf_4x invbuf_4_219(.s(net_1765), .s_out(r1do[23]), 
      .sb_out(r1doi[23]));
  DatapathDone__invbuf_4x invbuf_4_220(.s(net_1766), .s_out(r1do[24]), 
      .sb_out(r1doi[24]));
  DatapathDone__invbuf_4x invbuf_4_221(.s(net_1767), .s_out(r1do[25]), 
      .sb_out(r1doi[25]));
  DatapathDone__invbuf_4x invbuf_4_222(.s(net_1768), .s_out(r1do[26]), 
      .sb_out(r1doi[26]));
  DatapathDone__invbuf_4x invbuf_4_223(.s(net_1769), .s_out(r1do[27]), 
      .sb_out(r1doi[27]));
  DatapathDone__invbuf_4x invbuf_4_224(.s(net_1770), .s_out(r1do[28]), 
      .sb_out(r1doi[28]));
  DatapathDone__invbuf_4x invbuf_4_225(.s(net_1771), .s_out(r1do[29]), 
      .sb_out(r1doi[29]));
  DatapathDone__invbuf_4x invbuf_4_226(.s(net_1772), .s_out(r1do[30]), 
      .sb_out(r1doi[30]));
  DatapathDone__invbuf_4x invbuf_4_227(.s(net_1773), .s_out(r1do[31]), 
      .sb_out(r1doi[31]));
  DatapathDone__invbuf_4x invbuf_4_228(.s(net_1839), .s_out(r2do[1]), 
      .sb_out(r2doi[1]));
  DatapathDone__invbuf_4x invbuf_4_229(.s(net_1840), .s_out(r2do[2]), 
      .sb_out(r2doi[2]));
  DatapathDone__invbuf_4x invbuf_4_230(.s(net_1841), .s_out(r2do[3]), 
      .sb_out(r2doi[3]));
  DatapathDone__invbuf_4x invbuf_4_231(.s(net_1842), .s_out(r2do[4]), 
      .sb_out(r2doi[4]));
  DatapathDone__invbuf_4x invbuf_4_232(.s(net_1843), .s_out(r2do[5]), 
      .sb_out(r2doi[5]));
  DatapathDone__invbuf_4x invbuf_4_233(.s(net_1844), .s_out(r2do[6]), 
      .sb_out(r2doi[6]));
  DatapathDone__invbuf_4x invbuf_4_234(.s(net_1845), .s_out(r2do[7]), 
      .sb_out(r2doi[7]));
  DatapathDone__invbuf_4x invbuf_4_235(.s(net_1846), .s_out(r2do[8]), 
      .sb_out(r2doi[8]));
  DatapathDone__invbuf_4x invbuf_4_236(.s(net_1847), .s_out(r2do[9]), 
      .sb_out(r2doi[9]));
  DatapathDone__invbuf_4x invbuf_4_237(.s(net_1848), .s_out(r2do[10]), 
      .sb_out(r2doi[10]));
  DatapathDone__invbuf_4x invbuf_4_238(.s(net_1849), .s_out(r2do[11]), 
      .sb_out(r2doi[11]));
  DatapathDone__invbuf_4x invbuf_4_239(.s(net_1850), .s_out(r2do[12]), 
      .sb_out(r2doi[12]));
  DatapathDone__invbuf_4x invbuf_4_240(.s(net_1851), .s_out(r2do[13]), 
      .sb_out(r2doi[13]));
  DatapathDone__invbuf_4x invbuf_4_241(.s(net_1852), .s_out(r2do[14]), 
      .sb_out(r2doi[14]));
  DatapathDone__invbuf_4x invbuf_4_242(.s(net_1853), .s_out(r2do[15]), 
      .sb_out(r2doi[15]));
  DatapathDone__invbuf_4x invbuf_4_243(.s(net_1854), .s_out(r2do[16]), 
      .sb_out(r2doi[16]));
  DatapathDone__invbuf_4x invbuf_4_244(.s(net_1855), .s_out(r2do[17]), 
      .sb_out(r2doi[17]));
  DatapathDone__invbuf_4x invbuf_4_245(.s(net_1856), .s_out(r2do[18]), 
      .sb_out(r2doi[18]));
  DatapathDone__invbuf_4x invbuf_4_246(.s(net_1857), .s_out(r2do[19]), 
      .sb_out(r2doi[19]));
  DatapathDone__invbuf_4x invbuf_4_247(.s(net_1858), .s_out(r2do[20]), 
      .sb_out(r2doi[20]));
  DatapathDone__invbuf_4x invbuf_4_248(.s(net_1859), .s_out(r2do[21]), 
      .sb_out(r2doi[21]));
  DatapathDone__invbuf_4x invbuf_4_249(.s(net_1860), .s_out(r2do[22]), 
      .sb_out(r2doi[22]));
  DatapathDone__invbuf_4x invbuf_4_250(.s(net_1861), .s_out(r2do[23]), 
      .sb_out(r2doi[23]));
  DatapathDone__invbuf_4x invbuf_4_251(.s(net_1862), .s_out(r2do[24]), 
      .sb_out(r2doi[24]));
  DatapathDone__invbuf_4x invbuf_4_252(.s(net_1863), .s_out(r2do[25]), 
      .sb_out(r2doi[25]));
  DatapathDone__invbuf_4x invbuf_4_253(.s(net_1864), .s_out(r2do[26]), 
      .sb_out(r2doi[26]));
  DatapathDone__invbuf_4x invbuf_4_254(.s(net_1865), .s_out(r2do[27]), 
      .sb_out(r2doi[27]));
  DatapathDone__invbuf_4x invbuf_4_255(.s(net_1866), .s_out(r2do[28]), 
      .sb_out(r2doi[28]));
  DatapathDone__invbuf_4x invbuf_4_256(.s(net_1867), .s_out(r2do[29]), 
      .sb_out(r2doi[29]));
  DatapathDone__invbuf_4x invbuf_4_257(.s(net_1868), .s_out(r2do[30]), 
      .sb_out(r2doi[30]));
  DatapathDone__invbuf_4x invbuf_4_258(.s(net_1869), .s_out(r2do[31]), 
      .sb_out(r2doi[31]));
  DatapathDone__nor2_1x nor2_1x_0(.a(net_1520), .b(net_1582), .y(net_1614));
  DatapathDone__nor2_1x nor2_1x_1(.a(net_1518), .b(net_1580), .y(net_1613));
  DatapathDone__nor2_1x nor2_1x_2(.a(net_1516), .b(net_1578), .y(net_1612));
  DatapathDone__nor2_1x nor2_1x_3(.a(net_1514), .b(net_1576), .y(net_1611));
  DatapathDone__nor2_1x nor2_1x_4(.a(net_1512), .b(net_1574), .y(net_1610));
  DatapathDone__nor2_1x nor2_1x_5(.a(net_1510), .b(net_1572), .y(net_1609));
  DatapathDone__nor2_1x nor2_1x_6(.a(net_1508), .b(net_1570), .y(net_1608));
  DatapathDone__nor2_1x nor2_1x_7(.a(net_1506), .b(net_1568), .y(net_1607));
  DatapathDone__nor2_1x nor2_1x_8(.a(net_1504), .b(net_1566), .y(net_1606));
  DatapathDone__nor2_1x nor2_1x_9(.a(net_1502), .b(net_1564), .y(net_1605));
  DatapathDone__nor2_1x nor2_1x_10(.a(net_1500), .b(net_1562), .y(net_1604));
  DatapathDone__nor2_1x nor2_1x_11(.a(net_1498), .b(net_1560), .y(net_1603));
  DatapathDone__nor2_1x nor2_1x_12(.a(net_1496), .b(net_1558), .y(net_1602));
  DatapathDone__nor2_1x nor2_1x_13(.a(net_1494), .b(net_1556), .y(net_1601));
  DatapathDone__nor2_1x nor2_1x_14(.a(net_1492), .b(net_1554), .y(net_1600));
  DatapathDone__nor2_1x nor2_1x_15(.a(net_1490), .b(net_1552), .y(net_1599));
  DatapathDone__nor2_1x nor2_1x_16(.a(net_1488), .b(net_1550), .y(net_1598));
  DatapathDone__nor2_1x nor2_1x_17(.a(net_1486), .b(net_1548), .y(net_1597));
  DatapathDone__nor2_1x nor2_1x_18(.a(net_1484), .b(net_1546), .y(net_1596));
  DatapathDone__nor2_1x nor2_1x_19(.a(net_1482), .b(net_1544), .y(net_1595));
  DatapathDone__nor2_1x nor2_1x_20(.a(net_1480), .b(net_1542), .y(net_1594));
  DatapathDone__nor2_1x nor2_1x_21(.a(net_1478), .b(net_1540), .y(net_1593));
  DatapathDone__nor2_1x nor2_1x_22(.a(net_1476), .b(net_1538), .y(net_1592));
  DatapathDone__nor2_1x nor2_1x_23(.a(net_1474), .b(net_1536), .y(net_1591));
  DatapathDone__nor2_1x nor2_1x_24(.a(net_1472), .b(net_1534), .y(net_1590));
  DatapathDone__nor2_1x nor2_1x_25(.a(net_1470), .b(net_1532), .y(net_1589));
  DatapathDone__nor2_1x nor2_1x_26(.a(net_1468), .b(net_1530), .y(net_1588));
  DatapathDone__nor2_1x nor2_1x_27(.a(net_1466), .b(net_1528), .y(net_1587));
  DatapathDone__nor2_1x nor2_1x_28(.a(net_1464), .b(net_1526), .y(net_1586));
  DatapathDone__nor2_1x nor2_1x_29(.a(net_1462), .b(net_1524), .y(net_1585));
  DatapathDone__nor2_1x nor2_1x_30(.a(net_1460), .b(net_1522), .y(net_1584));
  DatapathDone__inv_4x r1addinv_4_(.a(r1add[4]), .y(r1addi[4]));
  DatapathDone__inv_4x r1addinv_3_(.a(r1add[3]), .y(r1addi[3]));
  DatapathDone__inv_4x r1addinv_2_(.a(r1add[2]), .y(r1addi[2]));
  DatapathDone__inv_4x r1addinv_1_(.a(r1add[1]), .y(r1addi[1]));
  DatapathDone__inv_4x r1addinv_0_(.a(r1add[0]), .y(r1addi[0]));
  DatapathDone__decoder_read r1dec_0_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1742));
  DatapathDone__decoder_read r1dec_1_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1743));
  DatapathDone__decoder_read r1dec_2_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1744));
  DatapathDone__decoder_read r1dec_3_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1745));
  DatapathDone__decoder_read r1dec_4_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1746));
  DatapathDone__decoder_read r1dec_5_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1747));
  DatapathDone__decoder_read r1dec_6_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1748));
  DatapathDone__decoder_read r1dec_7_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1749));
  DatapathDone__decoder_read r1dec_8_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1750));
  DatapathDone__decoder_read r1dec_9_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1751));
  DatapathDone__decoder_read r1dec_10_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1752));
  DatapathDone__decoder_read r1dec_11_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1753));
  DatapathDone__decoder_read r1dec_12_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1754));
  DatapathDone__decoder_read r1dec_13_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1755));
  DatapathDone__decoder_read r1dec_14_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1756));
  DatapathDone__decoder_read r1dec_15_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1add[4:4]), .rdecout_unbuf(net_1757));
  DatapathDone__decoder_read r1dec_16_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1758));
  DatapathDone__decoder_read r1dec_17_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1759));
  DatapathDone__decoder_read r1dec_18_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1760));
  DatapathDone__decoder_read r1dec_19_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1761));
  DatapathDone__decoder_read r1dec_20_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1762));
  DatapathDone__decoder_read r1dec_21_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1763));
  DatapathDone__decoder_read r1dec_22_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1764));
  DatapathDone__decoder_read r1dec_23_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1add[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1765));
  DatapathDone__decoder_read r1dec_24_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1766));
  DatapathDone__decoder_read r1dec_25_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1767));
  DatapathDone__decoder_read r1dec_26_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1768));
  DatapathDone__decoder_read r1dec_27_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1add[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1769));
  DatapathDone__decoder_read r1dec_28_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1770));
  DatapathDone__decoder_read r1dec_29_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1add[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1771));
  DatapathDone__decoder_read r1dec_30_(.rdecin(r1add[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1772));
  DatapathDone__decoder_read r1dec_31_(.rdecin(r1addi[0:0]), 
      .rdecin_1(r1addi[1:1]), .rdecin_2(r1addi[2:2]), .rdecin_3(r1addi[3:3]), 
      .rdecin_4(r1addi[4:4]), .rdecout_unbuf(net_1773));
  DatapathDone__inv_4x r2addinv_4_(.a(r2add[4]), .y(r2addi[4]));
  DatapathDone__inv_4x r2addinv_3_(.a(r2add[3]), .y(r2addi[3]));
  DatapathDone__inv_4x r2addinv_2_(.a(r2add[2]), .y(r2addi[2]));
  DatapathDone__inv_4x r2addinv_1_(.a(r2add[1]), .y(r2addi[1]));
  DatapathDone__inv_4x r2addinv_0_(.a(r2add[0]), .y(r2addi[0]));
  DatapathDone__decoder_read r2dec_0_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1838));
  DatapathDone__decoder_read r2dec_1_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1839));
  DatapathDone__decoder_read r2dec_2_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1840));
  DatapathDone__decoder_read r2dec_3_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1841));
  DatapathDone__decoder_read r2dec_4_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1842));
  DatapathDone__decoder_read r2dec_5_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1843));
  DatapathDone__decoder_read r2dec_6_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1844));
  DatapathDone__decoder_read r2dec_7_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1845));
  DatapathDone__decoder_read r2dec_8_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1846));
  DatapathDone__decoder_read r2dec_9_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1847));
  DatapathDone__decoder_read r2dec_10_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1848));
  DatapathDone__decoder_read r2dec_11_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1849));
  DatapathDone__decoder_read r2dec_12_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1850));
  DatapathDone__decoder_read r2dec_13_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1851));
  DatapathDone__decoder_read r2dec_14_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1852));
  DatapathDone__decoder_read r2dec_15_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2add[4:4]), .rdecout_unbuf(net_1853));
  DatapathDone__decoder_read r2dec_16_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1854));
  DatapathDone__decoder_read r2dec_17_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1855));
  DatapathDone__decoder_read r2dec_18_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1856));
  DatapathDone__decoder_read r2dec_19_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1857));
  DatapathDone__decoder_read r2dec_20_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1858));
  DatapathDone__decoder_read r2dec_21_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1859));
  DatapathDone__decoder_read r2dec_22_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1860));
  DatapathDone__decoder_read r2dec_23_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2add[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1861));
  DatapathDone__decoder_read r2dec_24_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1862));
  DatapathDone__decoder_read r2dec_25_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1863));
  DatapathDone__decoder_read r2dec_26_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1864));
  DatapathDone__decoder_read r2dec_27_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2add[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1865));
  DatapathDone__decoder_read r2dec_28_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1866));
  DatapathDone__decoder_read r2dec_29_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2add[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1867));
  DatapathDone__decoder_read r2dec_30_(.rdecin(r2add[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1868));
  DatapathDone__decoder_read r2dec_31_(.rdecin(r2addi[0:0]), 
      .rdecin_1(r2addi[1:1]), .rdecin_2(r2addi[2:2]), .rdecin_3(r2addi[3:3]), 
      .rdecin_4(r2addi[4:4]), .rdecout_unbuf(net_1869));
  DatapathDone__inv_4x waddinv_4_(.a(wadd[4]), .y(waddi[4]));
  DatapathDone__inv_4x waddinv_3_(.a(wadd[3]), .y(waddi[3]));
  DatapathDone__inv_4x waddinv_2_(.a(wadd[2]), .y(waddi[2]));
  DatapathDone__inv_4x waddinv_1_(.a(wadd[1]), .y(waddi[1]));
  DatapathDone__inv_4x waddinv_0_(.a(wadd[0]), .y(waddi[0]));
  DatapathDone__decoder_write wdec_1_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1460), 
      .wdecout_prenor2(net_1522));
  DatapathDone__decoder_write wdec_2_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1462), 
      .wdecout_prenor2(net_1524));
  DatapathDone__decoder_write wdec_3_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1464), 
      .wdecout_prenor2(net_1526));
  DatapathDone__decoder_write wdec_4_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1466), 
      .wdecout_prenor2(net_1528));
  DatapathDone__decoder_write wdec_5_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1468), 
      .wdecout_prenor2(net_1530));
  DatapathDone__decoder_write wdec_6_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1470), 
      .wdecout_prenor2(net_1532));
  DatapathDone__decoder_write wdec_7_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1472), 
      .wdecout_prenor2(net_1534));
  DatapathDone__decoder_write wdec_8_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1474), 
      .wdecout_prenor2(net_1536));
  DatapathDone__decoder_write wdec_9_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1476), 
      .wdecout_prenor2(net_1538));
  DatapathDone__decoder_write wdec_10_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1478), 
      .wdecout_prenor2(net_1540));
  DatapathDone__decoder_write wdec_11_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1480), 
      .wdecout_prenor2(net_1542));
  DatapathDone__decoder_write wdec_12_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1482), 
      .wdecout_prenor2(net_1544));
  DatapathDone__decoder_write wdec_13_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1484), 
      .wdecout_prenor2(net_1546));
  DatapathDone__decoder_write wdec_14_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1486), 
      .wdecout_prenor2(net_1548));
  DatapathDone__decoder_write wdec_15_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(waddi[4:4]), .wdecout_prenor1(net_1488), 
      .wdecout_prenor2(net_1550));
  DatapathDone__decoder_write wdec_16_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1490), 
      .wdecout_prenor2(net_1552));
  DatapathDone__decoder_write wdec_17_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1492), 
      .wdecout_prenor2(net_1554));
  DatapathDone__decoder_write wdec_18_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1494), 
      .wdecout_prenor2(net_1556));
  DatapathDone__decoder_write wdec_19_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1496), 
      .wdecout_prenor2(net_1558));
  DatapathDone__decoder_write wdec_20_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1498), 
      .wdecout_prenor2(net_1560));
  DatapathDone__decoder_write wdec_21_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1500), 
      .wdecout_prenor2(net_1562));
  DatapathDone__decoder_write wdec_22_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1502), 
      .wdecout_prenor2(net_1564));
  DatapathDone__decoder_write wdec_23_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(waddi[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1504), 
      .wdecout_prenor2(net_1566));
  DatapathDone__decoder_write wdec_24_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1506), 
      .wdecout_prenor2(net_1568));
  DatapathDone__decoder_write wdec_25_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1508), 
      .wdecout_prenor2(net_1570));
  DatapathDone__decoder_write wdec_26_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1510), 
      .wdecout_prenor2(net_1572));
  DatapathDone__decoder_write wdec_27_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(waddi[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1512), 
      .wdecout_prenor2(net_1574));
  DatapathDone__decoder_write wdec_28_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1514), 
      .wdecout_prenor2(net_1576));
  DatapathDone__decoder_write wdec_29_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(waddi[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1516), 
      .wdecout_prenor2(net_1578));
  DatapathDone__decoder_write wdec_30_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(waddi[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1518), 
      .wdecout_prenor2(net_1580));
  DatapathDone__decoder_write wdec_31_(.RegWrite(RegWrite), .ph2(ph2), 
      .wdecin(wadd[0:0]), .wdecin_1(wadd[1:1]), .wdecin_2(wadd[2:2]), 
      .wdecin_3(wadd[3:3]), .wdecin_4(wadd[4:4]), .wdecout_prenor1(net_1520), 
      .wdecout_prenor2(net_1582));
endmodule   /* DatapathDone__reg_decoder */

module DatapathDone__regram_dp_bit0(read1, read2, r1, r2);
  input read1;
  input read2;
  output r1;
  output r2;

  supply0 gnd;
  tranif1 nmos_1(gnd, r1, read1);
  tranif1 nmos_2(gnd, r2, read2);
endmodule   /* DatapathDone__regram_dp_bit0 */

module DatapathDone__regramvector0_dp(read1, read2, r1, r2);
  input read1;
  input read2;
  output [31:0] r1;
  output [31:0] r2;

  supply0 gnd;
  DatapathDone__regram_dp_bit0 regram_d_0(.read1(read1), .read2(read2), 
      .r1(r1[0]), .r2(r2[0]));
  DatapathDone__regram_dp_bit0 regram_d_1(.read1(read1), .read2(read2), 
      .r1(r1[1]), .r2(r2[1]));
  DatapathDone__regram_dp_bit0 regram_d_2(.read1(read1), .read2(read2), 
      .r1(r1[2]), .r2(r2[2]));
  DatapathDone__regram_dp_bit0 regram_d_3(.read1(read1), .read2(read2), 
      .r1(r1[3]), .r2(r2[3]));
  DatapathDone__regram_dp_bit0 regram_d_4(.read1(read1), .read2(read2), 
      .r1(r1[4]), .r2(r2[4]));
  DatapathDone__regram_dp_bit0 regram_d_5(.read1(read1), .read2(read2), 
      .r1(r1[5]), .r2(r2[5]));
  DatapathDone__regram_dp_bit0 regram_d_6(.read1(read1), .read2(read2), 
      .r1(r1[6]), .r2(r2[6]));
  DatapathDone__regram_dp_bit0 regram_d_7(.read1(read1), .read2(read2), 
      .r1(r1[7]), .r2(r2[7]));
  DatapathDone__regram_dp_bit0 regram_d_8(.read1(read1), .read2(read2), 
      .r1(r1[8]), .r2(r2[8]));
  DatapathDone__regram_dp_bit0 regram_d_9(.read1(read1), .read2(read2), 
      .r1(r1[9]), .r2(r2[9]));
  DatapathDone__regram_dp_bit0 regram_d_10(.read1(read1), .read2(read2), 
      .r1(r1[10]), .r2(r2[10]));
  DatapathDone__regram_dp_bit0 regram_d_11(.read1(read1), .read2(read2), 
      .r1(r1[11]), .r2(r2[11]));
  DatapathDone__regram_dp_bit0 regram_d_12(.read1(read1), .read2(read2), 
      .r1(r1[12]), .r2(r2[12]));
  DatapathDone__regram_dp_bit0 regram_d_13(.read1(read1), .read2(read2), 
      .r1(r1[13]), .r2(r2[13]));
  DatapathDone__regram_dp_bit0 regram_d_14(.read1(read1), .read2(read2), 
      .r1(r1[14]), .r2(r2[14]));
  DatapathDone__regram_dp_bit0 regram_d_15(.read1(read1), .read2(read2), 
      .r1(r1[15]), .r2(r2[15]));
  DatapathDone__regram_dp_bit0 regram_d_16(.read1(read1), .read2(read2), 
      .r1(r1[16]), .r2(r2[16]));
  DatapathDone__regram_dp_bit0 regram_d_17(.read1(read1), .read2(read2), 
      .r1(r1[17]), .r2(r2[17]));
  DatapathDone__regram_dp_bit0 regram_d_18(.read1(read1), .read2(read2), 
      .r1(r1[18]), .r2(r2[18]));
  DatapathDone__regram_dp_bit0 regram_d_19(.read1(read1), .read2(read2), 
      .r1(r1[19]), .r2(r2[19]));
  DatapathDone__regram_dp_bit0 regram_d_20(.read1(read1), .read2(read2), 
      .r1(r1[20]), .r2(r2[20]));
  DatapathDone__regram_dp_bit0 regram_d_21(.read1(read1), .read2(read2), 
      .r1(r1[21]), .r2(r2[21]));
  DatapathDone__regram_dp_bit0 regram_d_22(.read1(read1), .read2(read2), 
      .r1(r1[22]), .r2(r2[22]));
  DatapathDone__regram_dp_bit0 regram_d_23(.read1(read1), .read2(read2), 
      .r1(r1[23]), .r2(r2[23]));
  DatapathDone__regram_dp_bit0 regram_d_24(.read1(read1), .read2(read2), 
      .r1(r1[24]), .r2(r2[24]));
  DatapathDone__regram_dp_bit0 regram_d_25(.read1(read1), .read2(read2), 
      .r1(r1[25]), .r2(r2[25]));
  DatapathDone__regram_dp_bit0 regram_d_26(.read1(read1), .read2(read2), 
      .r1(r1[26]), .r2(r2[26]));
  DatapathDone__regram_dp_bit0 regram_d_27(.read1(read1), .read2(read2), 
      .r1(r1[27]), .r2(r2[27]));
  DatapathDone__regram_dp_bit0 regram_d_28(.read1(read1), .read2(read2), 
      .r1(r1[28]), .r2(r2[28]));
  DatapathDone__regram_dp_bit0 regram_d_29(.read1(read1), .read2(read2), 
      .r1(r1[29]), .r2(r2[29]));
  DatapathDone__regram_dp_bit0 regram_d_30(.read1(read1), .read2(read2), 
      .r1(r1[30]), .r2(r2[30]));
  DatapathDone__regram_dp_bit0 regram_d_31(.read1(read1), .read2(read2), 
      .r1(r1[31]), .r2(r2[31]));
endmodule   /* DatapathDone__regramvector0_dp */

module DatapathDone__regram_dp(read1, read1b, read2, read2b, w, write, writeb, 
      r1, r2);
  input read1;
  input read1b;
  input read2;
  input read2b;
  input w;
  input write;
  input writeb;
  output r1;
  output r2;

  supply1 vdd;
  supply0 gnd;
  wire net_69, net_70, net_71, net_72, net_74, net_76, v, vb;

  tranif1 nmos_0(net_70, v, vb);
  tranif1 nmos_1(gnd, net_70, writeb);
  tranif1 nmos_2(gnd, vb, v);
  tranif1 nmos_3(w, v, write);
  tranif1 nmos_4(net_71, r1, read1);
  tranif1 nmos_5(net_74, r2, read2);
  tranif1 nmos_6(gnd, net_71, vb);
  tranif1 nmos_7(gnd, net_74, vb);
  tranif0 pmos_0(v, net_69, vb);
  tranif0 pmos_1(net_69, vdd, write);
  tranif0 pmos_2(vb, vdd, v);
  tranif0 pmos_3(v, w, writeb);
  tranif0 pmos_4(net_72, vdd, vb);
  tranif0 pmos_5(r1, net_72, read1b);
  tranif0 pmos_6(r2, net_76, read2b);
  tranif0 pmos_7(net_76, vdd, vb);
endmodule   /* DatapathDone__regram_dp */

module DatapathDone__regramvector_dp(read1, read1b, read2, read2b, w, write, 
      writeb, r1, r2);
  input read1;
  input read1b;
  input read2;
  input read2b;
  input [31:0] w;
  input write;
  input writeb;
  output [31:0] r1;
  output [31:0] r2;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__regram_dp rambit_0_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[0]), .write(write), .writeb(writeb), 
      .r1(r1[0]), .r2(r2[0]));
  DatapathDone__regram_dp rambit_1_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[1]), .write(write), .writeb(writeb), 
      .r1(r1[1]), .r2(r2[1]));
  DatapathDone__regram_dp rambit_2_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[2]), .write(write), .writeb(writeb), 
      .r1(r1[2]), .r2(r2[2]));
  DatapathDone__regram_dp rambit_3_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[3]), .write(write), .writeb(writeb), 
      .r1(r1[3]), .r2(r2[3]));
  DatapathDone__regram_dp rambit_4_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[4]), .write(write), .writeb(writeb), 
      .r1(r1[4]), .r2(r2[4]));
  DatapathDone__regram_dp rambit_5_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[5]), .write(write), .writeb(writeb), 
      .r1(r1[5]), .r2(r2[5]));
  DatapathDone__regram_dp rambit_6_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[6]), .write(write), .writeb(writeb), 
      .r1(r1[6]), .r2(r2[6]));
  DatapathDone__regram_dp rambit_7_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[7]), .write(write), .writeb(writeb), 
      .r1(r1[7]), .r2(r2[7]));
  DatapathDone__regram_dp rambit_8_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[8]), .write(write), .writeb(writeb), 
      .r1(r1[8]), .r2(r2[8]));
  DatapathDone__regram_dp rambit_9_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[9]), .write(write), .writeb(writeb), 
      .r1(r1[9]), .r2(r2[9]));
  DatapathDone__regram_dp rambit_10_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[10]), .write(write), 
      .writeb(writeb), .r1(r1[10]), .r2(r2[10]));
  DatapathDone__regram_dp rambit_11_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[11]), .write(write), 
      .writeb(writeb), .r1(r1[11]), .r2(r2[11]));
  DatapathDone__regram_dp rambit_12_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[12]), .write(write), 
      .writeb(writeb), .r1(r1[12]), .r2(r2[12]));
  DatapathDone__regram_dp rambit_13_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[13]), .write(write), 
      .writeb(writeb), .r1(r1[13]), .r2(r2[13]));
  DatapathDone__regram_dp rambit_14_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[14]), .write(write), 
      .writeb(writeb), .r1(r1[14]), .r2(r2[14]));
  DatapathDone__regram_dp rambit_15_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[15]), .write(write), 
      .writeb(writeb), .r1(r1[15]), .r2(r2[15]));
  DatapathDone__regram_dp rambit_16_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[16]), .write(write), 
      .writeb(writeb), .r1(r1[16]), .r2(r2[16]));
  DatapathDone__regram_dp rambit_17_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[17]), .write(write), 
      .writeb(writeb), .r1(r1[17]), .r2(r2[17]));
  DatapathDone__regram_dp rambit_18_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[18]), .write(write), 
      .writeb(writeb), .r1(r1[18]), .r2(r2[18]));
  DatapathDone__regram_dp rambit_19_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[19]), .write(write), 
      .writeb(writeb), .r1(r1[19]), .r2(r2[19]));
  DatapathDone__regram_dp rambit_20_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[20]), .write(write), 
      .writeb(writeb), .r1(r1[20]), .r2(r2[20]));
  DatapathDone__regram_dp rambit_21_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[21]), .write(write), 
      .writeb(writeb), .r1(r1[21]), .r2(r2[21]));
  DatapathDone__regram_dp rambit_22_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[22]), .write(write), 
      .writeb(writeb), .r1(r1[22]), .r2(r2[22]));
  DatapathDone__regram_dp rambit_23_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[23]), .write(write), 
      .writeb(writeb), .r1(r1[23]), .r2(r2[23]));
  DatapathDone__regram_dp rambit_24_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[24]), .write(write), 
      .writeb(writeb), .r1(r1[24]), .r2(r2[24]));
  DatapathDone__regram_dp rambit_25_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[25]), .write(write), 
      .writeb(writeb), .r1(r1[25]), .r2(r2[25]));
  DatapathDone__regram_dp rambit_26_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[26]), .write(write), 
      .writeb(writeb), .r1(r1[26]), .r2(r2[26]));
  DatapathDone__regram_dp rambit_27_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[27]), .write(write), 
      .writeb(writeb), .r1(r1[27]), .r2(r2[27]));
  DatapathDone__regram_dp rambit_28_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[28]), .write(write), 
      .writeb(writeb), .r1(r1[28]), .r2(r2[28]));
  DatapathDone__regram_dp rambit_29_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[29]), .write(write), 
      .writeb(writeb), .r1(r1[29]), .r2(r2[29]));
  DatapathDone__regram_dp rambit_30_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[30]), .write(write), 
      .writeb(writeb), .r1(r1[30]), .r2(r2[30]));
  DatapathDone__regram_dp rambit_31_(.read1(read1), .read1b(read1b), 
      .read2(read2), .read2b(read2b), .w(w[31]), .write(write), 
      .writeb(writeb), .r1(r1[31]), .r2(r2[31]));
endmodule   /* DatapathDone__regramvector_dp */

module DatapathDone__regramarray_dp(r1, r2, read1, read1b, read2, read2b, w, 
      write, writeb);
  input [31:0] r1;
  input [31:0] r2;
  input [31:0] read1;
  input [31:1] read1b;
  input [31:0] read2;
  input [31:1] read2b;
  input [31:0] w;
  input [31:1] write;
  input [31:1] writeb;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__regramvector0_dp regramve_0(.read1(read1[0]), .read2(read2[0]), 
      .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_1_(.read1(read1[1]), 
      .read1b(read1b[1]), .read2(read2[1]), .read2b(read2b[1]), .w(w[31:0]), 
      .write(write[1]), .writeb(writeb[1]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_2_(.read1(read1[2]), 
      .read1b(read1b[2]), .read2(read2[2]), .read2b(read2b[2]), .w(w[31:0]), 
      .write(write[2]), .writeb(writeb[2]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_3_(.read1(read1[3]), 
      .read1b(read1b[3]), .read2(read2[3]), .read2b(read2b[3]), .w(w[31:0]), 
      .write(write[3]), .writeb(writeb[3]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_4_(.read1(read1[4]), 
      .read1b(read1b[4]), .read2(read2[4]), .read2b(read2b[4]), .w(w[31:0]), 
      .write(write[4]), .writeb(writeb[4]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_5_(.read1(read1[5]), 
      .read1b(read1b[5]), .read2(read2[5]), .read2b(read2b[5]), .w(w[31:0]), 
      .write(write[5]), .writeb(writeb[5]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_6_(.read1(read1[6]), 
      .read1b(read1b[6]), .read2(read2[6]), .read2b(read2b[6]), .w(w[31:0]), 
      .write(write[6]), .writeb(writeb[6]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_7_(.read1(read1[7]), 
      .read1b(read1b[7]), .read2(read2[7]), .read2b(read2b[7]), .w(w[31:0]), 
      .write(write[7]), .writeb(writeb[7]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_8_(.read1(read1[8]), 
      .read1b(read1b[8]), .read2(read2[8]), .read2b(read2b[8]), .w(w[31:0]), 
      .write(write[8]), .writeb(writeb[8]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_9_(.read1(read1[9]), 
      .read1b(read1b[9]), .read2(read2[9]), .read2b(read2b[9]), .w(w[31:0]), 
      .write(write[9]), .writeb(writeb[9]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_10_(.read1(read1[10]), 
      .read1b(read1b[10]), .read2(read2[10]), .read2b(read2b[10]), .w(w[31:0]), 
      .write(write[10]), .writeb(writeb[10]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_11_(.read1(read1[11]), 
      .read1b(read1b[11]), .read2(read2[11]), .read2b(read2b[11]), .w(w[31:0]), 
      .write(write[11]), .writeb(writeb[11]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_12_(.read1(read1[12]), 
      .read1b(read1b[12]), .read2(read2[12]), .read2b(read2b[12]), .w(w[31:0]), 
      .write(write[12]), .writeb(writeb[12]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_13_(.read1(read1[13]), 
      .read1b(read1b[13]), .read2(read2[13]), .read2b(read2b[13]), .w(w[31:0]), 
      .write(write[13]), .writeb(writeb[13]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_14_(.read1(read1[14]), 
      .read1b(read1b[14]), .read2(read2[14]), .read2b(read2b[14]), .w(w[31:0]), 
      .write(write[14]), .writeb(writeb[14]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_15_(.read1(read1[15]), 
      .read1b(read1b[15]), .read2(read2[15]), .read2b(read2b[15]), .w(w[31:0]), 
      .write(write[15]), .writeb(writeb[15]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_16_(.read1(read1[16]), 
      .read1b(read1b[16]), .read2(read2[16]), .read2b(read2b[16]), .w(w[31:0]), 
      .write(write[16]), .writeb(writeb[16]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_17_(.read1(read1[17]), 
      .read1b(read1b[17]), .read2(read2[17]), .read2b(read2b[17]), .w(w[31:0]), 
      .write(write[17]), .writeb(writeb[17]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_18_(.read1(read1[18]), 
      .read1b(read1b[18]), .read2(read2[18]), .read2b(read2b[18]), .w(w[31:0]), 
      .write(write[18]), .writeb(writeb[18]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_19_(.read1(read1[19]), 
      .read1b(read1b[19]), .read2(read2[19]), .read2b(read2b[19]), .w(w[31:0]), 
      .write(write[19]), .writeb(writeb[19]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_20_(.read1(read1[20]), 
      .read1b(read1b[20]), .read2(read2[20]), .read2b(read2b[20]), .w(w[31:0]), 
      .write(write[20]), .writeb(writeb[20]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_21_(.read1(read1[21]), 
      .read1b(read1b[21]), .read2(read2[21]), .read2b(read2b[21]), .w(w[31:0]), 
      .write(write[21]), .writeb(writeb[21]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_22_(.read1(read1[22]), 
      .read1b(read1b[22]), .read2(read2[22]), .read2b(read2b[22]), .w(w[31:0]), 
      .write(write[22]), .writeb(writeb[22]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_23_(.read1(read1[23]), 
      .read1b(read1b[23]), .read2(read2[23]), .read2b(read2b[23]), .w(w[31:0]), 
      .write(write[23]), .writeb(writeb[23]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_24_(.read1(read1[24]), 
      .read1b(read1b[24]), .read2(read2[24]), .read2b(read2b[24]), .w(w[31:0]), 
      .write(write[24]), .writeb(writeb[24]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_25_(.read1(read1[25]), 
      .read1b(read1b[25]), .read2(read2[25]), .read2b(read2b[25]), .w(w[31:0]), 
      .write(write[25]), .writeb(writeb[25]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_26_(.read1(read1[26]), 
      .read1b(read1b[26]), .read2(read2[26]), .read2b(read2b[26]), .w(w[31:0]), 
      .write(write[26]), .writeb(writeb[26]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_27_(.read1(read1[27]), 
      .read1b(read1b[27]), .read2(read2[27]), .read2b(read2b[27]), .w(w[31:0]), 
      .write(write[27]), .writeb(writeb[27]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_28_(.read1(read1[28]), 
      .read1b(read1b[28]), .read2(read2[28]), .read2b(read2b[28]), .w(w[31:0]), 
      .write(write[28]), .writeb(writeb[28]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_29_(.read1(read1[29]), 
      .read1b(read1b[29]), .read2(read2[29]), .read2b(read2b[29]), .w(w[31:0]), 
      .write(write[29]), .writeb(writeb[29]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_30_(.read1(read1[30]), 
      .read1b(read1b[30]), .read2(read2[30]), .read2b(read2b[30]), .w(w[31:0]), 
      .write(write[30]), .writeb(writeb[30]), .r1(r1[31:0]), .r2(r2[31:0]));
  DatapathDone__regramvector_dp regvector_31_(.read1(read1[31]), 
      .read1b(read1b[31]), .read2(read2[31]), .read2b(read2b[31]), .w(w[31:0]), 
      .write(write[31]), .writeb(writeb[31]), .r1(r1[31:0]), .r2(r2[31:0]));
endmodule   /* DatapathDone__regramarray_dp */

module DatapathDone__register_dp(RegWrite, ph2, r1add, r2add, w, wadd, r1, 
      r2);
  input RegWrite;
  input ph2;
  input [4:0] r1add;
  input [4:0] r2add;
  input [31:0] w;
  input [4:0] wadd;
  output [31:0] r1;
  output [31:0] r2;

  supply1 vdd;
  supply0 gnd;
  wire [0:30] net_892;
  wire [0:30] net_894;
  wire [0:31] net_896;
  wire [0:30] net_898;
  wire [0:31] net_900;
  wire [0:30] net_902;

  DatapathDone__reg_decoder reg_deco_0(.RegWrite(RegWrite), .ph2(ph2), 
      .r1add(r1add[4:0]), .r2add(r2add[4:0]), .wadd(wadd[4:0]), 
      .r1do({net_896[0], net_896[1], net_896[2], net_896[3], net_896[4], 
      net_896[5], net_896[6], net_896[7], net_896[8], net_896[9], net_896[10], 
      net_896[11], net_896[12], net_896[13], net_896[14], net_896[15], 
      net_896[16], net_896[17], net_896[18], net_896[19], net_896[20], 
      net_896[21], net_896[22], net_896[23], net_896[24], net_896[25], 
      net_896[26], net_896[27], net_896[28], net_896[29], net_896[30], 
      net_896[31]}), .r1doi({net_898[0], net_898[1], net_898[2], net_898[3], 
      net_898[4], net_898[5], net_898[6], net_898[7], net_898[8], net_898[9], 
      net_898[10], net_898[11], net_898[12], net_898[13], net_898[14], 
      net_898[15], net_898[16], net_898[17], net_898[18], net_898[19], 
      net_898[20], net_898[21], net_898[22], net_898[23], net_898[24], 
      net_898[25], net_898[26], net_898[27], net_898[28], net_898[29], 
      net_898[30]}), .r2do({net_900[0], net_900[1], net_900[2], net_900[3], 
      net_900[4], net_900[5], net_900[6], net_900[7], net_900[8], net_900[9], 
      net_900[10], net_900[11], net_900[12], net_900[13], net_900[14], 
      net_900[15], net_900[16], net_900[17], net_900[18], net_900[19], 
      net_900[20], net_900[21], net_900[22], net_900[23], net_900[24], 
      net_900[25], net_900[26], net_900[27], net_900[28], net_900[29], 
      net_900[30], net_900[31]}), .r2doi({net_902[0], net_902[1], net_902[2], 
      net_902[3], net_902[4], net_902[5], net_902[6], net_902[7], net_902[8], 
      net_902[9], net_902[10], net_902[11], net_902[12], net_902[13], 
      net_902[14], net_902[15], net_902[16], net_902[17], net_902[18], 
      net_902[19], net_902[20], net_902[21], net_902[22], net_902[23], 
      net_902[24], net_902[25], net_902[26], net_902[27], net_902[28], 
      net_902[29], net_902[30]}), .wdo({net_892[0], net_892[1], net_892[2], 
      net_892[3], net_892[4], net_892[5], net_892[6], net_892[7], net_892[8], 
      net_892[9], net_892[10], net_892[11], net_892[12], net_892[13], 
      net_892[14], net_892[15], net_892[16], net_892[17], net_892[18], 
      net_892[19], net_892[20], net_892[21], net_892[22], net_892[23], 
      net_892[24], net_892[25], net_892[26], net_892[27], net_892[28], 
      net_892[29], net_892[30]}), .wdoi({net_894[0], net_894[1], net_894[2], 
      net_894[3], net_894[4], net_894[5], net_894[6], net_894[7], net_894[8], 
      net_894[9], net_894[10], net_894[11], net_894[12], net_894[13], 
      net_894[14], net_894[15], net_894[16], net_894[17], net_894[18], 
      net_894[19], net_894[20], net_894[21], net_894[22], net_894[23], 
      net_894[24], net_894[25], net_894[26], net_894[27], net_894[28], 
      net_894[29], net_894[30]}));
  DatapathDone__regramarray_dp regramar_0(.r1(r1[31:0]), .r2(r2[31:0]), 
      .read1({net_896[0], net_896[1], net_896[2], net_896[3], net_896[4], 
      net_896[5], net_896[6], net_896[7], net_896[8], net_896[9], net_896[10], 
      net_896[11], net_896[12], net_896[13], net_896[14], net_896[15], 
      net_896[16], net_896[17], net_896[18], net_896[19], net_896[20], 
      net_896[21], net_896[22], net_896[23], net_896[24], net_896[25], 
      net_896[26], net_896[27], net_896[28], net_896[29], net_896[30], 
      net_896[31]}), .read1b({net_898[0], net_898[1], net_898[2], net_898[3], 
      net_898[4], net_898[5], net_898[6], net_898[7], net_898[8], net_898[9], 
      net_898[10], net_898[11], net_898[12], net_898[13], net_898[14], 
      net_898[15], net_898[16], net_898[17], net_898[18], net_898[19], 
      net_898[20], net_898[21], net_898[22], net_898[23], net_898[24], 
      net_898[25], net_898[26], net_898[27], net_898[28], net_898[29], 
      net_898[30]}), .read2({net_900[0], net_900[1], net_900[2], net_900[3], 
      net_900[4], net_900[5], net_900[6], net_900[7], net_900[8], net_900[9], 
      net_900[10], net_900[11], net_900[12], net_900[13], net_900[14], 
      net_900[15], net_900[16], net_900[17], net_900[18], net_900[19], 
      net_900[20], net_900[21], net_900[22], net_900[23], net_900[24], 
      net_900[25], net_900[26], net_900[27], net_900[28], net_900[29], 
      net_900[30], net_900[31]}), .read2b({net_902[0], net_902[1], net_902[2], 
      net_902[3], net_902[4], net_902[5], net_902[6], net_902[7], net_902[8], 
      net_902[9], net_902[10], net_902[11], net_902[12], net_902[13], 
      net_902[14], net_902[15], net_902[16], net_902[17], net_902[18], 
      net_902[19], net_902[20], net_902[21], net_902[22], net_902[23], 
      net_902[24], net_902[25], net_902[26], net_902[27], net_902[28], 
      net_902[29], net_902[30]}), .w(w[31:0]), .write({net_892[0], net_892[1], 
      net_892[2], net_892[3], net_892[4], net_892[5], net_892[6], net_892[7], 
      net_892[8], net_892[9], net_892[10], net_892[11], net_892[12], 
      net_892[13], net_892[14], net_892[15], net_892[16], net_892[17], 
      net_892[18], net_892[19], net_892[20], net_892[21], net_892[22], 
      net_892[23], net_892[24], net_892[25], net_892[26], net_892[27], 
      net_892[28], net_892[29], net_892[30]}), .writeb({net_894[0], net_894[1], 
      net_894[2], net_894[3], net_894[4], net_894[5], net_894[6], net_894[7], 
      net_894[8], net_894[9], net_894[10], net_894[11], net_894[12], 
      net_894[13], net_894[14], net_894[15], net_894[16], net_894[17], 
      net_894[18], net_894[19], net_894[20], net_894[21], net_894[22], 
      net_894[23], net_894[24], net_894[25], net_894[26], net_894[27], 
      net_894[28], net_894[29], net_894[30]}));
endmodule   /* DatapathDone__register_dp */

module DatapathDone__and2_4x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_1, net_2;

  tranif1 nmos_0(net_1, net_2, b);
  tranif1 nmos_1(gnd, net_1, a);
  tranif1 nmos_2(gnd, y, net_2);
  tranif0 pmos_0(net_2, vdd, b);
  tranif0 pmos_1(net_2, vdd, a);
  tranif0 pmos_2(y, vdd, net_2);
endmodule   /* DatapathDone__and2_4x */

module DatapathDone__signext32(enable, a, ex);
  input enable;
  input a;
  output ex;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__and2_4x and2_4x_0(.a(a), .b(enable), .y(ex));
endmodule   /* DatapathDone__signext32 */

module DatapathDone__decode(aluoutM, forwardaD, forwardbD, instrD, 
      pcbranchsrcD, pcplus4D, ph2, regwriteW, resultW, unsignedD, writeregW, 
      aeqbD, aeqzD, agtzD, pcnextbrFD, signimmD, srca2D, srcb2D);
  input [31:0] aluoutM;
  input forwardaD;
  input forwardbD;
  input [31:0] instrD;
  input [1:0] pcbranchsrcD;
  input [31:0] pcplus4D;
  input ph2;
  input regwriteW;
  input [31:0] resultW;
  input unsignedD;
  input [4:0] writeregW;
  output aeqbD;
  output aeqzD;
  output agtzD;
  output [31:0] pcnextbrFD;
  output [31:31] signimmD;
  output [31:0] srca2D;
  output [31:0] srcb2D;

  supply1 vdd;
  supply0 gnd;
  wire btadd_cout, net_72;
  wire [31:0] branchtargetD;
  wire [31:0] srcaD;
  wire [31:0] srcbD;

  DatapathDone__aeqbcmp_32 aeqbcmp__2(.a(srca2D[31:0]), .b(srcb2D[31:0]), 
      .eq(aeqbD));
  DatapathDone__aeqzcmp_32 aeqzcmp__0(.a(srca2D[31:0]), .eq(aeqzD));
  DatapathDone__adder_32 btadd(.a({signimmD[31], signimmD[31], signimmD[31], 
      signimmD[31], signimmD[31], signimmD[31], signimmD[31], signimmD[31], 
      signimmD[31], signimmD[31], signimmD[31], signimmD[31], signimmD[31], 
      signimmD[31], instrD[15], instrD[14], instrD[13], instrD[12], instrD[11], 
      instrD[10], instrD[9], instrD[8], instrD[7], instrD[6], instrD[5], 
      instrD[4], instrD[3], instrD[2], instrD[1], instrD[0], gnd, gnd}), 
      .b(pcplus4D[31:0]), .cin(gnd), .cout(btadd_cout), 
      .s(branchtargetD[31:0]));
  DatapathDone__mux2_dp_1x_32 forwardadmux(.d0(srcaD[31:0]), 
      .d1(aluoutM[31:0]), .s(forwardaD), .y(srca2D[31:0]));
  DatapathDone__mux2_dp_1x_32 forwardbdmux(.d0(srcbD[31:0]), 
      .d1(aluoutM[31:0]), .s(forwardbD), .y(srcb2D[31:0]));
  DatapathDone__inv_1x inv_1x_0(.a(unsignedD), .y(net_72));
  DatapathDone__nor2_1x nor2_1x_0(.a(aeqzD), .b(srca2D[31]), .y(agtzD));
  DatapathDone__mux3_dp_1x_32 pcbranchmux(.d0(branchtargetD[31:0]), 
      .d1({pcplus4D[31], pcplus4D[30], pcplus4D[29], pcplus4D[28], instrD[25], 
      instrD[24], instrD[23], instrD[22], instrD[21], instrD[20], instrD[19], 
      instrD[18], instrD[17], instrD[16], instrD[15], instrD[14], instrD[13], 
      instrD[12], instrD[11], instrD[10], instrD[9], instrD[8], instrD[7], 
      instrD[6], instrD[5], instrD[4], instrD[3], instrD[2], instrD[1], 
      instrD[0], gnd, gnd}), .d2(srca2D[31:0]), .s0(pcbranchsrcD[0]), 
      .s1(pcbranchsrcD[1]), .y(pcnextbrFD[31:0]));
  DatapathDone__register_dp register_2(.RegWrite(regwriteW), .ph2(ph2), 
      .r1add(instrD[25:21]), .r2add(instrD[20:16]), .w(resultW[31:0]), 
      .wadd(writeregW[4:0]), .r1(srcaD[31:0]), .r2(srcbD[31:0]));
  DatapathDone__signext32 signext3_0(.enable(instrD[15]), .a(net_72), 
      .ex(signimmD[31]));
endmodule   /* DatapathDone__decode */

module DatapathDone__decodefull(aluoutM, clear, en, forwardaD, forwardbD, 
      instrD, pcbranchsrcD, pcplus4D, ph1, ph2, regwriteW, reset, resultW, 
      unsignedD, writeregW, aeqbD, aeqzD, agtzD, altzD, pcnextbrFD, signimmE, 
      srcaE, srcbE);
  input [31:0] aluoutM;
  input clear;
  input en;
  input forwardaD;
  input forwardbD;
  input [31:0] instrD;
  input [1:0] pcbranchsrcD;
  input [31:0] pcplus4D;
  input ph1;
  input ph2;
  input regwriteW;
  input reset;
  input [31:0] resultW;
  input unsignedD;
  input [4:0] writeregW;
  output aeqbD;
  output aeqzD;
  output agtzD;
  output altzD;
  output [31:0] pcnextbrFD;
  output [31:0] signimmE;
  output [31:0] srcaE;
  output [31:0] srcbE;

  supply1 vdd;
  supply0 gnd;
  wire [31:1] net_10;
  wire [0:31] net_16;
  wire [16:16] signimmD;

  DatapathDone__decode decode_0(.aluoutM(aluoutM[31:0]), .forwardaD(forwardaD), 
      .forwardbD(forwardbD), .instrD(instrD[31:0]), 
      .pcbranchsrcD(pcbranchsrcD[1:0]), .pcplus4D(pcplus4D[31:0]), .ph2(ph2), 
      .regwriteW(regwriteW), .resultW(resultW[31:0]), .unsignedD(unsignedD), 
      .writeregW(writeregW[4:0]), .aeqbD(aeqbD), .aeqzD(aeqzD), .agtzD(agtzD), 
      .pcnextbrFD(pcnextbrFD[31:0]), .signimmD(signimmD[16:16]), 
      .srca2D({altzD, net_10[1], net_10[2], net_10[3], net_10[4], net_10[5], 
      net_10[6], net_10[7], net_10[8], net_10[9], net_10[10], net_10[11], 
      net_10[12], net_10[13], net_10[14], net_10[15], net_10[16], net_10[17], 
      net_10[18], net_10[19], net_10[20], net_10[21], net_10[22], net_10[23], 
      net_10[24], net_10[25], net_10[26], net_10[27], net_10[28], net_10[29], 
      net_10[30], net_10[31]}), .srcb2D({net_16[0], net_16[1], net_16[2], 
      net_16[3], net_16[4], net_16[5], net_16[6], net_16[7], net_16[8], 
      net_16[9], net_16[10], net_16[11], net_16[12], net_16[13], net_16[14], 
      net_16[15], net_16[16], net_16[17], net_16[18], net_16[19], net_16[20], 
      net_16[21], net_16[22], net_16[23], net_16[24], net_16[25], net_16[26], 
      net_16[27], net_16[28], net_16[29], net_16[30], net_16[31]}));
  DatapathDone__flopenrc_32 flopenrc_0(.clear(clear), .d({altzD, net_10[1], 
      net_10[2], net_10[3], net_10[4], net_10[5], net_10[6], net_10[7], 
      net_10[8], net_10[9], net_10[10], net_10[11], net_10[12], net_10[13], 
      net_10[14], net_10[15], net_10[16], net_10[17], net_10[18], net_10[19], 
      net_10[20], net_10[21], net_10[22], net_10[23], net_10[24], net_10[25], 
      net_10[26], net_10[27], net_10[28], net_10[29], net_10[30], net_10[31]}), 
      .en(en), .ph1(ph1), .ph2(ph2), .reset(reset), .q(srcaE[31:0]));
  DatapathDone__flopenrc_32 flopenrc_1(.clear(clear), .d({net_16[0], net_16[1], 
      net_16[2], net_16[3], net_16[4], net_16[5], net_16[6], net_16[7], 
      net_16[8], net_16[9], net_16[10], net_16[11], net_16[12], net_16[13], 
      net_16[14], net_16[15], net_16[16], net_16[17], net_16[18], net_16[19], 
      net_16[20], net_16[21], net_16[22], net_16[23], net_16[24], net_16[25], 
      net_16[26], net_16[27], net_16[28], net_16[29], net_16[30], net_16[31]}), 
      .en(en), .ph1(ph1), .ph2(ph2), .reset(reset), .q(srcbE[31:0]));
  DatapathDone__flopenrc_32 flopenrc_2(.clear(clear), .d({signimmD[16], 
      signimmD[16], signimmD[16], signimmD[16], signimmD[16], signimmD[16], 
      signimmD[16], signimmD[16], signimmD[16], signimmD[16], signimmD[16], 
      signimmD[16], signimmD[16], signimmD[16], signimmD[16], signimmD[16], 
      instrD[15], instrD[14], instrD[13], instrD[12], instrD[11], instrD[10], 
      instrD[9], instrD[8], instrD[7], instrD[6], instrD[5], instrD[4], 
      instrD[3], instrD[2], instrD[1], instrD[0]}), .en(en), .ph1(ph1), 
      .ph2(ph2), .reset(reset), .q(signimmE[31:0]));
endmodule   /* DatapathDone__decodefull */

module DatapathDone__flopenrc_32_special(clear, d, en, ph1, ph2, reset, en_out, 
      enb_out, ph1_out, ph1b_out, ph2_out, ph2b_out, q, resetb_out);
  input clear;
  input [31:0] d;
  input en;
  input ph1;
  input ph2;
  input reset;
  output en_out;
  output enb_out;
  output ph1_out;
  output ph1b_out;
  output ph2_out;
  output ph2b_out;
  output [31:0] q;
  output resetb_out;

  supply1 vdd;
  supply0 gnd;
  DatapathDone__clkinvbufdual_4x clkinvbu_0(.ph1b(ph1b_out), .ph1buf(ph1_out), 
      .ph2b(ph2b_out), .ph2buf(ph2_out), .ph1(ph1), .ph2(ph2));
  DatapathDone__flopenr_dp_1x flopenr_31_(.d(d[31]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[31]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_30_(.d(d[30]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[30]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_29_(.d(d[29]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[29]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_28_(.d(d[28]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[28]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_27_(.d(d[27]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[27]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_26_(.d(d[26]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[26]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_25_(.d(d[25]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[25]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_24_(.d(d[24]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[24]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_23_(.d(d[23]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[23]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_22_(.d(d[22]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[22]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_21_(.d(d[21]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[21]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_20_(.d(d[20]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[20]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_19_(.d(d[19]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[19]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_18_(.d(d[18]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[18]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_17_(.d(d[17]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[17]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_16_(.d(d[16]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[16]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_15_(.d(d[15]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[15]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_14_(.d(d[14]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[14]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_13_(.d(d[13]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[13]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_12_(.d(d[12]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[12]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_11_(.d(d[11]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[11]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_10_(.d(d[10]), .en(en_out), 
      .enb(enb_out), .resetb(resetb_out), .q(q[10]), .ph1(ph1_out), 
      .ph1b(ph1b_out), .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_9_(.d(d[9]), .en(en_out), .enb(enb_out), 
      .resetb(resetb_out), .q(q[9]), .ph1(ph1_out), .ph1b(ph1b_out), 
      .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_8_(.d(d[8]), .en(en_out), .enb(enb_out), 
      .resetb(resetb_out), .q(q[8]), .ph1(ph1_out), .ph1b(ph1b_out), 
      .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_7_(.d(d[7]), .en(en_out), .enb(enb_out), 
      .resetb(resetb_out), .q(q[7]), .ph1(ph1_out), .ph1b(ph1b_out), 
      .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_6_(.d(d[6]), .en(en_out), .enb(enb_out), 
      .resetb(resetb_out), .q(q[6]), .ph1(ph1_out), .ph1b(ph1b_out), 
      .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_5_(.d(d[5]), .en(en_out), .enb(enb_out), 
      .resetb(resetb_out), .q(q[5]), .ph1(ph1_out), .ph1b(ph1b_out), 
      .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_4_(.d(d[4]), .en(en_out), .enb(enb_out), 
      .resetb(resetb_out), .q(q[4]), .ph1(ph1_out), .ph1b(ph1b_out), 
      .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_3_(.d(d[3]), .en(en_out), .enb(enb_out), 
      .resetb(resetb_out), .q(q[3]), .ph1(ph1_out), .ph1b(ph1b_out), 
      .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_2_(.d(d[2]), .en(en_out), .enb(enb_out), 
      .resetb(resetb_out), .q(q[2]), .ph1(ph1_out), .ph1b(ph1b_out), 
      .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_1_(.d(d[1]), .en(en_out), .enb(enb_out), 
      .resetb(resetb_out), .q(q[1]), .ph1(ph1_out), .ph1b(ph1b_out), 
      .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__flopenr_dp_1x flopenr_0_(.d(d[0]), .en(en_out), .enb(enb_out), 
      .resetb(resetb_out), .q(q[0]), .ph1(ph1_out), .ph1b(ph1b_out), 
      .ph2(ph2_out), .ph2b(ph2b_out));
  DatapathDone__invbuf_4x invbuf_4_0(.s(en), .s_out(en_out), 
      .sb_out(enb_out));
  DatapathDone__nor2_2x nor2_2x_0(.a(reset), .b(clear), .y(resetb_out));
endmodule   /* DatapathDone__flopenrc_32_special */

module DatapathDone__Fetch_Decode(aluoutM, flushD, flushE, forwardaD, 
      forwardbD, instrF, pcbranchsrcD, pcsrcFD, ph1, ph2, rdD, regwriteW, 
      reset, resultW, rsD, rtD, stallD, stallE, stallF, unsignedD, writeregW, 
      adelthrownD, adelthrownE, aeqbD, aeqzD, agtzD, altzD, functD, opD, pcE, 
      pcF, signimmE, srcaE, srcbE);
  input [31:0] aluoutM;
  input flushD;
  input flushE;
  input forwardaD;
  input forwardbD;
  input [31:0] instrF;
  input [1:0] pcbranchsrcD;
  input [1:0] pcsrcFD;
  input ph1;
  input ph2;
  input [4:0] rdD;
  input regwriteW;
  input reset;
  input [31:0] resultW;
  input [4:0] rsD;
  input [4:0] rtD;
  input stallD;
  input stallE;
  input stallF;
  input unsignedD;
  input [4:0] writeregW;
  output adelthrownD;
  output adelthrownE;
  output aeqbD;
  output aeqzD;
  output agtzD;
  output altzD;
  output [5:0] functD;
  output [5:0] opD;
  output [31:0] pcE;
  output [31:0] pcF;
  output [31:0] signimmE;
  output [31:0] srcaE;
  output [31:0] srcbE;

  supply1 vdd;
  supply0 gnd;
  wire net_58, net_61, net_64, net_67, net_71, net_75, net_81, net_88;
  wire [10:6] instrD;
  wire [31:0] pcD;
  wire [31:0] pcnextbrFD;
  wire [31:0] pcplus4D;

  DatapathDone__Fetch_Stage Fetch_St_0(.pcF(pcF[31:0]), .flushD(flushD), 
      .instrF(instrF[31:0]), .pcnextbrFD(pcnextbrFD[31:0]), 
      .pcsrcFD(pcsrcFD[1:0]), .ph1(ph1), .ph2(ph2), .reset(reset), 
      .stallD(stallD), .stallF(stallF), .adelthrownD(adelthrownD), 
      .instrD({opD[5], opD[4], opD[3], opD[2], opD[1], opD[0], rsD[4], rsD[3], 
      rsD[2], rsD[1], rsD[0], rtD[4], rtD[3], rtD[2], rtD[1], rtD[0], rdD[4], 
      rdD[3], rdD[2], rdD[1], rdD[0], instrD[10], instrD[9], instrD[8], 
      instrD[7], instrD[6], functD[5], functD[4], functD[3], functD[2], 
      functD[1], functD[0]}), .pcD(pcD[31:0]), .pcplus4D(pcplus4D[31:0]));
  DatapathDone__decodefull decodefu_0(.aluoutM(aluoutM[31:0]), .clear(flushE), 
      .en(net_88), .forwardaD(forwardaD), .forwardbD(forwardbD), 
      .instrD({opD[5], opD[4], opD[3], opD[2], opD[1], opD[0], rsD[4], rsD[3], 
      rsD[2], rsD[1], rsD[0], rtD[4], rtD[3], rtD[2], rtD[1], rtD[0], rdD[4], 
      rdD[3], rdD[2], rdD[1], rdD[0], instrD[10], instrD[9], instrD[8], 
      instrD[7], instrD[6], functD[5], functD[4], functD[3], functD[2], 
      functD[1], functD[0]}), .pcbranchsrcD(pcbranchsrcD[1:0]), 
      .pcplus4D(pcplus4D[31:0]), .ph1(ph1), .ph2(ph2), .regwriteW(regwriteW), 
      .reset(reset), .resultW(resultW[31:0]), .unsignedD(unsignedD), 
      .writeregW(writeregW[4:0]), .aeqbD(aeqbD), .aeqzD(aeqzD), .agtzD(agtzD), 
      .altzD(altzD), .pcnextbrFD(pcnextbrFD[31:0]), .signimmE(signimmE[31:0]), 
      .srcaE(srcaE[31:0]), .srcbE(srcbE[31:0]));
  DatapathDone__flopenr_dp_1x flopenr__0(.d(adelthrownD), .en(net_75), 
      .enb(net_81), .resetb(net_71), .q(adelthrownE), .ph1(net_64), 
      .ph1b(net_61), .ph2(net_58), .ph2b(net_67));
  DatapathDone__flopenrc_32_special flopenrc_0(.clear(flushE), .d(pcD[31:0]), 
      .en(net_88), .ph1(ph1), .ph2(ph2), .reset(reset), .en_out(net_75), 
      .enb_out(net_81), .ph1_out(net_64), .ph1b_out(net_61), .ph2_out(net_58), 
      .ph2b_out(net_67), .q(pcE[31:0]), .resetb_out(net_71));
  DatapathDone__inv_1x inv_1x_0(.a(stallE), .y(net_88));
endmodule   /* DatapathDone__Fetch_Decode */

module DatapathDone__Datapath_Final(aluoutsrcE, alushcontrolE, alusrcE, 
      branchD, byteM, cop0readdataE, dataackM, halfwordM, hiloaccessD, 
      hilodisableE, hilosrcE, instrF, instrackF, jumpregD, loadsignedM, luiE, 
      mdstartE, memtoregE, memtoregM, memtoregW, pcbranchsrcD, pcsrcFD, 
      pendingexception, ph1, ph2, rdsrcD, re, readdataM, regdstE, regwriteE, 
      regwriteM, regwriteW, reset, specialregsrcE, unsignedD, activeexception, 
      adelthrownE, aeqbD, aeqzD, agtzD, altzD, aluoutM, byteenM, flushE, 
      flushM, functD, mdrunE, misalignedhE, misalignedwE, opD, overflowE, pcE, 
      pcF, rdE, rsD, rtD, stallD, stallE, stallM, stallW, writedata2M, 
      writedataW, writeregW);
  input [1:0] aluoutsrcE;
  input [2:0] alushcontrolE;
  input alusrcE;
  input branchD;
  input byteM;
  input [31:0] cop0readdataE;
  input dataackM;
  input halfwordM;
  input hiloaccessD;
  input [1:0] hilodisableE;
  input hilosrcE;
  input [31:0] instrF;
  input instrackF;
  input jumpregD;
  input loadsignedM;
  input luiE;
  input mdstartE;
  input memtoregE;
  input memtoregM;
  input memtoregW;
  input [1:0] pcbranchsrcD;
  input [1:0] pcsrcFD;
  input pendingexception;
  input ph1;
  input ph2;
  input rdsrcD;
  input re;
  input [31:0] readdataM;
  input regdstE;
  input regwriteE;
  input regwriteM;
  input regwriteW;
  input reset;
  input [1:0] specialregsrcE;
  input unsignedD;
  output activeexception;
  output adelthrownE;
  output aeqbD;
  output aeqzD;
  output agtzD;
  output altzD;
  output [31:0] aluoutM;
  output [3:0] byteenM;
  output flushE;
  output flushM;
  output [5:0] functD;
  output mdrunE;
  output misalignedhE;
  output misalignedwE;
  output [5:0] opD;
  output overflowE;
  output [31:0] pcE;
  output [31:0] pcF;
  output [4:0] rdE;
  output [4:0] rsD;
  output [4:0] rtD;
  output stallD;
  output stallE;
  output stallM;
  output stallW;
  output [31:0] writedata2M;
  output [31:0] writedataW;
  output [4:0] writeregW;

  supply1 vdd;
  supply0 gnd;
  wire adelthrownD, flushD, forwardaD, forwardbD, stallF;
  wire [4:0] rdD;
  wire [31:0] resultW;
  wire [31:0] signimmE;
  wire [31:0] srcaE;
  wire [31:0] srcbE;

  DatapathDone__Execute_Memory_Writeback_Five_Haz 
      Execute__0(.aluoutsrcE(aluoutsrcE[1:0]), 
      .alushcontrolE(alushcontrolE[2:0]), .alusrcE(alusrcE), .branchD(branchD), 
      .byteM(byteM), .cop0readdataE(cop0readdataE[31:0]), .dataackM(dataackM), 
      .halfwordM(halfwordM), .hiloaccessD(hiloaccessD), 
      .hilodisableE(hilodisableE[1:0]), .hilosrcE(hilosrcE), 
      .instrackF(instrackF), .jumpregD(jumpregD), .loadsignedM(loadsignedM), 
      .luiE(luiE), .mdstartE(mdstartE), .memtoregE(memtoregE), 
      .memtoregM(memtoregM), .memtoregW(memtoregW), .pcE(pcE[31:0]), 
      .pendingexception(pendingexception), .ph1(ph1), .ph2(ph2), 
      .rdD(rdD[4:0]), .rdsrcD(rdsrcD), .re(re), .readdataM(readdataM[31:0]), 
      .regdstE(regdstE), .regwriteE(regwriteE), .regwriteM(regwriteM), 
      .regwriteW(regwriteW), .reset(reset), .rsD(rsD[4:0]), .rtD(rtD[4:0]), 
      .signimmE(signimmE[31:0]), .specialregsrcE(specialregsrcE[1:0]), 
      .srcaE(srcaE[31:0]), .srcbE(srcbE[31:0]), 
      .activeexception(activeexception), .aluoutM(aluoutM[31:0]), 
      .byteenM(byteenM[3:0]), .flushD(flushD), .flushE(flushE), 
      .flushM(flushM), .forwardaD(forwardaD), .forwardbD(forwardbD), 
      .mdrunE(mdrunE), .misalignedhE(misalignedhE), 
      .misalignedwE(misalignedwE), .overflowE(overflowE), .rdE(rdE[4:0]), 
      .resultW(resultW[31:0]), .stallD(stallD), .stallE(stallE), 
      .stallF(stallF), .stallM(stallM), .stallW(stallW), 
      .writedata2M(writedata2M[31:0]), .writedataW(writedataW[31:0]), 
      .writeregW(writeregW[4:0]));
  DatapathDone__Fetch_Decode Fetch_De_1(.aluoutM(aluoutM[31:0]), 
      .flushD(flushD), .flushE(flushE), .forwardaD(forwardaD), 
      .forwardbD(forwardbD), .instrF(instrF[31:0]), 
      .pcbranchsrcD(pcbranchsrcD[1:0]), .pcsrcFD(pcsrcFD[1:0]), .ph1(ph1), 
      .ph2(ph2), .rdD(rdD[4:0]), .regwriteW(regwriteW), .reset(reset), 
      .resultW(resultW[31:0]), .rsD(rsD[4:0]), .rtD(rtD[4:0]), .stallD(stallD), 
      .stallE(stallE), .stallF(stallF), .unsignedD(unsignedD), 
      .writeregW(writeregW[4:0]), .adelthrownD(adelthrownD), 
      .adelthrownE(adelthrownE), .aeqbD(aeqbD), .aeqzD(aeqzD), .agtzD(agtzD), 
      .altzD(altzD), .functD(functD[5:0]), .opD(opD[5:0]), .pcE(pcE[31:0]), 
      .pcF(pcF[31:0]), .signimmE(signimmE[31:0]), .srcaE(srcaE[31:0]), 
      .srcbE(srcbE[31:0]));
endmodule   /* DatapathDone__Datapath_Final */

module muddlib07__clkinvbuf_4x(ph, phb, phbuf);
  input ph;
  output phb;
  output phbuf;

  supply1 vdd;
  supply0 gnd;
  wire notph;

  tranif1 nmos_0(gnd, phb, ph);
  tranif1 nmos_1(gnd, notph, ph);
  tranif1 nmos_2(gnd, phbuf, notph);
  tranif0 pmos_0(phb, vdd, ph);
  tranif0 pmos_1(notph, vdd, ph);
  tranif0 pmos_2(phbuf, vdd, notph);
endmodule   /* muddlib07__clkinvbuf_4x */

module muddlib07__clkinvbufdual_4x(ph1b, ph1buf, ph2b, ph2buf, ph1, ph2);
  output ph1b;
  output ph1buf;
  output ph2b;
  output ph2buf;
  input ph1;
  input ph2;

  supply1 vdd;
  supply0 gnd;
  muddlib07__clkinvbuf_4x clkinvbu_1(.ph(ph1), .phb(ph1b), .phbuf(ph1buf));
  muddlib07__clkinvbuf_4x clkinvbu_2(.ph(ph2), .phb(ph2b), .phbuf(ph2buf));
endmodule   /* muddlib07__clkinvbufdual_4x */

module muddlib07__flopen_dp_1x(d, en, enb, q, ph1, ph1b, ph2, ph2b);
  input d;
  input en;
  input enb;
  output q;
  input ph1;
  input ph1b;
  input ph2;
  input ph2b;

  supply1 vdd;
  supply0 gnd;
  wire master, masterinb, n2, n3, n4, n5, n6, n7, n8, n9, slaveb;
  trireg masterb, slave;

  tranif1 nmos_2(masterinb, masterb, ph2);
  tranif1 nmos_3(gnd, master, masterb);
  rtranif1 nmos_4(master, slave, ph1);
  tranif1 nmos_5(n6, masterb, ph2b);
  tranif1 nmos_6(gnd, n6, master);
  tranif1 nmos_7(gnd, n8, slaveb);
  tranif1 nmos_8(gnd, slaveb, slave);
  tranif1 nmos_10(n8, slave, ph1b);
  tranif1 nmos_11(gnd, q, slaveb);
  tranif1 nmos_16(gnd, n2, en);
  tranif1 nmos_18(n3, gnd, enb);
  tranif1 nmos_19(n2, masterinb, d);
  tranif1 nmos_20(masterinb, n3, slave);
  tranif0 pmos_2(masterb, masterinb, ph2b);
  tranif0 pmos_3(master, vdd, masterb);
  rtranif0 pmos_4(slave, master, ph1b);
  tranif0 pmos_5(masterb, n7, ph2);
  tranif0 pmos_6(n7, vdd, master);
  tranif0 pmos_7(n9, vdd, slaveb);
  tranif0 pmos_8(slaveb, vdd, slave);
  tranif0 pmos_10(slave, n9, ph1);
  tranif0 pmos_11(q, vdd, slaveb);
  tranif0 pmos_16(masterinb, n4, d);
  tranif0 pmos_17(n4, vdd, enb);
  tranif0 pmos_19(n5, masterinb, slave);
  tranif0 pmos_20(vdd, n5, en);
endmodule   /* muddlib07__flopen_dp_1x */

module wordlib__flopen_32(d, en, ph1, ph2, q);
  input [31:0] d;
  input en;
  input ph1;
  input ph2;
  output [31:0] q;

  supply1 vdd;
  supply0 gnd;
  wire net_15, net_16, net_17, net_18, net_19, net_21;

  muddlib07__clkinvbufdual_4x clkinvbu_0(.ph1b(net_18), .ph1buf(net_17), 
      .ph2b(net_16), .ph2buf(net_15), .ph1(ph1), .ph2(ph2));
  muddlib07__flopen_dp_1x flopen_32_31_(.d(d[31]), .en(net_21), .enb(net_19), 
      .q(q[31]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_30_(.d(d[30]), .en(net_21), .enb(net_19), 
      .q(q[30]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_29_(.d(d[29]), .en(net_21), .enb(net_19), 
      .q(q[29]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_28_(.d(d[28]), .en(net_21), .enb(net_19), 
      .q(q[28]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_27_(.d(d[27]), .en(net_21), .enb(net_19), 
      .q(q[27]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_26_(.d(d[26]), .en(net_21), .enb(net_19), 
      .q(q[26]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_25_(.d(d[25]), .en(net_21), .enb(net_19), 
      .q(q[25]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_24_(.d(d[24]), .en(net_21), .enb(net_19), 
      .q(q[24]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_23_(.d(d[23]), .en(net_21), .enb(net_19), 
      .q(q[23]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_22_(.d(d[22]), .en(net_21), .enb(net_19), 
      .q(q[22]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_21_(.d(d[21]), .en(net_21), .enb(net_19), 
      .q(q[21]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_20_(.d(d[20]), .en(net_21), .enb(net_19), 
      .q(q[20]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_19_(.d(d[19]), .en(net_21), .enb(net_19), 
      .q(q[19]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_18_(.d(d[18]), .en(net_21), .enb(net_19), 
      .q(q[18]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_17_(.d(d[17]), .en(net_21), .enb(net_19), 
      .q(q[17]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_16_(.d(d[16]), .en(net_21), .enb(net_19), 
      .q(q[16]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_15_(.d(d[15]), .en(net_21), .enb(net_19), 
      .q(q[15]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_14_(.d(d[14]), .en(net_21), .enb(net_19), 
      .q(q[14]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_13_(.d(d[13]), .en(net_21), .enb(net_19), 
      .q(q[13]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_12_(.d(d[12]), .en(net_21), .enb(net_19), 
      .q(q[12]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_11_(.d(d[11]), .en(net_21), .enb(net_19), 
      .q(q[11]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_10_(.d(d[10]), .en(net_21), .enb(net_19), 
      .q(q[10]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_9_(.d(d[9]), .en(net_21), .enb(net_19), 
      .q(q[9]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_8_(.d(d[8]), .en(net_21), .enb(net_19), 
      .q(q[8]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_7_(.d(d[7]), .en(net_21), .enb(net_19), 
      .q(q[7]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_6_(.d(d[6]), .en(net_21), .enb(net_19), 
      .q(q[6]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_5_(.d(d[5]), .en(net_21), .enb(net_19), 
      .q(q[5]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_4_(.d(d[4]), .en(net_21), .enb(net_19), 
      .q(q[4]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_3_(.d(d[3]), .en(net_21), .enb(net_19), 
      .q(q[3]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_2_(.d(d[2]), .en(net_21), .enb(net_19), 
      .q(q[2]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_1_(.d(d[1]), .en(net_21), .enb(net_19), 
      .q(q[1]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__flopen_dp_1x flopen_32_0_(.d(d[0]), .en(net_21), .enb(net_19), 
      .q(q[0]), .ph1(net_17), .ph1b(net_18), .ph2(net_15), .ph2b(net_16));
  muddlib07__invbuf_4x invbuf_4_0(.s(en), .s_out(net_21), .sb_out(net_19));
endmodule   /* wordlib__flopen_32 */

module cop0__causeregunit(activeexception, branchdelay, exccode, interrupts, 
      ph1, ph2, causereg);
  input activeexception;
  input branchdelay;
  input [4:0] exccode;
  input [7:0] interrupts;
  input ph1;
  input ph2;
  output [31:0] causereg;

  supply1 vdd;
  supply0 gnd;
  wordlib__flopen_32 causeregflop(.d({branchdelay, gnd, gnd, gnd, gnd, gnd, 
      gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, gnd, interrupts[7], 
      interrupts[6], interrupts[5], interrupts[4], interrupts[3], 
      interrupts[2], interrupts[1], interrupts[0], gnd, exccode[4], exccode[3], 
      exccode[2], exccode[1], exccode[0], gnd, gnd}), .en(activeexception), 
      .ph1(ph1), .ph2(ph2), .q(causereg[31:0]));
endmodule   /* cop0__causeregunit */

module wordlib__mux2_dp_1x_32(d0, d1, s, y);
  input [31:0] d0;
  input [31:0] d1;
  input s;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_27, net_29;

  muddlib07__invbuf_4x invbuf_4_0(.s(s), .s_out(net_29), .sb_out(net_27));
  muddlib07__mux2_dp_1x mux2_1x_dp_31_(.d0(d0[31]), .d1(d1[31]), .s(net_29), 
      .sb(net_27), .y(y[31]));
  muddlib07__mux2_dp_1x mux2_1x_dp_30_(.d0(d0[30]), .d1(d1[30]), .s(net_29), 
      .sb(net_27), .y(y[30]));
  muddlib07__mux2_dp_1x mux2_1x_dp_29_(.d0(d0[29]), .d1(d1[29]), .s(net_29), 
      .sb(net_27), .y(y[29]));
  muddlib07__mux2_dp_1x mux2_1x_dp_28_(.d0(d0[28]), .d1(d1[28]), .s(net_29), 
      .sb(net_27), .y(y[28]));
  muddlib07__mux2_dp_1x mux2_1x_dp_27_(.d0(d0[27]), .d1(d1[27]), .s(net_29), 
      .sb(net_27), .y(y[27]));
  muddlib07__mux2_dp_1x mux2_1x_dp_26_(.d0(d0[26]), .d1(d1[26]), .s(net_29), 
      .sb(net_27), .y(y[26]));
  muddlib07__mux2_dp_1x mux2_1x_dp_25_(.d0(d0[25]), .d1(d1[25]), .s(net_29), 
      .sb(net_27), .y(y[25]));
  muddlib07__mux2_dp_1x mux2_1x_dp_24_(.d0(d0[24]), .d1(d1[24]), .s(net_29), 
      .sb(net_27), .y(y[24]));
  muddlib07__mux2_dp_1x mux2_1x_dp_23_(.d0(d0[23]), .d1(d1[23]), .s(net_29), 
      .sb(net_27), .y(y[23]));
  muddlib07__mux2_dp_1x mux2_1x_dp_22_(.d0(d0[22]), .d1(d1[22]), .s(net_29), 
      .sb(net_27), .y(y[22]));
  muddlib07__mux2_dp_1x mux2_1x_dp_21_(.d0(d0[21]), .d1(d1[21]), .s(net_29), 
      .sb(net_27), .y(y[21]));
  muddlib07__mux2_dp_1x mux2_1x_dp_20_(.d0(d0[20]), .d1(d1[20]), .s(net_29), 
      .sb(net_27), .y(y[20]));
  muddlib07__mux2_dp_1x mux2_1x_dp_19_(.d0(d0[19]), .d1(d1[19]), .s(net_29), 
      .sb(net_27), .y(y[19]));
  muddlib07__mux2_dp_1x mux2_1x_dp_18_(.d0(d0[18]), .d1(d1[18]), .s(net_29), 
      .sb(net_27), .y(y[18]));
  muddlib07__mux2_dp_1x mux2_1x_dp_17_(.d0(d0[17]), .d1(d1[17]), .s(net_29), 
      .sb(net_27), .y(y[17]));
  muddlib07__mux2_dp_1x mux2_1x_dp_16_(.d0(d0[16]), .d1(d1[16]), .s(net_29), 
      .sb(net_27), .y(y[16]));
  muddlib07__mux2_dp_1x mux2_1x_dp_15_(.d0(d0[15]), .d1(d1[15]), .s(net_29), 
      .sb(net_27), .y(y[15]));
  muddlib07__mux2_dp_1x mux2_1x_dp_14_(.d0(d0[14]), .d1(d1[14]), .s(net_29), 
      .sb(net_27), .y(y[14]));
  muddlib07__mux2_dp_1x mux2_1x_dp_13_(.d0(d0[13]), .d1(d1[13]), .s(net_29), 
      .sb(net_27), .y(y[13]));
  muddlib07__mux2_dp_1x mux2_1x_dp_12_(.d0(d0[12]), .d1(d1[12]), .s(net_29), 
      .sb(net_27), .y(y[12]));
  muddlib07__mux2_dp_1x mux2_1x_dp_11_(.d0(d0[11]), .d1(d1[11]), .s(net_29), 
      .sb(net_27), .y(y[11]));
  muddlib07__mux2_dp_1x mux2_1x_dp_10_(.d0(d0[10]), .d1(d1[10]), .s(net_29), 
      .sb(net_27), .y(y[10]));
  muddlib07__mux2_dp_1x mux2_1x_dp_9_(.d0(d0[9]), .d1(d1[9]), .s(net_29), 
      .sb(net_27), .y(y[9]));
  muddlib07__mux2_dp_1x mux2_1x_dp_8_(.d0(d0[8]), .d1(d1[8]), .s(net_29), 
      .sb(net_27), .y(y[8]));
  muddlib07__mux2_dp_1x mux2_1x_dp_7_(.d0(d0[7]), .d1(d1[7]), .s(net_29), 
      .sb(net_27), .y(y[7]));
  muddlib07__mux2_dp_1x mux2_1x_dp_6_(.d0(d0[6]), .d1(d1[6]), .s(net_29), 
      .sb(net_27), .y(y[6]));
  muddlib07__mux2_dp_1x mux2_1x_dp_5_(.d0(d0[5]), .d1(d1[5]), .s(net_29), 
      .sb(net_27), .y(y[5]));
  muddlib07__mux2_dp_1x mux2_1x_dp_4_(.d0(d0[4]), .d1(d1[4]), .s(net_29), 
      .sb(net_27), .y(y[4]));
  muddlib07__mux2_dp_1x mux2_1x_dp_3_(.d0(d0[3]), .d1(d1[3]), .s(net_29), 
      .sb(net_27), .y(y[3]));
  muddlib07__mux2_dp_1x mux2_1x_dp_2_(.d0(d0[2]), .d1(d1[2]), .s(net_29), 
      .sb(net_27), .y(y[2]));
  muddlib07__mux2_dp_1x mux2_1x_dp_1_(.d0(d0[1]), .d1(d1[1]), .s(net_29), 
      .sb(net_27), .y(y[1]));
  muddlib07__mux2_dp_1x mux2_1x_dp_0_(.d0(d0[0]), .d1(d1[0]), .s(net_29), 
      .sb(net_27), .y(y[0]));
endmodule   /* wordlib__mux2_dp_1x_32 */

module wordlib__adder_32(a, b, cin, cout, s);
  input [31:0] a;
  input [31:0] b;
  input cin;
  output cout;
  output [31:0] s;

  supply1 vdd;
  supply0 gnd;
  wire [30:0] c;

  muddlib07__fulladder fa_31_(.a(a[31]), .b(b[31]), .c(c[30]), .cout(cout), 
      .s(s[31]));
  muddlib07__fulladder fa_30_(.a(a[30]), .b(b[30]), .c(c[29]), .cout(c[30]), 
      .s(s[30]));
  muddlib07__fulladder fa_29_(.a(a[29]), .b(b[29]), .c(c[28]), .cout(c[29]), 
      .s(s[29]));
  muddlib07__fulladder fa_28_(.a(a[28]), .b(b[28]), .c(c[27]), .cout(c[28]), 
      .s(s[28]));
  muddlib07__fulladder fa_27_(.a(a[27]), .b(b[27]), .c(c[26]), .cout(c[27]), 
      .s(s[27]));
  muddlib07__fulladder fa_26_(.a(a[26]), .b(b[26]), .c(c[25]), .cout(c[26]), 
      .s(s[26]));
  muddlib07__fulladder fa_25_(.a(a[25]), .b(b[25]), .c(c[24]), .cout(c[25]), 
      .s(s[25]));
  muddlib07__fulladder fa_24_(.a(a[24]), .b(b[24]), .c(c[23]), .cout(c[24]), 
      .s(s[24]));
  muddlib07__fulladder fa_23_(.a(a[23]), .b(b[23]), .c(c[22]), .cout(c[23]), 
      .s(s[23]));
  muddlib07__fulladder fa_22_(.a(a[22]), .b(b[22]), .c(c[21]), .cout(c[22]), 
      .s(s[22]));
  muddlib07__fulladder fa_21_(.a(a[21]), .b(b[21]), .c(c[20]), .cout(c[21]), 
      .s(s[21]));
  muddlib07__fulladder fa_20_(.a(a[20]), .b(b[20]), .c(c[19]), .cout(c[20]), 
      .s(s[20]));
  muddlib07__fulladder fa_19_(.a(a[19]), .b(b[19]), .c(c[18]), .cout(c[19]), 
      .s(s[19]));
  muddlib07__fulladder fa_18_(.a(a[18]), .b(b[18]), .c(c[17]), .cout(c[18]), 
      .s(s[18]));
  muddlib07__fulladder fa_17_(.a(a[17]), .b(b[17]), .c(c[16]), .cout(c[17]), 
      .s(s[17]));
  muddlib07__fulladder fa_16_(.a(a[16]), .b(b[16]), .c(c[15]), .cout(c[16]), 
      .s(s[16]));
  muddlib07__fulladder fa_15_(.a(a[15]), .b(b[15]), .c(c[14]), .cout(c[15]), 
      .s(s[15]));
  muddlib07__fulladder fa_14_(.a(a[14]), .b(b[14]), .c(c[13]), .cout(c[14]), 
      .s(s[14]));
  muddlib07__fulladder fa_13_(.a(a[13]), .b(b[13]), .c(c[12]), .cout(c[13]), 
      .s(s[13]));
  muddlib07__fulladder fa_12_(.a(a[12]), .b(b[12]), .c(c[11]), .cout(c[12]), 
      .s(s[12]));
  muddlib07__fulladder fa_11_(.a(a[11]), .b(b[11]), .c(c[10]), .cout(c[11]), 
      .s(s[11]));
  muddlib07__fulladder fa_10_(.a(a[10]), .b(b[10]), .c(c[9]), .cout(c[10]), 
      .s(s[10]));
  muddlib07__fulladder fa_9_(.a(a[9]), .b(b[9]), .c(c[8]), .cout(c[9]), 
      .s(s[9]));
  muddlib07__fulladder fa_8_(.a(a[8]), .b(b[8]), .c(c[7]), .cout(c[8]), 
      .s(s[8]));
  muddlib07__fulladder fa_7_(.a(a[7]), .b(b[7]), .c(c[6]), .cout(c[7]), 
      .s(s[7]));
  muddlib07__fulladder fa_6_(.a(a[6]), .b(b[6]), .c(c[5]), .cout(c[6]), 
      .s(s[6]));
  muddlib07__fulladder fa_5_(.a(a[5]), .b(b[5]), .c(c[4]), .cout(c[5]), 
      .s(s[5]));
  muddlib07__fulladder fa_4_(.a(a[4]), .b(b[4]), .c(c[3]), .cout(c[4]), 
      .s(s[4]));
  muddlib07__fulladder fa_3_(.a(a[3]), .b(b[3]), .c(c[2]), .cout(c[3]), 
      .s(s[3]));
  muddlib07__fulladder fa_2_(.a(a[2]), .b(b[2]), .c(c[1]), .cout(c[2]), 
      .s(s[2]));
  muddlib07__fulladder fa_1_(.a(a[1]), .b(b[1]), .c(c[0]), .cout(c[1]), 
      .s(s[1]));
  muddlib07__fulladder fa_0_(.a(a[0]), .b(b[0]), .c(cin), .cout(c[0]), 
      .s(s[0]));
endmodule   /* wordlib__adder_32 */

module cop0__epcunit(activeexception, bdsE, pcE, ph1, ph2, epc);
  input activeexception;
  input bdsE;
  input [31:0] pcE;
  input ph1;
  input ph2;
  output [31:0] epc;

  supply1 vdd;
  supply0 gnd;
  wire pcadd3_cout;
  wire [0:31] net_60;
  wire [0:31] net_62;

  wordlib__mux2_dp_1x_32 epcmux(.d0(pcE[31:0]), .d1({net_62[0], net_62[1], 
      net_62[2], net_62[3], net_62[4], net_62[5], net_62[6], net_62[7], 
      net_62[8], net_62[9], net_62[10], net_62[11], net_62[12], net_62[13], 
      net_62[14], net_62[15], net_62[16], net_62[17], net_62[18], net_62[19], 
      net_62[20], net_62[21], net_62[22], net_62[23], net_62[24], net_62[25], 
      net_62[26], net_62[27], net_62[28], net_62[29], net_62[30], net_62[31]}), 
      .s(bdsE), .y({net_60[0], net_60[1], net_60[2], net_60[3], net_60[4], 
      net_60[5], net_60[6], net_60[7], net_60[8], net_60[9], net_60[10], 
      net_60[11], net_60[12], net_60[13], net_60[14], net_60[15], net_60[16], 
      net_60[17], net_60[18], net_60[19], net_60[20], net_60[21], net_60[22], 
      net_60[23], net_60[24], net_60[25], net_60[26], net_60[27], net_60[28], 
      net_60[29], net_60[30], net_60[31]}));
  wordlib__flopen_32 epcreg(.d({net_60[0], net_60[1], net_60[2], net_60[3], 
      net_60[4], net_60[5], net_60[6], net_60[7], net_60[8], net_60[9], 
      net_60[10], net_60[11], net_60[12], net_60[13], net_60[14], net_60[15], 
      net_60[16], net_60[17], net_60[18], net_60[19], net_60[20], net_60[21], 
      net_60[22], net_60[23], net_60[24], net_60[25], net_60[26], net_60[27], 
      net_60[28], net_60[29], net_60[30], net_60[31]}), .en(activeexception), 
      .ph1(ph1), .ph2(ph2), .q(epc[31:0]));
  wordlib__adder_32 pcadd3(.a(pcE[31:0]), .b({vdd, vdd, vdd, vdd, vdd, vdd, 
      vdd, vdd, vdd, vdd, vdd, vdd, vdd, vdd, vdd, vdd, vdd, vdd, vdd, vdd, 
      vdd, vdd, vdd, vdd, vdd, vdd, vdd, vdd, vdd, vdd, gnd, gnd}), .cin(gnd), 
      .cout(pcadd3_cout), .s({net_62[0], net_62[1], net_62[2], net_62[3], 
      net_62[4], net_62[5], net_62[6], net_62[7], net_62[8], net_62[9], 
      net_62[10], net_62[11], net_62[12], net_62[13], net_62[14], net_62[15], 
      net_62[16], net_62[17], net_62[18], net_62[19], net_62[20], net_62[21], 
      net_62[22], net_62[23], net_62[24], net_62[25], net_62[26], net_62[27], 
      net_62[28], net_62[29], net_62[30], net_62[31]}));
endmodule   /* cop0__epcunit */

module muddlib07__a2o1_1x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_0, net_11, net_19;

  tranif1 nmos_0(gnd, net_19, a);
  tranif1 nmos_1(net_19, net_0, b);
  tranif1 nmos_2(gnd, net_0, c);
  tranif1 nmos_3(gnd, y, net_0);
  tranif0 pmos_0(net_0, net_11, c);
  tranif0 pmos_1(net_11, vdd, b);
  tranif0 pmos_2(net_11, vdd, a);
  tranif0 pmos_3(y, vdd, net_0);
endmodule   /* muddlib07__a2o1_1x */

module muddlib07__buf_1x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_23;

  tranif1 nmos_0(gnd, net_23, a);
  tranif1 nmos_1(gnd, y, net_23);
  tranif0 pmos_0(net_23, vdd, a);
  tranif0 pmos_1(y, vdd, net_23);
endmodule   /* muddlib07__buf_1x */

module muddlib07__or3_1x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_58, net_71, net_98;

  tranif1 nmos_8(gnd, net_58, c);
  tranif1 nmos_10(gnd, y, net_58);
  tranif1 nmos_11(gnd, net_58, b);
  tranif1 nmos_12(gnd, net_58, a);
  tranif0 pmos_2(net_58, net_71, c);
  tranif0 pmos_3(net_71, net_98, b);
  tranif0 pmos_4(y, vdd, net_58);
  tranif0 pmos_5(net_98, vdd, a);
endmodule   /* muddlib07__or3_1x */

module muddlib07__xor2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire ab, bb, net_3, net_4, net_7, net_8;

  tranif1 nmos_0(gnd, net_3, a);
  tranif1 nmos_1(gnd, net_4, ab);
  tranif1 nmos_2(net_3, y, b);
  tranif1 nmos_3(net_4, y, bb);
  tranif1 nmos_4(gnd, bb, b);
  tranif1 nmos_5(gnd, ab, a);
  tranif0 pmos_0(y, net_7, b);
  tranif0 pmos_1(net_7, vdd, ab);
  tranif0 pmos_2(y, net_8, bb);
  tranif0 pmos_3(net_8, vdd, a);
  tranif0 pmos_4(bb, vdd, b);
  tranif0 pmos_5(ab, vdd, a);
endmodule   /* muddlib07__xor2_1x */

module cop0__exccode(a, exccode);
  input [2:0] a;
  output [4:0] exccode;

  supply1 vdd;
  supply0 gnd;
  wire net_17, net_21, net_28, net_38, net_5, net_7;
  wire [2:0] ab;
  wire [2:0] abb;

  muddlib07__and2_1x and2_1x_0(.a(abb[2]), .b(abb[0]), .y(net_38));
  muddlib07__and2_1x and2_1x_1(.a(abb[2]), .b(abb[1]), .y(exccode[1]));
  muddlib07__buf_1x buf_1x_0(.a(gnd), .y(exccode[4]));
  muddlib07__invbuf_4x invbuf_4_0(.s(a[2]), .s_out(abb[2]), .sb_out(ab[2]));
  muddlib07__invbuf_4x invbuf_4_1(.s(a[1]), .s_out(abb[1]), .sb_out(ab[1]));
  muddlib07__invbuf_4x invbuf_4_2(.s(a[0]), .s_out(abb[0]), .sb_out(ab[0]));
  muddlib07__nand2_1x nand2_1x_0(.a(net_21), .b(net_17), .y(exccode[2]));
  muddlib07__nand2_1x nand2_1x_1(.a(net_28), .b(ab[2]), .y(exccode[3]));
  muddlib07__nor2_1x nor2_1x_0(.a(abb[2]), .b(net_7), .y(net_5));
  muddlib07__or2_1x or2_1x_0(.a(net_38), .b(net_5), .y(exccode[0]));
  muddlib07__or2_1x or2_1x_1(.a(abb[2]), .b(ab[0]), .y(net_17));
  muddlib07__or3_1x or3_1x_0(.a(abb[2]), .b(ab[1]), .c(abb[0]), .y(net_21));
  muddlib07__or3_1x or3_1x_1(.a(abb[2]), .b(abb[1]), .c(ab[0]), .y(net_28));
  muddlib07__xor2_1x xor2_1x_0(.a(abb[1]), .b(abb[0]), .y(net_7));
endmodule   /* cop0__exccode */

module muddlib07__nand4_1x(a, b, c, d, y);
  input a;
  input b;
  input c;
  input d;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_5, net_6, net_7;

  tranif1 nmos_0(net_5, net_7, b);
  tranif1 nmos_1(net_6, y, d);
  tranif1 nmos_2(gnd, net_5, a);
  tranif1 nmos_3(net_7, net_6, c);
  tranif0 pmos_0(y, vdd, a);
  tranif0 pmos_1(y, vdd, b);
  tranif0 pmos_2(y, vdd, c);
  tranif0 pmos_3(y, vdd, d);
endmodule   /* muddlib07__nand4_1x */

module muddlib07__nand2_2x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_5;

  tranif1 nmos_0(net_5, y, b);
  tranif1 nmos_1(gnd, net_5, a);
  tranif0 pmos_0(y, vdd, b);
  tranif0 pmos_1(y, vdd, a);
endmodule   /* muddlib07__nand2_2x */

module muddlib07__nand3_1_5x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_15, net_4;

  tranif1 nmos_0(net_15, net_4, b);
  tranif1 nmos_1(net_4, y, a);
  tranif1 nmos_2(gnd, net_15, c);
  tranif0 pmos_0(y, vdd, a);
  tranif0 pmos_1(y, vdd, b);
  tranif0 pmos_2(y, vdd, c);
endmodule   /* muddlib07__nand3_1_5x */

module muddlib07__nand4_1_5x(a, b, c, d, y);
  input a;
  input b;
  input c;
  input d;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_5, net_6, net_7;

  tranif1 nmos_0(net_5, net_7, b);
  tranif1 nmos_1(net_6, y, d);
  tranif1 nmos_2(gnd, net_5, a);
  tranif1 nmos_3(net_7, net_6, c);
  tranif0 pmos_0(y, vdd, a);
  tranif0 pmos_1(y, vdd, b);
  tranif0 pmos_2(y, vdd, c);
  tranif0 pmos_3(y, vdd, d);
endmodule   /* muddlib07__nand4_1_5x */

module cop0__prienc(a, priencout);
  input [7:0] a;
  output [2:0] priencout;

  supply1 vdd;
  supply0 gnd;
  wire net_101, net_108, net_121, net_194, net_21, net_26, net_66, net_67;
  wire net_88, net_94;

  muddlib07__and3_1x and3_1x_1(.a(net_88), .b(net_94), .c(net_101), 
      .y(net_121));
  muddlib07__and3_1x and3_1x_3(.a(net_88), .b(net_94), .c(net_101), 
      .y(net_67));
  muddlib07__and4_1x and4_1x_0(.a(net_88), .b(net_94), .c(net_101), 
      .d(net_108), .y(net_66));
  muddlib07__and4_1x and4_1x_1(.a(net_88), .b(net_94), .c(net_101), 
      .d(net_108), .y(priencout[2]));
  muddlib07__and4_1x and4_1x_2(.a(net_88), .b(net_94), .c(net_26), .d(net_21), 
      .y(priencout[1]));
  muddlib07__and4_1x and4_1x_3(.a(net_88), .b(net_101), .c(net_26), 
      .d(net_194), .y(priencout[0]));
  muddlib07__inv_4x inv_4x_0(.a(a[7]), .y(net_88));
  muddlib07__nand2_2x nand2_2x_0(.a(a[6]), .b(net_88), .y(net_94));
  muddlib07__nand3_1_5x nand3_1__0(.a(net_88), .b(net_94), .c(a[5]), 
      .y(net_101));
  muddlib07__nand3_1_5x nand3_1__2(.a(net_67), .b(net_108), .c(a[3]), 
      .y(net_26));
  muddlib07__nand4_1_5x nand4_1__0(.a(a[4]), .b(net_101), .c(net_94), 
      .d(net_88), .y(net_108));
  muddlib07__nand4_1_5x nand4_1__1(.a(a[2]), .b(net_26), .c(net_108), 
      .d(net_121), .y(net_21));
  muddlib07__nand4_1_5x nand4_1__2(.a(a[1]), .b(net_26), .c(net_21), 
      .d(net_66), .y(net_194));
endmodule   /* cop0__prienc */

module cop0__exceptionunit(adelableE, adelthrownE, adesableE, breakE, fpuE, 
      halfwordE, iec, im, interrupts, misalignedhE, misalignedwE, overflowE, 
      overflowableE, riE, syscallE, exccode, pendingexception);
  input adelableE;
  input adelthrownE;
  input adesableE;
  input breakE;
  input fpuE;
  input halfwordE;
  input iec;
  input [7:0] im;
  input [7:0] interrupts;
  input misalignedhE;
  input misalignedwE;
  input overflowE;
  input overflowableE;
  input riE;
  input syscallE;
  output [4:0] exccode;
  output pendingexception;

  supply1 vdd;
  supply0 gnd;
  wire adel, ades, iecb, interrupt, net_14, net_22, net_4, net_58, net_6;
  wire net_60, net_62, net_64, net_66, net_68, net_9, overflow;
  wire [2:0] priencout;
  wire [7:0] un2_interrupt;

  muddlib07__a2o1_1x a2o1_1x_0(.a(net_14), .b(misalignedwE), .c(misalignedhE), 
      .y(net_22));
  muddlib07__and2_1x and2_1x_0(.a(overflowE), .b(overflowableE), 
      .y(overflow));
  muddlib07__and2_1x and2_1x_1(.a(net_22), .b(adesableE), .y(ades));
  muddlib07__and2_1x and2_1x_2(.a(net_66), .b(net_68), .y(net_58));
  muddlib07__and2_1x and2_1x_3(.a(net_62), .b(net_64), .y(net_60));
  cop0__exccode exccode_2(.a(priencout[2:0]), .exccode(exccode[4:0]));
  muddlib07__inv_1x inv_1x_0(.a(iec), .y(iecb));
  muddlib07__inv_1x inv_1x_1(.a(halfwordE), .y(net_14));
  muddlib07__nand2_1x nand2_1x_0(.a(net_58), .b(net_60), 
      .y(pendingexception));
  muddlib07__nand4_1x nand4_1x_2(.a(un2_interrupt[4]), .b(un2_interrupt[5]), 
      .c(un2_interrupt[6]), .d(un2_interrupt[7]), .y(net_4));
  muddlib07__nand4_1x nand4_1x_3(.a(un2_interrupt[0]), .b(un2_interrupt[1]), 
      .c(un2_interrupt[2]), .d(un2_interrupt[3]), .y(net_6));
  muddlib07__nor2_1x nor2_1x_0(.a(net_4), .b(net_6), .y(net_9));
  muddlib07__nor2_1x nor2_1x_1(.a(iecb), .b(net_9), .y(interrupt));
  muddlib07__nor2_1x nor2_1x_2(.a(fpuE), .b(riE), .y(net_66));
  muddlib07__nor2_1x nor2_1x_3(.a(breakE), .b(syscallE), .y(net_68));
  muddlib07__nor2_1x nor2_1x_4(.a(ades), .b(adel), .y(net_62));
  muddlib07__nor2_1x overflow_nor2(.a(overflow), .b(interrupt), .y(net_64));
  cop0__prienc prienc_1(.a({interrupt, overflow, adel, ades, syscallE, breakE, 
      riE, fpuE}), .priencout(priencout[2:0]));
  muddlib07__a2o1_1x un1_adel_adel(.a(net_22), .b(adelableE), .c(adelthrownE), 
      .y(adel));
  muddlib07__nand2_1x un2_interrupt_7_(.a(im[7]), .b(interrupts[7]), 
      .y(un2_interrupt[7]));
  muddlib07__nand2_1x un2_interrupt_6_(.a(im[6]), .b(interrupts[6]), 
      .y(un2_interrupt[6]));
  muddlib07__nand2_1x un2_interrupt_5_(.a(im[5]), .b(interrupts[5]), 
      .y(un2_interrupt[5]));
  muddlib07__nand2_1x un2_interrupt_4_(.a(im[4]), .b(interrupts[4]), 
      .y(un2_interrupt[4]));
  muddlib07__nand2_1x un2_interrupt_3_(.a(im[3]), .b(interrupts[3]), 
      .y(un2_interrupt[3]));
  muddlib07__nand2_1x un2_interrupt_2_(.a(im[2]), .b(interrupts[2]), 
      .y(un2_interrupt[2]));
  muddlib07__nand2_1x un2_interrupt_1_(.a(im[1]), .b(interrupts[1]), 
      .y(un2_interrupt[1]));
  muddlib07__nand2_1x un2_interrupt_0_(.a(im[0]), .b(interrupts[0]), 
      .y(un2_interrupt[0]));
endmodule   /* cop0__exceptionunit */

module muddlib07__mux3_dp_1x(d0, d1, d2, s0, s0b, s1, s1b, y);
  input d0;
  input d1;
  input d2;
  input s0;
  input s0b;
  input s1;
  input s1b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_124, net_134, net_135, net_161, net_81, net_83, net_85, net_92;
  wire net_96;

  tranif1 nmos_8(net_92, net_83, s1);
  tranif1 nmos_9(gnd, y, net_83);
  tranif1 nmos_10(gnd, net_85, d0);
  tranif1 nmos_11(gnd, net_161, d1);
  tranif1 nmos_12(gnd, net_92, d2);
  tranif1 nmos_13(net_85, net_96, s0b);
  tranif1 nmos_14(net_161, net_96, s0);
  tranif1 nmos_15(net_96, net_83, s1b);
  tranif0 pmos_8(net_124, vdd, d2);
  tranif0 pmos_9(y, vdd, net_83);
  tranif0 pmos_10(net_83, net_81, s1);
  tranif0 pmos_11(net_83, net_124, s1b);
  tranif0 pmos_12(net_81, net_134, s0);
  tranif0 pmos_13(net_134, vdd, d0);
  tranif0 pmos_14(net_81, net_135, s0b);
  tranif0 pmos_15(net_135, vdd, d1);
endmodule   /* muddlib07__mux3_dp_1x */

module wordlib__mux3_dp_1x_32(d0, d1, d2, s0, s1, y);
  input [31:0] d0;
  input [31:0] d1;
  input [31:0] d2;
  input s0;
  input s1;
  output [31:0] y;

  supply1 vdd;
  supply0 gnd;
  wire net_42, net_48, net_49, net_53;

  muddlib07__invbuf_4x invbuf_4_0(.s(s0), .s_out(net_42), .sb_out(net_53));
  muddlib07__invbuf_4x invbuf_4_1(.s(s1), .s_out(net_48), .sb_out(net_49));
  muddlib07__mux3_dp_1x mux3_dp_1x_31_(.d0(d0[31]), .d1(d1[31]), .d2(d2[31]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[31]));
  muddlib07__mux3_dp_1x mux3_dp_1x_30_(.d0(d0[30]), .d1(d1[30]), .d2(d2[30]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[30]));
  muddlib07__mux3_dp_1x mux3_dp_1x_29_(.d0(d0[29]), .d1(d1[29]), .d2(d2[29]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[29]));
  muddlib07__mux3_dp_1x mux3_dp_1x_28_(.d0(d0[28]), .d1(d1[28]), .d2(d2[28]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[28]));
  muddlib07__mux3_dp_1x mux3_dp_1x_27_(.d0(d0[27]), .d1(d1[27]), .d2(d2[27]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[27]));
  muddlib07__mux3_dp_1x mux3_dp_1x_26_(.d0(d0[26]), .d1(d1[26]), .d2(d2[26]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[26]));
  muddlib07__mux3_dp_1x mux3_dp_1x_25_(.d0(d0[25]), .d1(d1[25]), .d2(d2[25]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[25]));
  muddlib07__mux3_dp_1x mux3_dp_1x_24_(.d0(d0[24]), .d1(d1[24]), .d2(d2[24]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[24]));
  muddlib07__mux3_dp_1x mux3_dp_1x_23_(.d0(d0[23]), .d1(d1[23]), .d2(d2[23]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[23]));
  muddlib07__mux3_dp_1x mux3_dp_1x_22_(.d0(d0[22]), .d1(d1[22]), .d2(d2[22]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[22]));
  muddlib07__mux3_dp_1x mux3_dp_1x_21_(.d0(d0[21]), .d1(d1[21]), .d2(d2[21]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[21]));
  muddlib07__mux3_dp_1x mux3_dp_1x_20_(.d0(d0[20]), .d1(d1[20]), .d2(d2[20]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[20]));
  muddlib07__mux3_dp_1x mux3_dp_1x_19_(.d0(d0[19]), .d1(d1[19]), .d2(d2[19]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[19]));
  muddlib07__mux3_dp_1x mux3_dp_1x_18_(.d0(d0[18]), .d1(d1[18]), .d2(d2[18]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[18]));
  muddlib07__mux3_dp_1x mux3_dp_1x_17_(.d0(d0[17]), .d1(d1[17]), .d2(d2[17]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[17]));
  muddlib07__mux3_dp_1x mux3_dp_1x_16_(.d0(d0[16]), .d1(d1[16]), .d2(d2[16]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[16]));
  muddlib07__mux3_dp_1x mux3_dp_1x_15_(.d0(d0[15]), .d1(d1[15]), .d2(d2[15]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[15]));
  muddlib07__mux3_dp_1x mux3_dp_1x_14_(.d0(d0[14]), .d1(d1[14]), .d2(d2[14]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[14]));
  muddlib07__mux3_dp_1x mux3_dp_1x_13_(.d0(d0[13]), .d1(d1[13]), .d2(d2[13]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[13]));
  muddlib07__mux3_dp_1x mux3_dp_1x_12_(.d0(d0[12]), .d1(d1[12]), .d2(d2[12]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[12]));
  muddlib07__mux3_dp_1x mux3_dp_1x_11_(.d0(d0[11]), .d1(d1[11]), .d2(d2[11]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[11]));
  muddlib07__mux3_dp_1x mux3_dp_1x_10_(.d0(d0[10]), .d1(d1[10]), .d2(d2[10]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[10]));
  muddlib07__mux3_dp_1x mux3_dp_1x_9_(.d0(d0[9]), .d1(d1[9]), .d2(d2[9]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[9]));
  muddlib07__mux3_dp_1x mux3_dp_1x_8_(.d0(d0[8]), .d1(d1[8]), .d2(d2[8]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[8]));
  muddlib07__mux3_dp_1x mux3_dp_1x_7_(.d0(d0[7]), .d1(d1[7]), .d2(d2[7]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[7]));
  muddlib07__mux3_dp_1x mux3_dp_1x_6_(.d0(d0[6]), .d1(d1[6]), .d2(d2[6]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[6]));
  muddlib07__mux3_dp_1x mux3_dp_1x_5_(.d0(d0[5]), .d1(d1[5]), .d2(d2[5]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[5]));
  muddlib07__mux3_dp_1x mux3_dp_1x_4_(.d0(d0[4]), .d1(d1[4]), .d2(d2[4]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[4]));
  muddlib07__mux3_dp_1x mux3_dp_1x_3_(.d0(d0[3]), .d1(d1[3]), .d2(d2[3]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[3]));
  muddlib07__mux3_dp_1x mux3_dp_1x_2_(.d0(d0[2]), .d1(d1[2]), .d2(d2[2]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[2]));
  muddlib07__mux3_dp_1x mux3_dp_1x_1_(.d0(d0[1]), .d1(d1[1]), .d2(d2[1]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[1]));
  muddlib07__mux3_dp_1x mux3_dp_1x_0_(.d0(d0[0]), .d1(d1[0]), .d2(d2[0]), 
      .s0(net_42), .s0b(net_53), .s1(net_48), .s1b(net_49), .y(y[0]));
endmodule   /* wordlib__mux3_dp_1x_32 */

module muddlib07__nor3_1x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_13, net_7;

  tranif1 nmos_0(gnd, y, a);
  tranif1 nmos_1(gnd, y, b);
  tranif1 nmos_2(gnd, y, c);
  tranif0 pmos_0(net_7, vdd, a);
  tranif0 pmos_1(net_13, net_7, b);
  tranif0 pmos_2(y, net_13, c);
endmodule   /* muddlib07__nor3_1x */

module muddlib07__flopenr_dp_1x(d, en, enb, resetb, q, ph1, ph1b, ph2, ph2b);
  input d;
  input en;
  input enb;
  input resetb;
  output q;
  input ph1;
  input ph1b;
  input ph2;
  input ph2b;

  supply1 vdd;
  supply0 gnd;
  wire master, masterinb, n1, n2, n3, n4, n5, n6, n7, n8, n9, slaveb;
  trireg masterb, slave;

  tranif1 nmos_2(masterinb, masterb, ph2);
  tranif1 nmos_3(gnd, master, masterb);
  rtranif1 nmos_4(master, slave, ph1);
  tranif1 nmos_5(n6, masterb, ph2b);
  tranif1 nmos_6(gnd, n6, master);
  tranif1 nmos_7(gnd, n8, slaveb);
  tranif1 nmos_8(gnd, slaveb, slave);
  tranif1 nmos_10(n8, slave, ph1b);
  tranif1 nmos_11(gnd, q, slaveb);
  tranif1 nmos_16(n1, n2, en);
  tranif1 nmos_17(gnd, n1, resetb);
  tranif1 nmos_18(n3, n1, enb);
  tranif1 nmos_19(n2, masterinb, d);
  tranif1 nmos_20(masterinb, n3, slave);
  tranif0 pmos_2(masterb, masterinb, ph2b);
  tranif0 pmos_3(master, vdd, masterb);
  rtranif0 pmos_4(slave, master, ph1b);
  tranif0 pmos_5(masterb, n7, ph2);
  tranif0 pmos_6(n7, vdd, master);
  tranif0 pmos_7(n9, vdd, slaveb);
  tranif0 pmos_8(slaveb, vdd, slave);
  tranif0 pmos_10(slave, n9, ph1);
  tranif0 pmos_11(q, vdd, slaveb);
  tranif0 pmos_16(masterinb, n4, d);
  tranif0 pmos_17(n4, vdd, enb);
  tranif0 pmos_18(masterinb, vdd, resetb);
  tranif0 pmos_19(n5, masterinb, slave);
  tranif0 pmos_20(vdd, n5, en);
endmodule   /* muddlib07__flopenr_dp_1x */

module muddlib07__flopen_c_1x(d, en, q, ph1, ph2);
  input d;
  input en;
  output q;
  input ph1;
  input ph2;

  supply1 vdd;
  supply0 gnd;
  wire enb, master, masterinb, n2, n3, n4, n5, n6, n7, n8, n9, ph1b, ph1buf;
  wire ph2b, ph2buf, slaveb;
  trireg masterb, slave;

  tranif1 nmos_2(masterinb, masterb, ph2buf);
  tranif1 nmos_3(gnd, master, masterb);
  rtranif1 nmos_4(master, slave, ph1buf);
  tranif1 nmos_5(n6, masterb, ph2b);
  tranif1 nmos_6(gnd, n6, master);
  tranif1 nmos_7(gnd, n8, slaveb);
  tranif1 nmos_8(gnd, slaveb, slave);
  tranif1 nmos_10(n8, slave, ph1b);
  tranif1 nmos_11(gnd, q, slaveb);
  tranif1 nmos_16(gnd, n2, en);
  tranif1 nmos_18(n3, gnd, enb);
  tranif1 nmos_19(n2, masterinb, d);
  tranif1 nmos_20(masterinb, n3, slave);
  tranif1 nmos_21(gnd, ph1b, ph1);
  tranif1 nmos_22(gnd, ph2b, ph2);
  tranif1 nmos_23(gnd, enb, en);
  tranif1 nmos_24(gnd, ph1buf, ph1b);
  tranif1 nmos_25(gnd, ph2buf, ph2b);
  tranif0 pmos_2(masterb, masterinb, ph2b);
  tranif0 pmos_3(master, vdd, masterb);
  rtranif0 pmos_4(slave, master, ph1b);
  tranif0 pmos_5(masterb, n7, ph2buf);
  tranif0 pmos_6(n7, vdd, master);
  tranif0 pmos_7(n9, vdd, slaveb);
  tranif0 pmos_8(slaveb, vdd, slave);
  tranif0 pmos_10(slave, n9, ph1buf);
  tranif0 pmos_11(q, vdd, slaveb);
  tranif0 pmos_16(masterinb, n4, d);
  tranif0 pmos_17(n4, vdd, enb);
  tranif0 pmos_19(n5, masterinb, slave);
  tranif0 pmos_20(vdd, n5, en);
  tranif0 pmos_21(ph1b, vdd, ph1);
  tranif0 pmos_22(ph2b, vdd, ph2);
  tranif0 pmos_23(enb, vdd, en);
  tranif0 pmos_24(ph1buf, vdd, ph1b);
  tranif0 pmos_25(ph2buf, vdd, ph2b);
endmodule   /* muddlib07__flopen_c_1x */

module cop0__statusregunit(activeexception, ph1, ph2, reset, rfeE, writedata, 
      writeenable, statusreg);
  input activeexception;
  input ph1;
  input ph2;
  input reset;
  input rfeE;
  input [31:0] writedata;
  input writeenable;
  output [31:0] statusreg;

  supply1 vdd;
  supply0 gnd;
  wire net_11, net_13, net_17, net_26, net_33, net_35, net_53, ph1buf, ph2buf;

  muddlib07__clkinvbufdual_4x clkinvbu_0(.ph1b(net_35), .ph1buf(ph1buf), 
      .ph2b(net_33), .ph2buf(ph2buf), .ph1(ph1), .ph2(ph2));
  muddlib07__or3_1x iecenable(.a(reset), .b(activeexception), .c(rfeE), 
      .y(net_13));
  muddlib07__or2_1x iecnew(.a(reset), .b(rfeE), .y(net_11));
  muddlib07__inv_4x inv_4x_0(.a(reset), .y(net_17));
  muddlib07__invbuf_4x invbuf_4_0(.s(writeenable), .s_out(net_26), 
      .sb_out(net_53));
  muddlib07__flopenr_dp_1x srhigh_30_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[31]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_29_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[30]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_28_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[29]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_27_(.d(writedata[28]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[28]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_26_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[27]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_25_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[26]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_24_(.d(writedata[25]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[25]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_23_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[24]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_22_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[23]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_21_(.d(writedata[22]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[22]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_20_(.d(writedata[21]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[21]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_19_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[20]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_18_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[19]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_17_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[18]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_16_(.d(writedata[17]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[17]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_15_(.d(writedata[16]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[16]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_14_(.d(writedata[15]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[15]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_13_(.d(writedata[14]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[14]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_12_(.d(writedata[13]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[13]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_11_(.d(writedata[12]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[12]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_10_(.d(writedata[11]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[11]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_9_(.d(writedata[10]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[10]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_8_(.d(writedata[9]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[9]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_7_(.d(writedata[8]), .en(net_26), 
      .enb(net_53), .resetb(net_17), .q(statusreg[8]), .ph1(ph1buf), 
      .ph1b(net_35), .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_6_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[7]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_5_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[6]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_4_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[5]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_3_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[4]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_2_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[3]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_1_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[2]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopenr_dp_1x srhigh_0_(.d(gnd), .en(net_26), .enb(net_53), 
      .resetb(net_17), .q(statusreg[1]), .ph1(ph1buf), .ph1b(net_35), 
      .ph2(ph2buf), .ph2b(net_33));
  muddlib07__flopen_c_1x srlo(.d(net_11), .en(net_13), .q(statusreg[0]), 
      .ph1(ph1buf), .ph2(ph2buf));
endmodule   /* cop0__statusregunit */

module cop0__coprocessor0(activeexception, adelableE, adelthrownE, adesableE, 
      bdsE, breakE, cop0writeW, fpuE, halfwordE, interrupts, misalignedhE, 
      misalignedwE, overflowE, overflowableE, pcE, ph1, ph2, readaddress, 
      reset, rfeE, riE, syscallE, writeaddress, writecop0W, cop0readdataE, isc, 
      pendingexception, re, swc);
  input activeexception;
  input adelableE;
  input adelthrownE;
  input adesableE;
  input bdsE;
  input breakE;
  input cop0writeW;
  input fpuE;
  input halfwordE;
  input [7:0] interrupts;
  input misalignedhE;
  input misalignedwE;
  input overflowE;
  input overflowableE;
  input [31:0] pcE;
  input ph1;
  input ph2;
  input [4:0] readaddress;
  input reset;
  input rfeE;
  input riE;
  input syscallE;
  input [4:0] writeaddress;
  input [31:0] writecop0W;
  output [31:0] cop0readdataE;
  output isc;
  output pendingexception;
  output re;
  output swc;

  supply1 vdd;
  supply0 gnd;
  wire iec, net_80, net_83, writeenable;
  wire [31:0] causereg;
  wire [31:0] epc;
  wire [4:0] exccode;
  wire [7:0] im;
  wire [7:1] statusreg;
  wire [24:18] statusreg_1;
  wire [31:26] statusreg_2;

  muddlib07__and2_1x and2_1x_0(.a(net_80), .b(net_83), .y(writeenable));
  muddlib07__and3_1x and3_1x_0(.a(cop0writeW), .b(writeaddress[2]), 
      .c(writeaddress[3]), .y(net_80));
  cop0__causeregunit causereg_0(.activeexception(activeexception), 
      .branchdelay(bdsE), .exccode(exccode[4:0]), .interrupts(interrupts[7:0]), 
      .ph1(ph1), .ph2(ph2), .causereg(causereg[31:0]));
  cop0__epcunit epcunit_0(.activeexception(activeexception), .bdsE(bdsE), 
      .pcE(pcE[31:0]), .ph1(ph1), .ph2(ph2), .epc(epc[31:0]));
  cop0__exceptionunit exceptio_0(.adelableE(adelableE), 
      .adelthrownE(adelthrownE), .adesableE(adesableE), .breakE(breakE), 
      .fpuE(fpuE), .halfwordE(halfwordE), .iec(iec), .im(im[7:0]), 
      .interrupts(interrupts[7:0]), .misalignedhE(misalignedhE), 
      .misalignedwE(misalignedwE), .overflowE(overflowE), 
      .overflowableE(overflowableE), .riE(riE), .syscallE(syscallE), 
      .exccode(exccode[4:0]), .pendingexception(pendingexception));
  wordlib__mux3_dp_1x_32 mux3_dp__0(.d0({statusreg_2[31], statusreg_2[30], 
      statusreg_2[29], statusreg_2[28], statusreg_2[27], statusreg_2[26], re, 
      statusreg_1[24], statusreg_1[23], statusreg_1[22], statusreg_1[21], 
      statusreg_1[20], statusreg_1[19], statusreg_1[18], swc, isc, im[7], 
      im[6], im[5], im[4], im[3], im[2], im[1], im[0], statusreg[7], 
      statusreg[6], statusreg[5], statusreg[4], statusreg[3], statusreg[2], 
      statusreg[1], iec}), .d1(causereg[31:0]), .d2(epc[31:0]), 
      .s0(readaddress[0]), .s1(readaddress[1]), .y(cop0readdataE[31:0]));
  muddlib07__nor3_1x nor3_1x_1(.a(writeaddress[4]), .b(writeaddress[1]), 
      .c(writeaddress[0]), .y(net_83));
  cop0__statusregunit statusre_0(.activeexception(activeexception), .ph1(ph1), 
      .ph2(ph2), .reset(reset), .rfeE(rfeE), .writedata(writecop0W[31:0]), 
      .writeenable(writeenable), .statusreg({statusreg_2[31], statusreg_2[30], 
      statusreg_2[29], statusreg_2[28], statusreg_2[27], statusreg_2[26], re, 
      statusreg_1[24], statusreg_1[23], statusreg_1[22], statusreg_1[21], 
      statusreg_1[20], statusreg_1[19], statusreg_1[18], swc, isc, im[7], 
      im[6], im[5], im[4], im[3], im[2], im[1], im[0], statusreg[7], 
      statusreg[6], statusreg[5], statusreg[4], statusreg[3], statusreg[2], 
      statusreg[1], iec}));
endmodule   /* cop0__coprocessor0 */

module new_controller__aluoutsrcD(cop0readD, hiloreadD, linkD, useshifterD, 
      aluoutsrcD);
  input cop0readD;
  input hiloreadD;
  input linkD;
  input useshifterD;
  output [1:0] aluoutsrcD;

  supply1 vdd;
  supply0 gnd;
  muddlib07__or3_1x or3_1x_0(.a(linkD), .b(cop0readD), .c(hiloreadD), 
      .y(aluoutsrcD[1]));
  muddlib07__or3_1x or3_1x_1(.a(useshifterD), .b(cop0readD), .c(hiloreadD), 
      .y(aluoutsrcD[0]));
endmodule   /* new_controller__aluoutsrcD */

module new_controller__alushpla(funct, functcontrol);
  input [5:0] funct;
  output [12:0] functcontrol;

  supply1 vdd;
  supply0 gnd;
  wire net_0, net_16, net_217, net_228, net_24, net_249, net_260, net_281;
  wire net_292, net_313, net_32, net_324, net_345, net_356, net_377, net_388;
  wire net_40, net_409, net_420, net_441, net_452, net_473, net_484, net_505;
  wire net_516, net_537, net_548, net_569, net_580, net_601, net_612, net_705;
  wire net_712, net_721, net_726, net_729, net_736, net_745, net_756, net_8;
  wire net_859, net_867, net_883, net_891, net_899;

  tranif1 nmos_4(gnd, net_0, funct[5]);
  tranif1 nmos_12(gnd, net_8, funct[4]);
  tranif1 nmos_20(gnd, net_16, funct[3]);
  tranif1 nmos_28(gnd, net_24, funct[2]);
  tranif1 nmos_36(gnd, net_32, funct[1]);
  tranif1 nmos_44(gnd, net_40, funct[0]);
  tranif1 nmos_50(net_217, gnd, funct[5]);
  tranif1 nmos_51(net_217, gnd, funct[4]);
  tranif1 nmos_52(net_217, gnd, net_16);
  tranif1 nmos_53(net_217, gnd, net_24);
  tranif1 nmos_54(net_217, gnd, funct[1]);
  tranif1 nmos_55(net_217, gnd, net_40);
  tranif1 nmos_56(gnd, net_228, funct[5]);
  tranif1 nmos_57(gnd, net_228, funct[4]);
  tranif1 nmos_58(gnd, net_228, net_16);
  tranif1 nmos_59(gnd, net_228, net_24);
  tranif1 nmos_60(gnd, net_228, funct[1]);
  tranif1 nmos_61(gnd, net_228, funct[0]);
  tranif1 nmos_62(net_249, gnd, funct[5]);
  tranif1 nmos_63(net_249, gnd, net_8);
  tranif1 nmos_64(net_249, gnd, net_16);
  tranif1 nmos_65(net_249, gnd, funct[2]);
  tranif1 nmos_66(net_249, gnd, net_32);
  tranif1 nmos_67(net_249, gnd, net_40);
  tranif1 nmos_68(gnd, net_260, funct[5]);
  tranif1 nmos_69(gnd, net_260, net_8);
  tranif1 nmos_70(gnd, net_260, net_16);
  tranif1 nmos_71(gnd, net_260, funct[2]);
  tranif1 nmos_72(gnd, net_260, net_32);
  tranif1 nmos_73(gnd, net_260, funct[0]);
  tranif1 nmos_74(net_281, gnd, funct[5]);
  tranif1 nmos_75(net_281, gnd, net_8);
  tranif1 nmos_76(net_281, gnd, net_16);
  tranif1 nmos_77(net_281, gnd, funct[2]);
  tranif1 nmos_78(net_281, gnd, funct[1]);
  tranif1 nmos_79(net_281, gnd, net_40);
  tranif1 nmos_80(gnd, net_292, funct[5]);
  tranif1 nmos_81(gnd, net_292, net_8);
  tranif1 nmos_82(gnd, net_292, net_16);
  tranif1 nmos_83(gnd, net_292, funct[2]);
  tranif1 nmos_84(gnd, net_292, funct[1]);
  tranif1 nmos_85(gnd, net_292, funct[0]);
  tranif1 nmos_86(net_313, gnd, funct[5]);
  tranif1 nmos_87(net_313, gnd, net_8);
  tranif1 nmos_88(net_313, gnd, funct[3]);
  tranif1 nmos_89(net_313, gnd, funct[2]);
  tranif1 nmos_90(net_313, gnd, net_32);
  tranif1 nmos_91(net_313, gnd, net_40);
  tranif1 nmos_92(gnd, net_324, funct[5]);
  tranif1 nmos_93(gnd, net_324, net_8);
  tranif1 nmos_94(gnd, net_324, funct[3]);
  tranif1 nmos_95(gnd, net_324, funct[2]);
  tranif1 nmos_96(gnd, net_324, net_32);
  tranif1 nmos_97(gnd, net_324, funct[0]);
  tranif1 nmos_98(net_345, gnd, funct[5]);
  tranif1 nmos_99(net_345, gnd, net_8);
  tranif1 nmos_100(net_345, gnd, funct[3]);
  tranif1 nmos_101(net_345, gnd, funct[2]);
  tranif1 nmos_102(net_345, gnd, funct[1]);
  tranif1 nmos_103(net_345, gnd, net_40);
  tranif1 nmos_104(gnd, net_356, funct[5]);
  tranif1 nmos_105(gnd, net_356, net_8);
  tranif1 nmos_106(gnd, net_356, funct[3]);
  tranif1 nmos_107(gnd, net_356, funct[2]);
  tranif1 nmos_108(gnd, net_356, funct[1]);
  tranif1 nmos_109(gnd, net_356, funct[0]);
  tranif1 nmos_110(net_377, gnd, funct[5]);
  tranif1 nmos_111(net_377, gnd, funct[4]);
  tranif1 nmos_112(net_377, gnd, funct[3]);
  tranif1 nmos_113(net_377, gnd, net_24);
  tranif1 nmos_114(net_377, gnd, net_32);
  tranif1 nmos_115(net_377, gnd, net_40);
  tranif1 nmos_116(gnd, net_388, funct[5]);
  tranif1 nmos_117(gnd, net_388, funct[4]);
  tranif1 nmos_118(gnd, net_388, funct[3]);
  tranif1 nmos_119(gnd, net_388, net_24);
  tranif1 nmos_120(gnd, net_388, net_32);
  tranif1 nmos_121(gnd, net_388, funct[0]);
  tranif1 nmos_122(net_409, gnd, funct[5]);
  tranif1 nmos_123(net_409, gnd, funct[4]);
  tranif1 nmos_124(net_409, gnd, funct[3]);
  tranif1 nmos_125(net_409, gnd, net_24);
  tranif1 nmos_126(net_409, gnd, funct[1]);
  tranif1 nmos_127(net_409, gnd, funct[0]);
  tranif1 nmos_128(gnd, net_420, funct[5]);
  tranif1 nmos_129(gnd, net_420, funct[4]);
  tranif1 nmos_130(gnd, net_420, funct[3]);
  tranif1 nmos_131(gnd, net_420, funct[2]);
  tranif1 nmos_132(gnd, net_420, net_32);
  tranif1 nmos_133(gnd, net_420, net_40);
  tranif1 nmos_134(net_441, gnd, funct[5]);
  tranif1 nmos_135(net_441, gnd, funct[4]);
  tranif1 nmos_136(net_441, gnd, funct[3]);
  tranif1 nmos_137(net_441, gnd, funct[2]);
  tranif1 nmos_138(net_441, gnd, net_32);
  tranif1 nmos_139(net_441, gnd, funct[0]);
  tranif1 nmos_140(gnd, net_452, funct[5]);
  tranif1 nmos_141(gnd, net_452, funct[4]);
  tranif1 nmos_142(gnd, net_452, funct[3]);
  tranif1 nmos_143(gnd, net_452, funct[2]);
  tranif1 nmos_144(gnd, net_452, funct[1]);
  tranif1 nmos_145(gnd, net_452, funct[0]);
  tranif1 nmos_146(net_473, gnd, net_0);
  tranif1 nmos_147(net_473, gnd, funct[4]);
  tranif1 nmos_148(net_473, gnd, net_16);
  tranif1 nmos_149(net_473, gnd, funct[2]);
  tranif1 nmos_150(net_473, gnd, net_32);
  tranif1 nmos_151(net_473, gnd, net_40);
  tranif1 nmos_152(gnd, net_484, net_0);
  tranif1 nmos_153(gnd, net_484, funct[4]);
  tranif1 nmos_154(gnd, net_484, net_16);
  tranif1 nmos_155(gnd, net_484, funct[2]);
  tranif1 nmos_156(gnd, net_484, net_32);
  tranif1 nmos_157(gnd, net_484, funct[0]);
  tranif1 nmos_158(net_505, gnd, net_0);
  tranif1 nmos_159(net_505, gnd, funct[4]);
  tranif1 nmos_160(net_505, gnd, funct[3]);
  tranif1 nmos_161(net_505, gnd, net_24);
  tranif1 nmos_162(net_505, gnd, net_32);
  tranif1 nmos_163(net_505, gnd, net_40);
  tranif1 nmos_164(gnd, net_516, net_0);
  tranif1 nmos_165(gnd, net_516, funct[4]);
  tranif1 nmos_166(gnd, net_516, funct[3]);
  tranif1 nmos_167(gnd, net_516, net_24);
  tranif1 nmos_168(gnd, net_516, net_32);
  tranif1 nmos_169(gnd, net_516, funct[0]);
  tranif1 nmos_170(net_537, gnd, net_0);
  tranif1 nmos_171(net_537, gnd, funct[4]);
  tranif1 nmos_172(net_537, gnd, funct[3]);
  tranif1 nmos_173(net_537, gnd, net_24);
  tranif1 nmos_174(net_537, gnd, funct[1]);
  tranif1 nmos_175(net_537, gnd, net_40);
  tranif1 nmos_176(gnd, net_548, net_0);
  tranif1 nmos_177(gnd, net_548, funct[4]);
  tranif1 nmos_178(gnd, net_548, funct[3]);
  tranif1 nmos_179(gnd, net_548, net_24);
  tranif1 nmos_180(gnd, net_548, funct[1]);
  tranif1 nmos_181(gnd, net_548, funct[0]);
  tranif1 nmos_182(net_569, gnd, net_0);
  tranif1 nmos_183(net_569, gnd, funct[4]);
  tranif1 nmos_184(net_569, gnd, funct[3]);
  tranif1 nmos_185(net_569, gnd, funct[2]);
  tranif1 nmos_186(net_569, gnd, net_32);
  tranif1 nmos_187(net_569, gnd, net_40);
  tranif1 nmos_188(gnd, net_580, net_0);
  tranif1 nmos_189(gnd, net_580, funct[4]);
  tranif1 nmos_190(gnd, net_580, funct[3]);
  tranif1 nmos_191(gnd, net_580, funct[2]);
  tranif1 nmos_192(gnd, net_580, net_32);
  tranif1 nmos_193(gnd, net_580, funct[0]);
  tranif1 nmos_194(net_601, gnd, net_0);
  tranif1 nmos_195(net_601, gnd, funct[4]);
  tranif1 nmos_196(net_601, gnd, funct[3]);
  tranif1 nmos_197(net_601, gnd, funct[2]);
  tranif1 nmos_198(net_601, gnd, funct[1]);
  tranif1 nmos_199(net_601, gnd, net_40);
  tranif1 nmos_200(gnd, net_612, net_0);
  tranif1 nmos_201(gnd, net_612, funct[4]);
  tranif1 nmos_202(gnd, net_612, funct[3]);
  tranif1 nmos_203(gnd, net_612, funct[2]);
  tranif1 nmos_204(gnd, net_612, funct[1]);
  tranif1 nmos_205(gnd, net_612, funct[0]);
  tranif1 nmos_362(gnd, net_867, net_217);
  tranif1 nmos_363(gnd, net_859, net_228);
  tranif1 nmos_364(gnd, net_721, net_249);
  tranif1 nmos_365(gnd, net_721, net_260);
  tranif1 nmos_366(gnd, net_745, net_260);
  tranif1 nmos_367(gnd, net_721, net_281);
  tranif1 nmos_368(gnd, net_756, net_281);
  tranif1 nmos_369(gnd, net_721, net_292);
  tranif1 nmos_370(gnd, net_745, net_292);
  tranif1 nmos_371(gnd, net_756, net_292);
  tranif1 nmos_372(gnd, net_899, net_313);
  tranif1 nmos_373(gnd, net_726, net_313);
  tranif1 nmos_374(gnd, net_712, net_324);
  tranif1 nmos_375(gnd, net_883, net_324);
  tranif1 nmos_376(gnd, net_891, net_345);
  tranif1 nmos_377(gnd, net_726, net_345);
  tranif1 nmos_378(gnd, net_712, net_356);
  tranif1 nmos_379(gnd, net_729, net_377);
  tranif1 nmos_380(gnd, net_756, net_377);
  tranif1 nmos_381(gnd, net_729, net_388);
  tranif1 nmos_382(gnd, net_729, net_409);
  tranif1 nmos_383(gnd, net_745, net_409);
  tranif1 nmos_384(gnd, net_729, net_420);
  tranif1 nmos_385(gnd, net_736, net_420);
  tranif1 nmos_386(gnd, net_756, net_420);
  tranif1 nmos_387(gnd, net_729, net_441);
  tranif1 nmos_388(gnd, net_736, net_441);
  tranif1 nmos_389(gnd, net_729, net_452);
  tranif1 nmos_390(gnd, net_736, net_452);
  tranif1 nmos_391(gnd, net_745, net_452);
  tranif1 nmos_392(gnd, net_745, net_473);
  tranif1 nmos_393(gnd, net_756, net_473);
  tranif1 nmos_394(gnd, net_736, net_484);
  tranif1 nmos_395(gnd, net_745, net_484);
  tranif1 nmos_396(gnd, net_756, net_484);
  tranif1 nmos_397(gnd, net_736, net_505);
  tranif1 nmos_398(gnd, net_756, net_505);
  tranif1 nmos_399(gnd, net_736, net_516);
  tranif1 nmos_400(gnd, net_756, net_537);
  tranif1 nmos_401(gnd, net_736, net_569);
  tranif1 nmos_402(gnd, net_745, net_569);
  tranif1 nmos_403(gnd, net_705, net_580);
  tranif1 nmos_404(gnd, net_736, net_580);
  tranif1 nmos_405(gnd, net_745, net_580);
  tranif1 nmos_406(gnd, net_745, net_601);
  tranif1 nmos_407(gnd, net_705, net_612);
  tranif1 nmos_408(gnd, net_745, net_612);
  tranif1 nmos_568(gnd, functcontrol[12], net_705);
  tranif1 nmos_576(gnd, functcontrol[11], net_859);
  tranif1 nmos_584(gnd, functcontrol[10], net_867);
  tranif1 nmos_592(gnd, functcontrol[9], net_712);
  tranif1 nmos_600(gnd, functcontrol[8], net_883);
  tranif1 nmos_608(gnd, functcontrol[7], net_891);
  tranif1 nmos_616(gnd, functcontrol[6], net_899);
  tranif1 nmos_624(gnd, functcontrol[5], net_721);
  tranif1 nmos_632(gnd, functcontrol[4], net_726);
  tranif1 nmos_640(gnd, functcontrol[3], net_729);
  tranif1 nmos_648(gnd, functcontrol[2], net_736);
  tranif1 nmos_656(gnd, functcontrol[1], net_745);
  tranif1 nmos_664(gnd, functcontrol[0], net_756);
  tranif0 pmos_5(net_0, vdd, funct[5]);
  tranif0 pmos_13(net_8, vdd, funct[4]);
  tranif0 pmos_21(net_16, vdd, funct[3]);
  tranif0 pmos_29(net_24, vdd, funct[2]);
  tranif0 pmos_37(net_32, vdd, funct[1]);
  tranif0 pmos_45(net_40, vdd, funct[0]);
  tranif0 pmos_569(functcontrol[12], vdd, net_705);
  tranif0 pmos_577(functcontrol[11], vdd, net_859);
  tranif0 pmos_585(functcontrol[10], vdd, net_867);
  tranif0 pmos_593(functcontrol[9], vdd, net_712);
  tranif0 pmos_601(functcontrol[8], vdd, net_883);
  tranif0 pmos_609(functcontrol[7], vdd, net_891);
  tranif0 pmos_617(functcontrol[6], vdd, net_899);
  tranif0 pmos_625(functcontrol[5], vdd, net_721);
  tranif0 pmos_633(functcontrol[4], vdd, net_726);
  tranif0 pmos_641(functcontrol[3], vdd, net_729);
  tranif0 pmos_649(functcontrol[2], vdd, net_736);
  tranif0 pmos_657(functcontrol[1], vdd, net_745);
  tranif0 pmos_665(functcontrol[0], vdd, net_756);
  rtranif0 pmos_670(net_705, vdd, gnd);
  rtranif0 pmos_672(net_859, vdd, gnd);
  rtranif0 pmos_674(net_867, vdd, gnd);
  rtranif0 pmos_676(net_712, vdd, gnd);
  rtranif0 pmos_678(net_883, vdd, gnd);
  rtranif0 pmos_680(net_891, vdd, gnd);
  rtranif0 pmos_682(net_899, vdd, gnd);
  rtranif0 pmos_684(net_721, vdd, gnd);
  rtranif0 pmos_686(net_726, vdd, gnd);
  rtranif0 pmos_688(net_729, vdd, gnd);
  rtranif0 pmos_690(net_736, vdd, gnd);
  rtranif0 pmos_692(net_745, vdd, gnd);
  rtranif0 pmos_694(net_756, vdd, gnd);
  rtranif0 pmos_698(vdd, net_612, gnd);
  rtranif0 pmos_700(vdd, net_601, gnd);
  rtranif0 pmos_702(vdd, net_580, gnd);
  rtranif0 pmos_704(vdd, net_569, gnd);
  rtranif0 pmos_706(vdd, net_548, gnd);
  rtranif0 pmos_708(vdd, net_537, gnd);
  rtranif0 pmos_710(vdd, net_516, gnd);
  rtranif0 pmos_712(vdd, net_505, gnd);
  rtranif0 pmos_714(vdd, net_484, gnd);
  rtranif0 pmos_716(vdd, net_473, gnd);
  rtranif0 pmos_718(vdd, net_452, gnd);
  rtranif0 pmos_720(vdd, net_441, gnd);
  rtranif0 pmos_722(vdd, net_420, gnd);
  rtranif0 pmos_724(vdd, net_409, gnd);
  rtranif0 pmos_726(vdd, net_388, gnd);
  rtranif0 pmos_728(vdd, net_377, gnd);
  rtranif0 pmos_730(vdd, net_356, gnd);
  rtranif0 pmos_732(vdd, net_345, gnd);
  rtranif0 pmos_734(vdd, net_324, gnd);
  rtranif0 pmos_736(vdd, net_313, gnd);
  rtranif0 pmos_738(vdd, net_292, gnd);
  rtranif0 pmos_740(vdd, net_281, gnd);
  rtranif0 pmos_742(vdd, net_260, gnd);
  rtranif0 pmos_744(vdd, net_249, gnd);
  rtranif0 pmos_746(vdd, net_228, gnd);
  rtranif0 pmos_748(vdd, net_217, gnd);
endmodule   /* new_controller__alushpla */

module new_controller__alushdec(alushmaincontrol, funct, maindecuseshifter, 
      rtype, alushcontrol, breakD, hilodisable, hiloread, hilosel, hilosrc, 
      mdstart, overflowable, syscallD, useshifter);
  input [2:0] alushmaincontrol;
  input [5:0] funct;
  input maindecuseshifter;
  input rtype;
  output [2:0] alushcontrol;
  output breakD;
  output [1:0] hilodisable;
  output hiloread;
  output hilosel;
  output hilosrc;
  output mdstart;
  output overflowable;
  output syscallD;
  output useshifter;

  supply1 vdd;
  supply0 gnd;
  wire [12:0] functcontrol;

  new_controller__alushpla alushpla_0(.funct(funct[5:0]), 
      .functcontrol(functcontrol[12:0]));
  muddlib07__and2_1x and2_8_(.a(rtype), .b(functcontrol[12]), 
      .y(overflowable));
  muddlib07__and2_1x and2_7_(.a(rtype), .b(functcontrol[11]), .y(syscallD));
  muddlib07__and2_1x and2_6_(.a(rtype), .b(functcontrol[10]), .y(breakD));
  muddlib07__and2_1x and2_5_(.a(rtype), .b(functcontrol[9]), .y(hiloread));
  muddlib07__and2_1x and2_4_(.a(rtype), .b(functcontrol[8]), .y(hilosel));
  muddlib07__and2_1x and2_3_(.a(rtype), .b(functcontrol[7]), 
      .y(hilodisable[1]));
  muddlib07__and2_1x and2_2_(.a(rtype), .b(functcontrol[6]), 
      .y(hilodisable[0]));
  muddlib07__and2_1x and2_1_(.a(rtype), .b(functcontrol[5]), .y(mdstart));
  muddlib07__and2_1x and2_0_(.a(rtype), .b(functcontrol[4]), .y(hilosrc));
  muddlib07__mux2_c_1x mux2_3_(.d0(maindecuseshifter), .d1(functcontrol[3]), 
      .s(rtype), .y(useshifter));
  muddlib07__mux2_c_1x mux2_2_(.d0(alushmaincontrol[2]), .d1(functcontrol[2]), 
      .s(rtype), .y(alushcontrol[2]));
  muddlib07__mux2_c_1x mux2_1_(.d0(alushmaincontrol[1]), .d1(functcontrol[1]), 
      .s(rtype), .y(alushcontrol[1]));
  muddlib07__mux2_c_1x mux2_0_(.d0(alushmaincontrol[0]), .d1(functcontrol[0]), 
      .s(rtype), .y(alushcontrol[0]));
endmodule   /* new_controller__alushdec */

module new_controller__branchcontroller(aeqb, aeqz, agtz, altz, branch, eq, gt, 
      jump, link, lt, pendingexception, reset, src, jumpreg, pcbranchsrc, 
      pcsrc, rdsrc);
  input aeqb;
  input aeqz;
  input agtz;
  input altz;
  input branch;
  input eq;
  input gt;
  input jump;
  input link;
  input lt;
  input pendingexception;
  input reset;
  input src;
  output jumpreg;
  output [1:0] pcbranchsrc;
  output [1:0] pcsrc;
  output rdsrc;

  supply1 vdd;
  supply0 gnd;
  wire abcompare, aeqzn, agtzn, altzn, azcompare, net_280, net_281, net_284;
  wire net_292, net_298, net_300, net_334;

  muddlib07__nand2_1x aeqznand(.a(aeqz), .b(eq), .y(aeqzn));
  muddlib07__nand2_1x agtznand(.a(agtz), .b(gt), .y(agtzn));
  muddlib07__nand2_1x altznand(.a(altz), .b(lt), .y(altzn));
  muddlib07__and2_1x and2_1x_0(.a(jump), .b(src), .y(pcbranchsrc[1]));
  muddlib07__and2_1x and2_1x_1(.a(branch), .b(net_280), .y(net_281));
  muddlib07__buf_1x buf_1x_0(.a(pcbranchsrc[1]), .y(jumpreg));
  muddlib07__inv_1x inv_1x_1(.a(link), .y(net_300));
  muddlib07__inv_1x inv_1x_2(.a(jump), .y(net_292));
  muddlib07__mux2_c_1x mux2_c_1_0(.d0(azcompare), .d1(abcompare), .s(src), 
      .y(net_280));
  muddlib07__nand4_1x nand4_1x_0(.a(net_334), .b(aeqzn), .c(agtzn), .d(altzn), 
      .y(azcompare));
  muddlib07__nor2_1x nor2_1x_1(.a(reset), .b(pendingexception), .y(pcsrc[1]));
  muddlib07__nor2_1x nor2_1x_2(.a(reset), .b(net_284), .y(pcsrc[0]));
  muddlib07__nor2_1x nor2_1x_3(.a(net_300), .b(net_298), .y(rdsrc));
  muddlib07__nor2_1x nor2_1x_4(.a(branch), .b(pcbranchsrc[0]), .y(net_298));
  muddlib07__nor2_1x nor2_1x_5(.a(net_292), .b(src), .y(pcbranchsrc[0]));
  muddlib07__nor3_1x nor3_1x_2(.a(pendingexception), .b(jump), .c(net_281), 
      .y(net_284));
  muddlib07__or3_1x or3_1x_0(.a(eq), .b(lt), .c(gt), .y(net_334));
  muddlib07__xnor2_1x xnor2_1x_0(.a(aeqb), .b(eq), .y(abcompare));
endmodule   /* new_controller__branchcontroller */

module new_controller__branchdecpla(_input, _input_1, _input_10, _input_11, 
      _input_12, _input_13, _input_14, _input_15, _input_16, _input_2, 
      _input_3, _input_4, _input_5, _input_6, _input_7, _input_8, _input_9, 
      controls, controls_1, controls_2, controls_3, controls_4, controls_5, 
      controls_6);
  input [0:0] _input;
  input [1:1] _input_1;
  input [10:10] _input_10;
  input [11:11] _input_11;
  input [12:12] _input_12;
  input [13:13] _input_13;
  input [14:14] _input_14;
  input [15:15] _input_15;
  input [16:16] _input_16;
  input [2:2] _input_2;
  input [3:3] _input_3;
  input [4:4] _input_4;
  input [5:5] _input_5;
  input [6:6] _input_6;
  input [7:7] _input_7;
  input [8:8] _input_8;
  input [9:9] _input_9;
  output [0:0] controls;
  output [1:1] controls_1;
  output [2:2] controls_2;
  output [3:3] controls_3;
  output [4:4] controls_4;
  output [5:5] controls_5;
  output [6:6] controls_6;

  supply1 vdd;
  supply0 gnd;
  wire net_1047, net_1048, net_1049, net_1050, net_1051, net_1052, net_1053;
  wire net_1054, net_1055, net_1056, net_128, net_24, net_287, net_298, net_319;
  wire net_32, net_330, net_351, net_362, net_398, net_40, net_414, net_455;
  wire net_471, net_502, net_519, net_564, net_575, net_64, net_670, net_675;
  wire net_684, net_693, net_702, net_711, net_716, net_88, net_96;

  tranif1 nmos_4(gnd, net_1056, _input_16[16]);
  tranif1 nmos_12(gnd, net_1047, _input_15[15]);
  tranif1 nmos_20(gnd, net_1048, _input_14[14]);
  tranif1 nmos_28(gnd, net_24, _input_13[13]);
  tranif1 nmos_36(gnd, net_32, _input_12[12]);
  tranif1 nmos_44(gnd, net_40, _input_11[11]);
  tranif1 nmos_52(gnd, net_1049, _input_10[10]);
  tranif1 nmos_60(gnd, net_1050, _input_9[9]);
  tranif1 nmos_68(gnd, net_64, _input_8[8]);
  tranif1 nmos_76(gnd, net_1051, _input_7[7]);
  tranif1 nmos_84(gnd, net_1052, _input_6[6]);
  tranif1 nmos_92(gnd, net_88, _input_5[5]);
  tranif1 nmos_100(gnd, net_96, _input_4[4]);
  tranif1 nmos_108(gnd, net_1053, _input_3[3]);
  tranif1 nmos_116(gnd, net_1054, _input_2[2]);
  tranif1 nmos_124(gnd, net_1055, _input_1[1]);
  tranif1 nmos_132(gnd, net_128, _input[0]);
  tranif1 nmos_138(net_287, gnd, _input_16[16]);
  tranif1 nmos_139(net_287, gnd, _input_15[15]);
  tranif1 nmos_140(net_287, gnd, _input_14[14]);
  tranif1 nmos_141(net_287, gnd, net_24);
  tranif1 nmos_142(net_287, gnd, net_32);
  tranif1 nmos_143(net_287, gnd, net_40);
  tranif1 nmos_144(gnd, net_298, _input_16[16]);
  tranif1 nmos_145(gnd, net_298, _input_15[15]);
  tranif1 nmos_146(gnd, net_298, _input_14[14]);
  tranif1 nmos_147(gnd, net_298, net_24);
  tranif1 nmos_148(gnd, net_298, net_32);
  tranif1 nmos_149(gnd, net_298, _input_11[11]);
  tranif1 nmos_150(net_319, gnd, _input_16[16]);
  tranif1 nmos_151(net_319, gnd, _input_15[15]);
  tranif1 nmos_152(net_319, gnd, _input_14[14]);
  tranif1 nmos_153(net_319, gnd, net_24);
  tranif1 nmos_154(net_319, gnd, _input_12[12]);
  tranif1 nmos_155(net_319, gnd, net_40);
  tranif1 nmos_156(gnd, net_330, _input_16[16]);
  tranif1 nmos_157(gnd, net_330, _input_15[15]);
  tranif1 nmos_158(gnd, net_330, _input_14[14]);
  tranif1 nmos_159(gnd, net_330, net_24);
  tranif1 nmos_160(gnd, net_330, _input_12[12]);
  tranif1 nmos_161(gnd, net_330, _input_11[11]);
  tranif1 nmos_162(net_351, gnd, _input_16[16]);
  tranif1 nmos_163(net_351, gnd, _input_15[15]);
  tranif1 nmos_164(net_351, gnd, _input_14[14]);
  tranif1 nmos_165(net_351, gnd, _input_13[13]);
  tranif1 nmos_166(net_351, gnd, _input_12[12]);
  tranif1 nmos_167(net_351, gnd, net_40);
  tranif1 nmos_168(gnd, net_362, _input_16[16]);
  tranif1 nmos_169(gnd, net_362, _input_15[15]);
  tranif1 nmos_170(gnd, net_362, _input_14[14]);
  tranif1 nmos_171(gnd, net_362, _input_13[13]);
  tranif1 nmos_172(gnd, net_362, _input_12[12]);
  tranif1 nmos_173(gnd, net_362, net_40);
  tranif1 nmos_174(gnd, net_362, net_96);
  tranif1 nmos_175(gnd, net_362, _input_3[3]);
  tranif1 nmos_176(gnd, net_362, _input_2[2]);
  tranif1 nmos_177(gnd, net_362, _input_1[1]);
  tranif1 nmos_178(gnd, net_362, net_128);
  tranif1 nmos_179(net_398, gnd, _input_16[16]);
  tranif1 nmos_180(net_398, gnd, _input_15[15]);
  tranif1 nmos_181(net_398, gnd, _input_14[14]);
  tranif1 nmos_182(net_398, gnd, _input_13[13]);
  tranif1 nmos_183(net_398, gnd, _input_12[12]);
  tranif1 nmos_184(net_398, gnd, net_40);
  tranif1 nmos_185(net_398, gnd, net_96);
  tranif1 nmos_186(net_398, gnd, _input_3[3]);
  tranif1 nmos_187(net_398, gnd, _input_2[2]);
  tranif1 nmos_188(net_398, gnd, _input_1[1]);
  tranif1 nmos_189(net_398, gnd, _input[0]);
  tranif1 nmos_190(gnd, net_414, _input_16[16]);
  tranif1 nmos_191(gnd, net_414, _input_15[15]);
  tranif1 nmos_192(gnd, net_414, _input_14[14]);
  tranif1 nmos_193(gnd, net_414, _input_13[13]);
  tranif1 nmos_194(gnd, net_414, _input_12[12]);
  tranif1 nmos_195(gnd, net_414, net_40);
  tranif1 nmos_196(gnd, net_414, _input_4[4]);
  tranif1 nmos_197(gnd, net_414, _input_3[3]);
  tranif1 nmos_198(gnd, net_414, _input_2[2]);
  tranif1 nmos_199(gnd, net_414, _input_1[1]);
  tranif1 nmos_200(gnd, net_414, net_128);
  tranif1 nmos_201(net_455, gnd, _input_16[16]);
  tranif1 nmos_202(net_455, gnd, _input_15[15]);
  tranif1 nmos_203(net_455, gnd, _input_14[14]);
  tranif1 nmos_204(net_455, gnd, _input_13[13]);
  tranif1 nmos_205(net_455, gnd, _input_12[12]);
  tranif1 nmos_206(net_455, gnd, net_40);
  tranif1 nmos_207(net_455, gnd, _input_4[4]);
  tranif1 nmos_208(net_455, gnd, _input_3[3]);
  tranif1 nmos_209(net_455, gnd, _input_2[2]);
  tranif1 nmos_210(net_455, gnd, _input_1[1]);
  tranif1 nmos_211(net_455, gnd, _input[0]);
  tranif1 nmos_212(gnd, net_471, _input_16[16]);
  tranif1 nmos_213(gnd, net_471, _input_15[15]);
  tranif1 nmos_214(gnd, net_471, _input_14[14]);
  tranif1 nmos_215(gnd, net_471, _input_13[13]);
  tranif1 nmos_216(gnd, net_471, _input_12[12]);
  tranif1 nmos_217(gnd, net_471, _input_11[11]);
  tranif1 nmos_218(net_502, gnd, _input_16[16]);
  tranif1 nmos_219(net_502, gnd, _input_15[15]);
  tranif1 nmos_220(net_502, gnd, _input_14[14]);
  tranif1 nmos_221(net_502, gnd, _input_13[13]);
  tranif1 nmos_222(net_502, gnd, _input_12[12]);
  tranif1 nmos_223(net_502, gnd, _input_11[11]);
  tranif1 nmos_224(net_502, gnd, _input_10[10]);
  tranif1 nmos_225(net_502, gnd, _input_9[9]);
  tranif1 nmos_226(net_502, gnd, net_64);
  tranif1 nmos_227(net_502, gnd, _input_7[7]);
  tranif1 nmos_228(net_502, gnd, _input_6[6]);
  tranif1 nmos_229(net_502, gnd, net_88);
  tranif1 nmos_230(gnd, net_519, _input_16[16]);
  tranif1 nmos_231(gnd, net_519, _input_15[15]);
  tranif1 nmos_232(gnd, net_519, _input_14[14]);
  tranif1 nmos_233(gnd, net_519, _input_13[13]);
  tranif1 nmos_234(gnd, net_519, _input_12[12]);
  tranif1 nmos_235(gnd, net_519, _input_11[11]);
  tranif1 nmos_236(gnd, net_519, _input_10[10]);
  tranif1 nmos_237(gnd, net_519, _input_9[9]);
  tranif1 nmos_238(gnd, net_519, net_64);
  tranif1 nmos_239(gnd, net_519, _input_7[7]);
  tranif1 nmos_240(gnd, net_519, _input_6[6]);
  tranif1 nmos_241(gnd, net_519, _input_5[5]);
  tranif1 nmos_242(net_564, gnd, _input_16[16]);
  tranif1 nmos_243(net_564, gnd, _input_15[15]);
  tranif1 nmos_244(net_564, gnd, _input_14[14]);
  tranif1 nmos_245(net_564, gnd, _input_13[13]);
  tranif1 nmos_246(net_564, gnd, net_32);
  tranif1 nmos_247(net_564, gnd, net_40);
  tranif1 nmos_248(gnd, net_575, _input_16[16]);
  tranif1 nmos_249(gnd, net_575, _input_15[15]);
  tranif1 nmos_250(gnd, net_575, _input_14[14]);
  tranif1 nmos_251(gnd, net_575, _input_13[13]);
  tranif1 nmos_252(gnd, net_575, net_32);
  tranif1 nmos_253(gnd, net_575, _input_11[11]);
  tranif1 nmos_376(gnd, net_675, net_287);
  tranif1 nmos_377(gnd, net_693, net_287);
  tranif1 nmos_378(gnd, net_675, net_298);
  tranif1 nmos_379(gnd, net_684, net_298);
  tranif1 nmos_380(gnd, net_702, net_298);
  tranif1 nmos_381(gnd, net_675, net_319);
  tranif1 nmos_382(gnd, net_684, net_319);
  tranif1 nmos_383(gnd, net_693, net_319);
  tranif1 nmos_384(gnd, net_711, net_319);
  tranif1 nmos_385(gnd, net_675, net_330);
  tranif1 nmos_386(gnd, net_702, net_330);
  tranif1 nmos_387(gnd, net_711, net_330);
  tranif1 nmos_388(gnd, net_675, net_362);
  tranif1 nmos_389(gnd, net_693, net_362);
  tranif1 nmos_390(gnd, net_702, net_362);
  tranif1 nmos_391(gnd, net_716, net_362);
  tranif1 nmos_392(gnd, net_675, net_398);
  tranif1 nmos_393(gnd, net_684, net_398);
  tranif1 nmos_394(gnd, net_716, net_398);
  tranif1 nmos_395(gnd, net_675, net_414);
  tranif1 nmos_396(gnd, net_693, net_414);
  tranif1 nmos_397(gnd, net_702, net_414);
  tranif1 nmos_398(gnd, net_675, net_455);
  tranif1 nmos_399(gnd, net_684, net_455);
  tranif1 nmos_400(gnd, net_670, net_502);
  tranif1 nmos_401(gnd, net_684, net_502);
  tranif1 nmos_402(gnd, net_693, net_502);
  tranif1 nmos_403(gnd, net_702, net_502);
  tranif1 nmos_404(gnd, net_711, net_502);
  tranif1 nmos_405(gnd, net_716, net_502);
  tranif1 nmos_406(gnd, net_670, net_519);
  tranif1 nmos_407(gnd, net_684, net_519);
  tranif1 nmos_408(gnd, net_693, net_519);
  tranif1 nmos_409(gnd, net_702, net_519);
  tranif1 nmos_410(gnd, net_711, net_519);
  tranif1 nmos_411(gnd, net_670, net_564);
  tranif1 nmos_412(gnd, net_684, net_564);
  tranif1 nmos_413(gnd, net_693, net_564);
  tranif1 nmos_414(gnd, net_702, net_564);
  tranif1 nmos_415(gnd, net_716, net_564);
  tranif1 nmos_416(gnd, net_670, net_575);
  tranif1 nmos_417(gnd, net_684, net_575);
  tranif1 nmos_418(gnd, net_693, net_575);
  tranif1 nmos_419(gnd, net_702, net_575);
  tranif1 nmos_458(gnd, controls_6[6], net_670);
  tranif1 nmos_466(gnd, controls_5[5], net_675);
  tranif1 nmos_474(gnd, controls_4[4], net_684);
  tranif1 nmos_482(gnd, controls_3[3], net_693);
  tranif1 nmos_490(gnd, controls_2[2], net_702);
  tranif1 nmos_498(gnd, controls_1[1], net_711);
  tranif1 nmos_506(gnd, controls[0], net_716);
  tranif0 pmos_5(net_1056, vdd, _input_16[16]);
  tranif0 pmos_13(net_1047, vdd, _input_15[15]);
  tranif0 pmos_21(net_1048, vdd, _input_14[14]);
  tranif0 pmos_29(net_24, vdd, _input_13[13]);
  tranif0 pmos_37(net_32, vdd, _input_12[12]);
  tranif0 pmos_45(net_40, vdd, _input_11[11]);
  tranif0 pmos_53(net_1049, vdd, _input_10[10]);
  tranif0 pmos_61(net_1050, vdd, _input_9[9]);
  tranif0 pmos_69(net_64, vdd, _input_8[8]);
  tranif0 pmos_77(net_1051, vdd, _input_7[7]);
  tranif0 pmos_85(net_1052, vdd, _input_6[6]);
  tranif0 pmos_93(net_88, vdd, _input_5[5]);
  tranif0 pmos_101(net_96, vdd, _input_4[4]);
  tranif0 pmos_109(net_1053, vdd, _input_3[3]);
  tranif0 pmos_117(net_1054, vdd, _input_2[2]);
  tranif0 pmos_125(net_1055, vdd, _input_1[1]);
  tranif0 pmos_133(net_128, vdd, _input[0]);
  tranif0 pmos_459(controls_6[6], vdd, net_670);
  tranif0 pmos_467(controls_5[5], vdd, net_675);
  tranif0 pmos_475(controls_4[4], vdd, net_684);
  tranif0 pmos_483(controls_3[3], vdd, net_693);
  tranif0 pmos_491(controls_2[2], vdd, net_702);
  tranif0 pmos_499(controls_1[1], vdd, net_711);
  tranif0 pmos_507(controls[0], vdd, net_716);
  rtranif0 pmos_512(net_670, vdd, gnd);
  rtranif0 pmos_514(net_675, vdd, gnd);
  rtranif0 pmos_516(net_684, vdd, gnd);
  rtranif0 pmos_518(net_693, vdd, gnd);
  rtranif0 pmos_520(net_702, vdd, gnd);
  rtranif0 pmos_522(net_711, vdd, gnd);
  rtranif0 pmos_524(net_716, vdd, gnd);
  rtranif0 pmos_528(vdd, net_575, gnd);
  rtranif0 pmos_530(vdd, net_564, gnd);
  rtranif0 pmos_532(vdd, net_519, gnd);
  rtranif0 pmos_534(vdd, net_502, gnd);
  rtranif0 pmos_536(vdd, net_471, gnd);
  rtranif0 pmos_538(vdd, net_455, gnd);
  rtranif0 pmos_540(vdd, net_414, gnd);
  rtranif0 pmos_542(vdd, net_398, gnd);
  rtranif0 pmos_544(vdd, net_362, gnd);
  rtranif0 pmos_546(vdd, net_351, gnd);
  rtranif0 pmos_548(vdd, net_330, gnd);
  rtranif0 pmos_550(vdd, net_319, gnd);
  rtranif0 pmos_552(vdd, net_298, gnd);
  rtranif0 pmos_554(vdd, net_287, gnd);
endmodule   /* new_controller__branchdecpla */

module new_controller__branchdec(funct, op, rt, branch, eq, gt, jump, link, lt, 
      src);
  input [5:0] funct;
  input [5:0] op;
  input [4:0] rt;
  output branch;
  output eq;
  output gt;
  output jump;
  output link;
  output lt;
  output src;

  supply1 vdd;
  supply0 gnd;
  new_controller__branchdecpla branchde_1(._input(rt[0:0]), ._input_1(rt[1:1]), 
      ._input_10(funct[5:5]), ._input_11(op[0:0]), ._input_12(op[1:1]), 
      ._input_13(op[2:2]), ._input_14(op[3:3]), ._input_15(op[4:4]), 
      ._input_16(op[5:5]), ._input_2(rt[2:2]), ._input_3(rt[3:3]), 
      ._input_4(rt[4:4]), ._input_5(funct[0:0]), ._input_6(funct[1:1]), 
      ._input_7(funct[2:2]), ._input_8(funct[3:3]), ._input_9(funct[4:4]), 
      .controls({link}), .controls_1({src}), .controls_2({eq}), 
      .controls_3({gt}), .controls_4({lt}), .controls_5({branch}), 
      .controls_6({jump}));
endmodule   /* new_controller__branchdec */

module muddlib07__inv_3x(a, y);
  input a;
  output y;

  supply1 vdd;
  supply0 gnd;
  tranif1 nmos_0(gnd, y, a);
  tranif0 pmos_0(y, vdd, a);
endmodule   /* muddlib07__inv_3x */

module new_controller__cop0dec(cop0op, funct, rs, cop0read, cop0write, rfe);
  input cop0op;
  input [5:0] funct;
  input [4:0] rs;
  output cop0read;
  output cop0write;
  output rfe;

  supply1 vdd;
  supply0 gnd;
  wire cop0opb, net_14, net_2, net_24, net_35, net_39, net_46, net_47, net_48;
  wire net_49, net_51, rs1nor0, rs4nor3;

  muddlib07__inv_1x inv_1x_0(.a(rs[2]), .y(net_2));
  muddlib07__inv_1x inv_1x_1(.a(funct[4]), .y(net_39));
  muddlib07__inv_3x inv_3x_0(.a(cop0op), .y(cop0opb));
  muddlib07__nand3_1x nand3_1x_1(.a(rs4nor3), .b(net_2), .c(rs1nor0), 
      .y(net_14));
  muddlib07__nand3_1x nand3_1x_3(.a(rs4nor3), .b(rs[2]), .c(rs1nor0), 
      .y(net_24));
  muddlib07__nand3_1x nand3_1x_4(.a(net_47), .b(net_46), .c(net_48), 
      .y(net_49));
  muddlib07__nand3_1x nand3_1x_5(.a(rs[4]), .b(net_35), .c(rs1nor0), 
      .y(net_51));
  muddlib07__nor2_1x nor2_1x_0(.a(funct[5]), .b(net_39), .y(net_47));
  muddlib07__nor2_1x nor2_1x_1(.a(rs[3]), .b(rs[2]), .y(net_35));
  muddlib07__nor2_1x nor2_1x_2(.a(net_24), .b(cop0opb), .y(cop0write));
  muddlib07__nor2_1x nor2_1x_5(.a(funct[1]), .b(funct[0]), .y(net_48));
  muddlib07__nor2_1x nor2_1x_6(.a(funct[3]), .b(funct[2]), .y(net_46));
  muddlib07__nor2_1x nor2_1x_7(.a(net_14), .b(cop0opb), .y(cop0read));
  muddlib07__nor2_1x nor2_1x_8(.a(rs[1]), .b(rs[0]), .y(rs1nor0));
  muddlib07__nor2_1x nor2_1x_9(.a(rs[4]), .b(rs[3]), .y(rs4nor3));
  muddlib07__nor3_1x nor3_1x_0(.a(net_51), .b(net_49), .c(cop0opb), .y(rfe));
endmodule   /* new_controller__cop0dec */

module new_controller__hilocontrol(hilodisablealushE, mdrunE, hilodisableE);
  input [1:0] hilodisablealushE;
  input mdrunE;
  output [1:0] hilodisableE;

  supply1 vdd;
  supply0 gnd;
  muddlib07__mux2_c_1x mux2_c_1_0(.d0(hilodisablealushE[1]), .d1(gnd), 
      .s(mdrunE), .y(hilodisableE[1]));
  muddlib07__mux2_c_1x mux2_c_1_1(.d0(hilodisablealushE[0]), .d1(gnd), 
      .s(mdrunE), .y(hilodisableE[0]));
endmodule   /* new_controller__hilocontrol */

module new_controller__maindecpla(op, op_1, op_2, op_3, op_4, op_5, controls, 
      controls_1, controls_10, controls_11, controls_12, controls_13, 
      controls_14, controls_15, controls_16, controls_17, controls_18, 
      controls_19, controls_2, controls_3, controls_4, controls_5, controls_6, 
      controls_7, controls_8, controls_9);
  input [0:0] op;
  input [1:1] op_1;
  input [2:2] op_2;
  input [3:3] op_3;
  input [4:4] op_4;
  input [5:5] op_5;
  output [0:0] controls;
  output [1:1] controls_1;
  output [10:10] controls_10;
  output [11:11] controls_11;
  output [12:12] controls_12;
  output [13:13] controls_13;
  output [14:14] controls_14;
  output [15:15] controls_15;
  output [16:16] controls_16;
  output [17:17] controls_17;
  output [18:18] controls_18;
  output [19:19] controls_19;
  output [2:2] controls_2;
  output [3:3] controls_3;
  output [4:4] controls_4;
  output [5:5] controls_5;
  output [6:6] controls_6;
  output [7:7] controls_7;
  output [8:8] controls_8;
  output [9:9] controls_9;

  supply1 vdd;
  supply0 gnd;
  wire net_2848, net_2851, net_2856, net_2902, net_2905, net_2908, net_2910;
  wire net_2912, net_2914, net_2920, net_2926, net_2928, net_2932, net_2936;
  wire net_2941, net_2945, net_2951, net_2956, net_2960, net_2967, net_2972;
  wire net_2977, net_2985, net_2992, net_2999, net_3008, net_3015, net_3023;
  wire net_3039, net_3043, net_3049, net_3070, net_3076, net_3078, net_3085;
  wire net_3090, net_3111, net_3138, net_3146, net_3157, net_3160, net_3250;
  wire net_3322, net_3342, net_3370, net_3380, net_3634, net_3662, net_3714;
  wire net_3747, net_3780, net_3912;

  tranif1 nmos_986(net_2920, gnd, net_3250);
  tranif1 nmos_987(net_2920, gnd, net_3634);
  tranif1 nmos_988(net_2932, gnd, op_5[5]);
  tranif1 nmos_989(net_3015, gnd, net_3747);
  tranif1 nmos_990(gnd, net_3250, op_3[3]);
  tranif1 nmos_991(gnd, net_2856, op_5[5]);
  tranif1 nmos_992(gnd, net_2856, op_4[4]);
  tranif1 nmos_993(gnd, net_2856, op_3[3]);
  tranif1 nmos_994(gnd, net_2856, op_2[2]);
  tranif1 nmos_995(gnd, net_2856, op_1[1]);
  tranif1 nmos_996(gnd, net_2856, op[0]);
  tranif1 nmos_997(gnd, net_3634, op_2[2]);
  tranif1 nmos_998(gnd, net_3714, op_1[1]);
  tranif1 nmos_999(net_2932, gnd, op_4[4]);
  tranif1 nmos_1000(gnd, net_3370, net_3780);
  tranif1 nmos_1001(gnd, net_3111, net_2902);
  tranif1 nmos_1002(gnd, net_3380, net_2902);
  tranif1 nmos_1003(gnd, net_3039, net_2905);
  tranif1 nmos_1004(gnd, net_3111, net_2905);
  tranif1 nmos_1005(gnd, net_3039, net_2908);
  tranif1 nmos_1006(gnd, net_3111, net_2908);
  tranif1 nmos_1007(gnd, net_3039, net_2910);
  tranif1 nmos_1008(gnd, net_3111, net_2910);
  tranif1 nmos_1009(gnd, net_3039, net_2912);
  tranif1 nmos_1010(net_2932, gnd, net_3250);
  tranif1 nmos_1011(gnd, net_3111, net_2912);
  tranif1 nmos_1012(gnd, net_3023, net_2914);
  tranif1 nmos_1013(gnd, net_3043, net_2914);
  tranif1 nmos_1014(gnd, net_3111, net_2914);
  tranif1 nmos_1015(gnd, net_3111, net_3912);
  tranif1 nmos_1016(gnd, net_3023, net_2920);
  tranif1 nmos_1017(gnd, net_3049, net_2920);
  tranif1 nmos_1018(gnd, net_2928, net_2920);
  tranif1 nmos_1019(gnd, net_3111, net_2920);
  tranif1 nmos_1020(gnd, net_3146, net_2920);
  tranif1 nmos_1021(net_2932, gnd, net_3634);
  tranif1 nmos_1022(gnd, net_3342, net_2920);
  tranif1 nmos_1023(gnd, net_3023, net_2926);
  tranif1 nmos_1024(gnd, net_3049, net_2926);
  tranif1 nmos_1025(gnd, net_3039, net_2926);
  tranif1 nmos_1026(gnd, net_3146, net_2926);
  tranif1 nmos_1027(gnd, net_3023, net_2932);
  tranif1 nmos_1028(gnd, net_3049, net_2932);
  tranif1 nmos_1029(gnd, net_3138, net_2932);
  tranif1 nmos_1030(gnd, net_3146, net_2932);
  tranif1 nmos_1031(gnd, net_3023, net_2936);
  tranif1 nmos_1032(net_2932, gnd, op_1[1]);
  tranif1 nmos_1033(gnd, net_3049, net_2936);
  tranif1 nmos_1034(gnd, net_3146, net_2936);
  tranif1 nmos_1035(gnd, net_3023, net_2941);
  tranif1 nmos_1036(gnd, net_3049, net_2941);
  tranif1 nmos_1037(gnd, net_3111, net_2941);
  tranif1 nmos_1038(gnd, net_3138, net_2941);
  tranif1 nmos_1039(gnd, net_3023, net_2945);
  tranif1 nmos_1040(gnd, net_3049, net_2945);
  tranif1 nmos_1041(gnd, net_2848, op_5[5]);
  tranif1 nmos_1042(gnd, net_3039, net_2945);
  tranif1 nmos_1043(net_2932, gnd, net_3747);
  tranif1 nmos_1044(gnd, net_3111, net_2945);
  tranif1 nmos_1045(gnd, net_3138, net_2945);
  tranif1 nmos_1046(gnd, net_3023, net_2951);
  tranif1 nmos_1047(gnd, net_3049, net_2951);
  tranif1 nmos_1048(gnd, net_3111, net_2951);
  tranif1 nmos_1049(gnd, net_3023, net_2956);
  tranif1 nmos_1050(gnd, net_3662, net_2956);
  tranif1 nmos_1051(gnd, net_3049, net_2956);
  tranif1 nmos_1052(gnd, net_3111, net_2956);
  tranif1 nmos_1053(gnd, net_3049, net_2960);
  tranif1 nmos_1054(gnd, net_2936, op_5[5]);
  tranif1 nmos_1055(gnd, net_3070, net_2960);
  tranif1 nmos_1056(gnd, net_3111, net_2960);
  tranif1 nmos_1057(gnd, net_3157, net_2960);
  tranif1 nmos_1058(gnd, net_3049, net_2967);
  tranif1 nmos_1059(gnd, net_3070, net_2967);
  tranif1 nmos_1060(gnd, net_3090, net_2967);
  tranif1 nmos_1061(gnd, net_3111, net_2967);
  tranif1 nmos_1062(gnd, net_3157, net_2967);
  tranif1 nmos_1063(gnd, net_3049, net_2972);
  tranif1 nmos_1064(gnd, net_3070, net_2972);
  tranif1 nmos_1065(gnd, net_2936, op_4[4]);
  tranif1 nmos_1066(gnd, net_3085, net_2972);
  tranif1 nmos_1067(gnd, net_3111, net_2972);
  tranif1 nmos_1068(gnd, net_3023, net_2977);
  tranif1 nmos_1069(gnd, net_3049, net_2977);
  tranif1 nmos_1070(gnd, net_3078, net_2977);
  tranif1 nmos_1071(gnd, net_3090, net_2977);
  tranif1 nmos_1072(gnd, net_3111, net_2977);
  tranif1 nmos_1073(gnd, net_3146, net_2977);
  tranif1 nmos_1074(gnd, net_3023, net_2985);
  tranif1 nmos_1075(gnd, net_3049, net_2985);
  tranif1 nmos_1076(gnd, net_2936, net_3250);
  tranif1 nmos_1077(gnd, net_3078, net_2985);
  tranif1 nmos_1078(gnd, net_3085, net_2985);
  tranif1 nmos_1079(gnd, net_3111, net_2985);
  tranif1 nmos_1080(gnd, net_3146, net_2985);
  tranif1 nmos_1081(gnd, net_3023, net_2992);
  tranif1 nmos_1082(gnd, net_3049, net_2992);
  tranif1 nmos_1083(gnd, net_3078, net_2992);
  tranif1 nmos_1084(gnd, net_2851, net_2992);
  tranif1 nmos_1085(gnd, net_3111, net_2992);
  tranif1 nmos_1086(gnd, net_3747, op[0]);
  tranif1 nmos_1087(gnd, net_2936, net_3634);
  tranif1 nmos_1088(gnd, net_3160, net_2992);
  tranif1 nmos_1089(gnd, net_3023, net_2999);
  tranif1 nmos_1090(gnd, net_3049, net_2999);
  tranif1 nmos_1091(gnd, net_3078, net_2999);
  tranif1 nmos_1092(gnd, net_3090, net_2999);
  tranif1 nmos_1093(gnd, net_2851, net_2999);
  tranif1 nmos_1094(gnd, net_3111, net_2999);
  tranif1 nmos_1095(gnd, net_3160, net_2999);
  tranif1 nmos_1096(gnd, net_3023, net_3008);
  tranif1 nmos_1097(gnd, net_3049, net_3008);
  tranif1 nmos_1098(net_2920, gnd, net_3714);
  tranif1 nmos_1099(gnd, net_3076, op_4[4]);
  tranif1 nmos_1100(gnd, net_3078, net_3008);
  tranif1 nmos_1101(gnd, net_3085, net_3008);
  tranif1 nmos_1102(gnd, net_2851, net_3008);
  tranif1 nmos_1103(gnd, net_3111, net_3008);
  tranif1 nmos_1104(gnd, net_3043, net_3015);
  tranif1 nmos_1105(gnd, net_3111, net_3015);
  tranif1 nmos_1106(gnd, net_3023, net_2856);
  tranif1 nmos_1107(gnd, net_3043, net_2856);
  tranif1 nmos_1108(gnd, net_3039, net_2856);
  tranif1 nmos_1109(gnd, net_3138, net_2856);
  tranif1 nmos_1110(gnd, net_2936, op_1[1]);
  tranif1 nmos_1111(gnd, net_3322, net_2856);
  tranif1 nmos_1112(net_3780, gnd, op_5[5]);
  tranif1 nmos_1113(net_3780, gnd, net_3076);
  tranif1 nmos_1114(net_3780, gnd, op_3[3]);
  tranif1 nmos_1115(net_3780, gnd, op_2[2]);
  tranif1 nmos_1116(net_3780, gnd, op_1[1]);
  tranif1 nmos_1117(net_3780, gnd, net_3747);
  tranif1 nmos_1118(gnd, controls_19[19], net_3023);
  tranif1 nmos_1119(gnd, net_2902, op_5[5]);
  tranif1 nmos_1120(gnd, controls_18[18], net_3043);
  tranif1 nmos_1121(gnd, net_2936, op[0]);
  tranif1 nmos_1122(gnd, controls_17[17], net_3662);
  tranif1 nmos_1123(gnd, net_2902, net_3076);
  tranif1 nmos_1124(gnd, controls_16[16], net_3049);
  tranif1 nmos_1125(gnd, net_2902, op_3[3]);
  tranif1 nmos_1126(gnd, controls_15[15], net_3070);
  tranif1 nmos_1127(gnd, net_2902, op_2[2]);
  tranif1 nmos_1128(gnd, controls_14[14], net_3078);
  tranif1 nmos_1129(gnd, net_2902, op_1[1]);
  tranif1 nmos_1130(gnd, controls_13[13], net_3085);
  tranif1 nmos_1131(gnd, controls_12[12], net_3090);
  tranif1 nmos_1132(net_2941, gnd, op_5[5]);
  tranif1 nmos_1133(gnd, net_2902, op[0]);
  tranif1 nmos_1134(gnd, controls_11[11], net_2851);
  tranif1 nmos_1135(net_2905, gnd, op_5[5]);
  tranif1 nmos_1136(gnd, controls_10[10], net_2928);
  tranif1 nmos_1137(net_2905, gnd, op_4[4]);
  tranif1 nmos_1138(gnd, controls_9[9], net_3039);
  tranif1 nmos_1139(net_2905, gnd, op_3[3]);
  tranif1 nmos_1140(gnd, controls_8[8], net_3111);
  tranif1 nmos_1141(gnd, controls_7[7], net_3138);
  tranif1 nmos_1142(net_2905, gnd, net_3634);
  tranif1 nmos_1143(net_2941, gnd, op_4[4]);
  tranif1 nmos_1144(gnd, controls_6[6], net_3322);
  tranif1 nmos_1145(net_2905, gnd, net_3714);
  tranif1 nmos_1146(gnd, controls_5[5], net_3146);
  tranif1 nmos_1147(net_2905, gnd, net_3747);
  tranif1 nmos_1148(gnd, controls_4[4], net_3342);
  tranif1 nmos_1149(gnd, net_2908, op_5[5]);
  tranif1 nmos_1150(gnd, controls_3[3], net_3157);
  tranif1 nmos_1151(gnd, controls_2[2], net_3160);
  tranif1 nmos_1152(gnd, net_2908, op_4[4]);
  tranif1 nmos_1153(gnd, controls_1[1], net_3370);
  tranif1 nmos_1154(net_2941, gnd, net_3250);
  tranif1 nmos_1155(gnd, net_2908, op_3[3]);
  tranif1 nmos_1156(gnd, controls[0], net_3380);
  tranif1 nmos_1157(gnd, net_2908, net_3634);
  tranif1 nmos_1158(gnd, net_2908, net_3714);
  tranif1 nmos_1159(gnd, net_2908, op[0]);
  tranif1 nmos_1160(net_2910, gnd, op_5[5]);
  tranif1 nmos_1161(net_2910, gnd, op_4[4]);
  tranif1 nmos_1162(net_2910, gnd, op_3[3]);
  tranif1 nmos_1163(net_2910, gnd, net_3634);
  tranif1 nmos_1164(net_2910, gnd, op_1[1]);
  tranif1 nmos_1165(net_2941, gnd, op_2[2]);
  tranif1 nmos_1166(net_2910, gnd, net_3747);
  tranif1 nmos_1167(gnd, net_2912, op_5[5]);
  tranif1 nmos_1168(gnd, net_2912, op_4[4]);
  tranif1 nmos_1169(gnd, net_2912, op_3[3]);
  tranif1 nmos_1170(gnd, net_2912, net_3634);
  tranif1 nmos_1171(gnd, net_2912, op_1[1]);
  tranif1 nmos_1172(gnd, net_2912, op[0]);
  tranif1 nmos_1173(net_2914, gnd, op_5[5]);
  tranif1 nmos_1174(net_2914, gnd, op_4[4]);
  tranif1 nmos_1175(net_2914, gnd, op_3[3]);
  tranif1 nmos_1176(net_2941, gnd, net_3714);
  tranif1 nmos_1177(net_2914, gnd, op_2[2]);
  tranif1 nmos_1178(net_2914, gnd, net_3714);
  tranif1 nmos_1179(net_2914, gnd, net_3747);
  tranif1 nmos_1180(gnd, net_3912, op_5[5]);
  tranif1 nmos_1181(gnd, net_3912, op_4[4]);
  tranif1 nmos_1182(gnd, net_3912, op_3[3]);
  tranif1 nmos_1183(gnd, net_3912, op_2[2]);
  tranif1 nmos_1184(gnd, net_3912, net_3714);
  tranif1 nmos_1185(gnd, net_3912, op[0]);
  tranif1 nmos_1186(net_2920, gnd, op_5[5]);
  tranif1 nmos_1187(net_2941, gnd, net_3747);
  tranif1 nmos_1188(net_2920, gnd, op_4[4]);
  tranif1 nmos_1189(gnd, net_2945, op_5[5]);
  tranif1 nmos_1190(net_2920, gnd, net_3747);
  tranif1 nmos_1191(gnd, net_2945, op_4[4]);
  tranif1 nmos_1192(gnd, net_2945, net_3250);
  tranif1 nmos_1193(gnd, net_2945, op_2[2]);
  tranif1 nmos_1194(gnd, net_2945, net_3714);
  tranif1 nmos_1195(gnd, net_2945, op[0]);
  tranif1 nmos_1196(net_2951, gnd, op_5[5]);
  tranif1 nmos_1197(net_2951, gnd, op_4[4]);
  tranif1 nmos_1198(net_2951, gnd, net_3250);
  tranif1 nmos_1199(net_2951, gnd, op_2[2]);
  tranif1 nmos_1200(net_2951, gnd, op_1[1]);
  tranif1 nmos_1201(gnd, net_2926, op_5[5]);
  tranif1 nmos_1202(net_2951, gnd, net_3747);
  tranif1 nmos_1203(gnd, net_2956, op_5[5]);
  tranif1 nmos_1204(gnd, net_2956, op_4[4]);
  tranif1 nmos_1205(gnd, net_2956, net_3250);
  tranif1 nmos_1206(gnd, net_2956, op_2[2]);
  tranif1 nmos_1207(gnd, net_2956, op_1[1]);
  tranif1 nmos_1208(gnd, net_2956, op[0]);
  tranif1 nmos_1209(net_2960, gnd, net_2848);
  tranif1 nmos_1210(net_2960, gnd, op_4[4]);
  tranif1 nmos_1211(net_2960, gnd, net_3250);
  tranif1 nmos_1212(gnd, net_2926, op_4[4]);
  tranif1 nmos_1213(net_2960, gnd, op_2[2]);
  tranif1 nmos_1214(net_2960, gnd, net_3714);
  tranif1 nmos_1215(net_2960, gnd, net_3747);
  tranif1 nmos_1216(gnd, net_2967, net_2848);
  tranif1 nmos_1217(gnd, net_2967, op_4[4]);
  tranif1 nmos_1218(gnd, net_2967, net_3250);
  tranif1 nmos_1219(gnd, net_2967, op_2[2]);
  tranif1 nmos_1220(gnd, net_2967, op_1[1]);
  tranif1 nmos_1221(gnd, net_2967, net_3747);
  tranif1 nmos_1222(net_2972, gnd, net_2848);
  tranif1 nmos_1223(gnd, net_2926, net_3250);
  tranif1 nmos_1224(net_2972, gnd, op_4[4]);
  tranif1 nmos_1225(net_2972, gnd, net_3250);
  tranif1 nmos_1226(net_2972, gnd, op_2[2]);
  tranif1 nmos_1227(net_2972, gnd, op_1[1]);
  tranif1 nmos_1228(net_2972, gnd, op[0]);
  tranif1 nmos_1229(gnd, net_2977, net_2848);
  tranif1 nmos_1230(gnd, net_2977, op_4[4]);
  tranif1 nmos_1231(gnd, net_2977, op_3[3]);
  tranif1 nmos_1232(gnd, net_2977, net_3634);
  tranif1 nmos_1233(gnd, net_2977, op_1[1]);
  tranif1 nmos_1234(gnd, net_2926, net_3634);
  tranif1 nmos_1235(gnd, net_2977, net_3747);
  tranif1 nmos_1236(net_2985, gnd, net_2848);
  tranif1 nmos_1237(net_2985, gnd, op_4[4]);
  tranif1 nmos_1238(net_2985, gnd, op_3[3]);
  tranif1 nmos_1239(net_2985, gnd, net_3634);
  tranif1 nmos_1240(net_2985, gnd, op_1[1]);
  tranif1 nmos_1241(net_2985, gnd, op[0]);
  tranif1 nmos_1242(gnd, net_2992, net_2848);
  tranif1 nmos_1243(gnd, net_2992, op_4[4]);
  tranif1 nmos_1244(gnd, net_2992, op_3[3]);
  tranif1 nmos_1245(gnd, net_2926, net_3714);
  tranif1 nmos_1246(gnd, net_2992, op_2[2]);
  tranif1 nmos_1247(gnd, net_2992, net_3714);
  tranif1 nmos_1248(gnd, net_2992, net_3747);
  tranif1 nmos_1249(net_2999, gnd, net_2848);
  tranif1 nmos_1250(net_2999, gnd, op_4[4]);
  tranif1 nmos_1251(net_2999, gnd, op_3[3]);
  tranif1 nmos_1252(net_2999, gnd, op_2[2]);
  tranif1 nmos_1253(net_2999, gnd, op_1[1]);
  tranif1 nmos_1254(net_2999, gnd, net_3747);
  tranif1 nmos_1255(gnd, net_3008, net_2848);
  tranif1 nmos_1256(gnd, net_2926, op[0]);
  tranif1 nmos_1257(gnd, net_3008, op_4[4]);
  tranif1 nmos_1258(gnd, net_3008, op_3[3]);
  tranif1 nmos_1259(gnd, net_3008, op_2[2]);
  tranif1 nmos_1260(gnd, net_3008, op_1[1]);
  tranif1 nmos_1261(gnd, net_3008, op[0]);
  tranif1 nmos_1262(net_3015, gnd, op_5[5]);
  tranif1 nmos_1263(net_3015, gnd, op_4[4]);
  tranif1 nmos_1264(net_3015, gnd, op_3[3]);
  tranif1 nmos_1265(net_3015, gnd, op_2[2]);
  tranif1 nmos_1266(net_3015, gnd, op_1[1]);
  tranif0 pmos_875(net_3076, vdd, op_4[4]);
  tranif0 pmos_876(net_3250, vdd, op_3[3]);
  tranif0 pmos_877(controls_15[15], vdd, net_3070);
  tranif0 pmos_878(controls_14[14], vdd, net_3078);
  tranif0 pmos_879(controls_13[13], vdd, net_3085);
  tranif0 pmos_880(controls_12[12], vdd, net_3090);
  tranif0 pmos_881(controls_11[11], vdd, net_2851);
  tranif0 pmos_882(controls_10[10], vdd, net_2928);
  tranif0 pmos_883(controls_9[9], vdd, net_3039);
  tranif0 pmos_884(controls_8[8], vdd, net_3111);
  tranif0 pmos_885(controls_7[7], vdd, net_3138);
  tranif0 pmos_886(controls_6[6], vdd, net_3322);
  tranif0 pmos_887(net_3634, vdd, op_2[2]);
  tranif0 pmos_888(controls_5[5], vdd, net_3146);
  tranif0 pmos_889(controls_4[4], vdd, net_3342);
  tranif0 pmos_890(controls_3[3], vdd, net_3157);
  tranif0 pmos_891(controls_2[2], vdd, net_3160);
  tranif0 pmos_892(controls_1[1], vdd, net_3370);
  tranif0 pmos_893(controls[0], vdd, net_3380);
  rtranif0 pmos_894(net_3023, vdd, gnd);
  rtranif0 pmos_895(net_3043, vdd, gnd);
  rtranif0 pmos_896(net_3662, vdd, gnd);
  rtranif0 pmos_897(net_3049, vdd, gnd);
  tranif0 pmos_898(net_3714, vdd, op_1[1]);
  rtranif0 pmos_899(net_3070, vdd, gnd);
  rtranif0 pmos_900(net_3078, vdd, gnd);
  rtranif0 pmos_901(net_3085, vdd, gnd);
  rtranif0 pmos_902(net_3090, vdd, gnd);
  rtranif0 pmos_903(net_2851, vdd, gnd);
  rtranif0 pmos_904(net_2928, vdd, gnd);
  rtranif0 pmos_905(net_3039, vdd, gnd);
  rtranif0 pmos_906(net_3111, vdd, gnd);
  rtranif0 pmos_907(net_3138, vdd, gnd);
  rtranif0 pmos_908(net_3322, vdd, gnd);
  tranif0 pmos_909(net_3747, vdd, op[0]);
  rtranif0 pmos_910(net_3146, vdd, gnd);
  rtranif0 pmos_911(net_3342, vdd, gnd);
  rtranif0 pmos_912(net_3157, vdd, gnd);
  rtranif0 pmos_913(net_3160, vdd, gnd);
  rtranif0 pmos_914(net_3370, vdd, gnd);
  rtranif0 pmos_915(net_3380, vdd, gnd);
  rtranif0 pmos_916(vdd, net_2856, gnd);
  rtranif0 pmos_917(vdd, net_3015, gnd);
  rtranif0 pmos_918(vdd, net_3008, gnd);
  rtranif0 pmos_919(vdd, net_2999, gnd);
  tranif0 pmos_920(net_2848, vdd, op_5[5]);
  rtranif0 pmos_921(vdd, net_2992, gnd);
  rtranif0 pmos_922(vdd, net_2985, gnd);
  rtranif0 pmos_923(vdd, net_2977, gnd);
  rtranif0 pmos_924(vdd, net_2972, gnd);
  rtranif0 pmos_925(vdd, net_2967, gnd);
  rtranif0 pmos_926(vdd, net_2960, gnd);
  rtranif0 pmos_927(vdd, net_2956, gnd);
  rtranif0 pmos_928(vdd, net_2951, gnd);
  rtranif0 pmos_929(vdd, net_2945, gnd);
  rtranif0 pmos_930(vdd, net_2941, gnd);
  tranif0 pmos_931(controls_19[19], vdd, net_3023);
  rtranif0 pmos_932(vdd, net_2936, gnd);
  rtranif0 pmos_933(vdd, net_2932, gnd);
  rtranif0 pmos_934(vdd, net_2926, gnd);
  rtranif0 pmos_935(vdd, net_2920, gnd);
  rtranif0 pmos_936(vdd, net_3912, gnd);
  rtranif0 pmos_937(vdd, net_2914, gnd);
  rtranif0 pmos_938(vdd, net_2912, gnd);
  rtranif0 pmos_939(vdd, net_2910, gnd);
  rtranif0 pmos_940(vdd, net_2908, gnd);
  rtranif0 pmos_941(vdd, net_2905, gnd);
  tranif0 pmos_942(controls_18[18], vdd, net_3043);
  rtranif0 pmos_943(vdd, net_2902, gnd);
  rtranif0 pmos_944(vdd, net_3780, gnd);
  tranif0 pmos_945(controls_17[17], vdd, net_3662);
  tranif0 pmos_946(controls_16[16], vdd, net_3049);
endmodule   /* new_controller__maindecpla */

module muddlib07__nor4_1x(a, b, c, d, y);
  input a;
  input b;
  input c;
  input d;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_2, net_3, net_41;

  tranif1 nmos_0(gnd, y, d);
  tranif1 nmos_1(gnd, y, c);
  tranif1 nmos_2(gnd, y, b);
  tranif1 nmos_3(gnd, y, a);
  tranif0 pmos_0(net_41, vdd, a);
  tranif0 pmos_1(net_2, net_41, b);
  tranif0 pmos_2(net_3, net_2, c);
  tranif0 pmos_3(y, net_3, d);
endmodule   /* muddlib07__nor4_1x */

module new_controller__maindec(op, adelableD, adesableD, alushcontrol, alusrc, 
      byte, cop0op, fpuD, halfword, loadsignedD, lui, memtoreg, memwrite, 
      overflowable, regdst, regwrite, riD, rtype, unsignedD, useshift);
  input [5:0] op;
  output adelableD;
  output adesableD;
  output [2:0] alushcontrol;
  output alusrc;
  output byte;
  output cop0op;
  output fpuD;
  output halfword;
  output loadsignedD;
  output lui;
  output memtoreg;
  output memwrite;
  output overflowable;
  output regdst;
  output regwrite;
  output riD;
  output rtype;
  output unsignedD;
  output useshift;

  supply1 vdd;
  supply0 gnd;
  new_controller__maindecpla maindecp_0(.op(op[0:0]), .op_1(op[1:1]), 
      .op_2(op[2:2]), .op_3(op[3:3]), .op_4(op[4:4]), .op_5(op[5:5]), 
      .controls({cop0op}), .controls_1({fpuD}), .controls_10({useshift}), 
      .controls_11({loadsignedD}), .controls_12({halfword}), 
      .controls_13({byte}), .controls_14({memtoreg}), .controls_15({memwrite}), 
      .controls_16({alusrc}), .controls_17({overflowable}), 
      .controls_18({regdst}), .controls_19({regwrite}), 
      .controls_2({adelableD}), .controls_3({adesableD}), .controls_4({lui}), 
      .controls_5({unsignedD}), .controls_6({rtype}), 
      .controls_7(alushcontrol[0:0]), .controls_8(alushcontrol[1:1]), 
      .controls_9(alushcontrol[2:2]));
  muddlib07__nor4_1x nor4_1x_0(.a(fpuD), .b(alushcontrol[1]), 
      .c(alushcontrol[2]), .d(unsignedD), .y(riD));
endmodule   /* new_controller__maindec */

module new_controller__regD(bdsF, ph1, ph2, resetb, stallDb, bdsD);
  input bdsF;
  input ph1;
  input ph2;
  input resetb;
  input stallDb;
  output bdsD;

  supply1 vdd;
  supply0 gnd;
  muddlib07__flopenr_c_1x regD(.d(bdsF), .en(stallDb), .resetb(resetb), 
      .q(bdsD), .ph1(ph1), .ph2(ph2));
endmodule   /* new_controller__regD */

module new_controller__regE(d, ph1, ph2, resetb, stallEb, q);
  input [30:0] d;
  input ph1;
  input ph2;
  input resetb;
  input stallEb;
  output [30:0] q;

  supply1 vdd;
  supply0 gnd;
  muddlib07__flopenr_c_1x flopenrc_30_(.d(d[30]), .en(stallEb), 
      .resetb(resetb), .q(q[30]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_29_(.d(d[29]), .en(stallEb), 
      .resetb(resetb), .q(q[29]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_28_(.d(d[28]), .en(stallEb), 
      .resetb(resetb), .q(q[28]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_27_(.d(d[27]), .en(stallEb), 
      .resetb(resetb), .q(q[27]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_26_(.d(d[26]), .en(stallEb), 
      .resetb(resetb), .q(q[26]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_25_(.d(d[25]), .en(stallEb), 
      .resetb(resetb), .q(q[25]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_24_(.d(d[24]), .en(stallEb), 
      .resetb(resetb), .q(q[24]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_23_(.d(d[23]), .en(stallEb), 
      .resetb(resetb), .q(q[23]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_22_(.d(d[22]), .en(stallEb), 
      .resetb(resetb), .q(q[22]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_21_(.d(d[21]), .en(stallEb), 
      .resetb(resetb), .q(q[21]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_20_(.d(d[20]), .en(stallEb), 
      .resetb(resetb), .q(q[20]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_19_(.d(d[19]), .en(stallEb), 
      .resetb(resetb), .q(q[19]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_18_(.d(d[18]), .en(stallEb), 
      .resetb(resetb), .q(q[18]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_17_(.d(d[17]), .en(stallEb), 
      .resetb(resetb), .q(q[17]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_16_(.d(d[16]), .en(stallEb), 
      .resetb(resetb), .q(q[16]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_15_(.d(d[15]), .en(stallEb), 
      .resetb(resetb), .q(q[15]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_14_(.d(d[14]), .en(stallEb), 
      .resetb(resetb), .q(q[14]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_13_(.d(d[13]), .en(stallEb), 
      .resetb(resetb), .q(q[13]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_12_(.d(d[12]), .en(stallEb), 
      .resetb(resetb), .q(q[12]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_11_(.d(d[11]), .en(stallEb), 
      .resetb(resetb), .q(q[11]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_10_(.d(d[10]), .en(stallEb), 
      .resetb(resetb), .q(q[10]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_9_(.d(d[9]), .en(stallEb), .resetb(resetb), 
      .q(q[9]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_8_(.d(d[8]), .en(stallEb), .resetb(resetb), 
      .q(q[8]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_7_(.d(d[7]), .en(stallEb), .resetb(resetb), 
      .q(q[7]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_6_(.d(d[6]), .en(stallEb), .resetb(resetb), 
      .q(q[6]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_5_(.d(d[5]), .en(stallEb), .resetb(resetb), 
      .q(q[5]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_4_(.d(d[4]), .en(stallEb), .resetb(resetb), 
      .q(q[4]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_3_(.d(d[3]), .en(stallEb), .resetb(resetb), 
      .q(q[3]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_2_(.d(d[2]), .en(stallEb), .resetb(resetb), 
      .q(q[2]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_1_(.d(d[1]), .en(stallEb), .resetb(resetb), 
      .q(q[1]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_0_(.d(d[0]), .en(stallEb), .resetb(resetb), 
      .q(q[0]), .ph1(ph1), .ph2(ph2));
endmodule   /* new_controller__regE */

module new_controller__regM(d, ph1, ph2, resetb, stallMb, q);
  input [6:0] d;
  input ph1;
  input ph2;
  input resetb;
  input stallMb;
  output [6:0] q;

  supply1 vdd;
  supply0 gnd;
  muddlib07__flopenr_c_1x flopenrc_6_(.d(d[6]), .en(stallMb), .resetb(resetb), 
      .q(q[6]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_5_(.d(d[5]), .en(stallMb), .resetb(resetb), 
      .q(q[5]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_4_(.d(d[4]), .en(stallMb), .resetb(resetb), 
      .q(q[4]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_3_(.d(d[3]), .en(stallMb), .resetb(resetb), 
      .q(q[3]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_2_(.d(d[2]), .en(stallMb), .resetb(resetb), 
      .q(q[2]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_1_(.d(d[1]), .en(stallMb), .resetb(resetb), 
      .q(q[1]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_0_(.d(d[0]), .en(stallMb), .resetb(resetb), 
      .q(q[0]), .ph1(ph1), .ph2(ph2));
endmodule   /* new_controller__regM */

module new_controller__regW(d, ph1, ph2, resetb, stallWb, q);
  input [2:0] d;
  input ph1;
  input ph2;
  input resetb;
  input stallWb;
  output [2:0] q;

  supply1 vdd;
  supply0 gnd;
  muddlib07__flopenr_c_1x flopenrc_2_(.d(d[2]), .en(stallWb), .resetb(resetb), 
      .q(q[2]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_1_(.d(d[1]), .en(stallWb), .resetb(resetb), 
      .q(q[1]), .ph1(ph1), .ph2(ph2));
  muddlib07__flopenr_c_1x flopenrc_0_(.d(d[0]), .en(stallWb), .resetb(resetb), 
      .q(q[0]), .ph1(ph1), .ph2(ph2));
endmodule   /* new_controller__regW */

module new_controller__registers(adelableD, adesableD, aluoutsrcD, 
      alushcontrol, alusrcD, bdsF, breakD, byteD, cop0writeD, flushE, flushM, 
      fpuD, halfwordD, hilodisablealushD, hiloselD, hilosrcD, loadsignedD, 
      luiD, mdstartD, memtoregD, memwriteD, overflowableD, ph1, ph2, regdstD, 
      regwriteD, reset, resetb, rfeD, riD, specialregsrcD, stallDb, stallEb, 
      stallMb, stallWb, syscallD, adelableE, adesableE, aluoutsrcE, 
      alushcontrolE, alusrcE, bdsE, breakE, byteM, cop0writeW, fpuE, halfwordE, 
      halfwordM, hilodisablealushE, hiloselE, hilosrcE, loadsignedM, luiE, 
      mdstartE, memtoregE, memtoregM, memtoregW, memwriteM, overflowableE, 
      regdstE, regwriteE, regwriteM, regwriteW, rfeE, riE, specialregsrcE, 
      syscallE);
  input adelableD;
  input adesableD;
  input [1:0] aluoutsrcD;
  input [2:0] alushcontrol;
  input alusrcD;
  input bdsF;
  input breakD;
  input byteD;
  input cop0writeD;
  input flushE;
  input flushM;
  input fpuD;
  input halfwordD;
  input [1:0] hilodisablealushD;
  input hiloselD;
  input hilosrcD;
  input loadsignedD;
  input luiD;
  input mdstartD;
  input memtoregD;
  input memwriteD;
  input overflowableD;
  input ph1;
  input ph2;
  input regdstD;
  input regwriteD;
  input reset;
  input resetb;
  input rfeD;
  input riD;
  input [1:0] specialregsrcD;
  input stallDb;
  input stallEb;
  input stallMb;
  input stallWb;
  input syscallD;
  output adelableE;
  output adesableE;
  output [1:0] aluoutsrcE;
  output [2:0] alushcontrolE;
  output alusrcE;
  output bdsE;
  output breakE;
  output byteM;
  output cop0writeW;
  output fpuE;
  output halfwordE;
  output halfwordM;
  output [1:0] hilodisablealushE;
  output hiloselE;
  output hilosrcE;
  output loadsignedM;
  output luiE;
  output mdstartE;
  output memtoregE;
  output memtoregM;
  output memtoregW;
  output memwriteM;
  output overflowableE;
  output regdstE;
  output regwriteE;
  output regwriteM;
  output regwriteW;
  output rfeE;
  output riE;
  output [1:0] specialregsrcE;
  output syscallE;

  supply1 vdd;
  supply0 gnd;
  wire net_289, net_305;
  wire [14:14] dE;
  wire [18:17] qE;
  wire [20:20] qE_1;
  wire [29:29] qE_2;
  wire [3:3] qM;

  muddlib07__nor2_1x nor2_1x_0(.a(reset), .b(flushE), .y(net_289));
  muddlib07__nor2_1x nor2_1x_1(.a(reset), .b(flushM), .y(net_305));
  new_controller__regD regD_0(.bdsF(bdsF), .ph1(ph1), .ph2(ph2), 
      .resetb(resetb), .stallDb(stallDb), .bdsD(dE[14]));
  new_controller__regE regE_0(.d({memtoregD, memwriteD, alusrcD, regdstD, 
      regwriteD, aluoutsrcD[1], aluoutsrcD[0], alushcontrol[2], 
      alushcontrol[1], alushcontrol[0], loadsignedD, luiD, cop0writeD, byteD, 
      halfwordD, overflowableD, dE[14], syscallD, breakD, riD, fpuD, adesableD, 
      adelableD, mdstartD, hilosrcD, hiloselD, hilodisablealushD[1], 
      hilodisablealushD[0], specialregsrcD[1], specialregsrcD[0], rfeD}), 
      .ph1(ph1), .ph2(ph2), .resetb(net_289), .stallEb(stallEb), .q({memtoregE, 
      qE_2[29], alusrcE, regdstE, regwriteE, aluoutsrcE[1], aluoutsrcE[0], 
      alushcontrolE[2], alushcontrolE[1], alushcontrolE[0], qE_1[20], luiE, 
      qE[18], qE[17], halfwordE, overflowableE, bdsE, syscallE, breakE, riE, 
      fpuE, adesableE, adelableE, mdstartE, hilosrcE, hiloselE, 
      hilodisablealushE[1], hilodisablealushE[0], specialregsrcE[1], 
      specialregsrcE[0], rfeE}));
  new_controller__regM regM_0(.d({memtoregE, qE_2[29], regwriteE, qE[18], 
      qE_1[20], qE[17], halfwordE}), .ph1(ph1), .ph2(ph2), .resetb(net_305), 
      .stallMb(stallMb), .q({memtoregM, memwriteM, regwriteM, qM[3], 
      loadsignedM, byteM, halfwordM}));
  new_controller__regW regW_0(.d({memtoregM, regwriteM, qM[3]}), .ph1(ph1), 
      .ph2(ph2), .resetb(resetb), .stallWb(stallWb), .q({memtoregW, regwriteW, 
      cop0writeW}));
endmodule   /* new_controller__registers */

module new_controller__specialregsrcD(hiloreadD, hiloselD, specialregsrcD);
  input hiloreadD;
  input hiloselD;
  output [1:0] specialregsrcD;

  supply1 vdd;
  supply0 gnd;
  wire net_63;

  muddlib07__and2_1x and2_1x_0(.a(hiloreadD), .b(hiloselD), 
      .y(specialregsrcD[1]));
  muddlib07__inv_1x inv_1x_0(.a(hiloreadD), .y(net_63));
  muddlib07__nor2_1x nor2_1x_0(.a(net_63), .b(hiloselD), 
      .y(specialregsrcD[0]));
endmodule   /* new_controller__specialregsrcD */

module new_controller__toplevellogic(alushdecoverflowableD, branchD, cop0readD, 
      cop0writeD, hiloreadD, jumpD, linkD, maindecoverflowableD, 
      maindecregdstD, mainregwrite, mdstartD, bdsF, hiloaccessD, overflowableD, 
      regdstD, regwriteD);
  input alushdecoverflowableD;
  input branchD;
  input cop0readD;
  input cop0writeD;
  input hiloreadD;
  input jumpD;
  input linkD;
  input maindecoverflowableD;
  input maindecregdstD;
  input mainregwrite;
  input mdstartD;
  output bdsF;
  output hiloaccessD;
  output overflowableD;
  output regdstD;
  output regwriteD;

  supply1 vdd;
  supply0 gnd;
  muddlib07__or2_1x or2_1x_0(.a(maindecregdstD), .b(cop0writeD), .y(regdstD));
  muddlib07__or2_1x or2_1x_1(.a(branchD), .b(jumpD), .y(bdsF));
  muddlib07__or2_1x or2_1x_2(.a(mdstartD), .b(hiloreadD), .y(hiloaccessD));
  muddlib07__or2_1x or2_1x_3(.a(maindecoverflowableD), 
      .b(alushdecoverflowableD), .y(overflowableD));
  muddlib07__or3_1x or3_1x_0(.a(mainregwrite), .b(linkD), .c(cop0readD), 
      .y(regwriteD));
endmodule   /* new_controller__toplevellogic */

module new_controller__mipscontroller(aeqbD, aeqzD, agtzD, altzD, flushE, 
      flushM, functD, mdrunE, opD, pendingexception, ph1, ph2, reset, rsD, rtD, 
      stallD, stallE, stallM, stallW, adelableE, adesableE, aluoutsrcE, 
      alushcontrolE, alusrcE, bdsE, branchD, breakE, byteM, cop0writeW, fpuE, 
      halfwordE, halfwordM, hiloaccessD, hilodisableE, hilosrcE, jumpD, 
      jumpregD, linkD, loadsignedM, luiE, mdstartE, memtoregE, memtoregM, 
      memtoregW, memwriteM, overflowableE, pcbranchsrcD, pcsrcFD, rdsrcD, 
      regdstE, regwriteE, regwriteM, regwriteW, rfeE, riE, specialregsrcE, 
      syscallE, unsignedD);
  input aeqbD;
  input aeqzD;
  input agtzD;
  input altzD;
  input flushE;
  input flushM;
  input [5:0] functD;
  input mdrunE;
  input [5:0] opD;
  input pendingexception;
  input ph1;
  input ph2;
  input reset;
  input [4:0] rsD;
  input [4:0] rtD;
  input stallD;
  input stallE;
  input stallM;
  input stallW;
  output adelableE;
  output adesableE;
  output [1:0] aluoutsrcE;
  output [2:0] alushcontrolE;
  output alusrcE;
  output bdsE;
  output branchD;
  output breakE;
  output byteM;
  output cop0writeW;
  output fpuE;
  output halfwordE;
  output halfwordM;
  output hiloaccessD;
  output [1:0] hilodisableE;
  output hilosrcE;
  output jumpD;
  output jumpregD;
  output linkD;
  output loadsignedM;
  output luiE;
  output mdstartE;
  output memtoregE;
  output memtoregM;
  output memtoregW;
  output memwriteM;
  output overflowableE;
  output [1:0] pcbranchsrcD;
  output [1:0] pcsrcFD;
  output rdsrcD;
  output regdstE;
  output regwriteE;
  output regwriteM;
  output regwriteW;
  output rfeE;
  output riE;
  output [1:0] specialregsrcE;
  output syscallE;
  output unsignedD;

  supply1 vdd;
  supply0 gnd;
  wire adelableD, adesableD, alushdecoverflowableD, alusrcD, bdsF, breakD;
  wire brsrcD, byteD, cop0opD, cop0readD, cop0writeD, eqD, fpuD, gtD, halfwordD;
  wire hiloreadD, hiloselD, hiloselE, hilosrcD, loadsignedD, ltD, luiD;
  wire maindecoverflowableD, maindecregdstD, maindecuseshifterD, mainregwrite;
  wire mdstartD, memtoregD, memwriteD, overflowableD, regdstD, regwriteD;
  wire resetb, rfeD, riD, rtypeD, stallDb, stallEb, stallMb, stallWb, syscallD;
  wire useshifterD;
  wire [1:0] aluoutsrcD;
  wire [2:0] alushcontmaindecD;
  wire [2:0] alushcontrolD;
  wire [1:0] hilodisablealushD;
  wire [1:0] hilodisablealushE;
  wire [1:0] specialregsrcD;

  new_controller__aluoutsrcD aluoutsr_1(.cop0readD(cop0readD), 
      .hiloreadD(hiloreadD), .linkD(linkD), .useshifterD(useshifterD), 
      .aluoutsrcD(aluoutsrcD[1:0]));
  new_controller__alushdec 
      alushdec_0(.alushmaincontrol(alushcontmaindecD[2:0]), 
      .funct(functD[5:0]), .maindecuseshifter(maindecuseshifterD), 
      .rtype(rtypeD), .alushcontrol(alushcontrolD[2:0]), .breakD(breakD), 
      .hilodisable(hilodisablealushD[1:0]), .hiloread(hiloreadD), 
      .hilosel(hiloselD), .hilosrc(hilosrcD), .mdstart(mdstartD), 
      .overflowable(alushdecoverflowableD), .syscallD(syscallD), 
      .useshifter(useshifterD));
  new_controller__branchcontroller branchco_0(.aeqb(aeqbD), .aeqz(aeqzD), 
      .agtz(agtzD), .altz(altzD), .branch(branchD), .eq(eqD), .gt(gtD), 
      .jump(jumpD), .link(linkD), .lt(ltD), 
      .pendingexception(pendingexception), .reset(reset), .src(brsrcD), 
      .jumpreg(jumpregD), .pcbranchsrc(pcbranchsrcD[1:0]), 
      .pcsrc(pcsrcFD[1:0]), .rdsrc(rdsrcD));
  new_controller__branchdec branchde_0(.funct(functD[5:0]), .op(opD[5:0]), 
      .rt(rtD[4:0]), .branch(branchD), .eq(eqD), .gt(gtD), .jump(jumpD), 
      .link(linkD), .lt(ltD), .src(brsrcD));
  new_controller__cop0dec cop0dec_0(.cop0op(cop0opD), .funct(functD[5:0]), 
      .rs(rsD[4:0]), .cop0read(cop0readD), .cop0write(cop0writeD), 
      .rfe(rfeD));
  new_controller__hilocontrol 
      hilocont_0(.hilodisablealushE(hilodisablealushE[1:0]), .mdrunE(mdrunE), 
      .hilodisableE(hilodisableE[1:0]));
  muddlib07__inv_1x inv_1x_1(.a(reset), .y(resetb));
  muddlib07__inv_1x inv_1x_2(.a(stallW), .y(stallWb));
  muddlib07__inv_1x inv_1x_3(.a(stallM), .y(stallMb));
  muddlib07__inv_1x inv_1x_4(.a(stallE), .y(stallEb));
  muddlib07__inv_1x inv_1x_5(.a(stallD), .y(stallDb));
  new_controller__maindec maindec_0(.op(opD[5:0]), .adelableD(adelableD), 
      .adesableD(adesableD), .alushcontrol(alushcontmaindecD[2:0]), 
      .alusrc(alusrcD), .byte(byteD), .cop0op(cop0opD), .fpuD(fpuD), 
      .halfword(halfwordD), .loadsignedD(loadsignedD), .lui(luiD), 
      .memtoreg(memtoregD), .memwrite(memwriteD), 
      .overflowable(maindecoverflowableD), .regdst(maindecregdstD), 
      .regwrite(mainregwrite), .riD(riD), .rtype(rtypeD), 
      .unsignedD(unsignedD), .useshift(maindecuseshifterD));
  new_controller__registers register_0(.adelableD(adelableD), 
      .adesableD(adesableD), .aluoutsrcD(aluoutsrcD[1:0]), 
      .alushcontrol(alushcontrolD[2:0]), .alusrcD(alusrcD), .bdsF(bdsF), 
      .breakD(breakD), .byteD(byteD), .cop0writeD(cop0writeD), .flushE(flushE), 
      .flushM(flushM), .fpuD(fpuD), .halfwordD(halfwordD), 
      .hilodisablealushD(hilodisablealushD[1:0]), .hiloselD(hiloselD), 
      .hilosrcD(hilosrcD), .loadsignedD(loadsignedD), .luiD(luiD), 
      .mdstartD(mdstartD), .memtoregD(memtoregD), .memwriteD(memwriteD), 
      .overflowableD(overflowableD), .ph1(ph1), .ph2(ph2), .regdstD(regdstD), 
      .regwriteD(regwriteD), .reset(reset), .resetb(resetb), .rfeD(rfeD), 
      .riD(riD), .specialregsrcD(specialregsrcD[1:0]), .stallDb(stallDb), 
      .stallEb(stallEb), .stallMb(stallMb), .stallWb(stallWb), 
      .syscallD(syscallD), .adelableE(adelableE), .adesableE(adesableE), 
      .aluoutsrcE(aluoutsrcE[1:0]), .alushcontrolE(alushcontrolE[2:0]), 
      .alusrcE(alusrcE), .bdsE(bdsE), .breakE(breakE), .byteM(byteM), 
      .cop0writeW(cop0writeW), .fpuE(fpuE), .halfwordE(halfwordE), 
      .halfwordM(halfwordM), .hilodisablealushE(hilodisablealushE[1:0]), 
      .hiloselE(hiloselE), .hilosrcE(hilosrcE), .loadsignedM(loadsignedM), 
      .luiE(luiE), .mdstartE(mdstartE), .memtoregE(memtoregE), 
      .memtoregM(memtoregM), .memtoregW(memtoregW), .memwriteM(memwriteM), 
      .overflowableE(overflowableE), .regdstE(regdstE), .regwriteE(regwriteE), 
      .regwriteM(regwriteM), .regwriteW(regwriteW), .rfeE(rfeE), .riE(riE), 
      .specialregsrcE(specialregsrcE[1:0]), .syscallE(syscallE));
  new_controller__specialregsrcD specialr_0(.hiloreadD(hiloreadD), 
      .hiloselD(hiloselD), .specialregsrcD(specialregsrcD[1:0]));
  new_controller__toplevellogic 
      toplevel_0(.alushdecoverflowableD(alushdecoverflowableD), 
      .branchD(branchD), .cop0readD(cop0readD), .cop0writeD(cop0writeD), 
      .hiloreadD(hiloreadD), .jumpD(jumpD), .linkD(linkD), 
      .maindecoverflowableD(maindecoverflowableD), 
      .maindecregdstD(maindecregdstD), .mainregwrite(mainregwrite), 
      .mdstartD(mdstartD), .bdsF(bdsF), .hiloaccessD(hiloaccessD), 
      .overflowableD(overflowableD), .regdstD(regdstD), 
      .regwriteD(regwriteD));
endmodule   /* new_controller__mipscontroller */

module MIPS__mips(dataackM, instrF, instrackF, interrupts, ph1, ph2, readdataM, 
      reset, aluoutM, byteenM, memtoregM, memwriteM, pcF, swc, writedataM);
  input dataackM;
  input [31:0] instrF;
  input instrackF;
  input [7:0] interrupts;
  input ph1;
  input ph2;
  input [31:0] readdataM;
  input reset;
  output [31:0] aluoutM;
  output [3:0] byteenM;
  output memtoregM;
  output memwriteM;
  output [31:0] pcF;
  output swc;
  output [31:0] writedataM;

  supply1 vdd;
  supply0 gnd;
  wire activeexception, adelableE, adelthrownE, adesableE, aeqbD, aeqzD, agtzD;
  wire altzD, alusrcE, bdsE, branchD, breakE, byteM, cop0writeW, flushE, flushM;
  wire fpuE, halfwordE, halfwordM, hiloaccessD, hilosrcE, isc, jumpD, jumpregD;
  wire linkD, loadsignedM, luiE, mdrunE, mdstartE, memtoregE, memtoregW;
  wire misalignedhE, misalignedwE, overflowE, overflowableE, pendingexception;
  wire rdsrcD, re, regdstE, regwriteE, regwriteM, regwriteW, rfeE, riE, stallD;
  wire stallE, stallM, stallW, syscallE, unsignedD;
  wire [1:0] aluoutsrcE;
  wire [2:0] alushcontrolE;
  wire [31:0] cop0readdataE;
  wire [5:0] functD;
  wire [1:0] hilodisableE;
  wire [5:0] opD;
  wire [31:0] pcE;
  wire [1:0] pcbranchsrcD;
  wire [1:0] pcsrcFD;
  wire [4:0] rdE;
  wire [4:0] rsD;
  wire [4:0] rtD;
  wire [1:0] specialregsrcE;
  wire [31:0] writedataW;
  wire [4:0] writeregW;

  DatapathDone__Datapath_Final Datapath_0(.aluoutsrcE(aluoutsrcE[1:0]), 
      .alushcontrolE(alushcontrolE[2:0]), .alusrcE(alusrcE), .branchD(branchD), 
      .byteM(byteM), .cop0readdataE(cop0readdataE[31:0]), .dataackM(dataackM), 
      .halfwordM(halfwordM), .hiloaccessD(hiloaccessD), 
      .hilodisableE(hilodisableE[1:0]), .hilosrcE(hilosrcE), 
      .instrF(instrF[31:0]), .instrackF(instrackF), .jumpregD(jumpregD), 
      .loadsignedM(loadsignedM), .luiE(luiE), .mdstartE(mdstartE), 
      .memtoregE(memtoregE), .memtoregM(memtoregM), .memtoregW(memtoregW), 
      .pcbranchsrcD(pcbranchsrcD[1:0]), .pcsrcFD(pcsrcFD[1:0]), 
      .pendingexception(pendingexception), .ph1(ph1), .ph2(ph2), 
      .rdsrcD(rdsrcD), .re(re), .readdataM(readdataM[31:0]), .regdstE(regdstE), 
      .regwriteE(regwriteE), .regwriteM(regwriteM), .regwriteW(regwriteW), 
      .reset(reset), .specialregsrcE(specialregsrcE[1:0]), 
      .unsignedD(unsignedD), .activeexception(activeexception), 
      .adelthrownE(adelthrownE), .aeqbD(aeqbD), .aeqzD(aeqzD), .agtzD(agtzD), 
      .altzD(altzD), .aluoutM(aluoutM[31:0]), .byteenM(byteenM[3:0]), 
      .flushE(flushE), .flushM(flushM), .functD(functD[5:0]), .mdrunE(mdrunE), 
      .misalignedhE(misalignedhE), .misalignedwE(misalignedwE), .opD(opD[5:0]), 
      .overflowE(overflowE), .pcE(pcE[31:0]), .pcF(pcF[31:0]), .rdE(rdE[4:0]), 
      .rsD(rsD[4:0]), .rtD(rtD[4:0]), .stallD(stallD), .stallE(stallE), 
      .stallM(stallM), .stallW(stallW), .writedata2M(writedataM[31:0]), 
      .writedataW(writedataW[31:0]), .writeregW(writeregW[4:0]));
  cop0__coprocessor0 coproces_0(.activeexception(activeexception), 
      .adelableE(adelableE), .adelthrownE(adelthrownE), .adesableE(adesableE), 
      .bdsE(bdsE), .breakE(breakE), .cop0writeW(cop0writeW), .fpuE(fpuE), 
      .halfwordE(halfwordE), .interrupts(interrupts[7:0]), 
      .misalignedhE(misalignedhE), .misalignedwE(misalignedwE), 
      .overflowE(overflowE), .overflowableE(overflowableE), .pcE(pcE[31:0]), 
      .ph1(ph1), .ph2(ph2), .readaddress(rdE[4:0]), .reset(reset), .rfeE(rfeE), 
      .riE(riE), .syscallE(syscallE), .writeaddress(writeregW[4:0]), 
      .writecop0W(writedataW[31:0]), .cop0readdataE(cop0readdataE[31:0]), 
      .isc(isc), .pendingexception(pendingexception), .re(re), .swc(swc));
  new_controller__mipscontroller mipscont_0(.aeqbD(aeqbD), .aeqzD(aeqzD), 
      .agtzD(agtzD), .altzD(altzD), .flushE(flushE), .flushM(flushM), 
      .functD(functD[5:0]), .mdrunE(mdrunE), .opD(opD[5:0]), 
      .pendingexception(pendingexception), .ph1(ph1), .ph2(ph2), .reset(reset), 
      .rsD(rsD[4:0]), .rtD(rtD[4:0]), .stallD(stallD), .stallE(stallE), 
      .stallM(stallM), .stallW(stallW), .adelableE(adelableE), 
      .adesableE(adesableE), .aluoutsrcE(aluoutsrcE[1:0]), 
      .alushcontrolE(alushcontrolE[2:0]), .alusrcE(alusrcE), .bdsE(bdsE), 
      .branchD(branchD), .breakE(breakE), .byteM(byteM), 
      .cop0writeW(cop0writeW), .fpuE(fpuE), .halfwordE(halfwordE), 
      .halfwordM(halfwordM), .hiloaccessD(hiloaccessD), 
      .hilodisableE(hilodisableE[1:0]), .hilosrcE(hilosrcE), .jumpD(jumpD), 
      .jumpregD(jumpregD), .linkD(linkD), .loadsignedM(loadsignedM), 
      .luiE(luiE), .mdstartE(mdstartE), .memtoregE(memtoregE), 
      .memtoregM(memtoregM), .memtoregW(memtoregW), .memwriteM(memwriteM), 
      .overflowableE(overflowableE), .pcbranchsrcD(pcbranchsrcD[1:0]), 
      .pcsrcFD(pcsrcFD[1:0]), .rdsrcD(rdsrcD), .regdstE(regdstE), 
      .regwriteE(regwriteE), .regwriteM(regwriteM), .regwriteW(regwriteW), 
      .rfeE(rfeE), .riE(riE), .specialregsrcE(specialregsrcE[1:0]), 
      .syscallE(syscallE), .unsignedD(unsignedD));
endmodule   /* MIPS__mips */

module topmips(input         ph1, ph2, reset,
                     input  [7:0]  interrupts,
                     output [31:0] memadr,
                     inout  [31:0] memdata,
                     output [3:0] membyteen,
                     output        memrwb,
                     output        memen,
                     input         memdone);
  assign memadr[1:0] = 2'b0;
  assign memadr[31:29] = 3'b0;
  supply1 vdd;
  supply0 gnd;
  wire dataackM, instrackF, memtoregM, memwriteM, swc;
  wire [31:0] aluoutM;
  wire [3:0] byteenM;
  wire [31:0] instrF;
  wire [31:0] pcF;
  wire [31:0] readdataM;
  wire [31:0] writedataM;

  memsys_final__memsys memsys_0(.adrM(aluoutM[31:2]), .byteenM(byteenM[3:0]), 
      .memdone(memdone), .memwriteM(memwriteM), .pcF(pcF[31:2]), .ph1(ph1), 
      .ph2(ph2), .reF(vdd), .reM(memtoregM), .reset(reset), .swc(swc), 
      .writedataM(writedataM[31:0]), .dataackM(dataackM), 
      .instrF(instrF[31:0]), .instrackF(instrackF), .memadr(memadr[28:2]), 
      .membyteen(membyteen[3:0]), .memen(memen), .memrwb(memrwb), 
      .readdataM(readdataM[31:0]), .memdata(memdata[31:0]));
  MIPS__mips mips_0(.dataackM(dataackM), .instrF(instrF[31:0]), 
      .instrackF(instrackF), .interrupts(interrupts[7:0]), .ph1(ph1), 
      .ph2(ph2), .readdataM(readdataM[31:0]), .reset(reset), 
      .aluoutM(aluoutM[31:0]), .byteenM(byteenM[3:0]), .memtoregM(memtoregM), 
      .memwriteM(memwriteM), .pcF(pcF[31:0]), .swc(swc), 
      .writedataM(writedataM[31:0]));
endmodule   /* topmips */
