module simonsays #(
  parameter CLKDIV_LIM=8'd6
  // DO NOT CHANGE THE VALUE OF CLKDIV_LIM
)(
  input logic hz100, reset, 
  input logic [19:0] pb,
  output logic [7:0] left, right, 
  output logic [7:0] ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue
);

  logic clk;
  logic sd_srst;
  logic fr_en;
  logic mem_en;
  logic strobe;
  logic [15:0]sd_out;
  logic [7:0]fr_out;
  logic [11:0]mem_out;
  clkdiv clkd (.clk(hz100),.rst(reset),.lim(CLKDIV_LIM),.hzX(clk));
  shiftdown shiftd(.clk(clk),.rst(reset),.srst(sd_srst),.out(sd_out));
  freerun freer(.clk(hz100),.en(fr_en),.max(8'd255),.rst(reset),.out(fr_out));
  mem me(.clk(hz100),.en(mem_en),.sel(fr_out),.btns(mem_out));
  scankey scank(.clk(hz100),.rst(reset),.in(pb[19:0]),.strobe(strobe));

  typedef enum logic [2:0] { READY=0, PLAY=1, FAIL=2, PASS=3, WIN=4 } dcl_fsm_t;

  logic [3:0]score;
  logic [2:0]state;
  logic [7:0]ssflag;
  logic [4:0]text0,text1,text2,text3,text4,text5,text6,text7;

  always_comb begin
    text7 = 0;
    text6 = 0;
    text5 = 0;
    text4 = 0;
    text3 = 0;
    text2 = 0;
    text1 = 0;
    text0 = 0;
    ssflag = 0;
    if (state==READY) begin
      text7 = {1'b1, 4'h6};
      text6 = {1'b0, 4'hE};
      text5 = {1'b0, 4'hA};
      text4 = {1'b0, 4'hD};
      text3 = {1'b1, 4'h8};
      text2 = {1'b1, 4'h9};
      text1 = {1'b0, 4'h0};
      text0 = {1'b0, score};
      ssflag = 8'b11111101;
    end
    else if (state==PLAY || state==PASS) begin
      text7 = {1'b1, 4'h1};
      text6 = {1'b0, 4'h0};
      text5 = {1'b1, 4'h4};
      text4 = {1'b0, 4'hD};
      text3 = {1'b0, 4'h0};
      text2 = {1'b0, mem_out[11:8]};
      text1 = {1'b0, mem_out[7:4]};
      text0 = {1'b0, mem_out[3:0]};
      ssflag = 8'b11110111;
    end
    else if (state==FAIL) begin
      text7 = {1'b1, 4'h7};
      text6 = {1'b1, 4'h6};
      text5 = {1'b1, 4'h8};
      text4 = {1'b0, 4'hA};
      text3 = {1'b1, 4'h0};
      text2 = {1'b0, 4'hA};
      text1 = {1'b1, 4'h2};
      text0 = {1'b1, 4'h5};
      ssflag = 8'b11111111;
    end
    else if (state==WIN) begin
      text7 = {1'b1, 4'h0};
      text6 = {1'b0, 4'h0};
      text5 = {1'b0, 4'h0};
      text4 = {1'b0, 4'hD};
      text3 = {1'b0, 4'h0};
      text2 = {1'b1, 4'h3};
      text1 = {1'b0, 4'h0};
      text0 = {1'b0, 4'hB};
      ssflag = 8'b11110111;
    end
    else
      ssflag = 8'b11111111;
  end

  ssdec_ext ssd0(.in(text0),.enable(ssflag[0]),.out(ss0[6:0]));
  ssdec_ext ssd1(.in(text1),.enable(ssflag[1]),.out(ss1[6:0]));
  ssdec_ext ssd2(.in(text2),.enable(ssflag[2]),.out(ss2[6:0]));
  ssdec_ext ssd3(.in(text3),.enable(ssflag[3]),.out(ss3[6:0]));
  ssdec_ext ssd4(.in(text4),.enable(ssflag[4]),.out(ss4[6:0]));
  ssdec_ext ssd5(.in(text5),.enable(ssflag[5]),.out(ss5[6:0]));
  ssdec_ext ssd6(.in(text6),.enable(ssflag[6]),.out(ss6[6:0]));
  ssdec_ext ssd7(.in(text7),.enable(ssflag[7]),.out(ss7[6:0]));

  logic simon_says;
  logic is_wrong;
  logic is_correct;
  logic sd_is_empty;
  logic round_passed;
  assign simon_says = ^mem_out;
  assign round_passed = pb[{1'b0, mem_out[3:0]}] && pb[{1'b0, mem_out[7:4]}] && pb[{1'b0, mem_out[11:8]}];
  assign sd_is_empty = (sd_out==0);

  controller ctrl(.clk(hz100),.rst(reset),.simon_says(simon_says),.sk_strobe(strobe),.round_passed(round_passed),.sd_is_empty(sd_is_empty),.sd_srst(sd_srst),.fr_en(fr_en),.is_wrong(is_wrong),.is_correct(is_correct),.mem_en(mem_en),.score(score),.state(state));

  always_comb begin
    if (state==PLAY || state==READY) begin
      {left,right} = sd_out;
    end
    else begin
      {left,right} = 0;
    end
    if (state==PLAY) begin
      blue = simon_says;
    end
    else begin
      blue = 0;
    end
  end

  assign red = is_wrong;
  assign green = is_correct;

endmodule
