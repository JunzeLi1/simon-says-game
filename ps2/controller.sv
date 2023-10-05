module controller(input logic clk,rst,simon_says,sk_strobe,round_passed,sd_is_empty, output logic sd_srst,fr_en,is_wrong,is_correct,mem_en, output logic [3:0]score, output logic [2:0]state);

  typedef enum logic [2:0] { READY=0, PLAY=1, FAIL=2, PASS=3, WIN=4 } dcl_fsm_t;
  dcl_fsm_t del_fsm;
  assign state = del_fsm;

  always_ff @ (posedge rst, posedge clk) begin
    if(rst==1'b1) begin
      is_correct <= 0;
      score <= 0;
      fr_en <= 1;
      mem_en <= 1;
      del_fsm <= READY;
      sd_srst <= 1;
      is_wrong <= 0; end     
    else if (del_fsm == READY) begin
      sd_srst <= 0;
      mem_en <= 1;
      fr_en <= 1;
      if (sd_is_empty==1'b1) begin
        mem_en <= 0;
        is_correct <= 0;
        del_fsm <= PLAY;
        sd_srst <= 1;
        fr_en <= 0;
      end
    end
    
    else if(del_fsm == PLAY) begin
      fr_en <= 1'b0;
      if (sd_is_empty==0) begin
        sd_srst <= 0;
      end
      if (sd_srst == 0 && sd_is_empty == 1) begin
        sd_srst <= 1;
        if(simon_says == 0 || round_passed == 1) begin
          del_fsm <= PASS; end
        else begin
          del_fsm <= FAIL; end
        end
      else if(sk_strobe==1) begin
        if(simon_says==0) begin
          del_fsm <= FAIL;end
          fr_en <= 1'b1;end
    end
    
    else if (del_fsm == FAIL) begin
      is_wrong <= 1'b1;
    end

    else if (del_fsm == PASS) begin
      is_correct <= 1'b1;
      if(score == 9) begin
        del_fsm <= WIN;
      end
      else begin
        sd_srst <= 1;
        if (sd_is_empty==0) begin
          score <= score+1;
          del_fsm <= READY;
          sd_srst <= 0;
        end
      end
      end

    else if (del_fsm == WIN) begin
      is_correct <= 1'b1;
    end

    else begin end
  end
endmodule
