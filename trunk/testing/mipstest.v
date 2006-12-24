//------------------------------------------------
// mipstest.v
// David_Harris@hmc.edu 23 October 2005
// Testbench for MIPS processor
//------------------------------------------------

module testbench();

  reg         clk;
  reg         reset;

  wire [31:0] writedata, dataadr;
  wire memwrite;

  // instantiate device to be tested
  top dut(clk, reset, writedata, dataadr, memwrite);
  
  integer currentTest;
  reg currentSuccess;
  
  // initialize test
  initial
    begin
      // Be sure to keep timing synced with imem's memory loads
      for(currentTest = 0; currentTest < 2; currentTest = currentTest + 1) begin
        currentSuccess <= 0;
        reset <= 1; # 10; reset <= 0;
        #1990;
        if(currentSuccess) begin
          $display("Simulation %d succeeded", currentTest);
        end else begin
          $display("Simulation %d failed", currentTest);
        end
      end
      $display("Test complete");
      $stop;
    end
    
  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check results
  always@(negedge clk)
    begin
      case (currentTest)
        0:
          if(memwrite) begin
            if(dataadr === 18 & writedata === 21) begin
              currentSuccess <= 1;
            end else begin
              $display("Writing value %d to address %h", writedata, dataadr);
            end
          end
        1:
          if(memwrite) begin
            if(dataadr === 84 & writedata === 7) begin
              currentSuccess <= 1;
            end
          end
//        default:
      endcase
    end
endmodule




