//------------------------------------------------
// mipstest.v
// David_Harris@hmc.edu 23 October 2005
// Testbench for MIPS processor
//------------------------------------------------

`timescale 1 ns / 1 ps

module testbench;

  reg         ph1, ph2;
  reg         reset;

  reg [7:0] interrupts;
  
  wire [31:0] writedata, dataadr;
  wire memwrite;

  // instantiate device to be tested
  top dut(ph1, ph2, reset, interrupts, writedata, dataadr, memwrite);
  
  integer currentTest;
  integer numTests;
  integer successfulTests;
  reg currentSuccess;
  
  reg [31:0] counter;
  
  always@(posedge ph1)
      counter <= counter + 1;
  
  // initialize test
  initial
    begin
      counter <= 0;
      successfulTests = 0;
      numTests = 17;
      // Be sure to keep timing synced with imem's memory loads
      for(currentTest = 0; currentTest < numTests; 
          currentTest = currentTest + 1) begin
        currentSuccess <= 0;
        reset <= 1; # 15; reset <= 0;
        // Pausing
        if(currentTest == 12 | currentTest == 16) begin
          # 4985;
        end else
           # 985;

        if(currentSuccess) begin
          $display("Simulation %d succeeded (end time %d)", currentTest, 
            counter);
          successfulTests = successfulTests + 1;
        end else begin
          $display("Simulation %d FAILED    (end time %d)", currentTest, 
            counter);
        end
      end
      $display("Test complete -- %d out of %d passed", successfulTests, 
        numTests);
      $stop;
    end
    
  initial
    begin
      interrupts[0] <= 0; #17400;
      interrupts[0] <= 1; #10;
      interrupts[0] <= 0;
    end
      
  initial
    begin
      interrupts[1] <= 0; #17100; 
      interrupts[1] <= 1; #10; 
      interrupts[1] <= 0; #90;
      interrupts[1] <= 1; #10;
      interrupts[1] <= 0; #240;
      interrupts[1] <= 1; #10;
      interrupts[1] <= 0;
    end
    
  initial
      begin
        interrupts[2] <= 0;
        interrupts[3] <= 0;
        interrupts[4] <= 0;
        interrupts[5] <= 0;
        interrupts[6] <= 0;
        interrupts[7] <= 0;
      end
  

  // generate clock to sequence tests
  always
    begin
      ph1 <= 1; # 4; ph1 <= 0; #1;
		ph2 <= 1; # 4; ph2 <= 0; #1;
    end

  // check results
  always@(posedge ph2)
    begin
      case (currentTest)
        0:
          if(memwrite) begin
            if(dataadr === 32'h14 & writedata === 21) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
        1:
          if(memwrite) begin
            if(dataadr === 32'h54 & writedata === 7) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
        2:
          if(memwrite) begin
            if(dataadr === 32'h70f00ff0 & writedata === 2) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
        3:
          if(memwrite) begin
            if(dataadr === 32'h8f0ff010 & writedata === 2) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
        4:
          if(memwrite) begin
            if(dataadr === 32'h0ffffffc & writedata === 32'h3f8) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
        5:
          if(memwrite) begin
            if(dataadr === 32'h2c & writedata === 32'h9) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %h to address %h", writedata, dataadr);
            end
          end
        6:
          if(memwrite) begin
            if(dataadr === 32'h1263ff00 & writedata === 32'h0) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
        7:
          if(memwrite) begin
            if(dataadr === 32'h14 & writedata === 32'h550000ff) begin
              currentSuccess <= 1;
            end 
            $display("Writing value %h to address %h", writedata, dataadr);
          end
        8:
          if(memwrite) begin
            if(dataadr === 32'h18 & writedata === 32'h1f) begin
              currentSuccess <= 1;
            end 
            $display("Writing value %h to address %h", writedata, dataadr);
          end
        9:
          if(memwrite) begin
            if(dataadr === 32'hc & writedata === 32'h0c) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
          
        10:
          if(memwrite) begin
            if(dataadr === 32'h0 & writedata === 32'h4) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
        11:
          if(memwrite) begin
            if(dataadr === 32'h0 & writedata === 32'h4) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
        12:
          if(memwrite) begin
            // This program is written in C, so we don't look at the address
            // that it is writing to, just the value it is writing
            if(writedata === 479001600 /* 12 factorial */) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h at time %d", writedata,
                       dataadr, counter);
            end
          end
          
        13:
          if(memwrite) begin
            if(dataadr === 32'h4 & writedata === 2) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
		  14:
          if(memwrite) begin
            if(dataadr === 32'h4 & writedata === 32'h4) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
		  15:
          if(memwrite) begin
            if(dataadr === 32'h4 & writedata === 32'h4) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
      16:
          if(memwrite) begin
            // This program is written in C, so we don't look at the address
            // that it is writing to, just the value it is writing
            if(writedata === 2201) begin
              currentSuccess <= 1;
            end else begin
              //$display("Writing value %d to address %h at time %d", writedata,
              // dataadr, counter);
            end
          end
//        default:
      endcase
    end
endmodule
