module mem (
  // port headers go here
  input logic clk, en, input logic [7:0] sel, output logic [11:0] btns
);

  // declare your memory here
  // it must have 256 rows of 12 bits each and be named "memory"
  logic [11:0] memory [0:255];

  initial begin
    // we load the memory with the contents of the file "press.mem", using all lines 0 to 255.
    $readmemh("press.mem", memory, 0, 255);
  end

  // on every edge of clk, if en is high, set btns to the value of the memory at the index sel
  // (remember, it's a 2D array, so you need to pick the right row based on sel)
  // (and you don't have to worry about reset here - just check if en is high.)
  always_ff @(posedge clk) begin
    if(en == 1) begin
      btns <= memory[sel]; end
    end

endmodule
