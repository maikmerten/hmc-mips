//------------------------------------------------
// mem.v
// npinckney@hmc.edu  January 2007
// Memory subsystem of mips microprocessor
//
// WORK IN PROGRESS
//------------------------------------------------

`timescale 1 ns / 1 ps

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

// Implementation of upper bit bypass here.
// Description of interface:
//
// pcF = Program counter (memory address)
// instrF = Instruction fetched (instruction data)
//
// swc = swap caches.  (0 = normal assignment, 1 = swapped)
// TODO: add cache bypass (or two controller.. above).
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

// TEST MEMORY
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
               
// 4kB CACHE
//
// TODO: Forward requests to write buffer.
module cache(input clk, reset,
             input [29:0] adr,
             inout [31:0] data,
             input [3:0] byteen,
             input rwb, en,
             output done,
             
             output reg [29:0] memadr, 
             inout  [31:0] memdata,
             output reg [3:0] membyteen,
             output reg memrwb,
             output reg memen,
             input memdone);
            
            reg [31:0] cacheline[1023:0];
            reg [19:0] tagdata[1023:0];
            reg        valid[1023:0];

            reg [31:0] memdataf;
            reg memdonef;

            wire [9:0] tag;
            wire [19:0] adrmsb;
            wire incache;
            assign tag = adr[9:0];
            assign adrmsb = adr[29:10];
            assign incache = (tagdata[tag] == adrmsb) & valid[tag];
            
            assign data = (rwb) ? cacheline[tag] : 32'bz;
            assign done = (incache & rwb) ? 1'b1 : memdonef;
            
            // Pass these on directly.
            assign memdata = (memrwb) ?
                              32'bz : memdataf;
  
            always @(negedge reset)
            begin
                memdataf <= 0;
                memen <= 0;
                memdonef <= 0;
            end
                          
            always @(posedge clk)
            begin
                  // If a request is pending,
                  // we're not already done,
                  // and we're not already working.
                  if(en & ~done & ~memen) begin
                    // If we're beginning writing.
                    if(~rwb) begin
                        cacheline[tag] <= (& byteen) ? data : 32'b0;
                        tagdata[tag] <= (& byteen) ? adrmsb : 20'b0;
                        valid[tag] <= (& byteen) ? 1'b1 : 1'b0; // If less than a word, invalidate.
                        memadr <= adr;
                        memdataf <= data;
                        membyteen <= byteen;
                        memrwb <= 1'b0;   // Writing
                        memen <= 1'b1;
                        $display("HERE %h", data);
                    end
                    
                    // If the entry is not in cache,
                    // we must read it from main memory.
                    if(rwb) begin
                        memadr <= adr;
                        membyteen <= 4'b1; // We'll always read in all.
                        memrwb <= 1'b1;    // Reading
                        memen <= 1'b1;
                    end
                end
                
                memdonef <= memen & memdone;
                
                // If we're done writing.
                if(~memrwb & memen & memdone) begin
                     memen <= 1'b0;
                end
                
               // If we're done reading.
               if(rwb & memen & memdone) begin
                   cacheline[tag] <= memdata;
                   tagdata[tag] <= adrmsb;
                   valid[tag] <= 1'b1;
                   memen <= 1'b0;
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
   reg [1:0] writeptr;          // Next value to write.
   reg [31:0] bufdata[3:0];
   reg [29:0] bufadr[3:0];
   reg [3:0] bufbyteen[3:0];
   reg [3:0] bufen[3:0];      // Flag to indicate whether buffer entry has
                              // valid data.
  
   assign done = ~bufen[ptr];   // If we have a free space available.
   
   always @(negedge reset)
   begin
       ptr <= 0;
       writeptr <= 0;
       memadr <= 0;
       memdata <= 0;
       membyteen <= 0;
       memen <= 0;
       bufen[0] <= 0;
       bufen[1] <= 0;
       bufen[2] <= 0;
       bufen[3] <= 0;
   end
   
   always @(posedge clk)
   begin     
       // If we have space, write to
       // buffer.
       if(en & done)
       begin
           bufadr[ptr] <= adr;
           bufdata[ptr] <= data;
           bufbyteen[ptr] <= byteen;
           bufen[ptr] <= 1;
           ptr <= ptr + 1;  // Assumes LSBs
       end
       
       // If memory is done or we aren't writing
       // then start a write, or disable memory.
       if(memdone | ~memen)   
       begin
          if(bufen[writeptr])  // write next one
           begin
              memadr <= bufadr[writeptr]; 
              memdata <= bufdata[writeptr];
              membyteen <= bufbyteen[writeptr];
              bufen[writeptr] <= 0;
              writeptr <= writeptr + 1; // Assumes LSBs
           end
           memen <= bufen[writeptr];
       end
   end
endmodule
