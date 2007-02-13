//------------------------------------------------
// mem.v
// npinckney@hmc.edu  January 2007
// Memory subsystem of mips microprocessor
//
// WORK IN PROGRESS
//------------------------------------------------

`timescale 1 ns / 1 ps



// Implementation of upper bit bypass here.
// Description of interface:
//
// pcF = Program counter (memory address)
// instrF = Instruction fetched (instruction data)
//
// swc = swap caches.  (0 = normal assignment, 1 = swapped)
module memsys(input ph1, ph2, reset,
                       input [31:2] pcF,
                       output [31:0] instrF,
                       input reF,
                       output instrackF,
                       
                       input [29:0] adrM, 
                       input [31:0] writedataM,
                       input [3:0] byteenM,
                       output [31:0] readdataM,
                       input memwriteM, reM,
                       output dataackM,
                       
                       input swc,
                       
                       output [26:0] memadr,
                       inout [31:0] memdata,
                       output [3:0] membyteen,
                       output memrwb,
                       output memen,
                       input memdone);

  wire enF, enM;
  
  assign enF = reF;
  assign enM = reM | memwriteM;

  wire [29:0] dadr;
  wire [31:0] ddata;
  wire [3:0] dbyteen;
  wire drwb, den, ddone;
  wire [26:0] dmemadr;
  wire [31:0] dmemdata;
  wire [3:0] dmembyteen;
  wire dmemrwb, dmemen;
  wire dmemdone;
  wire dmemdonewire;


  wire [29:0] iadr;
  wire [31:0] idata;
  wire [3:0] ibyteen;
  wire irwb, ien, idone;
  wire [26:0] imemadr;
  wire [31:0] imemdata;
  wire [3:0] imembyteen;
  wire imemrwb, imemen;
  wire imemdone;
  wire imemdonewire;

  wire [26:0] wbadr;
  wire [31:0] wbdata;
  wire [3:0] wbbyteen;
  wire wben, wbdone;
  wire [26:0] wbmemadr;
  wire [31:0] wbmemdata;
  wire [3:0] wbmembyteen;
  wire wbmemen;
  wire wbmemdone;

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
  //assign memdata = memrwb ? 32'bz : wbmemdata;
  //assign imemdata = (imemrwb & ion) ? memdata : 32'bz;
  //assign dmemdata = (dmemrwb & don) ? memdata : 32'bz;
  tribuf memdatatri(~memrwb, wbmemdata, memdata);
  tribuf dmemdatatri(dmemrwb & don, memdata, dmemdata);
  tribuf imemdatatri(imemrwb & ion, memdata, imemdata);
//  mux2 memdatamux(wbmemdata, 32'bz, memrwb, memdata);
//  mux2 imemdatamux(32'bz, memdata, ion & imemrwb, imemdata);
//  mux2 dmemdatamux(32'bz, memdata, don & dmemrwb, dmemdata);

  cache dcache(ph1, ph2, reset, dadr, ddata, dbyteen,
                           drwb, den, ddone,
                           dmemadr,dmemdata,dmembyteen,
                           dmemrwb, dmemen,dmemdonewire);
                         
  cache icache(ph1, ph2, reset, iadr, idata, ibyteen,
                           irwb, ien, idone,
                           imemadr,imemdata,imembyteen,
                           imemrwb, imemen,imemdonewire);

  // TODO: first one should go to memory multiplexor.
  // we need to split this up... so that it can directly access the buffer.
  //assign dmemdone = (dmemrwb) ? wbdone : wbdone;

  writebuffer writebuf(ph1, ph2, reset, wbadr, wbdata, wbbyteen,
                            wben, wbdone,
                            wbmemadr, wbmemdata, wbmembyteen,
                            wbmemen, wbmemdone);

  parameter SREADY = 2'b00; // Ready state
  parameter SWB = 2'b01;  // Write buffer on
  parameter SD = 2'b10;  // Data cache on
  parameter SI = 2'b11; // Instruction cache on

  reg [1:0] nextstate;
  wire [1:0] state;


  assign wbon = ~state[1] & state[0];
  assign don = state[1] & ~state[0];
  assign ion = state[1] & state[0];

  flopr #(2) fstate(ph1, ph2,reset,nextstate,state);

  mux4 #(27) memadrmux(27'b0,wbmemadr,dmemadr,imemadr,state,memadr);
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


// cache: a 1kB cache
module cache(input ph1, ph2, reset,
             input [29:0] adr,
             inout [31:0] data,
             input [3:0] byteen,
             input rwb, en,
             output done,
             
             output [26:0] memadr, 
             inout  [31:0] memdata,
             output [3:0] membyteen,
             output memrwb,
             output memen,
             input memdone);
            
  wire [31:0] readdata;
            
  // Cache ram ports
  wire [31:0] cacheline;
  wire [21:0] tagdata;
  wire        valid;
  wire [31:0] cachelinenew;
  wire [21:0] tagdatanew;
  wire        validnew;
  wire        cacheramrwb;
            
  // Control signals
  wire bypass;
  wire waiting;
  wire reading;
            
  cacheram cacheram(ph1, ph2, adr[7:0],cacheramrwb,
                    {validnew,tagdatanew,cachelinenew},
                    {valid,tagdata,cacheline});
  cachecontroller cachec(ph1, ph2, reset, adr[29:8], en, rwb,
                         tagdata, valid, memdone, 
                         bypass, waiting, reading, done);
            
  // Cache ram controls.  Cache ram doesn't have an enable,
  // just cacheramrwb goes low for writing.
  // We write if we're using memory (waiting)
  // and not bypassing.  (Remember rwb = 0 for a write)
  assign #1 cacheramrwb = ~waiting | bypass;
  mux2 #(32) cachelinemux(data,memdata,reading,cachelinenew);
  assign #1 tagdatanew = adr[29:8];
  assign #1 validnew = ((& byteen) | reading) & memdone;  // valid if reading or writing all
                                                                    // bytes.
  // Memory controls                  
  assign #1 memadr = adr[26:0];
  mux2 #(4) membyteenmux(byteen, 4'b1, reading, membyteen);
  assign #1 memrwb = rwb;
  assign #1 memen = waiting;
            
  // Bi-directional data port
  mux2 #(32) readdatamux(cacheline, memdata, waiting, readdata);
  tribuf #(32) datatri(rwb,readdata,data);
  tribuf #(32) memdatatri(~rwb,data,memdata);
endmodule


// cachecontroller: controls the cache for reading/writing.
module cachecontroller(input ph1, ph2, reset,
              input [29:8] adr,
              input en, rwb,
              
              input [21:0] tagdata,
              input valid,
              
              input memdone,
              
              output bypass,
              output waiting,
              output reading,
              output done);

    reg [1:0] nextstate;
    wire [1:0] state;

    assign #1 bypass = adr[29] & adr[27];
    assign #1 waiting = (|state);
    assign reading = state[0];  
    assign #1 incache = (tagdata == adr[29:8]) & valid;
    assign #1 done = (incache & rwb & ~bypass) | (waiting & memdone) | ~en | reset;

    parameter SREADY = 2'b00;  // Ready
    parameter SREAD  = 2'b01;  // Read
    parameter SWRITE = 2'b10;  // Write
            
    flopr #(2) fstate(ph1, ph2,reset,nextstate,state);
          
    always @(*)
      case(state)
         SREADY:  if(~done & rwb) nextstate <= SREAD;
                  else if(~done & ~rwb) nextstate <= SWRITE;
                  else        nextstate <= SREADY;
         SREAD:   if(memdone) nextstate <= SREADY;
                  else        nextstate <= SREAD;
         SWRITE:  if(memdone) nextstate <= SREADY;
                  else        nextstate <= SWRITE;
         default: nextstate <= SREADY;
       endcase
endmodule


// 1kB cache memory + tag (22) [53:32] + valid (1-bit) [54]
module cacheram(input ph1, ph2,
  input [7:0] adr,
  input rwb,
  input [54:0] din,
  output [54:0] dout);
  
  reg [54:0] mem[255:0];
  
  always @(posedge ph1)
    if(~rwb) mem[adr] <= din;
    
  assign dout = mem[adr];
endmodule


// writebuffer:  The write buffer, for storing
// data to write to external memory.
module writebuffer(input ph1, ph2, reset,
                   input [26:0] adr,
                   input [31:0] data,
                   input [3:0] byteen,
                   input en,
                   output done,
                   
                   output [26:0] memadr,
                   output [31:0] memdata,
                   output [3:0] membyteen,
                   output memen,
                   input memdone);
   wire [31:0] bufdata[3:0];
   wire [26:0] bufadr[3:0];
   wire [3:0] bufbyteen[3:0];
   wire bufen[3:0];             // Flags to indicate whether buffer entries have
                                // valid data.
   
   wire [1:0] ptr,writeptr;
   wire [3:0] ptrs,writeptrs;   // TODO: this could easily be a shift register...
   wire writeready;
   
   assign done = ~bufen[ptr];   // If we have a free space available.
   assign writeready = (memdone | ~memen) & bufen[writeptr];
   
   // TODO: put a inc() in here.
   flopenr #(2) ptrf(ph1, ph2, reset, en & done, ptr + 1'b1, ptr);
   flopenr #(2) writeptrf(ph1, ph2, reset, writeready, writeptr + 1'b1, writeptr);
   
   flopenr #(27) memadrf(ph1, ph2, reset, writeready, bufadr[writeptr], memadr);
   flopenr #(32) memdataf(ph1, ph2, reset, writeready, bufdata[writeptr], memdata);
   flopenr #(4) membyteenf(ph1, ph2, reset, writeready, bufbyteen[writeptr], membyteen);
   flopenr #(1) memenf(ph1, ph2, reset, memdone | ~memen, bufen[writeptr], memen);
  
   dec2 ptrdec(ptr,ptrs);
   dec2 writeptrdec(writeptr,writeptrs);
  
   genvar i;
   generate
     for(i = 0; i < 4; i = i + 1) begin:fbuf
       flopenr #(1) fbufen(ph1, ph2,reset,((en & done) & ptrs[i]) | ((memdone | ~memen) & writeptrs[i]), 
                                 (en & done) & ptrs[i],bufen[i]);
       flopenr #(32) fbufdata(ph1, ph2,reset,(en & done) & ptrs[i], 
                                 data,bufdata[i]);
       flopenr #(27) fbufadr(ph1, ph2,reset,(en & done) & ptrs[i], 
                                 adr,bufadr[i]);
       flopenr #(4) fbufbyteen(ph1, ph2,reset,(en & done) & ptrs[i], 
                                 byteen,bufbyteen[i]);
     end
   endgenerate
endmodule
