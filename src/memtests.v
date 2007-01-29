//------------------------------------------------
// memtests.v
// npinckney@hmc.edu  January 2007
// Memory subsystem of mips microprocessor
//
// Test benches for mips memory system
//------------------------------------------------

module testbench;
    
  reg         clk;
  reg         reset;
  reg    [31:0]     datar;
  wire    [31:0]    data;
  wire        done;
  wire         donetest;
  reg [29:0] adr;
  reg rwb, en;
  reg invalidate;

/*  
  wire memreaddone;
  wire [29:0] memadr;
  wire [31:0] memreaddata;
  wire memreaden;
  */
  wire [29:0] memadr;
  wire [31:0] memdata;
  wire [3:0] membyteen;
  wire memen;
  reg memdone;
  
  integer counter;

  assign data = (rwb) ? 32'bz : datar;

  // generate clock to sequence tests
  always
    begin
      #30;
      clk <= 1; # 5; clk <= 0; # 5;
    end
    
  initial
    begin
      counter <= 0;
      reset <= 1; #15; reset <= 0;
    end

   always @(posedge clk)
     begin
       case (counter)
           /*
         0: begin
            adr <= 30'h0;
            datar <= 32'hDEADBEEF;
            rwb <= 0;
            en <= 1;
            invalidate <= 0;
            #1
            $display("Wrote to %h: %h, done: %d", adr, data, done);
            end
         1: begin
            adr <= 30'hAC;
            datar <= 32'hABCDEFAB;
            rwb <= 0;
            en <= 1;
            invalidate <= 0;
            #1
            $display("Wrote to %h: %h, done: %d", adr, data, done);
            end
         2: begin
            adr <= 30'hAD;
            datar <= 32'h00000100;
            rwb <= 0;
            en <= 1;
            invalidate <= 1;
            #1
            $display("Wrote to %h: %h, done: %d", adr, data, done);
            end
         3: begin
            adr <= 30'hAD;
            rwb <= 1;
            en <= 1;
            invalidate <= 0;
            #1
            $display("Read from %h: %h, done: %d", adr, data, done);
            end
         4: begin
            $display("Read from %h: %h, done: %d", adr, data, done);
            end
         5: begin
            #1;
            $display("Read from %h: %h, done: %d", adr, data, done);
            end
         6: begin
            #1;
            adr <= 30'h4AD;
            $display("Read from %h: %h, done: %d", adr, data, done);
            end
         7: begin
             $display("Read from %h: %h, done: %d", adr, data, done);
            end
         8: begin
             $display("Read from %h: %h, done: %d", adr, data, done);
         end
         9: begin
             $display("Read from %h: %h, done: %d", adr, data, done);
         end
         10: begin
            adr <= 30'h0;
            rwb <= 1;
            en <= 1;
            #1;
            $display("Read from %h: %h, done: %d", adr, data, done);
            end
         11: begin
            adr <= 30'hAC;
            rwb <= 1;
            en <= 1;
            #1;
            $display("Read from %h: %h, done: %d", adr, data, done);
            end
         12: begin
            adr <= 30'hAD;
            rwb <= 1;
            en <= 1;
            #1;
            $display("Read from %h: %h, done: %d", adr, data, done);
            end
         13: begin
             $display("Read from %h: %h, done: %d", adr, data, done);
         end
         14: begin
             $display("Read from %h: %h, done: %d", adr, data, done);
         end
         15: begin
             $display("Read from %h: %h, done: %d", adr, data, done);
         end
         16: begin
             $display("Read from %h: %h, done: %d", adr, data, done);
         end */
         0: begin
            memdone <= 1;
            adr <= 30'h0;
            datar <= 32'hDEADBEEF;
            en <= 1;
            #1;
            $display("mem adr: %h, memdata %h, memen: %d, done: %d", memadr,memdata,memen,done);
         end
         1: begin
            $display("mem adr: %h, memdata %h, memen: %d, done: %d", memadr,memdata,memen,done);
         end
         2: begin
             $display("mem adr: %h, memdata %h, memen: %d, done: %d", memadr,memdata,memen,done);
         end
         default: begin
            $stop;
            end
        endcase
        counter <= counter + 1;
     end

/*
  cache testcache(clk,reset,adr,data,rwb,en,done,invalidate,
                memadr, memreaddata, memreaden,memreaddone);

  testmem mem(clk,reset,memadr,memreaddata,1'b1,memreaden,memreaddone);
  */

  
  writebuffer writebuf(clk,reset,adr,datar,en,done,4'b1,
     memadr,memdata,membyteen, memen, memdone);
  /*
  module writebuffer(input clk, reset,
                   input [29:0] adr,
                   input [31:0] data,
                   input en, output done,
                   input [3:0] byteen,
                   output reg [29:0] memadr,
                   output reg [31:0] memdata,
                   output reg [3:0] membyteen,
                   output reg memen,
                   input memdone)
                   */
endmodule

