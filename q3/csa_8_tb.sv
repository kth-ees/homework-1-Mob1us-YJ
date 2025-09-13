module csa_8_tb;

  // Inputs
  logic [7:0] a;
  logic [7:0] b;
  logic [7:0] sum;
  logic carry;

  // Instantiate the CSA_8 module
  csa_8 uut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  // Test cases
  initial begin
    $display("Testing 8-bit Carry Select Adder");
    $display("Time\t A\t\t B\t\t Sum\t\t Carry\t Expected");
    $display("--------------------------------------------------------------------");
    
    // Test case 1: Simple addition
    a = 8'h0F; b = 8'h01; #10;
    $display("%0t\t %02h (%3d)\t %02h (%3d)\t %02h (%3d)\t %b\t %3d", 
             $time, a, a, b, b, sum, sum, carry, a + b);
    
    // Test case 2: No carry
    a = 8'h12; b = 8'h34; #10;
    $display("%0t\t %02h (%3d)\t %02h (%3d)\t %02h (%3d)\t %b\t %3d", 
             $time, a, a, b, b, sum, sum, carry, a + b);
    
    // Test case 3: Carry from lower nibble
    a = 8'h0F; b = 8'h0F; #10;
    $display("%0t\t %02h (%3d)\t %02h (%3d)\t %02h (%3d)\t %b\t %3d", 
             $time, a, a, b, b, sum, sum, carry, a + b);
    
    // Test case 4: Maximum values
    a = 8'hFF; b = 8'hFF; #10;
    $display("%0t\t %02h (%3d)\t %02h (%3d)\t %02h (%3d)\t %b\t %3d", 
             $time, a, a, b, b, sum, sum, carry, a + b);
    
    // Test case 5: Overflow case
    a = 8'hFF; b = 8'h01; #10;
    $display("%0t\t %02h (%3d)\t %02h (%3d)\t %02h (%3d)\t %b\t %3d", 
             $time, a, a, b, b, sum, sum, carry, a + b);
    
    // Random test cases
    $display("\nRandom test cases:");
    for (int i = 0; i < 10; i++) begin
      a = $random; b = $random; #10;
      // Verify the result
      logic [8:0] expected = a + b;
      if ({carry, sum} !== expected) begin
        $error("Mismatch: A=%02h, B=%02h, Got=%02h%02h, Expected=%03h", 
               a, b, carry, sum, expected);
      end else begin
        $display("%0t\t %02h (%3d)\t %02h (%3d)\t %02h (%3d)\t %b\t %3d ✓", 
                 $time, a, a, b, b, sum, sum, carry, expected);
      end
    end
    
    $display("\nAll tests completed!");
    $finish;
  end
  
endmodule
