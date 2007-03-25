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
      numTests = 1;
      // Be sure to keep timing synced with imem's memory loads
      for(currentTest = 0; currentTest < numTests; 
          currentTest = currentTest + 1) begin
        currentSuccess <= 0;
        reset <= 1; # 30; reset <= 0;
        // Pausing
        if(currentTest == 0)begin
          # 14970;
        end

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
    
  /*initial
    begin
      interrupts[0] <= 0; #75800;
      interrupts[0] <= 1; #50;
      interrupts[0] <= 0;
//original      interrupts[0] <= 0; #75400;
//      interrupts[0] <= 1; #10;
//      interrupts[0] <= 0;

    end
      
  initial
    begin
      interrupts[1] <= 0; #75500; 
      interrupts[1] <= 1; #50;    // Cause exception 1
      interrupts[1] <= 0; #900;   // Wait for handler to exit
      interrupts[1] <= 1; #50;    // Cause exception 2
      interrupts[1] <= 0; #100;   // Send interupt high (but during handler)
      interrupts[1] <= 1; #50;    // So doesn't influence handler
      interrupts[1] <= 0;
//original      interrupts[1] <= 0; #75100; 
//      interrupts[1] <= 1; #10; 
//      interrupts[1] <= 0; #90;
//      interrupts[1] <= 1; #10;
//      interrupts[1] <= 0; #240;
//      interrupts[1] <= 1; #10;
//      interrupts[1] <= 0;
    end
*/
    
  initial
      begin
	  interrupts[0] <= 0;
	  interrupts[1] <= 0;
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
       //       $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
//        default:
      endcase
    end
endmodule
