module clkdiv(input logic clk, rst, input logic [7:0] lim, output hzX);
  logic [7:0] ctr;
  always_ff @ (posedge clk, posedge rst) begin
    if(rst == 1) begin
      ctr <= 0;
      hzX <= 0; end
    else if (ctr == lim) begin
      ctr <= 0;
      hzX <= ~hzX; end
    else begin
      ctr <= ctr + 1;end
  end
endmodule
