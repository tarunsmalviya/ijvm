module mar #(parameter WORD_WIDTH = 8) (clk,c_bus,c_write_enable,mem_out);
  input clk;
  input [WORD_WIDTH-1 : 0] c_bus;
  input c_write_enable;
  output  [WORD_WIDTH-1 : 0] mem_out;
  reg [WORD_WIDTH-1 : 0] data;

 assign mem_out = data;

  initial data = 0;  

  always @(posedge clk)
  begin
    if (c_write_enable)
      data <= c_bus;
  end
endmodule