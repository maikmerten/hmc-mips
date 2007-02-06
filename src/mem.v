//------------------------------------------------
// mem.v
// npinckney@hmc.edu  January 2007
// Memory subsystem of mips microprocessor
//
// WORK IN PROGRESS
//------------------------------------------------

`timescale 1 ns / 1 ps

// Test code for cache controller.
module testbenchccontroller;
  reg         clk;
  reg         reset;

  reg  [31:0] pcF;
  wire [31:0] instrF;
  reg enF;
  wire instrackF;
  
  reg [29:0] adrM;
  reg [31:0] writedataM;
  reg  [3:0]  byteenM;
  wire [31:0] readdataM;
  reg memwriteM, enM;
  wire dataackM;
  
  reg swc;
  
  integer counter;

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
      enM <= 0; 
      enF <= 0;
      swc <= 1;
    end

   always @(posedge clk)
     begin
       $display("%d", counter);
       case (counter)
         0: begin
            pcF <= 32'hA00012B4;
            enF <= 1;
         //   adrM <= 32'h200004Ad;
         //   memwriteM <= 0;
         //   enM <= 1;
              adrM <= 30'h000004Ad;
              writedataM <= 32'hDDCCBBAA;
              memwriteM <= 1;
              byteenM <= 4'b1111;
              enM <= 1;
         end
        2: begin
              adrM <= 30'h000004Ad;
              writedataM <= 32'hDDCCBBAA;
              memwriteM <= 0;
              enM <= 1;
            $display("instrackF: %d (%d), dataackM: %d (%d)",instrackF,enF,dataackM,enM);
            $display("instrF: %h, readdataM: %h", instrF, readdataM);
        end
        // 3: begin
        //      adrM <= 32'h200004Ad;
        //      memwriteM <= 0;
        //      enM <= 1;    
       //   end
         5: begin
             pcF <= 32'hA00012B4;
             enF <= 1;
             $display("instrackF: %d (%d), dataackM: %d (%d)",instrackF,enF,dataackM,enM);
            $display("instrF: %h, readdataM: %h", instrF, readdataM);
        end
         default: begin
            enM <= (dataackM) ? 0 : enM; 
            enF <= (instrackF) ? 0 : enF;
            $display("instrackF: %d (%d), dataackM: %d (%d)",instrackF,enF,dataackM,enM);
            $display("instrF: %h, readdataM: %h", instrF, readdataM);
            if(counter == 15) $stop;
            end
        endcase
        counter <= counter + 1;
        $display("");
     end

cachecontroller cc(clk, reset, pcF, instrF, enF, instrackF,
                   adrM, writedataM, byteenM, readdataM,
                   memwriteM, enM, dataackM,
                   swc);

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
  wire dmemdone;
  wire dmemdonewire;


  wire [29:0] iadr;
  wire [31:0] idata;
  wire [3:0] ibyteen;
  wire irwb, ien, idone;
  wire [29:0] imemadr;
  wire [31:0] imemdata;
  wire [3:0] imembyteen;
  wire imemrwb, imemen;
  wire imemdone;
  wire imemdonewire;

  wire [29:0] wbadr;
  wire [31:0] wbdata;
  wire [3:0] wbbyteen;
  wire wbrwb, wben, wbdone;
  wire [29:0] wbmemadr;
  wire [31:0] wbmemdata;
  wire [3:0] wbmembyteen;
  wire wbmemen;
  wire wbmemdone;

  wire [29:0] memadr;
  wire [31:0] memdata;
  reg [31:0] memdataf;
  wire [3:0] membyteen;
  wire memrwb;
  wire memen;
  wire memdone;

  wire don,ion,wbon;

  // This swaps the output if swc is asserted.
  // The first is the swapped case, second is normal.
  // Inputs:
  assign iadr = (swc) ? adrM  : pcF[31:2];
  assign dadr = (swc) ? pcF[31:2] : adrM;
  assign ien = (swc) ? enM : enF;
  assign den = (swc) ? enF : enM;
  assign ibyteen = (swc) ? byteenM : 4'b1;
  assign dbyteen = (swc) ? 4'b1 : byteenM;
  assign irwb = (swc) ? ~memwriteM : 1'b1;
  assign drwb = (swc) ? 1'b1 : ~memwriteM;

  wire working;
  assign working = wbon | don | ion;

  // If reading want this to be z,
  // if writing then drive with the data to write.
  assign ddata = (swc | ~memwriteM) ? 32'bz : writedataM;
  assign idata = (~swc | ~memwriteM) ? 32'bz : writedataM;

  // Outputs:
  mux2 #(32) instrFmux(idata,ddata,swc,instrF);
  mux2 #(32) readdataMmux(ddata,idata,swc,readdataM);
  mux2 #(1) instrackFmux(idone,ddone,swc,instrackF);
  mux2 #(1) dataackMmux(ddone,idone,swc,dataackM);

  // Write buffer... for writing.
  // need swap here...
  assign wbadr = (swc) ? (imemrwb ? 32'bz : imemadr) :
                          (dmemrwb ? 32'bz : dmemadr); 
  assign wbdata = (swc) ? (imemrwb ? 32'bz : imemdata) :
                          (dmemrwb ? 32'bz : dmemdata); 
  assign wbbyteen = (swc) ? (imemrwb ? 32'bz : imembyteen) :
                            (dmemrwb ? 32'bz : dmembyteen); 
  assign wben = (swc) ? (imemrwb ? 1'b0 : imemen) :
                        (dmemrwb ? 1'b0 : dmemen);
  assign dmemdonewire = (~swc & ~dmemrwb) ? wbdone :
                                            dmemdone;
  assign imemdonewire = (swc & ~imemrwb) ? wbdone :
                                          imemdone;

  // What tells these it is done.            
  mux2 #(1) wbmemdonemux(1'b0,memdone,wbon,wbmemdone);
  mux2 #(1) dmemdonemux(1'b0,memdone,don,dmemdone);
  mux2 #(1) imemdonemux(1'b0,memdone,ion,imemdone);


  // Mem assignments for reading (directly from
  // main memory)
  mux2 memdatamux(wbmemdata, 32'bz, memrwb, memdata);
  mux2 imemdatamux(32'bz, memdata, ion & imemrwb, imemdata);
  mux2 dmemdatamux(32'bz, memdata, don & dmemrwb, dmemdata);

  cache dcache(clk, reset, dadr, ddata, dbyteen,
                           drwb, den, ddone,
                           dmemadr,dmemdata,dmembyteen,
                           dmemrwb, dmemen,dmemdonewire);
                         
  cache icache(clk, reset, iadr, idata, ibyteen,
                           irwb, ien, idone,
                           imemadr,imemdata,imembyteen,
                           imemrwb, imemen,imemdonewire);

  // TODO: first one should go to memory multiplexor.
  // we need to split this up... so that it can directly access the buffer.
  //assign dmemdone = (dmemrwb) ? wbdone : wbdone;

  writebuffer writebuf(clk, reset, wbadr, wbdata, wbbyteen,
                            wben, wbdone,
                            wbmemadr, wbmemdata, wbmembyteen,
                            wbmemen, wbmemdone);
                          
  // TODO: Move mem so it is external.
  mainmem mem(clk, reset, memadr, memdata, membyteen,
                 memrwb, memen, memdone);
  

  parameter SREADY = 2'b00; // Ready state
  parameter SWB = 2'b01;  // Write buffer on
  parameter SD = 2'b10;  // Data cache on
  parameter SI = 2'b11; // Instruction cache on

  reg [1:0] nextstate;
  wire [1:0] state;


  assign wbon = ~state[1] & state[0];
  assign don = state[1] & ~state[0];
  assign ion = state[1] & state[0];

  flopr #(2) fstate(clk,reset,nextstate,state);

  mux4 #(30) memadrmux(30'b0,wbmemadr,dmemadr,imemadr,state,memadr);
  mux4 #(4) membyteenmux(4'b1,wbmembyteen,dmembyteen,imembyteen,state,membyteen);
  mux4 #(1) memrwbmux(1'b1,1'b0,1'b1,1'b1,state,memrwb);
  assign memen = (|state);

  always @(*)
  begin
      case(state)
          SREADY: if(wbmemen)  // High priority
                       nextstate <= SWB;
                  else if(~swc & dmemen & dmemrwb)  // Med. priority
                       nextstate <= SD;
                  else if(swc & imemen & imemrwb)
                       nextstate <= SI;
                  else if(~swc & imemen & imemrwb) // Low priority
                       nextstate <= SI;
                  else if(swc & dmemen & dmemrwb)
                       nextstate <= SD;
                  else nextstate <= SREADY;
          SWB:    if(memdone) nextstate <= SREADY;
                  else nextstate <= SWB;
          SD:     if(memdone) nextstate <= SREADY;
                  else nextstate <= SD;
          SI:     if(memdone) nextstate <= SREADY;
                  else nextstate <= SI;
          default: nextstate <= SREADY;
      endcase
  end
endmodule



// MAIN MEMORY
///
module mainmem(input clk, reset,
               input [29:0] adr,
               inout [31:0] data,
               input [3:0] byteen,
               input rwb, en,
               output done);
  
  integer i;             
  reg [31:0] mem[4095:0];
  wire [1:0] state;
  reg [1:0] nextstate;

  assign data = (rwb) ? mem[adr] : 32'bz;
  assign done = state[1];

  
  always @(negedge reset)
    begin
        for(i = 0; i < 4096; i = i + 1)
        begin
           mem[i] = 32'b0;
        end
    
        mem[0] = 32'hDEADBEEF;
        mem['had] = 32'hBEADBEEF;
        mem['h4ad] = 32'h21212121;
    end


  flopr #(2) fstate(clk,reset,nextstate,state);

  always @(*)
  case(state)
      2'b00: if(en) nextstate <= 2'b01;
             else nextstate <= 2'b00;
      2'b01: if(en) nextstate <= 2'b10;
             else nextstate <= 2'b00;
      default: nextstate <= 2'b00;
  endcase
  
  always @(posedge clk)
    if(~rwb) mem[adr] <= data;
endmodule
          
          
// 4kB cache memory + tag (20) [51:32] + valid (1-bit) [52]
module cacheram(input clk,
  input [9:0] adr,
  input rwb,
  input [52:0] din,
  output [52:0] dout);
  
  reg [52:0] mem[1023:0];
  
  always @(posedge clk)
    if(~rwb) mem[adr] <= din;
    
  assign dout = mem[adr];
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
             
             output [29:0] memadr, 
             inout  [31:0] memdata,
             output [3:0] membyteen,
             output memrwb,
             output memen,
             input memdone);
            
            wire [31:0] cacheline;
            wire [19:0] tagdata;
            wire        valid;
            wire [31:0] cachelinenew;
            wire [19:0] tagdatanew;
            wire        validnew;
            wire        cacheramrwb;
            
            wire [9:0] tag;
            wire [19:0] adrmsb;
            wire incache;
            wire bypass;
            
            reg [1:0] nextstate;
            wire [1:0] state;
            
            cacheram cacheram(clk,tag,cacheramrwb,{validnew,tagdatanew,cachelinenew},
                                                  {valid,tagdata,cacheline});

            // Valid if writing all or this is a read... and the memory is done.
            assign #1 cachelinenew = state[0] ? memdata : data;
            assign #1 tagdatanew = adrmsb;
            assign #1 validnew = ((& byteen) | state[0]) & memdone;
            assign #1 cacheramrwb = ~(|state) | bypass;
                     
            assign tag = adr[9:0];
            assign adrmsb = adr[29:10];
            assign #1 incache = (tagdata == adrmsb) & valid;
            assign #1 bypass = adr[29] & adr[27];
            
            assign data = rwb ? ((|state) ? memdata : cacheline) : 32'bz;
            assign #1 done = (incache & rwb & ~bypass) | ((|state) & memdone) | ~en;
            
            assign memadr = {3'b0, adr[26:0]};
            assign memdata = state[1] ? data : 32'bz;
            assign memen = (|state);
            assign membyteen = state[0] ? 4'b1 : byteen;
            assign memrwb = rwb;
            
            parameter SREADY = 2'b00;  // Ready
            parameter SREAD  = 2'b01;  // Read
            parameter SWRITE = 2'b10;  // Write
            
            flopr #(2) fstate(clk,reset,nextstate,state);
          
            always @(*)
              case(state)
                SREADY: if(en & ~done & rwb)       nextstate <= SREAD;
                        else if(en & ~rwb) nextstate <= SWRITE;
                        else                          nextstate <= SREADY;
                SREAD:  if(memdone) nextstate <= SREADY;
                        else        nextstate <= SREAD;
                SWRITE: if(memdone) nextstate <= SREADY;
                         else        nextstate <= SWRITE;
                default: nextstate <= SREADY;
              endcase
endmodule

module writebuffer(input clk, reset,
                   input [29:0] adr,
                   input [31:0] data,
                   input [3:0] byteen,
                   input en,
                   output done,
                   
                   output [29:0] memadr,
                   output [31:0] memdata,
                   output [3:0] membyteen,
                   output memen,
                   input memdone);
   wire [31:0] bufdata[3:0];
   wire [29:0] bufadr[3:0];
   wire [3:0] bufbyteen[3:0];
   wire bufen[3:0];      // Flag to indicate whether buffer entry has
                              // valid data.
   
   wire [1:0] ptr,writeptr;
   wire [3:0] ptrs,writeptrs;  // TODO: this could easily be a shift register...
   wire writeready;
   
   assign done = ~bufen[ptr];   // If we have a free space available.
   assign writeready = (memdone | ~memen) & bufen[writeptr];
   
   flopenr #(2) ptrf(clk, reset, en & done, ptr + 1'b1, ptr);
   flopenr #(2) writeptrf(clk, reset, writeready, writeptr + 1'b1, writeptr);
   
   flopenr #(30) memadrf(clk, reset, writeready, bufadr[writeptr], memadr);
   flopenr #(32) memdataf(clk, reset, writeready, bufdata[writeptr], memdata);
   flopenr #(4) membyteenf(clk, reset, writeready, bufbyteen[writeptr], membyteen);
   flopenr #(1) memenf(clk, reset, memdone | ~memen, bufen[writeptr], memen);
  
   dec2 ptrdec(ptr,ptrs);
   dec2 writeptrdec(writeptr,writeptrs);
  
  
   // TODO: this is really really not elegant.  We should change this
   // so the buffers are just mux'd out to the memory instead.
   genvar i;
   generate
     for(i = 0; i < 4; i = i + 1) begin:fbuf
       flopenr #(1) fbufen(clk,reset,((en & done) & ptrs[i]) | ((memdone | ~memen) & writeptrs[i]), 
                                 (en & done) & ptrs[i],bufen[i]);
       flopenr #(32) fbufdata(clk,reset,(en & done) & ptrs[i], 
                                 data,bufdata[i]);
       flopenr #(30) fbufadr(clk,reset,(en & done) & ptrs[i], 
                                 adr,bufadr[i]);
       flopenr #(4) fbufbyteen(clk,reset,(en & done) & ptrs[i], 
                                 byteen,bufbyteen[i]);
     end
   endgenerate
endmodule