// Test code for writebuffer.
module testbenchwb;
  reg         clk;
  reg         reset;
  reg    [31:0]     datar;
  wire    [31:0]    data;
  wire        done;
  wire         donetest;
  reg [29:0] adr;
  reg rwb, en;
  reg invalidate;

  wire [29:0] memadr;
  wire [31:0] memdata;
  wire [3:0] membyteen;
  wire memen;
  reg memdone;
  
  integer counter;

  assign data = (rwb) ? 32'bz : datar;

  // generate clock to sequence tests
  always
    begin
      #30;
      clk <= 1; # 5; clk <= 0; # 5;
    end
    
  initial
    begin
      counter <= 0;
      reset <= 1; #15; reset <= 0;
    end

   always @(posedge clk)
     begin
       case (counter)
           0: begin
            memdone <= 1;
            adr <= 30'h0;
            datar <= 32'hDEADBEEF;
            en <= 1;
         end
         1: begin
            adr <= 30'h0;
            datar <= 32'hAAAAAAAA;
            en <= 1;
            $display("mem adr: %h, memdata %h, memen: %d, done: %d", memadr,memdata,memen,done);
         end
         2: begin
            adr <= 30'h0;
            datar <= 32'hBBBBBBBB;
            en <= 1;           
             $display("mem adr: %h, memdata %h, memen: %d, done: %d", memadr,memdata,memen,done);
         end
         3: begin
            adr <= 30'h0;
            datar <= 32'hCCCCCCCC;
            en <= 1;
             $display("mem adr: %h, memdata %h, memen: %d, done: %d", memadr,memdata,memen,done);
         end
         4: begin
             adr <= 30'h0;
             datar <= 32'hDDDDDDDD;
             en <= 1;
             $display("mem adr: %h, memdata %h, memen: %d, done: %d", memadr,memdata,memen,done);
         end
         5: begin
             datar <= 32'h00000000;
             en <= ~done; 
             $display("mem adr: %h, memdata %h, memen: %d, done: %d", memadr,memdata,memen,done);
         end
         10: begin
             memdone <= 1;
             en <= ~done; 
         end
         default: begin
            en <= ~done; 
            $display("mem adr: %h, memdata %h, memen: %d, done: %d", memadr,memdata,memen,done);
            if(counter == 20) $stop;
            end
        endcase
        counter <= counter + 1;
     end

  
  writebuffer writebuf(clk,reset,adr,datar,4'b1,en,done,
     memadr,memdata,membyteen,memen,memdone);
endmodule

// Test code for cache.
module testbenchc;
  reg         clk;
  reg         reset;

  reg  [29:0] adr;
  wire [31:0] data;
  reg  [3:0]  byteen;
  reg  rwb, en;
  wire done;
  reg  [31:0] dataf;

  wire [29:0] memadr;
  wire [31:0] memdata;
  wire [3:0] membyteen;
  wire memrwb;
  wire memen;
  reg  memdone;
  reg  [31:0] memdataf;
  
  integer counter;

  assign data = (rwb) ? 32'bz : dataf;
  assign memdata = (memrwb) ? memdataf : 32'bz;

  // generate clock to sequence tests
  always
    begin
      #30;
      clk <= 1; # 5; clk <= 0; # 5;
    end
    
  initial
    begin
      counter <= 0;
      reset <= 1; #15; reset <= 0;
      en <= 0;     
    end

   always @(posedge clk)
     begin
       $display("%d", counter);
       case (counter)
         0: begin
            memdone <= 1;
            adr <= 30'h0;
            dataf <= 32'hDEADBEEF;
            byteen <= 4'b1111;
            rwb <= 1'b0;
            en <= 1;
         end

         3: begin
            memdone <= 1;
            adr <= 30'h0;
            dataf <= 32'hAABBCCDD;
            byteen <= 4'b1101;
            rwb <= 1'b0;
            en <= 1;
            $display("mem adr: %h, memdata %h, memen: %d, done: %d", memadr,memdata,memen,done);
         end        
        
         6:
         begin
            memdone <= 1;
            memdataf <= 32'hAAAAAAAA;
            
            adr <= 30'h0;
            byteen <= 4'b1111;
            rwb <= 1'b1;
            en <= 1;
            $display("read: %h, data %h, done: %d", adr,data,done);
            $display("readmem adr: %h, memdata %h, memen: %d, en %d done: %d", memadr,memdata,memen,en, done);
         end
         
         default: begin
            dataf <= (done) ? 32'b0 : dataf;
            en <= (done) ? 0 : en; 
            $display("read: %h, data %h, done: %d", adr,data,done);
            $display("mem adr: %h, memdata %h, memen: %d, en %d done: %d", memadr,memdata,memen,en, done);
            if(counter == 20) $stop;
            end
        endcase
        counter <= counter + 1;
        $display("");
     end

  cache testcache(clk,reset,adr,data,byteen,rwb,en,done,
     memadr,memdata,membyteen,memrwb,memen,memdone);
endmodule