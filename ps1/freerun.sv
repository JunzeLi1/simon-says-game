module freerun(input logic clk, rst, en, input logic [7:0] max, output logic [7:0] out);
  always@(posedge clk, posedge rst)
    begin
      if(rst == 1) begin
         out <= 8'd0; end
      else if(out == max) begin
        out <= 0; end
      else if(en == 1) begin
        out <= out + 1; end
      else begin
        out <= out;end
      end
endmodule
