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
  
  wire memreaddone;
  wire [29:0] memadr;
  wire [31:0] memreaddata;
  wire memreaden;
  
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
         end
         default: begin
            $stop;
            end
        endcase
        counter <= counter + 1;
     end

  cache testcache(clk,reset,adr,data,rwb,en,done,invalidate,
                memadr, memreaddata, memreaden,memreaddone);

  testmem mem(clk,reset,memadr,memreaddata,1'b1,memreaden,memreaddone);
endmodule

module memsys(input swap);
    
endmodule

// Implementation of upper bit bypass here.
module cachecontroller(input clk, reset,
                       input [31:0] pcF,
                       output [31:0] instrF,
                       input rwbM,            // 0 = write, 1 = read
                       input enM,             // Enable.  Read/write on this cycle.
                       input [3:0] byteenM,
                       input [31:0] adrM, writedataM,
                       output [31:0] readdataM,
                       output instrackF, dataackM,
                       input swc);
                       
wire ddone, cdone;                       

//cache dcache(clk,reset,adrM,writedataM,rwbM,enM,ddone);
//cache icache(clk,reset,pcF,instrF,rwbM,enM,ddone);

endmodule

module testmem(input clk, reset,
               input [29:0] adr,
               inout [31:0] data,
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
               
              
module cache(input clk, reset,
             input [29:0] adr,
             inout [31:0] data,
             input rwb, en,
             output done,
             input invalidate,
             output [29:0] memadr, 
             input [31:0] memreaddata,
             output memreaden,
             input memreaddone);
             
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
            
            assign memadr = adr;
            // TODO: delay memory interface so it waits at least one cycle...
            // and only sends enable once!
            assign memreaden = (en & rwb) & ~incache;
            
            always @(posedge clk)
              begin
                  if(en) begin
                    if(~rwb) begin // If we're writing.
                      cachedata[tag] <= (invalidate) ? 
                                          53'b0 : 
                                          {1'b1, adrmsb, data};
                    end
                    if(rwb & ~incache & memreaddone) begin
                      cachedata[tag] <= {1'b1, adrmsb, memreaddata};
                    end
                end
              end     
endmodule

module writebuffer(input clk, reset);
    reg [1:0] ptr;
    reg [35:0] data[3:0];
    
endmodule
