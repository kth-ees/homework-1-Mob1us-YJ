module bin2bcd_tb;

  // Testbench signals
  logic [3:0] binary;
  logic [3:0] bcd;
  logic carry;

  // Instantiate the bin2bcd module
  bin2bcd uut (
    .binary(binary),
    .bcd(bcd),
    .carry(carry)
  );

  // Test all possible input values
  initial begin
    $display("Testing Binary to BCD Converter");
    $display("Binary | BCD  | Carry | Expected");
    $display("-------|------|-------|----------");
    
    for (int i = 0; i < 16; i++) begin
      binary = i[3:0];
      #10; // Wait for combinational logic to settle
      
      // Display results
      $display(" %4b  | %4b |   %b   | %2d", binary, bcd, carry, i);
      
      // Verify the output
      logic [3:0] expected_bcd;
      logic expected_carry;
      
      if (i <= 9) begin
        expected_bcd = i[3:0];
        expected_carry = 1'b0;
      end else begin
        expected_bcd = (i - 10)[3:0];
        expected_carry = 1'b1;
      end
      
      if (bcd !== expected_bcd || carry !== expected_carry) begin
        $error("Test failed for binary=%b. Expected bcd=%b, carry=%b, got bcd=%b, carry=%b", 
               binary, expected_bcd, expected_carry, bcd, carry);
      end
    end
    
    $display("\nAll tests completed successfully!");
    $finish;
  end
endmodule
