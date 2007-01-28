//------------------------------------------------
// mem.v
// npinckney@hmc.edu  January 2007
// Memory subsystem of mips microprocessor
//
// WORK IN PROGRESS
//------------------------------------------------

`timescale 1 ns / 1 ps

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

module memsys(input swap);
    
endmodule

// Implementation of upper bit bypass here.
// Description of interface:
//
// pcF = Program counter (memory address)
// instrF = Instruction fetched (instruction data)
//
// swc = swap caches.  (0 = normal assignment, 1 = swapped)
module cachecontroller(input clk, reset,
                       input [31:0] pcF,
                       output [31:0] instrF,
                       input enF,
                       output instrackF,
                       
                       input [29:0] adrM, 
                       input [31:0] writedataM,
                       input [3:0] byteenM,
                       output [31:0] readdataM,
                       input memwriteM, enM,
                       output dataackM,
                       
                       input swc);

wire [29:0] dadr;
wire [31:0] ddata;
wire [3:0] dbyteen;
wire drwb, den, ddone;
wire [29:0] dmemadr;
wire [31:0] dmemdata;
wire [3:0] dmembyteen;
wire dmemrwb, dmemen;
reg dmemdone;


wire [29:0] iadr;
wire [31:0] idata;
wire [3:0] ibyteen;
wire irwb, ien, idone;
wire [29:0] imemadr;
wire [31:0] imemdata;
wire [3:0] imembyteen;
wire imemrwb, imemen;
reg imemdone;

wire [29:0] wbadr;
wire [31:0] wbdata;
wire [3:0] wbbyteen;
wire wbrwb, wben, wbdone;
wire [29:0] wbmemadr;
wire [31:0] wbmemdata;
wire [3:0] wbmembyteen;
wire wbmemen;
reg wbmemdone;

reg [29:0] memadr;
reg [31:0] memdata;
reg [3:0] membyteen;
reg memrwb, memen;
reg memdone;

reg don,ion,wbon;

// This swaps the output if swc is asserted.
// The first is the swapped case, second is normal.
// Inputs:
assign iadr = (swc) ? adrM  : pcF;
assign dadr = (swc) ? pcF : adrM;
assign ien = (swc) ? enM : enF;
assign den = (swc) ? enF : enM;
assign ibyteen = (swc) ? byteenM : 4'b1;
assign dbyteen = (swc) ? 4'b1 : byteenM;
assign irwb = (swc) ? ~memwriteM : 1'b1;
assign drwb = (swc) ? 1'b1 : ~memwriteM;

// If reading want this to be z,
// if writing then drive with the data to write.
assign ddata = (swc | ~memwriteM) ? 32'bz : writedataM;
assign idata = (swc | memwriteM) ? writedataM : 32'bz;

// Outputs:
assign instrF = (swc) ? ddata : idata;
assign readdataM = (swc) ? idata : ddata;
assign instrackF = (swc) ? ddone : idone;
assign dataackM = (swc) ? idone : ddone;


cache dcache(clk, reset, dadr, ddata, dbyteen,
                         drwb, den, ddone,
                         dmemadr,dmemdata,dmembyteen,
                         dmemrwb, dmemen,dmemdone);
                         
cache icache(clk, reset, iadr, idata, ibyteen,
                         irwb, ien, idone,
                         imemadr,imemdata,imembyteen,
                         imemrwb, imemen,imemdone);

// TODO: first one should go to memory multiplexor.
// we need to split this up... so that it can directly access the buffer.
//assign dmemdone = (dmemrwb) ? wbdone : wbdone;

writebuffer writebuf(clk, reset, wbadr, wbdata, wbbyteen,
                          wben, wbdone,
                          wbmemadr, wbmemdata, wbmembyteen,
                          wbmemen, wbmemdone);
                          
// TODO: modify this so that memdata is muxed between z and the register.
//       also, mem will probably be moved externally.
testmem mem(clk, reset, memadr, memdata, membyteen,
               memrwb, memen, memdone);
               
always @(negedge reset)
begin
    dmemdone <= 0;
    imemdone <= 0;
    wbmemdone <= 0;
end

always @(posedge clk)
begin
    if(~(wbon | don | ion)) // If we aren't already working...
    begin
        if(wben)
        begin
            wbon <= 1;
            memadr <= wbmemadr;
            memdata <= wbmemdata;
            membyteen <= wbmembyteen;
            memrwb <= 1'b0;  // write only.
            memen <= 1;
        end
        
        if(den & ~wben)
        begin
            don <= 1;
            memadr <= dmemadr;
            memdata <= dmemdata;
            membyteen <= dmembyteen;
            memrwb <= 1'b1;   // read only (writes go to write buffer)
            memen <= 1;     
        end
        
        if(ien & ~(wben | den))
        begin
            ion <= 1;
            memadr <= imemadr;
            memdata <= imemdata;
            membyteen <= imembyteen;
            memrwb <= 1'b1;   // read only (writes disallowed)
            memen <= 1;
        end
    end else begin    
      // TODO: remove this level.
      if(memdone)
      begin
          memen <= 0;   // We're done using the memory.
          // Deactivate these.
          don <= 1'b0;
          ion <= 1'b0;
          wbon <= 1'b0;
      end
    end
    // Has the result of asserting the respective done
    // for one cycle if memory has acknowledged the operation.
    dmemdone <= (memdone) ? don : 1'b0;
    imemdone <= (memdone) ? ion : 1'b0;
    wbmemdone <= (memdone) ? wbon : 1'b0;
end
endmodule

module testmem(input clk, reset,
               input [29:0] adr,
               inout [31:0] data,
               input [3:0] byteen,
               input rwb, en,
               output reg done);

integer i;

reg [31:0] mem[4095:0];
always @(negedge reset)
  begin
      for(i = 0; i < 4096; i = i + 1)
      begin
         mem[i] = 32'b0;
      end
    
      mem[0] = 32'hDEADBEEF;
      mem['had] = 32'hBEADBEEF;
      mem['h4ad] = 32'h21212121;
      done <= 1;
      i = 0;
  end


always @(posedge clk)
  begin
    i = i + 1;
    if(en & done)
    begin
      i = 0;
      done <= 0;
     end
    if(i == 1 & ~done)
    begin
        $display("DONE ! ");
        done <= 1;
    end    
  end

assign data = (rwb) ? mem[adr] : 32'bz;

endmodule
               
               
// TODO: We could reduce this interface by attaching at cachecontroller level.  Or make a memory controller?
module cache(input clk, reset,
             input [29:0] adr,
             inout [31:0] data,
             input [3:0] byteen,
             input rwb, en,
             output done,
             output [29:0] memadr, 
             input [31:0] memdata,
             output [3:0] membyteen,
             output memrwb, memen,
             input memdone);
             
            reg [52:0] cachedata[1023:0];
            reg waiting;

            wire [9:0] tag;
            wire [19:0] adrmsb;
            wire incache;
            wire [19:0] tagdata;
            wire valid;
            wire [31:0] cacheline;  // TODO: cache line correct here?
            wire [52:0] cacheslot;  // TODO: cache slot correct here?
            
            always @(negedge reset)
            begin
                waiting <= 0;
            end
            
       
            assign adrmsb = adr[29:10];
            assign tag = adr[9:0];
            assign cacheslot = cachedata[tag];
            assign valid = cacheslot[52];
            assign tagdata = cacheslot[51:32];
            assign cacheline = cacheslot[31:0];
            
            assign incache = (tagdata == adrmsb) & valid;
         
            assign data = (en & rwb & incache) ? cacheline : 32'bz;
            assign done = incache;
            
            // TODO: finish writing implementation.
            // Need an extra "writing" reg to make sure this isn't the first write.
            assign memadr = adr;
            assign memen = (en & rwb & ~incache) |  // Enable memory interface if
                           (en & ~rwb);              // it is reading and not in cache
                                                    // or if we are writing.
            
            always @(posedge clk)
              begin
                  if(en) begin
                    if(~rwb) begin // If we're writing.
                      cachedata[tag] <= (| byteen) ? 
                                          53'b0 :   // If less than a word, invalidate.
                                          {1'b1, adrmsb, data};  // Otherwise, store and valid.
                    end
                    if(rwb & ~incache & memdone) begin
                      cachedata[tag] <= {1'b1, adrmsb, memdata};
                    end
                end
              end     
endmodule

module writebuffer(input clk, reset,
                   input [29:0] adr,
                   input [31:0] data,
                   input [3:0] byteen,
                   input en,
                   output done,
                   
                   output reg [29:0] memadr,
                   output reg [31:0] memdata,
                   output reg [3:0] membyteen,
                   output reg memen,
                   input memdone);
   reg [1:0] ptr;               // Current place to store.
   reg [1:0] writeptr;
   reg writing;
   wire [1:0] nextptr;
   wire [1:0] nextwriteptr;
   reg [31:0] bufdata[3:0];
   reg [29:0] bufadr[3:0];
   reg [3:0] bufbyteen[3:0];
    
   assign done = ~((ptr == writeptr) & writing);   // If we have a free space available.
   
   assign nextptr = (nextptr + 1 == 4) ? 0 : nextptr + 1;
   assign nextwriteptr = (nextwriteptr + 1 == 4) ? 0 : nextwriteptr + 1;
   
   always @(negedge reset)
   begin
       ptr <= 0;
       writeptr <= 0;
       writing <= 0;
       memen <= 0;
       memadr <= 0;
       memdata <= 0;
       membyteen <= 0;
   end
   
   always @(posedge clk)
   begin
       if(en & done)
       begin
           bufadr[ptr] <= adr;
           bufdata[ptr] <= data;
           bufbyteen[ptr] <= byteen;
           ptr <= nextptr;
           writing <= 1;
           memadr <= bufadr[writeptr];   // TODO: improve this design so that 
           memdata <= bufdata[writeptr]; // memadr/data/etc not here.
           membyteen <= bufbyteen[writeptr];
           memen <= 1;
           $display("HERE %h", bufadr[ptr]);
       end
       
       if(writing & memdone)
       begin
           if(writeptr == nextwriteptr)
           begin
               writing <= 0;
               memen <= 0;
           end else begin
              memadr <= bufadr[nextwriteptr]; 
              memdata <= bufdata[nextwriteptr];
              membyteen <= bufbyteen[nextwriteptr];
              memen <= 1;
           end   
           writeptr <= nextwriteptr;
      end
   end
endmodule
