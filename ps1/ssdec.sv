module ssdec (
  input logic [3:0] in,
  input logic enable,
  output logic [6:0] out
);
  logic [6:0] LED [15:0];
  assign LED[4'h0] = 7'b0111111;
  assign LED[4'h1] = 7'b0000110;
  assign LED[4'h2] = 7'b1011011;
  assign LED[4'h3] = 7'b1001111;
  assign LED[4'h4] = 7'b1100110;
  assign LED[4'h5] = 7'b1101101;
  assign LED[4'h6] = 7'b1111101;
  assign LED[4'h7] = 7'b0000111;
  assign LED[4'h8] = 7'b1111111;
  assign LED[4'h9] = 7'b1100111;
  assign LED[4'ha] = 7'b1110111;
  assign LED[4'hb] = 7'b1111100;
  assign LED[4'hc] = 7'b0111001;
  assign LED[4'hd] = 7'b1011110;
  assign LED[4'he] = 7'b1111001;
  assign LED[4'hf] = 7'b1110001;
  assign {out[6:0]} = enable ? LED[in] : 0;
endmodule
