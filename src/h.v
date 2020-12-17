module h #(parameter WORD_WIDTH = 8) (clk,c_bus,c_write_enable,a_bus);
  input clk;
  input c_write_enable;
  input [WORD_WIDTH-1 : 0] c_bus;
  output [WORD_WIDTH-1 : 0] a_bus;
  reg [WORD_WIDTH-1 : 0] data;
  
  assign a_bus = data;
  
  initial data = 0;
  
  always @ (posedge clk)
  begin
    if (c_write_enable)
      data <= c_bus;
  end
  
endmodule