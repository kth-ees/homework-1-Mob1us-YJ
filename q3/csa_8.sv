module csa_8 (
  input logic [7:0] a, b,
  output logic [7:0] sum,
  output logic carry
);
  // 8-bit Carry Select Adder (CSA) implementation
  // Uses two 4-bit adders for lower and upper nibbles
  // Upper nibble computed with both carry_in = 0 and carry_in = 1
  // Then selects the correct result based on actual carry from lower nibble
  
  // Signals for lower 4-bit adder (bits 3:0)
  logic [3:0] sum_low;
  logic carry_low;
  
  // Signals for upper 4-bit adder with carry_in = 0
  logic [3:0] sum_high_0;
  logic carry_high_0;
  
  // Signals for upper 4-bit adder with carry_in = 1  
  logic [3:0] sum_high_1;
  logic carry_high_1;
  
  // Lower 4-bit adder (bits 3:0)
  adder_4 lower_adder (
    .A(a[3:0]),
    .B(b[3:0]),
    .sum(sum_low),
    .carry(carry_low)
  );
  
  // Upper 4-bit adder assuming carry_in = 0
  adder_4 upper_adder_0 (
    .A(a[7:4]),
    .B(b[7:4]),
    .sum(sum_high_0),
    .carry(carry_high_0)
  );
  
  // Upper 4-bit adder assuming carry_in = 1
  // Need to add 1 to the sum to account for carry_in = 1
  logic [3:0] b_plus_carry;
  assign b_plus_carry = b[7:4] + 4'b0001;
  
  adder_4 upper_adder_1 (
    .A(a[7:4]),
    .B(b_plus_carry),
    .sum(sum_high_1),
    .carry(carry_high_1)
  );
  
  // Multiplexer to select the correct upper result based on lower carry
  always_comb begin
    sum[3:0] = sum_low;  // Lower bits are always the same
    
    if (carry_low == 1'b0) begin
      sum[7:4] = sum_high_0;
      carry = carry_high_0;
    end else begin
      sum[7:4] = sum_high_1;
      carry = carry_high_1;
    end
  end
endmodule
