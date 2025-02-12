module random_card (
    input logic fast_clk,
    input logic rst_n,
    output logic [3:0] new_card
);
  logic [3:0] fast_count;

  // Super-fast wrapping counter is a simple random number generator.
  always_ff @(posedge fast_clk or negedge rst_n) begin
    if (~rst_n) begin
      fast_count <= 4'd1;
    end else begin
      if (fast_count == 4'd13) fast_count <= 4'd1;
      else fast_count <= fast_count + 1;
    end
  end

  assign new_card = fast_count;

endmodule
