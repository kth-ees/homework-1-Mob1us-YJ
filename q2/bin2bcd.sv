module bin2bcd (
  input logic [3:0] binary,
  output logic [3:0] bcd,
  output logic carry
);
  // Binary to BCD converter using 16-to-1 multiplexers
  // Converts 4-bit binary (0-15) to BCD format (0-9) with carry for values > 9
  
  always_comb begin
    case (binary)
      4'b0000: begin bcd = 4'b0000; carry = 1'b0; end // 0
      4'b0001: begin bcd = 4'b0001; carry = 1'b0; end // 1
      4'b0010: begin bcd = 4'b0010; carry = 1'b0; end // 2
      4'b0011: begin bcd = 4'b0011; carry = 1'b0; end // 3
      4'b0100: begin bcd = 4'b0100; carry = 1'b0; end // 4
      4'b0101: begin bcd = 4'b0101; carry = 1'b0; end // 5
      4'b0110: begin bcd = 4'b0110; carry = 1'b0; end // 6
      4'b0111: begin bcd = 4'b0111; carry = 1'b0; end // 7
      4'b1000: begin bcd = 4'b1000; carry = 1'b0; end // 8
      4'b1001: begin bcd = 4'b1001; carry = 1'b0; end // 9
      4'b1010: begin bcd = 4'b0000; carry = 1'b1; end // 10 -> 0 + carry
      4'b1011: begin bcd = 4'b0001; carry = 1'b1; end // 11 -> 1 + carry
      4'b1100: begin bcd = 4'b0010; carry = 1'b1; end // 12 -> 2 + carry
      4'b1101: begin bcd = 4'b0011; carry = 1'b1; end // 13 -> 3 + carry
      4'b1110: begin bcd = 4'b0100; carry = 1'b1; end // 14 -> 4 + carry
      4'b1111: begin bcd = 4'b0101; carry = 1'b1; end // 15 -> 5 + carry
      default: begin bcd = 4'b0000; carry = 1'b0; end
    endcase
  end
endmodule
