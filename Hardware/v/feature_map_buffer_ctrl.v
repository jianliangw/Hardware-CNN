module feature_map_buffer_ctrl(
  input clock,
  input reset,
  input data_rdy,
  
  input [`X_COORD_BITWIDTH:0] xcoord,
  input [`Y_COORD_BITWIDTH:0] ycoord, 

  output reg [`FM_ADDR_BITWIDTH:0] addr,
  output reg buffer_full
);

// incriment address
always@(posedge clock or negedge reset) begin
  if(reset == 1'b0) begin
    addr <= `FM_ADDR_WIDTH'd0;
  end else begin
    if(data_rdy) begin
      // addr <= addr + `FM_ADDR_WIDTH'd0;
      addr <= xcoord + (ycoord * `FM_ADDR_WIDTH'd`FM_WIDTH);
    end else begin
      // reset addres
      addr <= `FM_ADDR_WIDTH'd0;
    end // rdy
  end // reset
end // always


// set buffer full signal
always@(posedge clock or negedge reset) begin
  if (reset == 1'b0) begin
    buffer_full <= 1'b0;
  end else begin
    if (addr == `ADDR_MAX) begin
      buffer_full <= 1'b1;
    end else begin
      buffer_full <= 1'b0;
    end // addr == max
  end // reset
end // always

endmodule

